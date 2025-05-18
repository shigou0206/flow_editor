import 'package:flutter/services.dart';
import 'package:flow_editor/core/input/behavior_core/canvas_behavior.dart';
import 'package:flow_editor/core/input/behavior_core/behavior_context.dart';
import 'package:flow_editor/core/input/event/input_event.dart';
import 'package:flow_editor/core/input/event/input_event_type.dart';
import 'package:flow_editor/core/models/state/canvas_state.dart';

class CopyPasteBehavior implements CanvasBehavior {
  final BehaviorContext context;

  CopyPasteBehavior(this.context);

  @override
  int get priority => 90;

  @override
  bool canHandle(InputEvent ev, CanvasState _) {
    if (ev.type != InputEventType.keyDown) return false;
    final ctrl = ev.raw.isControlPressed();
    return ctrl &&
        (ev.key == LogicalKeyboardKey.keyC ||
            ev.key == LogicalKeyboardKey.keyV);
  }

  @override
  void handle(InputEvent ev, BehaviorContext context) {
    final ctrl = ev.raw.isControlPressed();
    if (!ctrl) return;

    if (ev.key == LogicalKeyboardKey.keyC) {
      context.controller.copySelection();
    } else if (ev.key == LogicalKeyboardKey.keyV) {
      context.controller.pasteClipboard();
    }
  }
}
