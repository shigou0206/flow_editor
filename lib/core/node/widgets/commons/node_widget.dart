import 'package:flutter/material.dart';
import '../../models/node_model.dart';
import '../../behaviors/node_behavior.dart';
import '../../../anchor/behaviors/anchor_behavior.dart';
import '../../../anchor/utils/anchor_position_utils.dart';
import 'node_block.dart';
import 'node_anchors.dart';

/// NodeWidget：负责 (节点主体 + 锚点) 的内部布局
/// 不再乘scale, 让最外层 Transform 统一处理
class NodeWidget extends StatelessWidget {
  final NodeModel node;
  final Widget child;
  final NodeBehavior? behavior;
  final AnchorBehavior? anchorBehavior;

  static const double defaultAnchorSize = 24.0;
  final double anchorSize;

  const NodeWidget({
    Key? key,
    required this.node,
    required this.child,
    this.behavior,
    this.anchorBehavior,
    this.anchorSize = defaultAnchorSize,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // 1) 计算 outside 时的外扩
    final padding = computeAnchorPadding(
      node.anchors,
      anchorWidgetSize: anchorSize,
    );
    final totalWidth = node.width + padding.left + padding.right;
    final totalHeight = node.height + padding.top + padding.bottom;

    return SizedBox(
      width: totalWidth,
      height: totalHeight,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          // 节点主体
          Positioned(
            left: padding.left,
            top: padding.top,
            child: NodeBlock(
              node: node,
              behavior: behavior,
              child: child,
            ),
          ),
          // 节点锚点
          Positioned(
            left: padding.left,
            top: padding.top,
            child: NodeAnchors(
              node: node,
              anchorBehavior: anchorBehavior,
              anchorWidgetSize: anchorSize,
            ),
          ),
        ],
      ),
    );
  }
}
