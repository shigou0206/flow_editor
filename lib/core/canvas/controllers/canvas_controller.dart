// file: canvas_controller.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../state_management/node_state/node_state_provider.dart';
import '../../state_management/edge_state/edge_state_provider.dart';
import '../models/canvas_visual_config.dart';
import '../renderers/canvas_renderer.dart';
import '../../node/behaviors/node_behavior.dart';
import '../../anchor/behaviors/anchor_behavior.dart';

/// CanvasController：
/// - 监听给定 workflowId 的 nodeState、edgeState
/// - 通过 Transform 对画布做平移(offset) + 缩放(scale)
/// - 将数据传给 CanvasRenderer 做真正的绘制
class CanvasController extends ConsumerWidget {
  /// 标识一个独立的 workflow
  final String workflowId;

  /// 画布视觉配置，例如背景颜色、网格相关
  final CanvasVisualConfig visualConfig;

  /// 画布平移量（在世界坐标中的偏移）
  final Offset offset;

  /// 画布缩放因子
  final double scale;

  /// 可选：节点行为
  final NodeBehavior? nodeBehavior;

  /// 可选：锚点行为
  final AnchorBehavior? anchorBehavior;

  /// 画布的 GlobalKey，供子组件获取全局坐标等
  final GlobalKey canvasGlobalKey;

  const CanvasController({
    Key? key,
    required this.workflowId,
    required this.visualConfig,
    required this.canvasGlobalKey,
    this.offset = Offset.zero,
    this.scale = 1.0,
    this.nodeBehavior,
    this.anchorBehavior,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // 1. watch 当前 workflowId 的 nodeState / edgeState
    final nodeState = ref.watch(nodeStateProvider(workflowId));
    final edgeState = ref.watch(edgeStateProvider(workflowId));

    // 2. 使用 ClipRect + Transform 来平移 & 缩放画布
    return ClipRect(
      child: Transform(
        transform: Matrix4.identity()
          ..translate(offset.dx, offset.dy)
          ..scale(scale),
        alignment: Alignment.topLeft,
        child: CanvasRenderer(
          nodeState: nodeState,
          edgeState: edgeState,
          visualConfig: visualConfig,
          nodeBehavior: nodeBehavior,
          anchorBehavior: anchorBehavior,
          canvasGlobalKey: canvasGlobalKey,
        ),
      ),
    );
  }
}
