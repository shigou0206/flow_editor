import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flow_editor/core/models/enums.dart';
import 'package:flow_editor/core/models/style/edge_animation_config.dart';
import 'package:flow_editor/core/models/style/edge_line_style.dart';
import 'package:flow_editor/core/models/edge_model.dart';
import 'package:flow_editor/core/models/edge_attachment_model.dart';

/// EdgeIdFactory 专门负责生成 EdgeModel 的唯一 ID
class EdgeIdFactory {
  /// 默认分隔符
  static const String separator = '\u0001';

  /// 基础的 createEdgeId 方法，保持与现有布局兼容
  static String createEdgeId(
    String v,
    String w,
    String? name,
    bool isDirected,
  ) {
    if (isDirected || v.compareTo(w) <= 0) {
      return name != null
          ? '\$v\$separator\$w\$separator\$name'
          : '\$v\$separator\$w\$separator\$separator';
    } else {
      return name != null
          ? '\$w\$separator\$v\$separator\$name'
          : '\$w\$separator\$v\$separator\$separator';
    }
  }

  /// 把节点 ID、锚点 ID 和可选 label 组合成复合 ID
  static String generateEdgeId(
    String? sourceNodeId,
    String? targetNodeId,
    String? sourceAnchorId,
    String? targetAnchorId,
    String? name, {
    bool isDirected = true,
  }) {
    final source = sourceNodeId ?? '';
    final target = targetNodeId ?? '';

    String? anchorName;
    if (sourceAnchorId != null && targetAnchorId != null) {
      final a = sourceAnchorId;
      final b = targetAnchorId;
      anchorName =
          (a.compareTo(b) <= 0) ? '\$a\$separator\$b' : '\$b\$separator\$a';
    }

    String? finalName;
    if (anchorName != null && name != null) {
      finalName = '\$anchorName\$separator\$name';
    } else {
      finalName = name;
    }

    return createEdgeId(source, target, finalName, isDirected);
  }
}

/// ========== buildEdgePaint ========== //
/// 用于构建 Paint(颜色,线宽,选中态...), 你也可把它放别处
Paint buildEdgePaint(
  EdgeLineStyle lineStyle,
  EdgeAnimationConfig animConfig,
  bool isSelected,
) {
  // 你项目中可能还有 EdgeLineStyle / EdgeAnimationConfig 类
  // 这里示范
  final color = _parseColorHex(lineStyle.colorHex);
  final paint = Paint()
    ..color = color
    ..strokeWidth = lineStyle.strokeWidth
    ..style = PaintingStyle.stroke;

  if (isSelected) {
    paint.color = paint.color.withOpacity(0.85);
    paint.strokeWidth += 1.5;
  }
  // lineCap / lineJoin, arrow config...
  return paint;
}

/// ========== dashPath ========== //
/// 将 Path 转成虚线
Path dashPath(
  Path source,
  List<double> pattern, {
  double phase = 0.0,
}) {
  final outPath = Path();
  for (final metric in source.computeMetrics()) {
    double distance = 0.0;
    bool draw = true;
    int patternIndex = 0;
    while (distance < metric.length) {
      final lengthToDraw = pattern[patternIndex % pattern.length];
      final segLen = math.min(lengthToDraw, metric.length - distance);

      if (draw) {
        outPath.addPath(
          metric.extractPath(distance + phase, distance + segLen + phase),
          Offset.zero,
        );
      }
      distance += segLen;
      draw = !draw;
      patternIndex++;
    }
  }
  return outPath;
}

/// ========== drawArrowHead ========== //
/// 在 Path 的起点/终点画三角形(或arrow)箭头
void drawArrowHead(
  Canvas canvas,
  Path path,
  Paint paint,
  EdgeLineStyle lineStyle, {
  required bool atStart,
}) {
  final metrics = path.computeMetrics().toList();
  if (metrics.isEmpty) return;

  final metric = atStart ? metrics.first : metrics.last;
  final length = metric.length;
  final tangent = metric.getTangentForOffset(atStart ? 0 : length);
  if (tangent == null) return;

  final position = tangent.position;
  final direction = tangent.vector;
  final arrowSize = lineStyle.arrowSize;
  final arrowAngle = lineStyle.arrowAngleDeg;

  final dir = atStart ? -direction : direction;
  final dirNorm = dir / dir.distance;

  final halfRad = (arrowAngle * 0.5) * math.pi / 180.0;
  Offset rotate(Offset v, double r) {
    final cosT = math.cos(r), sinT = math.sin(r);
    return Offset(
      v.dx * cosT - v.dy * sinT,
      v.dx * sinT + v.dy * cosT,
    );
  }

  final v1 = rotate(dirNorm, halfRad) * arrowSize;
  final v2 = rotate(dirNorm, -halfRad) * arrowSize;
  final p1 = position;
  final p2 = position + v1;
  final p3 = position + v2;

  final arrowPath = Path()
    ..moveTo(p1.dx, p1.dy)
    ..lineTo(p2.dx, p2.dy)
    ..lineTo(p3.dx, p3.dy)
    ..close();

  canvas.drawPath(arrowPath, paint);
}

/// ========== 解析颜色 hex ========== //
Color _parseColorHex(String hexStr) {
  var hex = hexStr.replaceAll('#', '');
  if (hex.length == 6) {
    hex = 'FF$hex'; // 不透明
  }
  if (hex.length == 8) {
    final val = int.parse(hex, radix: 16);
    return Color(val);
  }
  return Colors.black;
}

/// ========== 命中测试(若需要线段Hover/点击) ========== //
bool hitTestEdge(Path path, Offset pointer, double threshold) {
  final metrics = path.computeMetrics();
  for (final metric in metrics) {
    for (double d = 0; d < metric.length; d += 5.0) {
      final tan = metric.getTangentForOffset(d);
      if (tan == null) continue;
      if ((tan.position - pointer).distance <= threshold) {
        return true;
      }
    }
  }
  return false;
}

/// =================== 正交/贝塞尔函数 =================== //
///
/// 你可在 EdgeRenderer switch里调用这些：
///  getOrthogonalPath3Segments, getOrthogonalPath5Segments, getBezierPath, getHVBezierPath
///  (line 用普通 Path moveTo/lineTo)

Path getOrthogonalPath3Segments({
  required double sx,
  required double sy,
  Position? sourcePos,
  required double tx,
  required double ty,
  Position? targetPos,
  double offsetDist = 40.0,
}) {
  final path = Path()..moveTo(sx, sy);
  final (mx1, my1) = _extendOut(sx, sy, sourcePos, offsetDist);
  final (mx2, my2) = _extendOut(tx, ty, targetPos, offsetDist);

  // (sx,sy)->(mx1,my1)->(mx1,my2)->(mx2,my2)->(tx,ty)
  path.lineTo(mx1, my1);
  path.lineTo(mx1, my2);
  path.lineTo(mx2, my2);
  path.lineTo(tx, ty);
  return path;
}

Path getOrthogonalPath5Segments({
  required double sx,
  required double sy,
  Position? sourcePos,
  required double tx,
  required double ty,
  Position? targetPos,
  double offsetDist = 40.0,
}) {
  final path = Path()..moveTo(sx, sy);
  final (mx1, my1) = _extendOut(sx, sy, sourcePos, offsetDist);
  final (mx2, my2) = _extendOut(tx, ty, targetPos, offsetDist);

  path.lineTo(mx1, my1);
  final midY = (my1 + my2) * 0.5;
  path.lineTo(mx1, midY);
  path.lineTo(mx2, midY);
  path.lineTo(mx2, my2);
  path.lineTo(tx, ty);

  return path;
}

/// "距离×曲率"贝塞尔 => 返回 [path, labelX, labelY, offsetX, offsetY]
List<dynamic> getBezierPath({
  required double sourceX,
  required double sourceY,
  required Position sourcePos,
  required double targetX,
  required double targetY,
  required Position targetPos,
  double curvature = 0.25,
}) {
  final sc = _getControlWithCurvature(
    sourcePos,
    sourceX,
    sourceY,
    targetX,
    targetY,
    curvature,
  );
  final (sxC, syC) = (sc[0], sc[1]);

  final tc = _getControlWithCurvature(
    targetPos,
    targetX,
    targetY,
    sourceX,
    sourceY,
    curvature,
  );
  final (txC, tyC) = (tc[0], tc[1]);

  final path = Path()
    ..moveTo(sourceX, sourceY)
    ..cubicTo(sxC, syC, txC, tyC, targetX, targetY);

  // 中点
  final metrics = path.computeMetrics().toList();
  if (metrics.isEmpty) {
    return [
      path,
      (sourceX + targetX) * 0.5,
      (sourceY + targetY) * 0.5,
      0.0,
      0.0,
    ];
  }
  final metric = metrics.first;
  final halfLen = metric.length * 0.5;
  final tan = metric.getTangentForOffset(halfLen);
  if (tan == null) {
    return [
      path,
      (sourceX + targetX) * 0.5,
      (sourceY + targetY) * 0.5,
      0.0,
      0.0,
    ];
  }
  final center = tan.position;
  final dx = (center.dx - sourceX).abs();
  final dy = (center.dy - sourceY).abs();
  return [path, center.dx, center.dy, dx, dy];
}

/// "HV"贝塞尔 => 返回 [path, labelX, labelY, offsetX, offsetY]
List<dynamic> getHVBezierPath({
  required double sourceX,
  required double sourceY,
  required Position sourcePos,
  required double targetX,
  required double targetY,
  required Position targetPos,
  double offset = 50.0,
}) {
  final (sxC, syC) = _getHVControlPoint(sourceX, sourceY, sourcePos, offset);
  final (txC, tyC) = _getHVControlPoint(targetX, targetY, targetPos, offset);

  final path = Path()
    ..moveTo(sourceX, sourceY)
    ..cubicTo(sxC, syC, txC, tyC, targetX, targetY);

  // 中点
  final metrics = path.computeMetrics().toList();
  if (metrics.isEmpty) {
    return [
      path,
      (sourceX + targetX) * 0.5,
      (sourceY + targetY) * 0.5,
      0.0,
      0.0,
    ];
  }
  final metric = metrics.first;
  final halfLen = metric.length * 0.5;
  final tan = metric.getTangentForOffset(halfLen);
  if (tan == null) {
    return [
      path,
      (sourceX + targetX) * 0.5,
      (sourceY + targetY) * 0.5,
      0.0,
      0.0,
    ];
  }
  final center = tan.position;
  final dx = (center.dx - sourceX).abs();
  final dy = (center.dy - sourceY).abs();
  return [path, center.dx, center.dy, dx, dy];
}

// 私有函数: anchorPos => x,y 往外 offsetDist
(double, double) _extendOut(
  double x,
  double y,
  Position? pos,
  double dist,
) {
  if (pos == null) {
    // fallback => no offset
    return (x, y);
  }
  switch (pos) {
    case Position.left:
      return (x - dist, y);
    case Position.right:
      return (x + dist, y);
    case Position.top:
      return (x, y - dist);
    case Position.bottom:
      return (x, y + dist);
  }
}

// 距离<0 => curvature*25*sqrt(-distance)
double _calcControlOffset(double distance, double c) {
  if (distance >= 0) {
    return distance * c;
  }
  return c * 25 * math.sqrt(-distance);
}

/// "距离×curvature" 计算控制点
List<double> _getControlWithCurvature(
  Position pos,
  double x1,
  double y1,
  double x2,
  double y2,
  double c,
) {
  switch (pos) {
    case Position.left:
      final dx = (x1 - x2);
      return [x1 - _calcControlOffset(dx, c), y1];
    case Position.right:
      final dx = (x2 - x1);
      return [x1 + _calcControlOffset(dx, c), y1];
    case Position.top:
      final dy = (y1 - y2);
      return [x1, y1 - _calcControlOffset(dy, c)];
    case Position.bottom:
      final dy = (y2 - y1);
      return [x1, y1 + _calcControlOffset(dy, c)];
  }
}

/// anchorPos => 强制水平或垂直
(double, double) _getHVControlPoint(
  double x1,
  double y1,
  Position pos,
  double offset,
) {
  switch (pos) {
    case Position.left:
      return (x1 - offset, y1);
    case Position.right:
      return (x1 + offset, y1);
    case Position.top:
      return (x1, y1 - offset);
    case Position.bottom:
      return (x1, y1 + offset);
  }
}

// 定义返回值类
class EdgePathPoint {
  final Path path;
  final Offset point;
  EdgePathPoint(this.path, this.point);
}

/// buildEdgePathAndCenter
/// 根据传入的参数和 EdgeMode，构造边的路径，并计算路径中点
EdgePathPoint buildEdgePathAndPoint({
  required EdgeMode mode,
  required double sourceX,
  required double sourceY,
  required Position sourcePos,
  required double targetX,
  required double targetY,
  required Position targetPos,
  double curvature = 0.25,
  double hvOffset = 50.0,
  double orthoDist = 40.0,
  double pathRatio = 0.5, // 控制点在路径的 0~1 位置，默认为 0.5（中心）
}) {
  // 1) 根据 mode 获取原始 path
  Path rawPath;
  switch (mode) {
    case EdgeMode.line:
      // 直线
      rawPath = Path()
        ..moveTo(sourceX, sourceY)
        ..lineTo(targetX, targetY);
      break;

    case EdgeMode.orthogonal3:
      rawPath = getOrthogonalPath3Segments(
        sx: sourceX,
        sy: sourceY,
        sourcePos: sourcePos,
        tx: targetX,
        ty: targetY,
        targetPos: targetPos,
        offsetDist: orthoDist,
      );
      break;

    case EdgeMode.orthogonal5:
      rawPath = getOrthogonalPath5Segments(
        sx: sourceX,
        sy: sourceY,
        sourcePos: sourcePos,
        tx: targetX,
        ty: targetY,
        targetPos: targetPos,
        offsetDist: orthoDist,
      );
      break;

    case EdgeMode.bezier:
      // getBezierPath 返回一个 list: [path, centerX, centerY, dx, dy]
      // 这里我们只需要第一项 (path)
      rawPath = getBezierPath(
        sourceX: sourceX,
        sourceY: sourceY,
        sourcePos: sourcePos,
        targetX: targetX,
        targetY: targetY,
        targetPos: targetPos,
        curvature: curvature,
      )[0] as Path;
      break;

    case EdgeMode.hvBezier:
      rawPath = getHVBezierPath(
        sourceX: sourceX,
        sourceY: sourceY,
        sourcePos: sourcePos,
        targetX: targetX,
        targetY: targetY,
        targetPos: targetPos,
        offset: hvOffset,
      )[0] as Path;
      break;
  }

  // 2) 计算 pathRatio 处的点
  //  - 首先获取 PathMetric
  //  - 然后根据 pathRatio*length 获取 Tangent
  Offset targetPoint;
  final metrics = rawPath.computeMetrics().toList();
  if (metrics.isNotEmpty) {
    final metric = metrics.first; // 假设这里只有一段 path
    final length = metric.length;
    final offsetDist = (pathRatio.clamp(0.0, 1.0)) * length; // 0~length
    final tangent = metric.getTangentForOffset(offsetDist);
    if (tangent != null) {
      targetPoint = tangent.position;
    } else {
      // 如果意外取不到 tangent，就用中点 fallback
      targetPoint = Offset((sourceX + targetX) / 2, (sourceY + targetY) / 2);
    }
  } else {
    // 如果 pathMetric 为空，表示 path 可能无效，fallback -> 中点
    targetPoint = Offset((sourceX + targetX) / 2, (sourceY + targetY) / 2);
  }

  return EdgePathPoint(rawPath, targetPoint);
}

Path simpleLinePath(Offset start, Offset end) {
  return Path()
    ..moveTo(start.dx, start.dy)
    ..lineTo(end.dx, end.dy);
}

(double, double) extendOutSingle(
    double sx, double sy, Position? pos, double dist) {
  if (pos == null) return (sx, sy);
  switch (pos) {
    case Position.left:
      return (sx - dist, sy);
    case Position.right:
      return (sx + dist, sy);
    case Position.top:
      return (sx, sy - dist);
    case Position.bottom:
      return (sx, sy + dist);
  }
}

(double, double) getHVControlPointSingleStandard(
    double sx, double sy, Position pos, double offset) {
  switch (pos) {
    case Position.left:
      return (sx - offset, sy);
    case Position.right:
      return (sx + offset, sy);
    case Position.top:
      return (sx, sy - offset);
    case Position.bottom:
      return (sx, sy + offset);
  }
}

Position guessPosStandard(double sx, double sy, double tx, double ty) {
  return Position.left; // 根据具体需求实现
}

class BezierUtils {
  static void lockAttachments(EdgeModel edge, Path path) {
    if (edge.attachments.isEmpty) return;

    final ms = path.computeMetrics().toList();
    if (ms.isEmpty) return;

    Offset _world(EdgeAttachmentModel a) {
      final seg = a.seg.clamp(0, ms.length - 1);
      return ms[seg].getTangentForOffset(ms[seg].length * a.t)!.position +
          a.offset;
    }

    for (final a in edge.attachments) {
      final world = _world(a);
      // 最近点
      double best = double.infinity;
      int bestSeg = 0;
      double bestT = 0;
      for (var i = 0; i < ms.length; i++) {
        final m = ms[i];
        const sample = 60;
        for (var s = 0; s <= sample; s++) {
          final t = s / sample;
          final d =
              (m.getTangentForOffset(m.length * t)!.position - world).distance;
          if (d < best) {
            best = d;
            bestSeg = i;
            bestT = t;
          }
        }
      }
      a.seg = bestSeg;
      a.t = bestT;
      final base =
          ms[a.seg].getTangentForOffset(ms[a.seg].length * a.t)!.position;
      a.offset = world - base;
    }
  }
}
