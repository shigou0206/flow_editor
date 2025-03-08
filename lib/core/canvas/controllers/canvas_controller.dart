// file: canvas_controller.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../node/node_state/node_state_provider.dart';
import '../../edge/edge_state/edge_state_provider.dart';
import '../models/canvas_visual_config.dart';
import '../renderers/canvas_renderer.dart';
import '../../node/behaviors/node_behavior.dart';
import '../../anchor/behaviors/anchor_behavior.dart';

/// CanvasController(改造版):
/// - 不再用 ClipRect + Transform 包裹子树
/// - 仅布局一个容器来承载 CanvasRenderer
class CanvasController extends ConsumerWidget {
  final String workflowId; // 唯一标识某个工作流

  final CanvasVisualConfig visualConfig; // 画布视觉配置
  final GlobalKey canvasGlobalKey; // 若需要 globalToLocal，可供外部使用
  final Offset offset; // 当前平移量
  final double scale; // 当前缩放因子

  final NodeBehavior? nodeBehavior;
  final AnchorBehavior? anchorBehavior;

  const CanvasController({
    super.key,
    required this.workflowId,
    required this.visualConfig,
    required this.canvasGlobalKey,
    this.offset = Offset.zero,
    this.scale = 1.0,
    this.nodeBehavior,
    this.anchorBehavior,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // 1. 获取当前 workflow 的 nodeState / edgeState
    final nodeState = ref.watch(nodeStateProvider(workflowId));
    final edgeState = ref.watch(edgeStateProvider(workflowId));
    debugPrint('CanvasController rebuilt: draggingEdgeId=${edgeState.draggingEdgeId}, draggingEnd=${edgeState.draggingEnd}');

    // 2. 用一个容器(或 SizedBox.expand)承载 CanvasRenderer
    //    不再在这里做 父级 Transform / ClipRect
    return SizedBox(
      // 或 SizedBox.expand() if you want full screen
      key: canvasGlobalKey,
      // 也可根据你需求定尺寸,比如 config.canvasConfig.viewportWidth/Height
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
      ),
    );
  }
}
