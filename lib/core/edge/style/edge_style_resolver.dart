import 'package:flutter/material.dart';
import 'package:flow_editor/core/edge/models/edge_line_style.dart';
import 'package:flow_editor/core/edge/models/edge_enums.dart';
import 'package:flow_editor/core/edge/models/edge_animation_config.dart';
import 'package:flow_editor/core/types/position_enum.dart';
import 'package:flow_editor/core/edge/utils/edge_utils.dart';

class EdgeStyleResolver {
  const EdgeStyleResolver();

  /// 根据 edge 的各种状态 (isDragging / isSelected / isHover)
  /// 返回一支 Paint，用于实际画线。
  Paint resolvePaint(
    EdgeLineStyle style,
    bool isSelected, {
    bool isHover = false,
    bool isDragging = false,
  }) {
    // 1) 基础色
    final baseColor = _parseColor(style.colorHex);

    // 2) 优先级: 拖拽 > 选中 > 悬停 > 默认
    Color finalColor;
    double finalOpacity = 0.5;
    double finalStrokeWidth = style.strokeWidth;

    if (isDragging) {
      finalColor = Colors.orangeAccent; // 拖拽优先
      finalOpacity = 1.0;
      finalStrokeWidth *= 1.2; // 拖拽时稍加粗
    } else if (isSelected) {
      finalColor = baseColor; // 选中
      finalOpacity = 1.0;
    } else if (isHover) {
      finalColor = baseColor; // 悬停
      finalOpacity = 0.7;
      finalStrokeWidth *= 1.1; // 悬停时略加粗
    } else {
      // 默认
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

  /// 拖拽中的“幽灵线”专用 Paint
  Paint resolveGhostPaint(EdgeLineStyle style) {
    return Paint()
      ..color = Colors.orange
      ..strokeWidth = 3
      ..style = PaintingStyle.stroke;
  }

  /// 根据 edgeMode 构建实际连接路径 (source->target)
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
        if (sourcePos != null && targetPos != null) {
          final result = getBezierPath(
            sourceX: sourceWorld.dx,
            sourceY: sourceWorld.dy,
            sourcePosition: sourcePos,
            targetX: targetWorld.dx,
            targetY: targetWorld.dy,
            targetPosition: targetPos,
            curvature: 0.25,
          );
          return result[0] as Path;
        } else {
          return Path()
            ..moveTo(sourceWorld.dx, sourceWorld.dy)
            ..lineTo(targetWorld.dx, targetWorld.dy);
        }

      case EdgeMode.hvBezier:
        if (sourcePos != null && targetPos != null) {
          final result = getHVBezierPath(
            sourceX: sourceWorld.dx,
            sourceY: sourceWorld.dy,
            sourcePos: sourcePos,
            targetX: targetWorld.dx,
            targetY: targetWorld.dy,
            targetPos: targetPos,
            offset: 50.0,
          );
          return result[0] as Path;
        } else {
          return Path()
            ..moveTo(sourceWorld.dx, sourceWorld.dy)
            ..lineTo(targetWorld.dx, targetWorld.dy);
        }
    }
  }

  /// 拖拽中的“单端”路径(ghost edge)
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

  /// 计算 dash流动动画的相位
  double computeDashFlowPhase(EdgeAnimationConfig anim) {
    if (anim.animateDash) {
      return anim.dashFlowPhase ?? 0;
    }
    return 0;
  }

  /// 下面几个方法是辅助(箭头、dash等)
  List<double> resolveDashPattern(EdgeLineStyle style) => style.dashPattern;
  ArrowType resolveArrowStart(EdgeLineStyle style) => style.arrowStart;
  ArrowType resolveArrowEnd(EdgeLineStyle style) => style.arrowEnd;
  double resolveArrowSize(EdgeLineStyle style) => style.arrowSize;
  double resolveArrowAngle(EdgeLineStyle style) => style.arrowAngleDeg;

  // ========== 内部解析/辅助函数 ==========

  Color _parseColor(String hex) {
    final cleaned = hex.replaceAll('#', '');
    final hexValue = cleaned.length == 6 ? 'FF$cleaned' : cleaned;
    return Color(int.parse(hexValue, radix: 16));
  }

  StrokeCap _toStrokeCap(EdgeLineCap cap) {
    switch (cap) {
      case EdgeLineCap.round:
        return StrokeCap.round;
      case EdgeLineCap.square:
        return StrokeCap.square;
      case EdgeLineCap.butt:
      default:
        return StrokeCap.butt;
    }
  }

  StrokeJoin _toStrokeJoin(EdgeLineJoin join) {
    switch (join) {
      case EdgeLineJoin.round:
        return StrokeJoin.round;
      case EdgeLineJoin.bevel:
        return StrokeJoin.bevel;
      case EdgeLineJoin.miter:
      default:
        return StrokeJoin.miter;
    }
  }

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
