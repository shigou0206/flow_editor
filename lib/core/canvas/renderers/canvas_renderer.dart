import 'package:flutter/material.dart';
import '../../node/widgets/commons/node_widget.dart';
import '../../node/behaviors/node_behavior.dart';
import '../../state_management/node_state/node_state.dart';
import '../../edge/edge_renderer.dart';
import '../renderers/background_renderer.dart';
import '../models/canvas_visual_config.dart';
import '../../state_management/edge_state/edge_state.dart';
import '../../anchor/utils/anchor_position_utils.dart';
import '../../anchor/behaviors/anchor_behavior.dart';

/// CanvasRenderer (精简版)
///
/// - 不在这里乘以 canvasOffset、canvasScale
/// - 仅根据 node.x、node.y、外扩padding 来布置节点
/// - 连线EdgeRenderer 也可暂时保留, 若EdgeRenderer仍引用canvasScale/offset,
///   在后续也要移除, 改由最外层 Transform 统一处理
class CanvasRenderer extends StatelessWidget {
  final NodeState nodeState;
  final EdgeState edgeState;
  final CanvasVisualConfig canvasVisualConfig;
  final NodeBehavior? nodeBehavior;
  final AnchorBehavior? anchorBehavior;

  /// 原先的画布偏移/缩放, 这里不再使用, 可删除
  final Offset canvasOffset;
  final double canvasScale;

  const CanvasRenderer({
    super.key,
    required this.nodeState,
    required this.edgeState,
    required this.canvasVisualConfig,
    this.nodeBehavior,
    this.anchorBehavior,
    // 不再使用 offset/scale, 仅保留作兼容, 实际不乘
    this.canvasOffset = Offset.zero,
    this.canvasScale = 1.0,
  });

  @override
  Widget build(BuildContext context) {
    // 1) 提取节点列表、边列表（世界坐标）
    final nodeList =
        nodeState.nodesByWorkflow.values.expand((m) => m.values).toList();
    final edgeList =
        edgeState.edgesByWorkflow.values.expand((m) => m.values).toList();

    debugPrint('CanvasRenderer (No Manual Scale/Offset)');
    debugPrint('node count=${nodeList.length}, edge count=${edgeList.length}');

    return Stack(
      fit: StackFit.expand,
      children: [
        // 背景网格 (可保留, 如果 BackgroundRenderer 原先也基于 offset/scale, 建议移除引用)
        CustomPaint(
          size: Size.infinite,
          painter: BackgroundRenderer(
            config: canvasVisualConfig,
            // 若原先 BackgroundRenderer 需要 offset/scale, 建议去掉, 让它直接绘制固定背景
            offset: Offset.zero,
            scale: 1.0,
          ),
        ),

        // 边绘制 (EdgeRenderer) - 如果 EdgeRenderer 目前还引用 canvasOffset/canvasScale,
        // 可以在后续移除
        CustomPaint(
          size: Size.infinite,
          painter: EdgeRenderer(
            nodes: nodeList,
            edges: edgeList,
          ),
        ),

        // 节点
        ...nodeList.map((node) {
          // 2) 计算节点外扩padding
          final padding = computeAnchorPadding(
            node.anchors,
            anchorWidgetSize: NodeWidget.defaultAnchorSize,
          );
          final totalWidth = node.width + padding.left + padding.right;
          final totalHeight = node.height + padding.top + padding.bottom;

          // 3) 直接使用 node.x - padding.left 作为 Positioned.left
          //    不再乘以 canvasScale
          final left = node.x - padding.left;
          final top = node.y - padding.top;

          debugPrint(
              'Node ${node.id} -> left=$left, top=$top, w=$totalWidth, h=$totalHeight');

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
