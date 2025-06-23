import 'package:flutter/services.dart';
import 'package:flow_editor/core/input/behavior_core/canvas_behavior.dart';
import 'package:flow_editor/core/input/behavior_core/behavior_context.dart';
import 'package:flow_editor/core/input/event/input_event.dart';
import 'package:flow_editor/core/input/event/input_event_type.dart';
import 'package:flow_editor/core/models/ui_state/editor_state.dart';
import 'package:flow_editor/core/models/config/input_config.dart';

class UndoRedoBehavior implements CanvasBehavior {
  final BehaviorContext context;

  UndoRedoBehavior(this.context);

  @override
  int get priority => context.getState().behaviorPriority.undoRedoKey;

  bool get _isCommandPressed {
    final keys = HardwareKeyboard.instance.logicalKeysPressed;
    return keys.contains(LogicalKeyboardKey.controlLeft) ||
        keys.contains(LogicalKeyboardKey.controlRight) ||
        keys.contains(LogicalKeyboardKey.metaLeft) || // macOS Cmd
        keys.contains(LogicalKeyboardKey.metaRight);
  }

  bool get _isShiftPressed {
    final keys = HardwareKeyboard.instance.logicalKeysPressed;
    return keys.contains(LogicalKeyboardKey.shiftLeft) ||
        keys.contains(LogicalKeyboardKey.shiftRight);
  }

  @override
  bool canHandle(InputEvent ev, EditorState _) {
    if (ev.type != InputEventType.keyDown) return false;
    if (!_isCommandPressed) return false;

    return ev.key == LogicalKeyboardKey.keyZ ||
        ev.key == LogicalKeyboardKey.keyY;
  }

  @override
  void handle(InputEvent ev, BehaviorContext context) {
    if (!_isCommandPressed) return;

    // Undo: Ctrl/Cmd + Z
    if (ev.key == LogicalKeyboardKey.keyZ && !_isShiftPressed) {
      context.controller.graph.undo();
    }

    // Redo: Ctrl+Y or Cmd+Shift+Z
    if (ev.key == LogicalKeyboardKey.keyY ||
        (ev.key == LogicalKeyboardKey.keyZ && _isShiftPressed)) {
      context.controller.graph.redo();
    }
  }

  @override
  bool enabled(InputConfig config) => config.enableKeyUndoRedo;
}
