import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flow_editor/core/models/node_model.dart';
import 'package:flow_editor/core/models/anchor_model.dart';
import 'package:flow_editor/core/models/enums/position_enum.dart';

Offset computeAnchorLocalPosition(AnchorModel anchor, Size nodeSize) {
  final double w = nodeSize.width;
  final double h = nodeSize.height;

  final (baseX, baseY) = switch (anchor.position) {
    Position.left => (0.0, h * anchor.ratio),
    Position.right => (w, h * anchor.ratio),
    Position.top => (w * anchor.ratio, 0.0),
    Position.bottom => (w * anchor.ratio, h),
  };

  final dx = baseX + anchor.offset.dx;
  final dy = baseY + anchor.offset.dy;
  return Offset(dx, dy);
}

Offset computeAnchorWorldPosition(
  NodeModel node,
  AnchorModel anchor,
  List<NodeModel>? allNodes,
) {
  final localAnchorPos = computeAnchorLocalPosition(
    anchor,
    Size(node.size.width, node.size.height),
  );

  final nodePos =
      (allNodes == null) ? node.position : node.absolutePosition(allNodes);

  return nodePos + localAnchorPos;
}

AnchorPadding computeAnchorPadding(
  List<AnchorModel> anchors,
  Size nodeSize,
) {
  double expandLeft = 0;
  double expandRight = 0;
  double expandTop = 0;
  double expandBottom = 0;

  for (final anchor in anchors) {
    final localPos = computeAnchorLocalPosition(anchor, nodeSize);
    expandLeft = max(expandLeft, -localPos.dx);
    expandRight =
        max(expandRight, localPos.dx + anchor.size.width - nodeSize.width);
    expandTop = max(expandTop, -localPos.dy);
    expandBottom =
        max(expandBottom, localPos.dy + anchor.size.height - nodeSize.height);
  }

  return AnchorPadding(
    left: expandLeft,
    right: expandRight,
    top: expandTop,
    bottom: expandBottom,
  );
}

class AnchorPadding {
  final double left;
  final double right;
  final double top;
  final double bottom;

  const AnchorPadding({
    required this.left,
    required this.right,
    required this.top,
    required this.bottom,
  });

  factory AnchorPadding.fromJson(Map<String, dynamic> json) {
    return AnchorPadding(
      left: json['left'],
      right: json['right'],
      top: json['top'],
      bottom: json['bottom'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'left': left,
      'right': right,
      'top': top,
      'bottom': bottom,
    };
  }
}
