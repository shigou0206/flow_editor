import 'package:flutter/material.dart';
import '../../../node/models/node_model.dart';
import '../../../anchor/widgets/anchor_widget.dart';
import '../../../anchor/utils/anchor_position_utils.dart';
import '../../../anchor/behaviors/anchor_behavior.dart';

class NodeAnchors extends StatelessWidget {
  final NodeModel node;
  final AnchorBehavior? anchorBehavior;

  final AnchorPadding padding;

  const NodeAnchors({
    super.key,
    required this.node,
    this.anchorBehavior,
    required this.padding,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: node.width + padding.left + padding.right,
      height: node.height + padding.top + padding.bottom,
      child: Stack(
        clipBehavior: Clip.none,
        children: node.anchors.map((anchor) {
          final Offset localPos =
              computeAnchorLocalPosition(anchor, Size(node.width, node.height));

          return Positioned(
            left: localPos.dx + padding.left,
            top: localPos.dy + padding.top,
            child: AnchorWidget(
              anchor: anchor,
              width: anchor.width,
              height: anchor.height,
              anchorBehavior: anchorBehavior,
            ),
          );
        }).toList(),
      ),
    );
  }
}
