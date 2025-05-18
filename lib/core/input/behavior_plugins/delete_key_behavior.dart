import 'package:flutter/services.dart';
import 'package:flow_editor/core/input/behavior_core/canvas_behavior.dart';
import 'package:flow_editor/core/input/behavior_core/behavior_context.dart';
import 'package:flow_editor/core/input/event/input_event.dart';
import 'package:flow_editor/core/input/event/input_event_type.dart';
import 'package:flow_editor/core/models/state/canvas_state.dart';

class DeleteKeyBehavior implements CanvasBehavior {
  final BehaviorContext context;

  DeleteKeyBehavior(this.context);

  @override
  int get priority => 80;

  @override
  bool canHandle(InputEvent ev, CanvasState _) {
    return ev.type == InputEventType.keyDown &&
        ev.key == LogicalKeyboardKey.delete;
  }

  @override
  void handle(InputEvent ev, BehaviorContext context) {
    context.controller.deleteSelection();
  }
}
