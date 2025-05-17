import 'package:flutter/material.dart';

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
