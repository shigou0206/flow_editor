import 'package:flow_editor/core/input/behavior_core/canvas_behavior.dart';
import 'package:flow_editor/core/input/behavior_core/behavior_context.dart';
import 'package:flow_editor/core/input/event/input_event.dart';
import 'package:flutter/foundation.dart';
// class BehaviorManager {
//   final List<CanvasBehavior> _behaviors;

//   BehaviorManager(List<CanvasBehavior> behaviors)
//       : _behaviors = [...behaviors] {
//     _behaviors.sort((a, b) => a.priority.compareTo(b.priority));
//   }

//   void handle(InputEvent ev, BehaviorContext context) {
//     final state = context.getState();
//     for (final b in _behaviors) {
//       final can = b.canHandle(ev, state);
//       final enabled = b.enabled(state.inputConfig);
//       if (can && enabled) {
//         b.handle(ev, context);
//         break;
//       }
//     }
//   }
// }

class BehaviorManager {
  final List<CanvasBehavior> _behaviors;

  BehaviorManager(List<CanvasBehavior> behaviors)
      : _behaviors = [...behaviors] {
    _behaviors.sort((a, b) => a.priority.compareTo(b.priority));
    debugPrint(
        'BehaviorManager initialized with behaviors sorted by priority:');
    for (final b in _behaviors) {
      debugPrint('- ${b.runtimeType} (priority: ${b.priority})');
    }
  }

  void handle(InputEvent ev, BehaviorContext context) {
    final state = context.getState();

    debugPrint('📌 BehaviorManager handling event: ${ev.type}');
    debugPrint('Event position: ${ev.canvasPos}');

    for (final b in _behaviors) {
      final can = b.canHandle(ev, state);
      final enabled = b.enabled(state.inputConfig);

      debugPrint('👉 Checking behavior: ${b.runtimeType}');
      debugPrint('   - Can handle: $can');
      debugPrint('   - Enabled: $enabled');

      if (can && enabled) {
        debugPrint('✅ ${b.runtimeType} will handle the event.');
        b.handle(ev, context);
        break;
      }
    }
  }
}
