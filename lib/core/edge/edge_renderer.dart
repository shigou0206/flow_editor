import 'package:flutter/material.dart';
import 'package:flow_editor/core/node/models/node_model.dart';
import 'package:flow_editor/core/edge/models/edge_model.dart';
import 'package:flow_editor/core/edge/models/edge_enums.dart';
import 'package:flow_editor/core/edge/models/edge_animation_config.dart';
import 'package:flow_editor/core/edge/edge_utils.dart';
import 'package:flow_editor/core/types/position_enum.dart';
import 'package:flow_editor/core/anchor/utils/anchor_position_utils.dart';

class EdgeRenderer extends CustomPainter {
  final List<NodeModel> nodes;
  final List<EdgeModel> edges;
  final Set<String> selectedEdgeIds;
  final String? draggingEdgeId;
  final Offset? draggingEnd;
  final bool showHalfConnectedEdges;
  final bool defaultUseBezier;

  const EdgeRenderer({
    required this.nodes,
    required this.edges,
    this.selectedEdgeIds = const {},
    this.draggingEdgeId,
    this.draggingEnd,
    this.showHalfConnectedEdges = false,
    this.defaultUseBezier = false,
  });

  @override
  void paint(Canvas canvas, Size size) {
    for (final edge in edges) {
      if (edge.isConnected &&
          edge.targetNodeId != null &&
          edge.targetAnchorId != null) {
        _drawEdge(canvas, edge);
      } else if (showHalfConnectedEdges) {
        _drawHalfConnectedEdge(canvas, edge);
      }
    }
    _drawDraggingEdge(canvas);
  }

  void _drawEdge(Canvas canvas, EdgeModel edge) {
    final (sourceWorld, sourcePos) =
        _getAnchorWorldInfo(edge.sourceNodeId, edge.sourceAnchorId);
    final (targetWorld, targetPos) =
        _getAnchorWorldInfo(edge.targetNodeId!, edge.targetAnchorId!);

    if (sourceWorld == null || targetWorld == null) {
      return;
    }

    Path path =
        _buildEdgePath(sourceWorld, targetWorld, sourcePos, targetPos, edge);
    final isSelected = selectedEdgeIds.contains(edge.id);
    final paint = buildEdgePaint(edge.lineStyle, edge.animConfig, isSelected);

    if (edge.lineStyle.dashPattern.isNotEmpty) {
      path = dashPath(path, edge.lineStyle.dashPattern,
          phase: _computeDashFlowPhase(edge.animConfig));
    }

    canvas.drawPath(path, paint);

    if (edge.lineStyle.arrowEnd != ArrowType.none) {
      drawArrowHead(canvas, path, paint, edge.lineStyle, atStart: false);
    }
    if (edge.lineStyle.arrowStart != ArrowType.none) {
      drawArrowHead(canvas, path, paint, edge.lineStyle, atStart: true);
    }
  }

  void _drawHalfConnectedEdge(Canvas canvas, EdgeModel edge) {
    final (sourceWorld, _) =
        _getAnchorWorldInfo(edge.sourceNodeId, edge.sourceAnchorId);
    if (sourceWorld == null) {
      return;
    }

    final fallbackEnd = sourceWorld + const Offset(50, 0);
    final paint = buildEdgePaint(
        edge.lineStyle, edge.animConfig, selectedEdgeIds.contains(edge.id));
    final path = _buildEdgePath(sourceWorld, fallbackEnd, null, null, edge);
    canvas.drawPath(path, paint);
  }

  void _drawDraggingEdge(Canvas canvas) {
    if (draggingEdgeId == null || draggingEnd == null) {
      return;
    }

    final edge = edges.firstWhereOrNull((e) => e.id == draggingEdgeId);

    if (edge == null) {
      return;
    }

    if (edge.isConnected) {
      return;
    }

    final (sourceWorld, _) =
        _getAnchorWorldInfo(edge.sourceNodeId, edge.sourceAnchorId);
    if (sourceWorld == null) {
      return;
    }

    final paint = Paint()
      ..color = Colors.orange
      ..strokeWidth = 3
      ..style = PaintingStyle.stroke;

    final path = _buildEdgePath(sourceWorld, draggingEnd!, null, null, edge);
    canvas.drawPath(path, paint);
  }

  Path _buildEdgePath(Offset p1, Offset p2, Position? sourcePos,
      Position? targetPos, EdgeModel edge) {
    final useBezier = edge.lineStyle.useBezier || defaultUseBezier;
    if (useBezier && sourcePos != null && targetPos != null) {
      return getBezierPath(
        sourceX: p1.dx,
        sourceY: p1.dy,
        sourcePosition: sourcePos,
        targetX: p2.dx,
        targetY: p2.dy,
        targetPosition: targetPos,
        curvature: 0.25,
      )[0] as Path;
    }
    return Path()
      ..moveTo(p1.dx, p1.dy)
      ..lineTo(p2.dx, p2.dy);
  }

  double _computeDashFlowPhase(EdgeAnimationConfig anim) =>
      anim.animateDash == true ? anim.dashFlowPhase ?? 0 : 0;

  (Offset?, Position?) _getAnchorWorldInfo(String nodeId, String anchorId) {
    final node = nodes.firstWhereOrNull((n) => n.id == nodeId);
    final anchor = node?.anchors.firstWhereOrNull((a) => a.id == anchorId);

    if (node == null || anchor == null) {
      return (null, null);
    }

    final worldPos = computeAnchorWorldPosition(node, anchor) +
        Offset(anchor.width / 2, anchor.height / 2);
    return (worldPos, anchor.position);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

extension FirstWhereOrNull<E> on Iterable<E> {
  E? firstWhereOrNull(bool Function(E e) test) =>
      cast<E?>().firstWhere((x) => x != null && test(x), orElse: () => null);
}
