import 'package:flow_editor/core/node/models/node_model.dart';
import 'dart:math' as math;
import 'package:flutter/material.dart';

Rect computeContentBounds(List<NodeModel> nodes) {
  const double padding = 50.0;
  if (nodes.isEmpty) {
    return const Rect.fromLTWH(0, 0, 10, 10);
  }

  double minX = nodes.first.x;
  double minY = nodes.first.y;
  double maxX = nodes.first.x + nodes.first.width;
  double maxY = nodes.first.y + nodes.first.height;
  for (final node in nodes) {
    minX = math.min(minX, node.x);
    minY = math.min(minY, node.y);
    maxX = math.max(maxX, node.x + node.width);
    maxY = math.max(maxY, node.y + node.height);
  }
  return Rect.fromLTWH(minX - padding, minY - padding,
      (maxX - minX) + 2 * padding, (maxY - minY) + 2 * padding);
}
