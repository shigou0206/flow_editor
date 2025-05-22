// lib/ui/canvas/canvas_renderer.dart

import 'package:flutter/material.dart';
import 'package:flow_editor/core/models/state/node_state.dart';
import 'package:flow_editor/core/models/state/edge_state.dart';
import 'package:flow_editor/core/models/state/interaction_transient_state.dart';
import 'package:flow_editor/core/models/styles/canvas_visual_config.dart';
import 'package:flow_editor/core/painters/dotted_grid_painter.dart';
import 'package:flow_editor/core/painters/path_generators/flexible_path_generator.dart';
import 'package:flow_editor/ui/edge/edge_renderer.dart';
import 'package:flow_editor/ui/node/factories/node_widget_factory.dart';

class CanvasRenderer extends StatelessWidget {
  const CanvasRenderer({
    super.key,
    required this.offset,
    required this.scale,
    required this.visualConfig,
    required this.nodeState,
    required this.edgeState,
    required this.interaction,
    required this.nodeWidgetFactory,
  });

  final Offset offset;
  final double scale;
  final CanvasVisualConfig visualConfig;
  final NodeState nodeState;
  final EdgeState edgeState;
  final InteractionState interaction;
  final NodeWidgetFactory nodeWidgetFactory;

  @override
  Widget build(BuildContext context) {
    final nodes = nodeState.nodes;
    final edges = edgeState.edges;
    final pathGen = FlexiblePathGenerator(nodes);

    // —— 临时节点拖拽偏移 ——
    final draggingNode = interaction.mapOrNull(dragNode: (s) => s);
    final nodeDragDelta = draggingNode != null
        ? draggingNode.lastCanvas - draggingNode.startCanvas
        : Offset.zero;

    // —— 临时连线拖拽 ——
    final draggingEdgeId = interaction.mapOrNull(dragEdge: (s) => s.edgeId);
    final draggingEdgeEnd =
        interaction.mapOrNull(dragEdge: (s) => s.lastCanvas);

    // —— 悬停 ID ——
    final hoveredEdgeId = interaction.mapOrNull(hoveringEdge: (s) => s.edgeId);

    return Stack(
      clipBehavior: Clip.none,
      children: [
        // 1) 背景网格
        Positioned.fill(
          child: CustomPaint(
            painter: DottedGridPainter(
              config: visualConfig,
              offset: offset,
              scale: scale,
              style: visualConfig.backgroundStyle,
              themeMode: Theme.of(context).brightness == Brightness.dark
                  ? ThemeMode.dark
                  : ThemeMode.light,
            ),
          ),
        ),

        // 2) 边的渲染（含连线拖动的“虚影”）
        Transform(
          alignment: Alignment.topLeft,
          transform: Matrix4.identity()
            ..translate(offset.dx, offset.dy)
            ..scale(scale),
          child: CustomPaint(
            painter: EdgeRenderer(
              nodes: nodes,
              edges: edges,
              pathGenerator: pathGen,
              hoveredEdgeId: hoveredEdgeId,
              draggingEdgeId: draggingEdgeId,
              draggingEnd: draggingEdgeEnd,
            ),
          ),
        ),

        // 3) 节点的渲染（含节点拖动预览）
        ...nodes.map((node) {
          // 如果当前在拖这个节点，就加上临时偏移
          final basePos = node.position;
          final pos = (node.id == draggingNode?.nodeId)
              ? basePos + nodeDragDelta
              : basePos;

          return Positioned(
            key: ValueKey(node.id),
            left: offset.dx + (pos.dx - node.anchorPadding.left) * scale,
            top: offset.dy + (pos.dy - node.anchorPadding.top) * scale,
            child: Transform.scale(
              scale: scale,
              alignment: Alignment.topLeft,
              transformHitTests: true,
              child: nodeWidgetFactory.createNodeWidget(node),
            ),
          );
        }).toList(),
      ],
    );
  }
}
