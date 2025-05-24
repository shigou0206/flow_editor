import 'package:flutter/material.dart';
import 'package:flow_editor/core/models/state/node_state.dart';
import 'package:flow_editor/core/models/state/edge_state.dart';
import 'package:flow_editor/core/models/state/interaction_transient_state.dart';
import 'package:flow_editor/core/models/styles/canvas_visual_config.dart';
import 'package:flow_editor/core/painters/dotted_grid_painter.dart';
import 'package:flow_editor/core/painters/path_generators/flexible_path_generator.dart';
import 'package:flow_editor/ui/edge/edge_renderer.dart';
import 'package:flow_editor/ui/node/factories/node_widget_factory.dart';
import 'package:flow_editor/core/models/node_model.dart';
import 'package:flow_editor/core/models/edge_model.dart';

class SfnCanvasRenderer extends StatelessWidget {
  const SfnCanvasRenderer({
    super.key,
    required this.offset,
    required this.scale,
    required this.visualConfig,
    required this.nodeState,
    required this.edgeState,
    required this.interaction,
    required this.nodeWidgetFactory,
    required this.renderedNodes,
    required this.renderedEdges,
  });

  final Offset offset;
  final double scale;
  final CanvasVisualConfig visualConfig;
  final NodeState nodeState;
  final EdgeState edgeState;
  final InteractionState interaction;
  final NodeWidgetFactory nodeWidgetFactory;
  final List<NodeModel> renderedNodes;
  final List<EdgeModel> renderedEdges;

  @override
  Widget build(BuildContext context) {
    final pathGen = FlexiblePathGenerator(renderedNodes);

    final groupNodes = renderedNodes.where((n) => n.isGroup).toList();
    final regularNodes = renderedNodes.where((n) => !n.isGroup).toList();

    return Stack(
      clipBehavior: Clip.none,
      children: [
        // 背景网格（最底层）
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

        // 使用统一的Transform处理节点和边的缩放与平移
        Transform(
          alignment: Alignment.topLeft,
          transform: Matrix4.identity()
            ..translate(offset.dx, offset.dy)
            ..scale(scale),
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              // ✅ Group节点放最底层
              ...groupNodes.map((node) {
                final absPos = node.absolutePosition(renderedNodes);
                return Positioned(
                  key: ValueKey(node.id),
                  left: absPos.dx,
                  top: absPos.dy,
                  child: nodeWidgetFactory.createNodeWidget(node),
                );
              }),

              // ✅ 边在Group节点之上，普通节点之下
              Positioned.fill(
                child: CustomPaint(
                  painter: EdgeRenderer(
                    nodes: renderedNodes,
                    edges: renderedEdges,
                    pathGenerator: pathGen,
                    hoveredEdgeId: interaction.insertingHighlightedEdgeId ??
                        interaction.hoveringTargetId,
                    draggingEdgeId: interaction.draggingTargetId,
                    draggingEnd: interaction.mapOrNull(
                      dragEdge: (s) => s.lastCanvas,
                    ),
                  ),
                ),
              ),

              // ✅ 普通节点在最上层
              ...regularNodes.map((node) {
                final absPos = node.absolutePosition(renderedNodes);
                return Positioned(
                  key: ValueKey(node.id),
                  left: absPos.dx,
                  top: absPos.dy,
                  child: nodeWidgetFactory.createNodeWidget(node),
                );
              }),
            ],
          ),
        ),
      ],
    );
  }
}
