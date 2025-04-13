import 'package:flow_editor/core/node/models/node_model.dart';
import 'dart:math' as math;
import 'package:flutter/material.dart';

Rect computeContentBounds(List<NodeModel> nodes) {
  const double padding = 50.0;
  if (nodes.isEmpty) {
    return const Rect.fromLTWH(0, 0, 10, 10);
  }

  double minX = nodes.first.position.dx;
  double minY = nodes.first.position.dy;
  double maxX = nodes.first.position.dx + nodes.first.size.width;
  double maxY = nodes.first.position.dy + nodes.first.size.height;
  for (final node in nodes) {
    minX = math.min(minX, node.position.dx);
    minY = math.min(minY, node.position.dy);
    maxX = math.max(maxX, node.position.dx + node.size.width);
    maxY = math.max(maxY, node.position.dy + node.size.height);
  }
  return Rect.fromLTWH(minX - padding, minY - padding,
      (maxX - minX) + 2 * padding, (maxY - minY) + 2 * padding);
}
