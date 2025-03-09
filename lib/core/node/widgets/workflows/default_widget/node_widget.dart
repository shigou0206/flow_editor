// ✅ 修复后 NodeWidget: 不再返回 Positioned
//    仅返回本节点内部布局 (Size+Stack+NodeBlock+NodeAnchors)

import 'package:flutter/material.dart';
import 'package:flow_editor/core/node/models/node_model.dart';
import 'package:flow_editor/core/node/behaviors/node_behavior.dart';
import 'package:flow_editor/core/anchor/behaviors/anchor_behavior.dart';
import 'package:flow_editor/core/anchor/utils/anchor_position_utils.dart';
import 'node_block.dart';
import 'node_anchors.dart';

class NodeWidget extends StatelessWidget {
  final NodeModel node;
  final Widget child;
  final NodeBehavior? behavior;
  final AnchorBehavior? anchorBehavior;

  const NodeWidget({
    super.key,
    required this.node,
    required this.child,
    this.behavior,
    this.anchorBehavior,
  });

  @override
  Widget build(BuildContext context) {
    // 1. 计算锚点外扩的边距
    final AnchorPadding padding = node.anchorPadding;
    // 2. 总宽高：节点尺寸 + 锚点扩展
    final double totalWidth = node.width + padding.left + padding.right;
    final double totalHeight = node.height + padding.top + padding.bottom;

    // 3. 返回一个普通 Widget (不再 Positioned)
    //    父层会决定它的 (left, top)
    return SizedBox(
      width: totalWidth,
      height: totalHeight,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          // 3.1 节点主体，放在 (padding.left, padding.top)
          Positioned(
            left: padding.left,
            top: padding.top,
            child: NodeBlock(
              node: node,
              behavior: behavior,
              child: child,
            ),
          ),
          // 3.2 锚点层, 放在 (0,0), 里面再根据padding排布
          Positioned(
            left: 0,
            top: 0,
            child: NodeAnchors(
              node: node,
              anchorBehavior: anchorBehavior,
              padding: padding,
            ),
          ),
        ],
      ),
    );
  }
}
