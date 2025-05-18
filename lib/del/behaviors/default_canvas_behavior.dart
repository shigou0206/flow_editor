import 'package:flutter/material.dart';
import 'package:flow_editor/del/behaviors/canvas_behavior.dart';
import 'package:flow_editor/del/controllers/canvas_controller_interface.dart';

/// DefaultCanvasBehavior：同时处理画布 / 节点 / 边 逻辑，
/// 全部转发给 [ICanvasController].
class DefaultCanvasBehavior implements CanvasBehavior {
  final ICanvasController controller;

  DefaultCanvasBehavior({required this.controller});

  @override
  void onTapDown(BuildContext context, TapDownDetails details) {
    controller.onTapDown(context, details);
  }

  @override
  void onPanStart(BuildContext context, DragStartDetails details) {
    controller.onPanStart(context, details);
  }

  @override
  void onPanUpdate(DragUpdateDetails details) {
    controller.onPanUpdate(details);
  }

  @override
  void onPanEnd(DragEndDetails details) {
    controller.onPanEnd(details);
  }
}
