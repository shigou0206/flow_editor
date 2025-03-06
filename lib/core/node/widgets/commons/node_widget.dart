import 'package:flutter/material.dart';
import '../../models/node_model.dart';
import '../../behaviors/node_behavior.dart';
import '../../../anchor/behaviors/anchor_behavior.dart';
import '../../../anchor/utils/anchor_position_utils.dart';
import 'node_block.dart';
import 'node_anchors.dart';

class NodeWidget extends StatelessWidget {
  final NodeModel node;
  final Widget child;
  final NodeBehavior? behavior;
  final AnchorBehavior? anchorBehavior;

  const NodeWidget(
      {Key? key,
      required this.node,
      required this.child,
      this.behavior,
      this.anchorBehavior})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    // 计算锚点外扩的边距
    final AnchorPadding padding = computeAnchorPadding(node.anchors, node);
    // 总宽高：节点尺寸加上两侧扩展
    final double totalWidth = node.width + padding.left + padding.right;
    final double totalHeight = node.height + padding.top + padding.bottom;

    // 为了保证全局位置符合 node.x,node.y，我们将 NodeWidget 的左上角设为：
    // (node.x - padding.left, node.y - padding.top)
    return Positioned(
      left: node.x - padding.left,
      top: node.y - padding.top,
      child: SizedBox(
        width: totalWidth,
        height: totalHeight,
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            // 节点主体，放在 (padding.left, padding.top)
            Positioned(
              left: padding.left,
              top: padding.top,
              child: NodeBlock(
                node: node,
                behavior: behavior,
                child: child,
              ),
            ),
            // 锚点层，同样放在 (padding.left, padding.top)
            Positioned(
              left: padding.left,
              top: padding.top,
              child: NodeAnchors(node: node, anchorBehavior: anchorBehavior),
            ),
          ],
        ),
      ),
    );
  }
}
