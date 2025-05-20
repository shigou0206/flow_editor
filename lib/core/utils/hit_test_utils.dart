import 'package:flutter/material.dart';
import 'package:flow_editor/core/models/edge_model.dart';
import 'package:flow_editor/core/models/hit_test_result.dart';

double distanceToPath(Path path, Offset pointer, {int sampleCount = 80}) {
  double minDist = double.infinity;

  for (final metric in path.computeMetrics()) {
    final length = metric.length;
    for (int i = 0; i < sampleCount; i++) {
      final t = i / (sampleCount - 1);
      final pos = metric.getTangentForOffset(length * t)?.position;
      if (pos != null) {
        final dist = (pos - pointer).distance;
        if (dist < minDist) {
          minDist = dist;
        }
      }
    }
  }
  return minDist;
}

Offset computeHandlePosition(Rect rect, ResizeHandlePosition handle) {
  return switch (handle) {
    ResizeHandlePosition.topLeft => rect.topLeft,
    ResizeHandlePosition.topRight => rect.topRight,
    ResizeHandlePosition.bottomLeft => rect.bottomLeft,
    ResizeHandlePosition.bottomRight => rect.bottomRight,
    ResizeHandlePosition.left => Offset(rect.left, rect.center.dy),
    ResizeHandlePosition.right => Offset(rect.right, rect.center.dy),
    ResizeHandlePosition.top => Offset(rect.center.dx, rect.top),
    ResizeHandlePosition.bottom => Offset(rect.center.dx, rect.bottom),
  };
}

Offset computeEdgeMidpoint(EdgeModel edge) {
  final pts = edge.waypoints;
  if (pts != null && pts.length >= 2) {
    return Offset.lerp(pts.first, pts.last, 0.5)!;
  }

  final p1 = edge.sourcePosition;
  final p2 = edge.targetPosition;
  if (p1 != null && p2 != null) {
    return Offset.lerp(p1, p2, 0.5)!;
  }

  return Offset.zero;
}
