import 'package:flutter/material.dart';
import 'package:flow_editor/core/models/ui/node_model.dart';
import 'package:flow_editor/ui/anchor/anchor_widget.dart';
import 'package:flow_editor/core/utils/anchor_position_utils.dart';

class NodeAnchors extends StatelessWidget {
  final NodeModel node;

  final AnchorPadding padding;

  const NodeAnchors({
    super.key,
    required this.node,
    required this.padding,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: node.size.width + padding.left + padding.right,
      height: node.size.height + padding.top + padding.bottom,
      child: Stack(
        clipBehavior: Clip.none,
        children: node.anchors.map((anchor) {
          final Offset localPos = computeAnchorLocalPosition(anchor, node.size);

          return Positioned(
            left: localPos.dx + padding.left,
            top: localPos.dy + padding.top,
            child: AnchorWidget(anchor: anchor, size: anchor.size),
          );
        }).toList(),
      ),
    );
  }
}
