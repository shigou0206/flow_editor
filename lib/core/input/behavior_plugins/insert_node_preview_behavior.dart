import 'package:flutter/foundation.dart';
import 'package:flow_editor/core/input/behavior_core/canvas_behavior.dart';
import 'package:flow_editor/core/input/behavior_core/behavior_context.dart';
import 'package:flow_editor/core/input/event/input_event.dart';
import 'package:flow_editor/core/input/event/input_event_type.dart';
import 'package:flow_editor/core/models/state/interaction_transient_state.dart';
import 'package:flow_editor/core/models/config/input_config.dart';

class InsertNodePreviewBehavior implements CanvasBehavior {
  final BehaviorContext context;

  InsertNodePreviewBehavior(this.context);

  @override
  int get priority => context.getState().behaviorPriority.nodeInsertPreview;

  @override
  bool canHandle(InputEvent ev, dynamic _) {
    final interaction = context.interaction;
    return interaction is InsertingNodePreview &&
        (ev.type == InputEventType.pointerMove ||
            ev.type == InputEventType.pointerUp);
  }

  @override
  void handle(InputEvent ev, BehaviorContext ctx) {
    final interaction = ctx.interaction;

    if (interaction is! InsertingNodePreview) {
      debugPrint(
        '[InsertNodePreviewBehavior] Aborted: '
        'Not in InsertingNodePreview state',
      );
      return;
    }

    switch (ev.type) {
      case InputEventType.pointerMove:
        final mousePos = ev.canvasPos!;
        final highlightedEdgeId = ctx.hitTester.hitTestEdge(mousePos);

        debugPrint(
          '[InsertNodePreviewBehavior] pointerMove: '
          'mousePos=$mousePos, highlightedEdgeId=$highlightedEdgeId',
        );

        ctx.controller.interaction.updateInsertingNodePreview(
          mousePos,
          highlightedEdgeId,
        );

        debugPrint('[InsertNodePreviewBehavior] updated preview state');
        break;

      case InputEventType.pointerUp:
        final mousePos = ev.canvasPos!;
        final highlightedEdgeId = ctx.hitTester.hitTestEdge(mousePos);

        debugPrint(
          '[InsertNodePreviewBehavior] pointerUp: '
          'mousePos=$mousePos, highlightedEdgeId=$highlightedEdgeId',
        );

        if (highlightedEdgeId != null) {
          final node = interaction.node.copyWith(position: mousePos);

          debugPrint(
            '[InsertNodePreviewBehavior] inserting node: '
            'id=${node.id}, type=${node.type}, position=${node.position}, '
            'edgeId=$highlightedEdgeId',
          );

          ctx.controller.graph.insertNodeIntoEdge(node, highlightedEdgeId);

          debugPrint('[InsertNodePreviewBehavior] node successfully inserted');
        } else {
          debugPrint(
            '[InsertNodePreviewBehavior] no edge highlighted, '
            'node insertion skipped',
          );
        }

        ctx.controller.interaction.endInsertingNodePreview();

        debugPrint('[InsertNodePreviewBehavior] reset to idle state');
        break;

      default:
        debugPrint(
          '[InsertNodePreviewBehavior] unhandled event: ${ev.type}',
        );
        break;
    }
  }

  @override
  bool enabled(InputConfig config) {
    final isEnabled = config.enableNodeInsertPreview;
    debugPrint('[InsertNodePreviewBehavior] enabled: $isEnabled');
    return isEnabled;
  }
}
