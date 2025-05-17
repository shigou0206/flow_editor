import 'package:flow_editor/core/models/node_model.dart';
import 'package:flow_editor/core/plugin/plugin_state/minimap_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MinimapStateNotifier extends StateNotifier<MinimapState> {
  MinimapStateNotifier() : super(const MinimapState());

  // Calculate the bounding box that contains all nodes
  Rect _getBoundingBox(List<NodeModel> nodes) {
    if (nodes.isEmpty) {
      return const Rect.fromLTWH(0, 0, 10, 10);
    }
    double minX = nodes.first.position.dx;
    double minY = nodes.first.position.dy;
    double maxX = nodes.first.position.dx + nodes.first.size.width;
    double maxY = nodes.first.position.dy + nodes.first.size.height;

    for (final node in nodes) {
      minX = node.position.dx < minX ? node.position.dx : minX;
      minY = node.position.dy < minY ? node.position.dy : minY;
      final nodeRight = node.position.dx + node.size.width;
      final nodeBottom = node.position.dy + node.size.height;
      maxX = nodeRight > maxX ? nodeRight : maxX;
      maxY = nodeBottom > maxY ? nodeBottom : maxY;
    }

    return Rect.fromLTRB(minX, minY, maxX, maxY);
  }

  // Adjust the minimap to ensure all nodes are visible and centered
  void fitNodes(List<NodeModel> nodes) {
    if (nodes.isEmpty) return;

    final box = _getBoundingBox(nodes);
    final contentW = box.width;
    final contentH = box.height;

    if (contentW < 1 || contentH < 1) return;

    final scaleX = state.width / contentW;
    final scaleY = state.height / contentH;
    var newScale = (scaleX < scaleY ? scaleX : scaleY) * 0.9; // 10% margin

    if (newScale.isInfinite || newScale.isNaN) {
      newScale = 1.0;
    }

    // Center the bounding box
    final offsetX =
        (state.width - contentW * newScale) / 2 - box.left * newScale;
    final offsetY =
        (state.height - contentH * newScale) / 2 - box.top * newScale;

    state = state.copyWith(
      scale: newScale,
      offsetX: offsetX,
      offsetY: offsetY,
    );
  }
}

final minimapStateProvider =
    StateNotifierProvider<MinimapStateNotifier, MinimapState>(
  (ref) => MinimapStateNotifier(),
);
