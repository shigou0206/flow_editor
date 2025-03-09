import 'package:flutter/material.dart';

abstract class CanvasBehavior {
  void startPan(Offset globalPosition);
  void updatePan(Offset globalPosition);
  void endPan();
  void zoom(double zoomFactor, Offset focalPoint);
  void resetView();
  void fitView(Rect contentBounds, Size viewportSize, {double padding});
  void panBy(double dx, double dy);
}
