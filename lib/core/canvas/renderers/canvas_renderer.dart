import 'package:flutter/material.dart';

import '../../node/behaviors/node_behavior.dart';
import '../../anchor/behaviors/anchor_behavior.dart';
import '../../state_management/node_state/node_state.dart';
import '../../state_management/edge_state/edge_state.dart';
import '../models/canvas_visual_config.dart';
import '../renderers/background_renderer.dart';
import '../../edge/edge_renderer.dart';
import '../../node/widgets/commons/node_widget.dart';

/// CanvasRenderer:
/// 根据传入的 nodeState、edgeState、visualConfig 等进行绘制，同时背景层支持手势操作。
class CanvasRenderer extends StatelessWidget {
  final NodeState nodeState;
  final EdgeState edgeState;
  final CanvasVisualConfig visualConfig;

  final NodeBehavior? nodeBehavior;
  final AnchorBehavior? anchorBehavior;

  /// 可选：背景层手势回调，例如点击背景、拖动背景等
  final VoidCallback? onBackgroundTap;
  final GestureDragUpdateCallback? onBackgroundDragUpdate;

  const CanvasRenderer({
    super.key,
    required this.nodeState,
    required this.edgeState,
    required this.visualConfig,
    this.nodeBehavior,
    this.anchorBehavior,
    this.onBackgroundTap,
    this.onBackgroundDragUpdate,
  });

  @override
  Widget build(BuildContext context) {
    // 获取当前 workflow 中的所有节点与边
    final nodeList =
        nodeState.nodesByWorkflow.values.expand((m) => m.values).toList();
    final edgeList =
        edgeState.edgesByWorkflow.values.expand((m) => m.values).toList();

    final draggingEdgeId = edgeState.draggingEdgeId;
    final draggingEnd = edgeState.draggingEnd;

    return Stack(
      fit: StackFit.expand,
      children: [
        // 背景层，增加手势处理
        GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: onBackgroundTap,
          onPanUpdate: onBackgroundDragUpdate,
          child: CustomPaint(
            size: Size.infinite,
            painter: BackgroundRenderer(
              config: visualConfig,
              offset: Offset.zero,
              scale: 1.0,
            ),
          ),
        ),
        // 边绘制
        CustomPaint(
          size: Size.infinite,
          painter: EdgeRenderer(
            nodes: nodeList,
            edges: edgeList,
            draggingEdgeId: draggingEdgeId,
            draggingEnd: draggingEnd,
          ),
        ),
        // 节点绘制
        ...nodeList.map((node) => NodeWidget(
              key: ValueKey(node.id),
              node: node,
              behavior: nodeBehavior,
              anchorBehavior: anchorBehavior,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(6),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 4,
                      offset: const Offset(2, 2),
                    ),
                  ],
                ),
                alignment: Alignment.center,
                child: Text(
                  node.title,
                  style: const TextStyle(fontSize: 14, color: Colors.black87),
                ),
              ),
            )),
      ],
    );
  }
}
