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

  // ——— public props ——————————————————————————————
  final Offset offset;
  final double scale;

  final CanvasVisualConfig visualConfig;
  final NodeState nodeState;
  final EdgeState edgeState;
  final InteractionState interaction;
  final NodeWidgetFactory nodeWidgetFactory;

  @override
  Widget build(BuildContext context) {
    final nodes = nodeState.nodes; // 假设这是扁平的 List<NodeModel>
    final edges = edgeState.edges; // 假设这是扁平的 List<EdgeModel>

    // 从 InteractionState 里取出各类临时状态
    final hoveredEdgeId = interaction.mapOrNull(hoveringEdge: (s) => s.edgeId);

    final draggingEdgeId = interaction.mapOrNull(dragEdge: (s) => s.edgeId);
    final draggingEnd = interaction.mapOrNull(dragEdge: (s) => s.lastCanvas);

    final generator = FlexiblePathGenerator(nodes);

    return Stack(
      clipBehavior: Clip.none,
      children: [
        // ① 背景
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

        // ② 边
        Transform(
          alignment: Alignment.topLeft,
          transform: Matrix4.identity()
            ..translate(offset.dx, offset.dy)
            ..scale(scale),
          child: CustomPaint(
            painter: EdgeRenderer(
              nodes: nodes,
              edges: edges,
              pathGenerator: generator,
              hoveredEdgeId: hoveredEdgeId,
              draggingEdgeId: draggingEdgeId,
              draggingEnd: draggingEnd,
            ),
          ),
        ),

        // ③ 节点
        ...nodes.map(
          (node) {
            return Positioned(
              key: ValueKey(node.id),
              left: offset.dx +
                  (node.position.dx - node.anchorPadding.left) * scale,
              top: offset.dy +
                  (node.position.dy - node.anchorPadding.top) * scale,
              child: Transform.scale(
                scale: scale,
                alignment: Alignment.topLeft,
                transformHitTests: true,
                child: nodeWidgetFactory.createNodeWidget(node),
              ),
            );
          },
        ),
      ],
    );
  }
}
