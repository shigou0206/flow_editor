import 'package:flutter/services.dart';
import 'package:flow_editor/core/input/behavior_core/canvas_behavior.dart';
import 'package:flow_editor/core/input/behavior_core/behavior_context.dart';
import 'package:flow_editor/core/input/event/input_event.dart';
import 'package:flow_editor/core/input/event/input_event_type.dart';
import 'package:flow_editor/core/models/state/canvas_state.dart';

class UndoRedoBehavior implements CanvasBehavior {
  final BehaviorContext context;

  UndoRedoBehavior(this.context);

  @override
  int get priority => 100;

  @override
  bool canHandle(InputEvent ev, CanvasState _) {
    if (ev.type != InputEventType.keyDown) return false;
    final ctrl = ev.raw.isControlPressed();
    return ctrl &&
        (ev.key == LogicalKeyboardKey.keyZ ||
            ev.key == LogicalKeyboardKey.keyY);
  }

  @override
  void handle(InputEvent ev, BehaviorContext context) {
    if (!ev.raw.isControlPressed()) return;

    if (ev.key == LogicalKeyboardKey.keyZ) {
      context.controller.undo();
    } else if (ev.key == LogicalKeyboardKey.keyY) {
      context.controller.redo();
    }
  }
}
