import 'package:flutter/material.dart';
import '../models/canvas_visual_config.dart';
import '../renderers/canvas_renderer.dart';
import '../../node/behaviors/node_behavior.dart';
import '../../anchor/behaviors/anchor_behavior.dart';
import '../../state_management/node_state/node_state.dart';
import '../../state_management/edge_state/edge_state.dart';

/// CanvasController
/// 包裹 CanvasRenderer，并统一处理缩放与平移
class CanvasController extends StatelessWidget {
  /// 画布的 NodeState 与 EdgeState
  final NodeState nodeState;
  final EdgeState edgeState;

  /// 画布视觉配置，比如背景颜色、网格等
  final CanvasVisualConfig visualConfig;

  /// 画布平移量（世界坐标中的平移）
  final Offset offset;

  /// 画布缩放因子
  final double scale;

  /// 传入的 NodeBehavior
  final NodeBehavior? nodeBehavior;

  /// 传入的 AnchorBehavior
  final AnchorBehavior? anchorBehavior;

  const CanvasController({
    Key? key,
    required this.nodeState,
    required this.edgeState,
    required this.visualConfig,
    this.offset = Offset.zero,
    this.scale = 1.0,
    this.nodeBehavior,
    this.anchorBehavior,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // 使用 Transform 对整个画布进行缩放和平移
    return ClipRect(
      child: Transform(
        transform: Matrix4.identity()
          ..translate(offset.dx, offset.dy)
          ..scale(scale),
        alignment: Alignment.topLeft,
        child: CanvasRenderer(
          nodeState: nodeState,
          edgeState: edgeState,
          canvasVisualConfig: visualConfig,
          nodeBehavior: nodeBehavior,
          anchorBehavior: anchorBehavior,
          // 注意这里传入的 offset/scale保持默认，因为已经在 Transform 中处理
          canvasOffset: Offset.zero,
          canvasScale: 1.0,
        ),
      ),
    );
  }
}
