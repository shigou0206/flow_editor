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

/// CanvasRenderer(改造版):
/// - 内部使用 Stack(clipBehavior: Clip.none)，不再父层 Transform
/// - 网格/边/节点都自行加 offset, scale 实现平移/缩放
class CanvasRenderer extends StatelessWidget {
  final Offset offset; // 画布平移量
  final double scale; // 画布缩放因子

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
    // 假设 nodeState/edgeState 只包含1个workflow
    final nodeList =
        nodeState.nodesByWorkflow.values.expand((m) => m.values).toList();
    final edgeList =
        edgeState.edgesByWorkflow.values.expand((m) => m.values).toList();

    final draggingEdgeId = edgeState.draggingEdgeId;
    final draggingEnd = edgeState.draggingEnd;

    // 用 Stack(clipBehavior: Clip.none) 不剪裁溢出
    return Stack(
      clipBehavior: Clip.none,
      children: [
        // 1) 背景绘制(网格)
        //    这里若你想"无限"网格，可用BackgroundRenderer里自己写( offset, scale ) => 大范围 or 动态
        Positioned.fill(
          child: CustomPaint(
            painter: BackgroundRenderer(
              config: visualConfig,
              offset: offset,
              scale: scale,
            ),
          ),
        ),

        // 2) 绘制所有边(EdgeRenderer)
        //    这里有两种做法:
        //    A) 先用 Transform(...translate(offset)..scale(scale)) 包裹,再在EdgeRenderer用( x,y )逻辑坐标
        //    B) 直接 EdgeRenderer 里 强调 ( node.x*scale+offset.x, node.y*scale+offset.y )
        //    这里示范(A)
        Positioned.fill(
          child: Transform(
            transform: Matrix4.identity()
              ..translate(offset.dx, offset.dy)
              ..scale(scale),
            alignment: Alignment.topLeft,
            child: CustomPaint(
              painter: EdgeRenderer(
                nodes: nodeList,
                edges: edgeList,
                draggingEdgeId: draggingEdgeId,
                draggingEnd: draggingEnd,
              ),
            ),
          ),
        ),

        // 3) 节点绘制
        //    这里在"布局坐标"= offset + node.x*scale
        //    再包一层 Transform.scale(scale) 让节点自身内容变大
        for (final node in nodeList) ...[
          Positioned(
            left: offset.dx + (node.x - node.anchorPadding.left) * scale,
            top: offset.dy + (node.y - node.anchorPadding.top) * scale,
            width: (node.width +
                    node.anchorPadding.left +
                    node.anchorPadding.right) *
                scale,
            height: (node.height +
                    node.anchorPadding.top +
                    node.anchorPadding.bottom) *
                scale,
            child: Transform.scale(
              scale: scale,
              alignment: Alignment.topLeft,
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
            ),
          ),
        ],
      ],
    );
  }
}
