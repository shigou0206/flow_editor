// file: canvas_renderer.dart
import 'package:flutter/material.dart';

import '../../node/behaviors/node_behavior.dart';
import '../../anchor/behaviors/anchor_behavior.dart';
import '../../node/node_state/node_state.dart';
import '../../edge/edge_state/edge_state.dart';
import '../models/canvas_visual_config.dart';
import '../renderers/background_renderer.dart';
import '../../edge/edge_renderer.dart';
import '../../node/widgets/commons/node_widget.dart';

/// CanvasRenderer:
/// - 一个普通Widget，不再 watch Provider，
/// - 只根据传入的 nodeState、edgeState、visualConfig 等进行绘制。
class CanvasRenderer extends StatelessWidget {
  final Offset offset;
  final double scale;
  final NodeState nodeState;
  final EdgeState edgeState;
  final CanvasVisualConfig visualConfig;

  final NodeBehavior? nodeBehavior;
  final AnchorBehavior? anchorBehavior;

  const CanvasRenderer({
    super.key,
    required this.offset,
    required this.scale,
    required this.nodeState,
    required this.edgeState,
    required this.visualConfig,
    this.nodeBehavior,
    this.anchorBehavior,
  });

  @override
  Widget build(BuildContext context) {
    // 1. 获取本 workflow 的节点/边
    // 如果你只渲染单一workflow：
    // final nodeList = nodeState.nodesOf(workflowId).values.toList();
    // final edgeList = edgeState.edgesOf(workflowId).values.toList();

    // 如果 nodeState / edgeState 是「仅包含单一workflow」的数据，
    // 也可以直接获取
    final nodeList =
        nodeState.nodesByWorkflow.values.expand((m) => m.values).toList();
    final edgeList =
        edgeState.edgesByWorkflow.values.expand((m) => m.values).toList();

    final draggingEdgeId = edgeState.draggingEdgeId;
    final draggingEnd = edgeState.draggingEnd;

    return Stack(
      fit: StackFit.expand,
      children: [
        // 2. 背景绘制
        CustomPaint(
          size: Size.infinite,
          painter: BackgroundRenderer(
            config: visualConfig,
            offset: offset,
            scale: scale,
          ),
        ),
        // 3. 边绘制
        CustomPaint(
          size: Size.infinite,
          painter: EdgeRenderer(
            nodes: nodeList,
            edges: edgeList,
            draggingEdgeId: draggingEdgeId,
            draggingEnd: draggingEnd,
          ),
        ),
        // 4. 节点绘制
        ...nodeList.map((node) {
          final left = node.x;
          final top = node.y;

          return Positioned(
            key: ValueKey(node.id),
            left: left,
            top: top,
            width: node.width,
            height: node.height,
            child: NodeWidget(
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
            ),
          );
        }),
      ],
    );
  }
}
