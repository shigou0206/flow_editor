// core/canvas/controllers/canvas_viewport_controller.dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import '../../state_management/canvas_state/canvas_state_provider.dart';

class CanvasViewportController {
  final Ref ref;

  CanvasViewportController(this.ref);

  /// 设置offset
  void setOffset(Offset offset) {
    ref.read(multiCanvasStateProvider.notifier).setOffset(offset);
  }

  /// 平移
  void panBy(double dx, double dy) {
    ref.read(multiCanvasStateProvider.notifier).panBy(dx, dy);
  }

  /// 缩放
  void setScale(double scale) {
    ref.read(multiCanvasStateProvider.notifier).setScale(scale);
  }

  /// 以某点为中心缩放
  void zoomAtPoint(double scaleFactor, Offset focalPoint) {
    ref
        .read(multiCanvasStateProvider.notifier)
        .zoomAtPoint(scaleFactor, focalPoint);
  }

  /// ...
}
