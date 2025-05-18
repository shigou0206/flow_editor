import 'package:flow_editor/core/input/event/input_event.dart';
import 'package:flow_editor/core/models/state/canvas_state.dart';
import 'package:flow_editor/core/input/behavior_core/behavior_context.dart';

abstract class CanvasBehavior {
  int get priority;

  bool canHandle(InputEvent ev, CanvasState state);

  void handle(InputEvent ev, BehaviorContext context);
}
