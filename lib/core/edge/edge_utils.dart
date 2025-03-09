import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flow_editor/core/types/position_enum.dart';
import 'package:flow_editor/core/edge/models/edge_line_style.dart';
import 'package:flow_editor/core/edge/models/edge_animation_config.dart';

/// ===================== Edge Paint & Dash Utils ===================== //

/// 构建用于绘制边(Line)的 [Paint]。
///
/// - [lineStyle] 提供颜色, 线宽, 虚线参数(dashPattern), 箭头size等；
/// - [animConfig] 若需要动画(颜色闪烁)可在此处处理；
/// - [isSelected] => 选中时可加粗/变色。
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

  // 如果选中 => 加粗/微调颜色
  if (isSelected) {
    paint.color = paint.color.withOpacity(0.85);
    paint.strokeWidth += 1.5;
  }

  // 可额外根据 animConfig 做闪烁/渐变
  return paint;
}

/// 将 [source] Path 转换为虚线 (dash) 形式的 Path。
///
/// [pattern] => e.g. [5,3] => 5px 实线,3px 空白重复；
/// [phase] => dash流动动画起始偏移，可配合 dashFlowPhase。
Path dashPath(
  Path source,
  List<double> pattern, {
  double phase = 0.0,
}) {
  // 你可使用第三方 dash_path/dashed_path，这里手写一个简单实现:
  final metrics = source.computeMetrics();
  final outPath = Path();

  for (final metric in metrics) {
    double distance = 0.0;
    bool draw = true; // 是否画(实线) or 跳过(空白)
    int patternIndex = 0;

    while (distance < metric.length) {
      final lengthToDraw = pattern[patternIndex % pattern.length];
      final segmentLen = math.min(lengthToDraw, metric.length - distance);

      if (draw) {
        outPath.addPath(
          metric.extractPath(distance + phase, distance + segmentLen + phase),
          Offset.zero,
        );
      }
      distance += segmentLen;
      draw = !draw;
      patternIndex++;
    }
  }

  return outPath;
}

/// 在 Path 的起点或终点绘制三角形箭头。
///
/// - [lineStyle] => arrowSize (像素), arrowAngleDeg(三角形张角)，arrowStart/arrowEnd决定是否画；
/// - [atStart]=true => 在path起点画，否则终点画。
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
  // 取 offset=0(起点) 或 offset=length(终点)
  final tangent = metric.getTangentForOffset(atStart ? 0 : length);
  if (tangent == null) return;

  final position = tangent.position; // 箭头所在坐标
  final direction = tangent.vector; // 切线方向(单位向量)

  // 箭头大小 & 角度
  final arrowSize = lineStyle.arrowSize;
  final arrowAngle = lineStyle.arrowAngleDeg;

  // 构建三角形顶点
  // arrowAngleDeg => 半角 => (arrowAngle/2) 往左右旋转
  final halfRadians = (arrowAngle / 2.0) * math.pi / 180.0;

  // 当 atStart=true => 方向要反转(朝source)
  final dir = atStart ? -direction : direction;

  // A = position
  // B = A + dir旋转(halfRadians)*arrowSize
  // C = A + dir旋转(-halfRadians)*arrowSize
  // 旋转一个向量: (xcosθ - ysinθ, xsinθ + ycosθ)
  Offset rotate(Offset v, double rad) {
    final cosTheta = math.cos(rad), sinTheta = math.sin(rad);
    return Offset(
      v.dx * cosTheta - v.dy * sinTheta,
      v.dx * sinTheta + v.dy * cosTheta,
    );
  }

  // dir 要先归一化 => metric.getTangentForOffset()返回的 vector通常已归一
  // 但最好再次归一, 避免误差
  final dirNorm = dir / dir.distance;

  final v1 = rotate(dirNorm, halfRadians) * arrowSize;
  final v2 = rotate(dirNorm, -halfRadians) * arrowSize;

  final p1 = position;
  final p2 = position + v1;
  final p3 = position + v2;

  // 画三角形
  final arrowPath = Path()
    ..moveTo(p1.dx, p1.dy)
    ..lineTo(p2.dx, p2.dy)
    ..lineTo(p3.dx, p3.dy)
    ..close();

  canvas.drawPath(arrowPath, paint);
}

/// 解析颜色 "#RRGGBB" 或 "#AARRGGBB"
Color _parseColorHex(String hexStr) {
  String hex = hexStr.replaceAll('#', '');
  if (hex.length == 6) {
    hex = 'FF$hex'; // 默认不透明
  }
  if (hex.length == 8) {
    final val = int.parse(hex, radix: 16);
    return Color(val);
  }
  return Colors.black;
}

/// ===================== Bézier Curvature Logic ===================== //

/// 计算控制点偏移量 => 距离 * curvature (无论正负),
/// 若 distance<0, 用 curvature * 25 * sqrt(-distance) 做放大.
double calculateControlOffset(double distance, double curvature) {
  if (distance >= 0) {
    // 改为 distance * curvature
    return distance * curvature;
  }
  // distance <0 => curvature*25*sqrt(-distance)
  return curvature * 25 * math.sqrt(-distance);
}

/// 根据位置 [pos] (left/right/top/bottom) & (x1,y1->x2,y2) + curvature
/// 计算三次贝塞尔曲线其中一个控制点
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

/// 计算三次贝塞尔在 t=0.5 处的中点坐标(用于 label / offset)
List<double> getBezierEdgeCenter({
  required double sourceX,
  required double sourceY,
  required double sourceControlX,
  required double sourceControlY,
  required double targetControlX,
  required double targetControlY,
  required double targetX,
  required double targetY,
}) {
  // t=0.5, Bernstein系数(1/8,3/8,3/8,1/8)
  final centerX = sourceX * 0.125 +
      sourceControlX * 0.375 +
      targetControlX * 0.375 +
      targetX * 0.125;
  final centerY = sourceY * 0.125 +
      sourceControlY * 0.375 +
      targetControlY * 0.375 +
      targetY * 0.125;

  final offsetX = (centerX - sourceX).abs();
  final offsetY = (centerY - sourceY).abs();
  return [centerX, centerY, offsetX, offsetY];
}

/// 生成三次贝塞尔路径 + 中点信息:
/// 返回 [Path, labelX, labelY, offsetX, offsetY].
List<dynamic> getBezierPath({
  required double sourceX,
  required double sourceY,
  required Position sourcePosition,
  required double targetX,
  required double targetY,
  required Position targetPosition,
  double curvature = 0.25,
}) {
  // 1) 控制点
  final sourceCtrl = getControlWithCurvature(
    pos: sourcePosition,
    x1: sourceX,
    y1: sourceY,
    x2: targetX,
    y2: targetY,
    c: curvature,
  );
  final targetCtrl = getControlWithCurvature(
    pos: targetPosition,
    x1: targetX,
    y1: targetY,
    x2: sourceX,
    y2: sourceY,
    c: curvature,
  );

  final (sxC, syC) = (sourceCtrl[0], sourceCtrl[1]);
  final (txC, tyC) = (targetCtrl[0], targetCtrl[1]);

  // 2) 求曲线中点
  final centerInfo = getBezierEdgeCenter(
    sourceX: sourceX,
    sourceY: sourceY,
    sourceControlX: sxC,
    sourceControlY: syC,
    targetControlX: txC,
    targetControlY: tyC,
    targetX: targetX,
    targetY: targetY,
  );

  // 3) 构建路径
  final path = Path()
    ..moveTo(sourceX, sourceY)
    ..cubicTo(sxC, syC, txC, tyC, targetX, targetY);

  return [
    path,
    centerInfo[0], // labelX
    centerInfo[1], // labelY
    centerInfo[2], // offsetX
    centerInfo[3], // offsetY
  ];
}
