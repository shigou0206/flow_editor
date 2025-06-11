import 'dart:math';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flow_editor/core/models/styles/edge_line_style.dart';
import 'package:flow_editor/core/models/enums/edge_enums.dart';
import 'package:flow_editor/core/models/styles/edge_animation_config.dart';

class EdgeStyleResolver {
  const EdgeStyleResolver();

  Paint resolvePaint(
    EdgeLineStyle style,
    bool isSelected, {
    bool isHover = false,
    bool isDragging = false,
  }) {
    final baseColor = _parseColor(style.colorHex);

    final (color, opacity, strokeWidth) = _resolvePaintAttributes(
      baseColor,
      style.strokeWidth,
      isSelected,
      isHover,
      isDragging,
    );

    return Paint()
      ..color = color.withOpacity(opacity)
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.values[style.lineCap.index]
      ..strokeJoin = StrokeJoin.values[style.lineJoin.index];
  }

  Paint resolveGhostPaint(EdgeLineStyle style) {
    return Paint()
      ..color = Colors.orange
      ..strokeWidth = 3
      ..style = PaintingStyle.stroke;
  }

  void drawArrowIfNeeded({
    required Canvas canvas,
    required Path path,
    required Paint paint,
    required EdgeLineStyle style,
    List<Offset>? waypoints,
  }) {
    if (style.arrowStart == ArrowType.none &&
        style.arrowEnd == ArrowType.none) {
      return;
    }

    if (waypoints != null && waypoints.length >= 2) {
      _drawArrowByWaypoints(
        canvas: canvas,
        paint: paint,
        style: style,
        waypoints: waypoints,
      );
    } else {
      final metrics = path.computeMetrics().toList();
      if (metrics.isEmpty) return;

      if (style.arrowStart != ArrowType.none) {
        _drawArrowByMetric(
          canvas: canvas,
          metric: metrics.first,
          isStart: true,
          style: style,
          paint: paint,
        );
      }

      if (style.arrowEnd != ArrowType.none) {
        _drawArrowByMetric(
          canvas: canvas,
          metric: metrics.last,
          isStart: false,
          style: style,
          paint: paint,
        );
      }
    }
  }

  double computeDashFlowPhase(EdgeAnimationConfig animConfig) {
    return animConfig.animateDash ? (animConfig.dashFlowPhase ?? 0.0) : 0.0;
  }

  (Color, double, double) _resolvePaintAttributes(
    Color baseColor,
    double baseWidth,
    bool selected,
    bool hover,
    bool dragging,
  ) {
    if (dragging) {
      return (Colors.orangeAccent, 1.0, baseWidth * 1.2);
    }
    if (selected) {
      return (baseColor, 1.0, baseWidth);
    }
    if (hover) {
      return (baseColor, 0.7, baseWidth * 1.1);
    }
    return (baseColor, 0.5, baseWidth);
  }

  /// 根据Waypoints绘制箭头
  void _drawArrowByWaypoints({
    required Canvas canvas,
    required Paint paint,
    required EdgeLineStyle style,
    required List<Offset> waypoints,
  }) {
    // 起点箭头（指向waypoints.first）
    if (style.arrowStart != ArrowType.none && waypoints.length > 1) {
      final from = waypoints[1];
      final to = waypoints[0]; // 箭头头部位置
      _drawArrowByPoints(canvas, paint, style, from, to);
    }

    // 终点箭头（指向waypoints.last）
    if (style.arrowEnd != ArrowType.none && waypoints.length > 1) {
      final from = waypoints[waypoints.length - 2];
      final to = waypoints.last; // 箭头头部位置
      _drawArrowByPoints(canvas, paint, style, from, to);
    }
  }

  /// 根据两个点绘制单个箭头（箭头头部指向to点）
  void _drawArrowByPoints(
      Canvas canvas, Paint paint, EdgeLineStyle style, Offset from, Offset to) {
    final angle = (to - from).direction;
    final arrowAngle = radians(style.arrowAngleDeg);

    final path = Path()
      ..moveTo(to.dx, to.dy)
      ..lineTo(
        to.dx - style.arrowSize * cos(angle - arrowAngle),
        to.dy - style.arrowSize * sin(angle - arrowAngle),
      )
      ..moveTo(to.dx, to.dy)
      ..lineTo(
        to.dx - style.arrowSize * cos(angle + arrowAngle),
        to.dy - style.arrowSize * sin(angle + arrowAngle),
      );

    canvas.drawPath(path, paint);
  }

  /// 根据PathMetric绘制箭头
// 修正后的 _drawArrowByMetric 方法
  // void _drawArrowByMetric({
  //   required Canvas canvas,
  //   required PathMetric metric,
  //   required bool isStart,
  //   required EdgeLineStyle style,
  //   required Paint paint,
  // }) {
  //   final offset = isStart ? 0.0 : metric.length;
  //   final tangent = metric.getTangentForOffset(offset);
  //   if (tangent == null) return;

  //   double angle = tangent.angle;

  //   if (isStart) {
  //     angle += pi;
  //   }
  //   final arrowAngle = radians(style.arrowAngleDeg);

  //   debugPrint('🚩 Arrow drawn at ${tangent.position} with angle: $angle');

  //   final path = Path()
  //     ..moveTo(tangent.position.dx, tangent.position.dy)
  //     ..lineTo(
  //       tangent.position.dx - style.arrowSize * cos(angle - arrowAngle),
  //       tangent.position.dy - style.arrowSize * sin(angle - arrowAngle),
  //     )
  //     ..moveTo(tangent.position.dx, tangent.position.dy)
  //     ..lineTo(
  //       tangent.position.dx - style.arrowSize * cos(angle + arrowAngle),
  //       tangent.position.dy - style.arrowSize * sin(angle + arrowAngle),
  //     );

  //   canvas.drawPath(path, paint);
  // }

  void _drawArrowByMetric({
    required Canvas canvas,
    required PathMetric metric,
    required bool isStart,
    required EdgeLineStyle style,
    required Paint paint,
  }) {
    final offset = isStart ? 0.0 : metric.length;
    final tangent = metric.getTangentForOffset(offset);
    if (tangent == null) return;

    // 🧠 使用 vector 方向判断角度（始终朝向目标）
    final direction = isStart ? -tangent.vector : tangent.vector;
    final angle = atan2(direction.dy, direction.dx);
    final arrowAngle = radians(style.arrowAngleDeg);

    final pos = tangent.position;
    final size = style.arrowSize;

    debugPrint('🚩 Arrow drawn at $pos with angle: $angle');

    final path = Path()
      ..moveTo(pos.dx, pos.dy)
      ..lineTo(
        pos.dx - size * cos(angle - arrowAngle),
        pos.dy - size * sin(angle - arrowAngle),
      )
      ..moveTo(pos.dx, pos.dy)
      ..lineTo(
        pos.dx - size * cos(angle + arrowAngle),
        pos.dy - size * sin(angle + arrowAngle),
      );

    canvas.drawPath(path, paint);
  }

  Color _parseColor(String hex) {
    final hexValue = hex.replaceAll('#', '').padLeft(8, 'FF');
    return Color(int.parse(hexValue, radix: 16));
  }

  double radians(double degrees) => degrees * pi / 180;
}
