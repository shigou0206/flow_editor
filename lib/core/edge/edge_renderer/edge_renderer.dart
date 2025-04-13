import 'package:flutter/material.dart';
import 'package:flow_editor/core/node/models/node_model.dart';
import 'package:flow_editor/core/edge/models/edge_model.dart';
import 'package:flow_editor/core/edge/style/edge_style_resolver.dart';
import 'package:flow_editor/core/anchor/utils/anchor_position_utils.dart';
import 'package:flow_editor/core/edge/edge_renderer/path_generators/path_generator.dart';
import 'package:collection/collection.dart';

class EdgeRenderer extends CustomPainter {
  final List<NodeModel> nodes;
  final List<EdgeModel> edges;
  final PathGenerator pathGenerator;
  final EdgeStyleResolver styleResolver;

  final Set<String> selectedEdgeIds;
  final String? hoveredEdgeId;

  final String? draggingEdgeId;
  final Offset? draggingEnd;

  EdgeRenderer({
    required this.nodes,
    required this.edges,
    required this.pathGenerator,
    this.styleResolver = const EdgeStyleResolver(),
    this.selectedEdgeIds = const {},
    this.hoveredEdgeId,
    this.draggingEdgeId,
    this.draggingEnd,
  });

  @override
  void paint(Canvas canvas, Size size) {
    for (final edge in edges) {
      _drawEdge(canvas, edge);
    }
    _drawGhostEdge(canvas);
  }

  void _drawEdge(Canvas canvas, EdgeModel edge) {
    final edgePath = pathGenerator.generate(edge);

    if (edgePath == null) return;

    final isSelected = selectedEdgeIds.contains(edge.id);
    final isHovered = hoveredEdgeId == edge.id;

    final paint = styleResolver.resolvePaint(
      edge.lineStyle,
      isSelected,
      isHover: isHovered,
    );

    canvas.drawPath(edgePath.path, paint);

    // 绘制箭头（确保已实现）
    styleResolver.drawArrowIfNeeded(
        canvas, edgePath.path, paint, edge.lineStyle);
  }

  void _drawGhostEdge(Canvas canvas) {
    if (draggingEdgeId == null || draggingEnd == null) return;

    final edge = edges.firstWhereOrNull((e) => e.id == draggingEdgeId);
    if (edge == null) return;

    final source =
        _getAnchorOrNodeCenter(edge.sourceNodeId, edge.sourceAnchorId);
    if (source == null) return;

    // 生成拖拽过程中的临时路径
    final path = Path()
      ..moveTo(source.dx, source.dy)
      ..lineTo(draggingEnd!.dx, draggingEnd!.dy);

    final paint = styleResolver.resolveGhostPaint(edge.lineStyle);
    canvas.drawPath(path, paint);

    // 也可以绘制箭头（根据需求）
    styleResolver.drawArrowIfNeeded(canvas, path, paint, edge.lineStyle);
  }

  Offset? _getAnchorOrNodeCenter(String nodeId, String? anchorId) {
    final node = nodes.firstWhereOrNull((n) => n.id == nodeId);
    if (node == null) return null;

    if (anchorId != null) {
      final anchor = node.anchors?.firstWhereOrNull((a) => a.id == anchorId);
      if (anchor != null) {
        return computeAnchorWorldPosition(node, anchor) +
            Offset(anchor.width / 2, anchor.height / 2);
      }
    }

    return Offset(node.x, node.y);
  }

  @override
  bool shouldRepaint(covariant EdgeRenderer oldDelegate) {
    return oldDelegate.nodes != nodes ||
        oldDelegate.edges != edges ||
        oldDelegate.draggingEnd != draggingEnd ||
        oldDelegate.hoveredEdgeId != hoveredEdgeId ||
        oldDelegate.selectedEdgeIds != selectedEdgeIds;
  }
}
