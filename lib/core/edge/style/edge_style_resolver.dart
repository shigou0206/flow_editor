import 'dart:math';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flow_editor/core/edge/models/edge_line_style.dart';
import 'package:flow_editor/core/edge/models/edge_enums.dart';
import 'package:flow_editor/core/types/position_enum.dart';
import 'package:flow_editor/core/edge/utils/edge_utils.dart';
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

  Path resolvePath(
    EdgeMode edgeMode,
    Offset sourceWorld,
    Position? sourcePos,
    Offset targetWorld,
    Position? targetPos,
  ) {
    switch (edgeMode) {
      case EdgeMode.line:
        return _simpleLinePath(sourceWorld, targetWorld);
      case EdgeMode.orthogonal3:
        return getOrthogonalPath3Segments(
          sx: sourceWorld.dx,
          sy: sourceWorld.dy,
          sourcePos: sourcePos,
          tx: targetWorld.dx,
          ty: targetWorld.dy,
          targetPos: targetPos,
          offsetDist: 40,
        );
      case EdgeMode.orthogonal5:
        return getOrthogonalPath5Segments(
          sx: sourceWorld.dx,
          sy: sourceWorld.dy,
          sourcePos: sourcePos,
          tx: targetWorld.dx,
          ty: targetWorld.dy,
          targetPos: targetPos,
          offsetDist: 40,
        );
      case EdgeMode.bezier:
        return getBezierPath(
          sourceX: sourceWorld.dx,
          sourceY: sourceWorld.dy,
          sourcePosition: sourcePos!,
          targetX: targetWorld.dx,
          targetY: targetWorld.dy,
          targetPosition: targetPos!,
          curvature: 0.25,
        )[0];
      case EdgeMode.hvBezier:
        return getHVBezierPath(
          sourceX: sourceWorld.dx,
          sourceY: sourceWorld.dy,
          sourcePos: sourcePos!,
          targetX: targetWorld.dx,
          targetY: targetWorld.dy,
          targetPos: targetPos!,
          offset: 50.0,
        )[0];
    }
  }

  Path resolveGhostPath(
    EdgeMode edgeMode,
    Offset sourceWorld,
    Position? sourcePos,
    Offset draggingEnd,
  ) {
    final sx = sourceWorld.dx, sy = sourceWorld.dy;
    final tx = draggingEnd.dx, ty = draggingEnd.dy;

    switch (edgeMode) {
      case EdgeMode.line:
        return _simpleLinePath(sourceWorld, draggingEnd);
      case EdgeMode.orthogonal3:
        final (mx, my) = _extendOutSingle(sx, sy, sourcePos, 40);
        return Path()
          ..moveTo(sx, sy)
          ..lineTo(mx, my)
          ..lineTo(mx, ty)
          ..lineTo(tx, ty);
      case EdgeMode.orthogonal5:
        final (mx, my) = _extendOutSingle(sx, sy, sourcePos, 40);
        final midY = (my + ty) / 2;
        return Path()
          ..moveTo(sx, sy)
          ..lineTo(mx, my)
          ..lineTo(mx, midY)
          ..lineTo(tx, midY)
          ..lineTo(tx, ty);
      case EdgeMode.bezier:
        if (sourcePos != null) {
          final (sxC, syC) =
              _getHVControlPointSingleStandard(sx, sy, sourcePos, 50);
          return Path()
            ..moveTo(sx, sy)
            ..cubicTo(sxC, syC, tx, ty, tx, ty);
        } else {
          return _simpleLinePath(sourceWorld, draggingEnd);
        }
      case EdgeMode.hvBezier:
        if (sourcePos != null) {
          final guessedPos = _guessPosStandard(sx, sy, tx, ty);
          final (sxC, syC) =
              _getHVControlPointSingleStandard(sx, sy, sourcePos, 50);
          final (txC, tyC) =
              _getHVControlPointSingleStandard(tx, ty, guessedPos, 50);
          return Path()
            ..moveTo(sx, sy)
            ..cubicTo(sxC, syC, txC, tyC, tx, ty);
        } else {
          return _simpleLinePath(sourceWorld, draggingEnd);
        }
    }
  }

  void drawArrowIfNeeded(
      Canvas canvas, Path path, Paint paint, EdgeLineStyle style) {
    final metrics = path.computeMetrics().toList();
    if (metrics.isEmpty) return;
    final metric = metrics.first;

    _drawArrow(canvas, metric, 0, style.arrowStart, style, paint,
        reverse: true);
    _drawArrow(canvas, metric, metric.length, style.arrowEnd, style, paint);
  }

  double computeDashFlowPhase(EdgeAnimationConfig animConfig) {
    return animConfig.animateDash ? (animConfig.dashFlowPhase ?? 0.0) : 0.0;
  }

  // ========== 私有辅助函数 ==========

  Path _simpleLinePath(Offset start, Offset end) {
    return Path()
      ..moveTo(start.dx, start.dy)
      ..lineTo(end.dx, end.dy);
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

  void _drawArrow(Canvas canvas, PathMetric metric, double offset,
      ArrowType type, EdgeLineStyle style, Paint paint,
      {bool reverse = false}) {
    if (type == ArrowType.none) return;

    final tangent = metric.getTangentForOffset(offset);
    if (tangent == null) return;

    final angle = reverse ? tangent.angle + pi : tangent.angle;
    final arrowPath = Path()
      ..moveTo(tangent.position.dx, tangent.position.dy)
      ..lineTo(
          tangent.position.dx -
              style.arrowSize * cos(angle - radians(style.arrowAngleDeg)),
          tangent.position.dy -
              style.arrowSize * sin(angle - radians(style.arrowAngleDeg)))
      ..moveTo(tangent.position.dx, tangent.position.dy)
      ..lineTo(
          tangent.position.dx -
              style.arrowSize * cos(angle + radians(style.arrowAngleDeg)),
          tangent.position.dy -
              style.arrowSize * sin(angle + radians(style.arrowAngleDeg)));

    canvas.drawPath(arrowPath, paint);
  }

  Color _parseColor(String hex) {
    final hexValue = hex.replaceAll('#', '').padLeft(8, 'FF');
    return Color(int.parse(hexValue, radix: 16));
  }

  (double, double) _extendOutSingle(
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

  (double, double) _getHVControlPointSingleStandard(
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

  Position _guessPosStandard(double sx, double sy, double tx, double ty) {
    return Position.left; // 根据具体需求实现
  }

  double radians(double degrees) => degrees * pi / 180;
}
