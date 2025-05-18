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

  bool _isControlPressed(dynamic raw) {
    // ignore: deprecated_member_use
    if (raw is RawKeyEvent && raw.data is RawKeyEventDataMacOs) {
      // ignore: deprecated_member_use
      final mods = (raw.data as RawKeyEventDataMacOs).modifiers;
      // ignore: deprecated_member_use
      return (mods & RawKeyEventDataMacOs.modifierControl) != 0;
    }
    return false;
  }

  @override
  bool canHandle(InputEvent ev, CanvasState state) {
    if (ev.type != InputEventType.keyDown) return false;
    return _isControlPressed(ev.raw) &&
        (ev.key == LogicalKeyboardKey.keyC ||
            ev.key == LogicalKeyboardKey.keyV);
  }

  @override
  void handle(InputEvent ev, BehaviorContext context) {
    if (!_isControlPressed(ev.raw)) return;
    if (ev.key == LogicalKeyboardKey.keyC) {
      context.controller.copySelection();
    } else if (ev.key == LogicalKeyboardKey.keyV) {
      context.controller.pasteClipboard();
    }
  }
}
