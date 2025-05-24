import 'package:flutter/services.dart';
import 'package:flow_editor/core/input/behavior_core/canvas_behavior.dart';
import 'package:flow_editor/core/input/behavior_core/behavior_context.dart';
import 'package:flow_editor/core/input/event/input_event.dart';
import 'package:flow_editor/core/input/event/input_event_type.dart';
import 'package:flow_editor/core/models/config/input_config.dart';
import 'package:flow_editor/core/models/state/editor_state.dart';

class CopyPasteBehavior implements CanvasBehavior {
  final BehaviorContext context;

  CopyPasteBehavior(this.context);

  @override
  int get priority => context.getState().behaviorPriority.copyPasteKey;

  bool get isControlOrCommandPressed {
    final keys = HardwareKeyboard.instance.logicalKeysPressed;
    return keys.contains(LogicalKeyboardKey.controlLeft) ||
        keys.contains(LogicalKeyboardKey.controlRight) ||
        keys.contains(LogicalKeyboardKey.metaLeft) ||
        keys.contains(LogicalKeyboardKey.metaRight);
  }

  @override
  bool canHandle(InputEvent ev, EditorState state) {
    if (ev.type != InputEventType.keyDown) return false;
    return isControlOrCommandPressed &&
        (ev.key == LogicalKeyboardKey.keyC ||
            ev.key == LogicalKeyboardKey.keyV);
  }

  @override
  void handle(InputEvent ev, BehaviorContext context) {
    if (!isControlOrCommandPressed) return;

    if (ev.key == LogicalKeyboardKey.keyC) {
      context.controller.interaction.copySelection();
    } else if (ev.key == LogicalKeyboardKey.keyV) {
      context.controller.interaction.pasteClipboard();
    }
  }

  @override
  bool enabled(InputConfig config) => config.enableKeyCopyPaste;
}
