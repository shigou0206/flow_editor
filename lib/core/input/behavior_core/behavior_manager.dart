import 'package:flow_editor/core/input/behavior_core/canvas_behavior.dart';
import 'package:flow_editor/core/input/behavior_core/behavior_context.dart';
import 'package:flow_editor/core/input/event/input_event.dart';
import 'package:flutter/foundation.dart';

class BehaviorManager {
  final List<CanvasBehavior> _behaviors;

  BehaviorManager(List<CanvasBehavior> behaviors)
      : _behaviors = [...behaviors] {
    _behaviors.sort((a, b) => a.priority.compareTo(b.priority));
  }

  void handle(InputEvent ev, BehaviorContext context) {
    debugPrint(
        '🔔 dispatching event: ${ev.type}, interaction=${context.interaction}');
    final state = context.getState();
    for (final b in _behaviors) {
      final can = b.canHandle(ev, state);
      debugPrint('  🔍 [${b.runtimeType}] canHandle → $can');
      if (can) {
        debugPrint('⚡ [${b.runtimeType}] HANDLE this event');
        b.handle(ev, context);
        break;
      }
    }
  }
}
