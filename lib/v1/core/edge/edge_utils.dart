// file: edge_utils.dart
import 'dart:math' as math;
import 'package:flutter/material.dart';

// 如果你项目中有以下类或枚举，请改为实际import:
import '../types/position_enum.dart'; // Position { left, right, top, bottom }
import 'models/edge_line_style.dart';
import 'models/edge_animation_config.dart';

/// ======================= Paint & Dash & Arrow ======================= ///

/// 构建Edge画笔
Paint buildEdgePaint(
  EdgeLineStyle lineStyle,
  EdgeAnimationConfig animConfig,
  bool isSelected,
) {
  final color = _parseColorHex(lineStyle.colorHex);
  final paint = Paint()
    ..color = color
    ..strokeWidth = lineStyle.strokeWidth
    ..style = PaintingStyle.stroke;

  if (isSelected) {
    paint.color = paint.color.withOpacity(0.85);
    paint.strokeWidth += 1.5;
  }
  // 若 animConfig需要闪烁 => 在外部负责刷新
  return paint;
}

/// 虚线
Path dashPath(Path source, List<double> pattern, {double phase = 0.0}) {
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

/// 画箭头(三角形)在 path 起点/终点
void drawArrowHead(
  Canvas canvas,
  Path path,
  Paint paint,
  EdgeLineStyle lineStyle, {
  required bool atStart,
}) {
  final pathMetrics = path.computeMetrics().toList();
  if (pathMetrics.isEmpty) return;

  final metric = atStart ? pathMetrics.first : pathMetrics.last;
  final length = metric.length;
  final tangent = metric.getTangentForOffset(atStart ? 0 : length);
  if (tangent == null) return;

  final position = tangent.position;
  final direction = tangent.vector; // (dx,dy)
  final arrowSize = lineStyle.arrowSize;
  final arrowAngle = lineStyle.arrowAngleDeg;

  // if atStart => 反向
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

/// ==================== "普通" Bézier(基于distance*curvature) ==================== //

/// distance<0 => curvature*25*sqrt(-distance)
double calculateControlOffset(double distance, double curvature) {
  if (distance >= 0) {
    return distance * curvature;
  }
  // distance<0 => bigger
  return curvature * 25 * math.sqrt(-distance);
}

/// 为 source/target 各自算一个控制点
List<double> getControlWithCurvature({
  required Position pos,
  required double x1,
  required double y1,
  required double x2,
  required double y2,
  required double c,
}) {
  switch (pos) {
    case Position.left:
      final dx = x1 - x2;
      return [x1 - calculateControlOffset(dx, c), y1];
    case Position.right:
      final dx = x2 - x1;
      return [x1 + calculateControlOffset(dx, c), y1];
    case Position.top:
      final dy = y1 - y2;
      return [x1, y1 - calculateControlOffset(dy, c)];
    case Position.bottom:
      final dy = y2 - y1;
      return [x1, y1 + calculateControlOffset(dy, c)];
  }
}

/// 根据 sourceControl / targetControl => 生成三次贝塞尔 path, 并计算中点
/// 返回: [Path, labelX, labelY, offsetX, offsetY]
List<dynamic> getBezierPath({
  required double sourceX,
  required double sourceY,
  required Position sourcePosition,
  required double targetX,
  required double targetY,
  required Position targetPosition,
  double curvature = 0.25,
}) {
  final sc = getControlWithCurvature(
    pos: sourcePosition,
    x1: sourceX,
    y1: sourceY,
    x2: targetX,
    y2: targetY,
    c: curvature,
  );
  final tc = getControlWithCurvature(
    pos: targetPosition,
    x1: targetX,
    y1: targetY,
    x2: sourceX,
    y2: sourceY,
    c: curvature,
  );
  final (sxC, syC) = (sc[0], sc[1]);
  final (txC, tyC) = (tc[0], tc[1]);

  // 构建path
  final path = Path()
    ..moveTo(sourceX, sourceY)
    ..cubicTo(sxC, syC, txC, tyC, targetX, targetY);

  // 计算中点 => t=0.5
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
  final tangent = metric.getTangentForOffset(halfLen);
  if (tangent == null) {
    return [
      path,
      (sourceX + targetX) * 0.5,
      (sourceY + targetY) * 0.5,
      0.0,
      0.0,
    ];
  }
  final center = tangent.position;
  final dx = (center.dx - sourceX).abs();
  final dy = (center.dy - sourceY).abs();
  return [path, center.dx, center.dy, dx, dy];
}

/// ==================== HV Bézier(起点/终点水平/垂直离开) ==================== //

/// 强制让线段在 anchorPos=left/right 时 水平离开/进入,
/// anchorPos=top/bottom 时 垂直离开/进入.
/// offset => 偏移量 (比如50)
List<dynamic> getHVBezierPath({
  required double sourceX,
  required double sourceY,
  required Position sourcePos,
  required double targetX,
  required double targetY,
  required Position targetPos,
  double offset = 50.0,
}) {
  // 1) 起点控制
  final (sxC, syC) = _getHVControlPoint(
      x1: sourceX, y1: sourceY, anchorPos: sourcePos, offset: offset);
  // 2) 终点控制
  final (txC, tyC) = _getHVControlPoint(
      x1: targetX, y1: targetY, anchorPos: targetPos, offset: offset);

  // 3) 构建三次贝塞尔
  final path = Path()
    ..moveTo(sourceX, sourceY)
    ..cubicTo(sxC, syC, txC, tyC, targetX, targetY);

  // 4) 算中点 => path metric
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

/// 内部 => 根据 anchorPos, 固定水平/垂直往外 offset
(double, double) _getHVControlPoint({
  required double x1,
  required double y1,
  required Position anchorPos,
  required double offset,
}) {
  switch (anchorPos) {
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

/// ==================== 命中测试(可选) ==================== //
/// 若想检测鼠标点是否命中edge, 用 path+point+threshold
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
