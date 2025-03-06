import 'package:flutter/material.dart';
import '../../../node/models/node_model.dart';
import '../../../anchor/widgets/anchor_widget.dart';
import '../../../anchor/utils/anchor_position_utils.dart';
import '../../../anchor/behaviors/anchor_behavior.dart';

class NodeAnchors extends StatelessWidget {
  final NodeModel node;
  final AnchorBehavior? anchorBehavior;
  final double scale;

  const NodeAnchors({
    Key? key,
    required this.node,
    this.anchorBehavior,
    this.scale = 1.0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: node.width,
      height: node.height,
      child: Stack(
        clipBehavior: Clip.none,
        children: node.anchors.map((anchor) {
          final Offset localPos =
              computeAnchorLocalPosition(anchor, Size(node.width, node.height));

          return Positioned(
            left: localPos.dx - anchor.width / 2,
            top: localPos.dy - anchor.height / 2,
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
