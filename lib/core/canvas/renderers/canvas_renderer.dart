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
import '../../anchor/utils/anchor_position_utils.dart';

/// CanvasRenderer:
/// - 一个普通Widget，不再 watch Provider，
/// - 只根据传入的 nodeState、edgeState、visualConfig 等进行绘制。
class CanvasRenderer extends StatelessWidget {
  final NodeState nodeState;
  final EdgeState edgeState;
  final CanvasVisualConfig visualConfig;

  final NodeBehavior? nodeBehavior;
  final AnchorBehavior? anchorBehavior;

  /// 画布本身的 globalKey（用于锚点坐标计算等）
  final GlobalKey canvasGlobalKey;

  const CanvasRenderer({
    super.key,
    required this.nodeState,
    required this.edgeState,
    required this.visualConfig,
    required this.canvasGlobalKey,
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
      key: canvasGlobalKey,
      fit: StackFit.expand,
      children: [
        // 2. 背景绘制
        CustomPaint(
          size: Size.infinite,
          painter: BackgroundRenderer(
            config: visualConfig,
            offset: Offset.zero, // 如果想让背景跟随canvas平移/缩放，可再传参
            scale: 1.0,
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
            // 其他可选: selectedEdgeIds, defaultUseBezier, ...
          ),
        ),
        // 4. 节点绘制
        ...nodeList.map((node) {
          final padding = computeAnchorPadding(
            node.anchors,
            anchorWidgetSize: NodeWidget.defaultAnchorSize,
          );
          final totalWidth = node.width + padding.left + padding.right;
          final totalHeight = node.height + padding.top + padding.bottom;
          final left = node.x - padding.left;
          final top = node.y - padding.top;

          return Positioned(
            key: ValueKey(node.id),
            left: left,
            top: top,
            width: totalWidth,
            height: totalHeight,
            child: NodeWidget(
              node: node,
              behavior: nodeBehavior,
              anchorBehavior: anchorBehavior,
              canvasGlobalKey: canvasGlobalKey,
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
