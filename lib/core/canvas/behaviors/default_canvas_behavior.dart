import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../state_management/canvas_state/canvas_state_provider.dart';
import 'canvas_behavior.dart';

class DefaultCanvasBehavior implements CanvasBehavior {
  final WidgetRef ref;

  DefaultCanvasBehavior(this.ref);

  Offset? _lastPanPosition;

  @override
  void startPan(Offset globalPosition) {
    _lastPanPosition = globalPosition;
  }

  @override
  void updatePan(Offset globalPosition) {
    if (_lastPanPosition == null) return;

    final delta = globalPosition - _lastPanPosition!;
    ref.read(multiCanvasStateProvider.notifier).panBy(
          -delta.dx / ref.read(multiCanvasStateProvider).activeState.scale,
          -delta.dy / ref.read(multiCanvasStateProvider).activeState.scale,
        );

    _lastPanPosition = globalPosition;
  }

  @override
  void endPan() {
    _lastPanPosition = null;
  }

  @override
  void zoom(double zoomFactor, Offset focalPoint) {
    ref.read(multiCanvasStateProvider.notifier).zoomAtPoint(
          zoomFactor,
          focalPoint,
        );
  }

  @override
  void resetView() {
    ref.read(multiCanvasStateProvider.notifier).resetCanvas();
  }

  @override
  void fitView(Rect contentBounds, Size viewportSize, {double padding = 20}) {
    final scaleX = (viewportSize.width - padding * 2) / contentBounds.width;
    final scaleY = (viewportSize.height - padding * 2) / contentBounds.height;
    final newScale = scaleX < scaleY ? scaleX : scaleY;

    final contentCenter = contentBounds.center;
    final viewportCenter = viewportSize.center(Offset.zero);

    ref.read(multiCanvasStateProvider.notifier)
      ..setScale(newScale)
      ..setOffset(contentCenter - viewportCenter / newScale);
  }

  @override
  void panBy(double dx, double dy) {
    ref.read(multiCanvasStateProvider.notifier).panBy(dx, dy);
  }
}
