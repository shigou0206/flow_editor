import 'package:flutter/material.dart';
import '../../../node/models/node_model.dart';
import '../../../anchor/widgets/anchor_widget.dart';
import '../../../anchor/utils/anchor_position_utils.dart';
import '../../../anchor/behaviors/anchor_behavior.dart';

class NodeAnchors extends StatelessWidget {
  final NodeModel node;
  final AnchorBehavior? anchorBehavior;
  final double anchorWidgetSize;
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
    final padding = computeAnchorPadding(
      node.anchors,
      anchorWidgetSize: anchorWidgetSize,
    );

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
          final localPos = computeAnchorLocalPosition(
            anchor,
            Size(node.width, node.height),
            anchorWidgetSize: anchorWidgetSize,
          );

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
