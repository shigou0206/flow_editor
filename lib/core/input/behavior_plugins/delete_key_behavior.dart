import 'package:flutter/services.dart';
import 'package:flow_editor/core/input/behavior_core/canvas_behavior.dart';
import 'package:flow_editor/core/input/behavior_core/behavior_context.dart';
import 'package:flow_editor/core/input/event/input_event.dart';
import 'package:flow_editor/core/input/event/input_event_type.dart';
import 'package:flow_editor/core/models/config/input_config.dart';
import 'package:flow_editor/core/models/ui_state/editor_state.dart';

class DeleteKeyBehavior implements CanvasBehavior {
  final BehaviorContext context;

  DeleteKeyBehavior(this.context);

  @override
  int get priority => context.getState().behaviorPriority.deleteKey;

  @override
  bool canHandle(InputEvent ev, EditorState state) {
    return ev.type == InputEventType.keyDown &&
        ev.key == LogicalKeyboardKey.delete;
  }

  @override
  void handle(InputEvent ev, BehaviorContext context) {
    context.controller.interaction.deleteSelection();
  }

  @override
  bool enabled(InputConfig config) => config.enableKeyDelete;
}
