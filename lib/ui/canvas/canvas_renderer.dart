import 'package:flutter/material.dart';
import 'package:flow_editor/core/models/state/node_state.dart';
import 'package:flow_editor/core/models/state/edge_state.dart';
import 'package:flow_editor/core/models/state/interaction_transient_state.dart';
import 'package:flow_editor/core/models/styles/canvas_visual_config.dart';
import 'package:flow_editor/core/painters/dotted_grid_painter.dart';
import 'package:flow_editor/core/painters/path_generators/flexible_path_generator.dart';
import 'package:flow_editor/ui/edge/edge_renderer.dart';
import 'package:flow_editor/ui/node/factories/node_widget_factory.dart';
import 'package:flow_editor/core/utils/anchor_position_utils.dart';

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
    final pathGen = FlexiblePathGenerator(nodeState.nodes);

    return Stack(
      clipBehavior: Clip.none,
      children: [
        // 背景网格
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

        // 边的渲染（含临时拖动边）
        Transform(
          alignment: Alignment.topLeft,
          transform: Matrix4.identity()
            ..translate(offset.dx, offset.dy)
            ..scale(scale),
          child: CustomPaint(
            painter: EdgeRenderer(
              nodes: nodeState.nodes,
              edges: edgeState.edges,
              pathGenerator: pathGen,
              hoveredEdgeId: interaction.hoveringTargetId,
              draggingEdgeId: interaction.draggingTargetId,
              draggingStart: interaction.mapOrNull(dragEdge: (s) {
                final node = nodeState.nodes.firstWhere(
                  (n) => n.anchors.any((a) => a.id == s.sourceAnchor.id),
                );
                return computeAnchorWorldPosition(
                    node, s.sourceAnchor, nodeState.nodes);
              }),
              draggingEnd: interaction.mapOrNull(dragEdge: (s) => s.lastCanvas),
            ),
          ),
        ),

        // 节点的渲染（含节点拖动预览）
        ...nodeState.nodes.map((node) {
          final pos = node.position + interaction.dragOffsetForNode(node.id);

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
        }),
      ],
    );
  }
}
