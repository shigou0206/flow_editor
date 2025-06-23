import 'package:flow_editor/core/input/event/input_event.dart';
import 'package:flow_editor/core/models/ui_state/editor_state.dart';
import 'package:flow_editor/core/models/config/input_config.dart';
import 'package:flow_editor/core/input/behavior_core/behavior_context.dart';

abstract class CanvasBehavior {
  int get priority;

  bool canHandle(InputEvent ev, EditorState state);

  void handle(InputEvent ev, BehaviorContext context);

  bool enabled(InputConfig config);
}
