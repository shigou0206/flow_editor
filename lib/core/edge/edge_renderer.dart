// file: edge_renderer.dart
import 'package:flutter/material.dart';
import 'package:flow_editor/core/node/models/node_model.dart';
import 'package:flow_editor/core/edge/models/edge_model.dart';
import 'package:flow_editor/core/edge/models/edge_enums.dart';
import 'package:flow_editor/core/edge/models/edge_animation_config.dart';
import 'package:flow_editor/core/types/position_enum.dart';
import 'package:flow_editor/core/anchor/utils/anchor_position_utils.dart';

import 'package:flow_editor/core/edge/utils/edge_utils.dart';
// 包含: buildEdgePaint, dashPath, drawArrowHead,
// getOrthogonalPath3Segments, getOrthogonalPath5Segments,
// getBezierPath, getHVBezierPath, etc.

class EdgeRenderer extends CustomPainter {
  final List<NodeModel> nodes;
  final List<EdgeModel> edges;
  final Set<String> selectedEdgeIds;
  final String? draggingEdgeId;
  final Offset? draggingEnd;
  final bool showHalfConnectedEdges;

  const EdgeRenderer({
    required this.nodes,
    required this.edges,
    this.selectedEdgeIds = const {},
    this.draggingEdgeId,
    this.draggingEnd,
    this.showHalfConnectedEdges = false,
  });

  @override
  void paint(Canvas canvas, Size size) {
    // 绘制已连接的边
    for (final edge in edges) {
      if (edge.isConnected &&
          edge.targetNodeId != null &&
          edge.targetAnchorId != null) {
        _drawEdge(canvas, edge);
      } else if (showHalfConnectedEdges) {
        _drawHalfConnectedEdge(canvas, edge);
      }
    }
    // 绘制拖拽中的幽灵线
    _drawDraggingEdge(canvas);
  }

  /// 正常边绘制：根据 edge.lineStyle.edgeMode 构造完整路径
  void _drawEdge(Canvas canvas, EdgeModel edge) {
    final (sourceWorld, sourcePos) =
        _getAnchorWorldInfo(edge.sourceNodeId, edge.sourceAnchorId);
    final (targetWorld, targetPos) =
        _getAnchorWorldInfo(edge.targetNodeId!, edge.targetAnchorId!);
    if (sourceWorld == null || targetWorld == null) return;

    Path path;
    switch (edge.lineStyle.edgeMode) {
      case EdgeMode.line:
        path = Path()
          ..moveTo(sourceWorld.dx, sourceWorld.dy)
          ..lineTo(targetWorld.dx, targetWorld.dy);
        break;
      case EdgeMode.orthogonal3:
        path = getOrthogonalPath3Segments(
          sx: sourceWorld.dx,
          sy: sourceWorld.dy,
          sourcePos: sourcePos,
          tx: targetWorld.dx,
          ty: targetWorld.dy,
          targetPos: targetPos,
          offsetDist: 40,
        );
        break;
      case EdgeMode.orthogonal5:
        path = getOrthogonalPath5Segments(
          sx: sourceWorld.dx,
          sy: sourceWorld.dy,
          sourcePos: sourcePos,
          tx: targetWorld.dx,
          ty: targetWorld.dy,
          targetPos: targetPos,
          offsetDist: 40,
        );
        break;
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
          path = result[0] as Path;
        } else {
          path = Path()
            ..moveTo(sourceWorld.dx, sourceWorld.dy)
            ..lineTo(targetWorld.dx, targetWorld.dy);
        }
        break;
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
          path = result[0] as Path;
        } else {
          path = Path()
            ..moveTo(sourceWorld.dx, sourceWorld.dy)
            ..lineTo(targetWorld.dx, targetWorld.dy);
        }
        break;
    }

    final isSelected = selectedEdgeIds.contains(edge.id);
    final paint = buildEdgePaint(edge.lineStyle, edge.animConfig, isSelected);

    if (edge.lineStyle.dashPattern.isNotEmpty) {
      path = dashPath(
        path,
        edge.lineStyle.dashPattern,
        phase: _computeDashFlowPhase(edge.animConfig),
      );
    }

    canvas.drawPath(path, paint);

    if (edge.lineStyle.arrowEnd != ArrowType.none) {
      drawArrowHead(canvas, path, paint, edge.lineStyle, atStart: false);
    }
    if (edge.lineStyle.arrowStart != ArrowType.none) {
      drawArrowHead(canvas, path, paint, edge.lineStyle, atStart: true);
    }
  }

  /// 半连接：只有 source 可用时，暂时用简单 fallback
  void _drawHalfConnectedEdge(Canvas canvas, EdgeModel edge) {
    final (sourceWorld, _) =
        _getAnchorWorldInfo(edge.sourceNodeId, edge.sourceAnchorId);
    if (sourceWorld == null) return;

    final fallbackEnd = sourceWorld + const Offset(50, 0);
    final paint = buildEdgePaint(
      edge.lineStyle,
      edge.animConfig,
      selectedEdgeIds.contains(edge.id),
    );
    final path = Path()
      ..moveTo(sourceWorld.dx, sourceWorld.dy)
      ..lineTo(fallbackEnd.dx, fallbackEnd.dy);
    canvas.drawPath(path, paint);
  }

  /// 拖拽幽灵线：根据 edgeMode 处理“单端”拖拽效果，
  /// 此处尝试对 hvBezier 实现“双端”效果，
  /// 即根据源点 anchor 与鼠标位置猜测目标 anchor方向。
  void _drawDraggingEdge(Canvas canvas) {
    if (draggingEdgeId == null || draggingEnd == null) return;
    final edge = edges.firstWhereOrNull((e) => e.id == draggingEdgeId);
    if (edge == null || edge.isConnected) return;

    final (sourceWorld, sourcePos) =
        _getAnchorWorldInfo(edge.sourceNodeId, edge.sourceAnchorId);
    if (sourceWorld == null) return;

    final paint = Paint()
      ..color = Colors.orange
      ..strokeWidth = 3
      ..style = PaintingStyle.stroke;

    final tx = draggingEnd!.dx;
    final ty = draggingEnd!.dy;

    Path path;
    switch (edge.lineStyle.edgeMode) {
      case EdgeMode.line:
        path = Path()
          ..moveTo(sourceWorld.dx, sourceWorld.dy)
          ..lineTo(tx, ty);
        break;
      case EdgeMode.orthogonal3:
        {
          // 单端正交3：仅使用 source 端 offset
          final (mx1, my1) = _extendOutSingle(
            sourceWorld.dx,
            sourceWorld.dy,
            sourcePos,
            40,
          );
          path = Path()
            ..moveTo(sourceWorld.dx, sourceWorld.dy)
            ..lineTo(mx1, my1)
            ..lineTo(mx1, ty)
            ..lineTo(tx, ty);
        }
        break;
      case EdgeMode.orthogonal5:
        {
          final (mx1, my1) = _extendOutSingle(
            sourceWorld.dx,
            sourceWorld.dy,
            sourcePos,
            40,
          );
          final midY = (my1 + ty) * 0.5;
          path = Path()
            ..moveTo(sourceWorld.dx, sourceWorld.dy)
            ..lineTo(mx1, my1)
            ..lineTo(mx1, midY)
            ..lineTo(tx, midY)
            ..lineTo(tx, ty);
        }
        break;
      case EdgeMode.bezier:
        {
          if (sourcePos != null) {
            // 单端普通贝塞尔：使用 source 端 HV 控制点，target直接连接
            final (sxC, syC) = _getHVControlPointSingleStandard(
              sourceWorld.dx,
              sourceWorld.dy,
              sourcePos,
              50,
            );
            path = Path()
              ..moveTo(sourceWorld.dx, sourceWorld.dy)
              ..cubicTo(sxC, syC, tx, ty, tx, ty);
          } else {
            path = Path()
              ..moveTo(sourceWorld.dx, sourceWorld.dy)
              ..lineTo(tx, ty);
          }
        }
        break;
      case EdgeMode.hvBezier:
        {
          if (sourcePos != null) {
            // 使用标准猜测：dx>0 => target 为 right, dx<0 => left, etc.
            final guessedPos = _guessPosStandard(
              sourceWorld.dx,
              sourceWorld.dy,
              tx,
              ty,
            );
            final (sxC, syC) = _getHVControlPointSingleStandard(
              sourceWorld.dx,
              sourceWorld.dy,
              sourcePos,
              50,
            );
            final (txC, tyC) = _getHVControlPointSingleStandard(
              tx,
              ty,
              guessedPos,
              50,
            );
            path = Path()
              ..moveTo(sourceWorld.dx, sourceWorld.dy)
              ..cubicTo(sxC, syC, txC, tyC, tx, ty);
          } else {
            path = Path()
              ..moveTo(sourceWorld.dx, sourceWorld.dy)
              ..lineTo(tx, ty);
          }
        }
        break;
    }

    canvas.drawPath(path, paint);
  }

  double _computeDashFlowPhase(EdgeAnimationConfig anim) {
    if (anim.animateDash == true) {
      return anim.dashFlowPhase ?? 0;
    }
    return 0;
  }

  (Offset?, Position?) _getAnchorWorldInfo(String nodeId, String anchorId) {
    final node = nodes.firstWhereOrNull((n) => n.id == nodeId);
    final anchor = node?.anchors.firstWhereOrNull((a) => a.id == anchorId);
    if (node == null || anchor == null) return (null, null);

    final worldPos = computeAnchorWorldPosition(node, anchor) +
        Offset(anchor.width / 2, anchor.height / 2);
    return (worldPos, anchor.position);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}

// ========== 辅助函数，仅用于拖拽幽灵线 ========== //

/// 单端正交: 当只有 sourcePos 时使用
(double, double) _extendOutSingle(
  double sx,
  double sy,
  Position? pos,
  double dist,
) {
  if (pos == null) return (sx, sy);
  // 标准正向: left => (sx - dist, sy), right => (sx + dist, sy), top => (sx, sy - dist), bottom => (sx, sy + dist)
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

/// HV 单端控制点，标准正向：
/// 对于源端：如果 anchor 为 left，则返回 (sx - offset, sy) 等。
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

/// 标准猜测目标 anchor：
/// 如果 x 差值大，则 dx > 0 => Position.right, dx < 0 => Position.left；
/// 否则，dy > 0 => Position.bottom, dy < 0 => Position.top.
// Position _guessPosStandard(double sx, double sy, double tx, double ty) {
//   final dx = tx - sx;
//   if (dx > 0) return Position.right; // 如果水平有正偏移，则直接认定为右侧
//   if (dx < 0) return Position.left;
//   // 如果水平无偏移，则根据垂直判断
//   final dy = ty - sy;
//   return dy > 0 ? Position.bottom : Position.top;
// }
Position _guessPosStandard(double sx, double sy, double tx, double ty) {
  return Position.left; // 如果水平有正偏移，则直接认定为右侧
}

// extension
extension FirstWhereOrNull<E> on Iterable<E> {
  E? firstWhereOrNull(bool Function(E e) test) =>
      cast<E?>().firstWhere((x) => x != null && test(x), orElse: () => null);
}
