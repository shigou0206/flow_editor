// file: canvas_renderer.dart
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
/// 根据传入的 nodeState、edgeState、visualConfig 等进行绘制。
class CanvasRenderer extends StatelessWidget {
  final NodeState nodeState;
  final EdgeState edgeState;
  final CanvasVisualConfig visualConfig;

  final NodeBehavior? nodeBehavior;
  final AnchorBehavior? anchorBehavior;

  const CanvasRenderer({
    super.key,
    required this.nodeState,
    required this.edgeState,
    required this.visualConfig,
    this.nodeBehavior,
    this.anchorBehavior,
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
        // 背景绘制
        CustomPaint(
          size: Size.infinite,
          painter: BackgroundRenderer(
            config: visualConfig,
            offset: Offset.zero,
            scale: 1.0,
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
        // 节点绘制：直接使用 NodeWidget（内部会根据锚点计算 padding 并调整全局位置）
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
