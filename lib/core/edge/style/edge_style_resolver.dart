import 'package:flutter/material.dart';
import 'package:flow_editor/core/edge/models/edge_line_style.dart';
import 'package:flow_editor/core/edge/models/edge_enums.dart';
import 'package:flow_editor/core/types/position_enum.dart';
import 'package:flow_editor/core/edge/utils/edge_utils.dart';
import 'package:flow_editor/core/edge/models/edge_animation_config.dart';
import 'dart:math';

class EdgeStyleResolver {
  const EdgeStyleResolver();

  Paint resolvePaint(
    EdgeLineStyle style,
    bool isSelected, {
    bool isHover = false,
    bool isDragging = false,
  }) {
    final baseColor = _parseColor(style.colorHex);

    Color finalColor;
    double finalOpacity = 0.5;
    double finalStrokeWidth = style.strokeWidth;

    if (isDragging) {
      finalColor = Colors.orangeAccent;
      finalOpacity = 1.0;
      finalStrokeWidth *= 1.2;
    } else if (isSelected) {
      finalColor = baseColor;
      finalOpacity = 1.0;
    } else if (isHover) {
      finalColor = baseColor;
      finalOpacity = 0.7;
      finalStrokeWidth *= 1.1;
    } else {
      finalColor = baseColor;
      finalOpacity = 0.5;
    }

    return Paint()
      ..color = finalColor.withOpacity(finalOpacity)
      ..strokeWidth = finalStrokeWidth
      ..style = PaintingStyle.stroke
      ..strokeCap = _toStrokeCap(style.lineCap)
      ..strokeJoin = _toStrokeJoin(style.lineJoin);
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
        return Path()
          ..moveTo(sourceWorld.dx, sourceWorld.dy)
          ..lineTo(targetWorld.dx, targetWorld.dy);

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
    final sx = sourceWorld.dx;
    final sy = sourceWorld.dy;
    final tx = draggingEnd.dx;
    final ty = draggingEnd.dy;

    switch (edgeMode) {
      case EdgeMode.line:
        return Path()
          ..moveTo(sx, sy)
          ..lineTo(tx, ty);

      case EdgeMode.orthogonal3:
        {
          final (mx1, my1) = _extendOutSingle(sx, sy, sourcePos, 40);
          return Path()
            ..moveTo(sx, sy)
            ..lineTo(mx1, my1)
            ..lineTo(mx1, ty)
            ..lineTo(tx, ty);
        }

      case EdgeMode.orthogonal5:
        {
          final (mx1, my1) = _extendOutSingle(sx, sy, sourcePos, 40);
          final midY = (my1 + ty) * 0.5;
          return Path()
            ..moveTo(sx, sy)
            ..lineTo(mx1, my1)
            ..lineTo(mx1, midY)
            ..lineTo(tx, midY)
            ..lineTo(tx, ty);
        }

      case EdgeMode.bezier:
        {
          if (sourcePos != null) {
            final (sxC, syC) =
                _getHVControlPointSingleStandard(sx, sy, sourcePos, 50);
            return Path()
              ..moveTo(sx, sy)
              ..cubicTo(sxC, syC, tx, ty, tx, ty);
          } else {
            return Path()
              ..moveTo(sx, sy)
              ..lineTo(tx, ty);
          }
        }

      case EdgeMode.hvBezier:
        {
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
            return Path()
              ..moveTo(sx, sy)
              ..lineTo(tx, ty);
          }
        }
    }
  }

  void drawArrowIfNeeded(
      Canvas canvas, Path path, Paint paint, EdgeLineStyle style) {
    final pathMetrics = path.computeMetrics();
    if (pathMetrics.isEmpty) return;

    final metric = pathMetrics.first;

    if (style.arrowStart != ArrowType.none) {
      final tangent = metric.getTangentForOffset(0);
      if (tangent != null) {
        drawArrow(canvas, tangent.position, tangent.angle + pi, style, paint);
      }
    }

    if (style.arrowEnd != ArrowType.none) {
      final tangent = metric.getTangentForOffset(metric.length);
      if (tangent != null) {
        drawArrow(canvas, tangent.position, tangent.angle, style, paint);
      }
    }
  }

  void drawArrow(Canvas canvas, Offset position, double angle,
      EdgeLineStyle style, Paint paint) {
    final arrowAngleRad = style.arrowAngleDeg * (pi / 180.0);
    final arrowLength = style.arrowSize;

    final path = Path()
      ..moveTo(position.dx, position.dy)
      ..lineTo(position.dx - arrowLength * cos(angle - arrowAngleRad),
          position.dy - arrowLength * sin(angle - arrowAngleRad))
      ..moveTo(position.dx, position.dy)
      ..lineTo(position.dx - arrowLength * cos(angle + arrowAngleRad),
          position.dy - arrowLength * sin(angle + arrowAngleRad));

    canvas.drawPath(path, paint);
  }

  Color _parseColor(String hex) {
    final hexValue = hex.replaceAll('#', '').padLeft(8, 'FF');
    return Color(int.parse(hexValue, radix: 16));
  }

  StrokeCap _toStrokeCap(EdgeLineCap cap) {
    return StrokeCap.values[cap.index];
  }

  StrokeJoin _toStrokeJoin(EdgeLineJoin join) {
    return StrokeJoin.values[join.index];
  }

  double computeDashFlowPhase(EdgeAnimationConfig animConfig) {
    if (!animConfig.animateDash || animConfig.dashFlowPhase == null) {
      return 0.0;
    }
    return animConfig.dashFlowPhase!;
  }

  // StrokeJoin _toStrokeJoin(EdgeLineJoin join) {
  //   switch (join) {
  //     case EdgeLineJoin.round:
  //       return StrokeJoin.round;
  //     case EdgeLineJoin.bevel:
  //       return StrokeJoin.bevel;
  //     case EdgeLineJoin.miter:
  //     default:
  //       return StrokeJoin.miter;
  //   }
  // }

  // ======== Orthogonal / hvBezier 拓展配合的函数 ==========
  (double, double) _extendOutSingle(
    double sx,
    double sy,
    Position? pos,
    double dist,
  ) {
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
    double sx,
    double sy,
    Position pos,
    double offset,
  ) {
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
    // 这里只是演示, 按你需要实现
    return Position.left;
  }
}
