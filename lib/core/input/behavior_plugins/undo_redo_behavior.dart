// lib/core/input/behavior_plugins/undo_redo_behavior.dart

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

  bool get _ctrlPressed {
    final pressed = HardwareKeyboard.instance.physicalKeysPressed;
    return pressed.contains(PhysicalKeyboardKey.controlLeft) ||
        pressed.contains(PhysicalKeyboardKey.controlRight);
  }

  @override
  bool canHandle(InputEvent ev, CanvasState _) {
    // 仅在 keyDown 且 Ctrl 正在按下，且键是 Z 或 Y
    if (ev.type != InputEventType.keyDown) return false;
    if (!_ctrlPressed) return false;
    return ev.key == LogicalKeyboardKey.keyZ ||
        ev.key == LogicalKeyboardKey.keyY;
  }

  @override
  void handle(InputEvent ev, BehaviorContext context) {
    if (!_ctrlPressed) return;
    if (ev.key == LogicalKeyboardKey.keyZ) {
      context.controller.undo();
    } else if (ev.key == LogicalKeyboardKey.keyY) {
      context.controller.redo();
    }
  }
}
