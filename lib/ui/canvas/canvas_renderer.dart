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

    // 如果拖拽中，把那个节点加上这次的偏移
    String? draggingId = interaction.mapOrNull(dragNode: (s) => s.nodeId);
    Offset dragDelta =
        interaction.mapOrNull(dragNode: (s) => s.lastCanvas - s.startCanvas) ??
            Offset.zero;

    return Stack(children: [
      // 背景
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

      // 边
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
            // （边的hover/drag逻辑同理）
          ),
        ),
      ),

      // 节点
      ...nodes.map((node) {
        // 计算临时位置
        final base = node.position;
        final pos = (node.id == draggingId) ? base + dragDelta : base;
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
    ]);
  }
}
