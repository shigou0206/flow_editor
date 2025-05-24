// import 'package:flow_editor/core/input/behavior_core/canvas_behavior.dart';
// import 'package:flow_editor/core/input/behavior_core/behavior_context.dart';
// import 'package:flow_editor/core/input/event/input_event.dart';
// import 'package:flow_editor/core/input/event/input_event_type.dart';
// import 'package:flow_editor/core/models/state/interaction_transient_state.dart';
// import 'package:flow_editor/core/models/config/input_config.dart';
// import 'package:flow_editor/core/models/node_model.dart';
// import 'package:uuid/uuid.dart';

// class InsertNodePreviewBehavior implements CanvasBehavior {
//   final BehaviorContext context;
//   final _uuid = const Uuid();

//   InsertNodePreviewBehavior(this.context);

//   @override
//   int get priority => context.getState().behaviorPriority.nodeInsertPreview;

//   @override
//   bool canHandle(InputEvent ev, dynamic _) {
//     final interaction = context.interaction;

//     return (ev.type == InputEventType.pointerMove &&
//             interaction is InsertingNodePreview) ||
//         (ev.type == InputEventType.pointerUp &&
//             interaction is InsertingNodePreview);
//   }

//   @override
//   void handle(InputEvent ev, BehaviorContext ctx) {
//     final interaction = ctx.interaction as InsertingNodePreview;

//     switch (ev.type) {
//       case InputEventType.pointerMove:
//         final mousePos = ev.canvasPos!;
//         final highlightedEdgeId = ctx.hitTester.hitTestEdge(mousePos);
//         ctx.controller.interaction.updateInsertingNodePreview(
//           mousePos,
//           highlightedEdgeId,
//         );
//         break;

//       case InputEventType.pointerUp:
//         final mousePos = ev.canvasPos!;
//         final highlightedEdgeId = ctx.hitTester.hitTestEdge(mousePos);

//         if (highlightedEdgeId != null) {
//           final newNode = NodeModel(
//             id: 'node_${_uuid.v4()}',
//             type: interaction.nodeType,
//             position: mousePos,
//             size: interaction.nodeSize,
//             title: interaction.nodeType,
//           );

//           ctx.controller.graph.insertNodeIntoEdge(newNode, highlightedEdgeId);
//         }

//         ctx.controller.interaction.endInsertingNodePreview();
//         break;

//       default:
//         break;
//     }
//   }

//   @override
//   bool enabled(InputConfig config) => config.enableNodeInsertPreview;
// }

import 'package:flutter/foundation.dart';
import 'package:flow_editor/core/input/behavior_core/canvas_behavior.dart';
import 'package:flow_editor/core/input/behavior_core/behavior_context.dart';
import 'package:flow_editor/core/input/event/input_event.dart';
import 'package:flow_editor/core/input/event/input_event_type.dart';
import 'package:flow_editor/core/models/state/interaction_transient_state.dart';
import 'package:flow_editor/core/models/config/input_config.dart';
import 'package:flow_editor/core/models/node_model.dart';
import 'package:uuid/uuid.dart';

class InsertNodePreviewBehavior implements CanvasBehavior {
  final BehaviorContext context;
  final _uuid = const Uuid();

  InsertNodePreviewBehavior(this.context);

  @override
  int get priority => context.getState().behaviorPriority.nodeInsertPreview;

  @override
  bool canHandle(InputEvent ev, dynamic _) {
    final interaction = context.interaction;

    final canHandle = (ev.type == InputEventType.pointerMove &&
            interaction is InsertingNodePreview) ||
        (ev.type == InputEventType.pointerUp &&
            interaction is InsertingNodePreview);

    debugPrint(
      '[InsertNodePreviewBehavior] canHandle: '
      'eventType=${ev.type}, interaction=${interaction.runtimeType}, '
      'result=$canHandle',
    );

    return canHandle;
  }

  @override
  void handle(InputEvent ev, BehaviorContext ctx) {
    final interaction = ctx.interaction;

    debugPrint(
      '[InsertNodePreviewBehavior] handle triggered: '
      'eventType=${ev.type}, interaction=${interaction.runtimeType}',
    );

    if (interaction is! InsertingNodePreview) {
      debugPrint(
          '[InsertNodePreviewBehavior] Aborted - Not in InsertingNodePreview state.');
      return;
    }

    switch (ev.type) {
      case InputEventType.pointerMove:
        final mousePos = ev.canvasPos!;
        final highlightedEdgeId = ctx.hitTester.hitTestEdge(mousePos);

        debugPrint(
          '[InsertNodePreviewBehavior] pointerMove at $mousePos, '
          'highlightedEdgeId=$highlightedEdgeId',
        );

        ctx.controller.interaction.updateInsertingNodePreview(
          mousePos,
          highlightedEdgeId,
        );
        break;

      case InputEventType.pointerUp:
        final mousePos = ev.canvasPos!;
        final highlightedEdgeId = ctx.hitTester.hitTestEdge(mousePos);

        debugPrint(
          '[InsertNodePreviewBehavior] pointerUp at $mousePos, '
          'highlightedEdgeId=$highlightedEdgeId',
        );

        if (highlightedEdgeId != null) {
          final newNode = NodeModel(
            id: 'node_${_uuid.v4()}',
            type: interaction.nodeType,
            position: mousePos,
            size: interaction.nodeSize,
            title: interaction.nodeType,
          );

          debugPrint(
            '[InsertNodePreviewBehavior] Creating node: '
            'id=${newNode.id}, type=${newNode.type}, '
            'position=${newNode.position}',
          );

          ctx.controller.graph.insertNodeIntoEdge(newNode, highlightedEdgeId);

          debugPrint(
            '[InsertNodePreviewBehavior] Node inserted into edge: '
            'edgeId=$highlightedEdgeId',
          );
        } else {
          debugPrint(
              '[InsertNodePreviewBehavior] No edge highlighted, node insertion skipped.');
        }

        ctx.controller.interaction.endInsertingNodePreview();

        debugPrint(
            '[InsertNodePreviewBehavior] Interaction state reset to idle.');
        break;

      default:
        debugPrint(
            '[InsertNodePreviewBehavior] Event type ${ev.type} not handled.');
        break;
    }
  }

  @override
  bool enabled(InputConfig config) {
    final enabled = config.enableNodeInsertPreview;
    debugPrint('[InsertNodePreviewBehavior] enabled: $enabled');
    return enabled;
  }
}
