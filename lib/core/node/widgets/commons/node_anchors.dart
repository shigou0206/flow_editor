import 'package:flutter/material.dart';
import '../../../node/models/node_model.dart';
import '../../../anchor/widgets/anchor_widget.dart';
import '../../../anchor/utils/anchor_position_utils.dart';
import '../../../anchor/behaviors/anchor_behavior.dart';

/// NodeAnchors：负责在节点内部（或外扩）安放所有 anchorWidget。
class NodeAnchors extends StatelessWidget {
  final NodeModel node;

  /// 控制锚点点击/拖拽等交互的行为
  final AnchorBehavior? anchorBehavior;

  /// 锚点的基础尺寸(不缩放时)
  final double anchorWidgetSize;

  /// 若需要让锚点随画布一起缩放，可在外部传入 scale
  final double scale;

  const NodeAnchors({
    Key? key,
    required this.node,
    this.anchorBehavior,
    this.anchorWidgetSize = 24.0,
    this.scale = 1.0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // 1) 计算外扩 (outside)
    final padding = computeAnchorPadding(
      node.anchors,
      anchorWidgetSize: anchorWidgetSize,
    );

    // 2) 父容器最终大小 = 节点尺寸 + 外扩
    //    若需要随画布缩放，也可在这里乘以 scale
    final totalWidth = node.width + padding.left + padding.right;
    final totalHeight = node.height + padding.top + padding.bottom;
    final scaledWidth = totalWidth * scale;
    final scaledHeight = totalHeight * scale;

    return SizedBox(
      width: scaledWidth,
      height: scaledHeight,
      child: Stack(
        clipBehavior: Clip.none,
        children: node.anchors.map((anchor) {
          // 3) 先算 anchor 在节点 (0,0)~(width,height) 内的局部中心 (不含外扩)
          final localPos = computeAnchorLocalPosition(
            anchor,
            Size(node.width, node.height),
            anchorWidgetSize: anchorWidgetSize,
          );

          // 4) 让锚点中心点位于 (localPos + padding)，再减去半个锚点大小
          //    若需要随画布缩放 => 整体乘 scale
          final dx =
              (localPos.dx - anchorWidgetSize / 2 + padding.left) * scale;
          final dy = (localPos.dy - anchorWidgetSize / 2 + padding.top) * scale;

          return Positioned(
            left: dx,
            top: dy,
            child: AnchorWidget(
              anchor: anchor,
              baseSize: anchorWidgetSize,
              anchorBehavior: anchorBehavior,
            ),
          );
        }).toList(),
      ),
    );
  }
}
