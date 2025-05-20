import 'package:flow_editor/core/input/behavior_core/canvas_behavior.dart';
import 'package:flow_editor/core/input/behavior_core/behavior_context.dart';
import 'package:flow_editor/core/input/event/input_event.dart';

class BehaviorManager {
  final List<CanvasBehavior> _behaviors;

  BehaviorManager(List<CanvasBehavior> behaviors)
      : _behaviors = [...behaviors] {
    _behaviors.sort((a, b) => a.priority.compareTo(b.priority));
  }

  void handle(InputEvent ev, BehaviorContext context) {
    final state = context.getState();
    for (final b in _behaviors) {
      if (b.canHandle(ev, state)) {
        b.handle(ev, context);
        break;
      }
    }
  }
}
