import 'dart:math';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flow_editor/core/edge/models/edge_line_style.dart';
import 'package:flow_editor/core/edge/models/edge_enums.dart';
import 'package:flow_editor/core/edge/models/edge_animation_config.dart';

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
        baseColor, style.strokeWidth, isSelected, isHover, isDragging);

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
    // 如果两端都不画箭头，就直接返回
    if (style.arrowStart == ArrowType.none &&
        style.arrowEnd == ArrowType.none) {
      return;
    }

    if (waypoints != null && waypoints.length >= 2) {
      // --- 用 points 方式 ---
      // waypoints 方式：适合折线/动态多点的场景
      _drawArrowByWaypoints(
        canvas: canvas,
        paint: paint,
        style: style,
        waypoints: waypoints,
      );
    } else {
      // --- 用 PathMetric 方式 ---
      // 适合贝塞尔/Orthogonal 等复杂路径
      final metrics = path.computeMetrics().toList();
      if (metrics.isEmpty) return;

      // 起点箭头 => first metric offset=0
      if (style.arrowStart != ArrowType.none) {
        _drawArrowByMetric(
          canvas: canvas,
          metric: metrics.first,
          isStart: true,
          style: style,
          paint: paint,
        );
      }

      // 终点箭头 => last metric offset=length
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

  // ========== 私有辅助函数 ==========
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

  // =============== Waypoints 方式 ===============
  void _drawArrowByWaypoints({
    required Canvas canvas,
    required Paint paint,
    required EdgeLineStyle style,
    required List<Offset> waypoints,
  }) {
    // 如果只想画终点箭头，就画[倒数第2点->最后1点]
    // 如果需要起点箭头，就画[第1点->第2点]
    // 如果是 both，就都画

    // 画“起点箭头”
    if (style.arrowStart != ArrowType.none && waypoints.length > 1) {
      // 取 [0]->[1] 计算方向 (箭头朝第0个点)
      final from = waypoints[1];
      final to = waypoints.first;
      _drawArrowByPoints(canvas, paint, style, from, to);
    }

    // 画“终点箭头”
    if (style.arrowEnd != ArrowType.none && waypoints.length > 1) {
      // 取 [倒数第2]->[倒数第1] 计算方向
      final from = waypoints[waypoints.length - 2];
      final to = waypoints.last;
      _drawArrowByPoints(canvas, paint, style, from, to);
    }
  }

  /// points 直接两个点计算方向
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

  // =============== PathMetric 方式 ===============
  void _drawArrowByMetric({
    required Canvas canvas,
    required PathMetric metric,
    required bool isStart,
    required EdgeLineStyle style,
    required Paint paint,
  }) {
    // offset=0 => 起点； offset=metric.length => 终点
    final offset = isStart ? 0.0 : metric.length;
    final tangent = metric.getTangentForOffset(offset);
    if (tangent == null) return;

    // 如果是起点箭头，需要反向
    final angle = isStart ? tangent.angle + pi : tangent.angle;
    final arrowAngle = radians(style.arrowAngleDeg);

    final path = Path()
      ..moveTo(tangent.position.dx, tangent.position.dy)
      ..lineTo(
        tangent.position.dx - style.arrowSize * cos(angle - arrowAngle),
        tangent.position.dy - style.arrowSize * sin(angle - arrowAngle),
      )
      ..moveTo(tangent.position.dx, tangent.position.dy)
      ..lineTo(
        tangent.position.dx - style.arrowSize * cos(angle + arrowAngle),
        tangent.position.dy - style.arrowSize * sin(angle + arrowAngle),
      );

    canvas.drawPath(path, paint);
  }

  Color _parseColor(String hex) {
    final hexValue = hex.replaceAll('#', '').padLeft(8, 'FF');
    return Color(int.parse(hexValue, radix: 16));
  }

  double radians(double degrees) => degrees * pi / 180;
}
