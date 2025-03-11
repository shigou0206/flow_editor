// file: canvas_controller.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:flow_editor/core/node/node_state/node_state_provider.dart';
import 'package:flow_editor/core/edge/edge_state/edge_state_provider.dart';
import 'package:flow_editor/core/canvas/models/canvas_visual_config.dart';
import 'package:flow_editor/core/canvas/renderers/canvas_renderer.dart';
import 'package:flow_editor/core/node/behaviors/node_behavior.dart';
import 'package:flow_editor/core/anchor/behaviors/anchor_behavior.dart';
import 'package:flow_editor/core/canvas/behaviors/canvas_behavior.dart';
import 'package:flow_editor/core/edge/behaviors/edge_behavior.dart';

import 'package:flow_editor/core/edge/plugins/edge_overlay_plugin.dart';

/// CanvasController(改造版):
/// - 不再用 ClipRect + Transform 包裹子树
/// - 仅布局一个容器来承载 CanvasRenderer
class CanvasWidget extends ConsumerWidget {
  final String workflowId; // 唯一标识某个工作流

  final CanvasVisualConfig visualConfig; // 画布视觉配置
  final GlobalKey canvasGlobalKey; // 若需要 globalToLocal，可供外部使用
  final Offset offset; // 当前平移量
  final double scale; // 当前缩放因子

  final NodeBehavior? nodeBehavior;
  final AnchorBehavior? anchorBehavior;
  final EdgeBehavior? edgeBehavior;
  final CanvasBehavior? canvasBehavior;

  final List<EdgeOverlayPlugin>? edgePlugins;

  const CanvasWidget({
    super.key,
    required this.workflowId,
    required this.visualConfig,
    required this.canvasGlobalKey,
    this.offset = Offset.zero,
    this.scale = 1.0,
    this.nodeBehavior,
    this.anchorBehavior,
    this.edgeBehavior,
    this.canvasBehavior,
    this.edgePlugins,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final nodeState = ref.watch(nodeStateProvider(workflowId));
    final edgeState = ref.watch(edgeStateProvider(workflowId));

    return SizedBox(
      key: canvasGlobalKey,
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: CanvasRenderer(
        offset: offset,
        scale: scale,
        nodeState: nodeState,
        edgeState: edgeState,
        visualConfig: visualConfig,
        nodeBehavior: nodeBehavior,
        anchorBehavior: anchorBehavior,
        edgeBehavior: edgeBehavior,
        canvasBehavior: canvasBehavior,
      ),
    );
  }
}
