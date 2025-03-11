import 'package:flutter/material.dart';
import 'package:flow_editor/core/canvas/behaviors/canvas_behavior.dart';
import 'package:flow_editor/core/canvas/controllers/canvas_controller_interface.dart';

/// DefaultCanvasBehavior：基于 CanvasBehavior 接口，
/// 内部注入一个 ICanvasController 来执行具体的画布操作。
class DefaultCanvasBehavior implements CanvasBehavior {
  final ICanvasController controller;

  /// 构造时传入一个 ICanvasController
  /// 若外部不传，可以在此用 ?? SomeDefaultCanvasController() 做默认值
  DefaultCanvasBehavior({
    required this.controller,
  });

  @override
  void startPan(Offset globalPosition) {
    controller.startPan(globalPosition);
  }

  @override
  void updatePan(Offset globalPosition) {
    controller.updatePan(globalPosition);
  }

  @override
  void endPan() {
    controller.endPan();
  }

  @override
  void zoom(double zoomFactor, Offset focalPoint) {
    controller.zoom(zoomFactor, focalPoint);
  }

  @override
  void resetView() {
    controller.resetView();
  }

  @override
  void fitView(Rect contentBounds, Size viewportSize, {double padding = 20}) {
    controller.fitView(contentBounds, viewportSize, padding: padding);
  }

  @override
  void panBy(double dx, double dy) {
    controller.panBy(dx, dy);
  }
}
