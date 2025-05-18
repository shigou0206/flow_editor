import 'package:flutter/material.dart';
import 'package:flow_editor/core/models/node_model.dart';
import 'package:flow_editor/core/widgets/anchor_widget.dart';
import 'package:flow_editor/core/utils/anchor_position_utils.dart';
import 'package:flow_editor/core/behaviors/anchor_behavior.dart';

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
      width: node.size.width + padding.left + padding.right,
      height: node.size.height + padding.top + padding.bottom,
      child: Stack(
        clipBehavior: Clip.none,
        children: node.anchors?.map((anchor) {
              final Offset localPos =
                  computeAnchorLocalPosition(anchor, node.size);

              return Positioned(
                left: localPos.dx + padding.left,
                top: localPos.dy + padding.top,
                child: AnchorWidget(
                  anchor: anchor,
                  size: anchor.size,
                  anchorBehavior: anchorBehavior,
                ),
              );
            }).toList() ??
            [],
      ),
    );
  }
}
