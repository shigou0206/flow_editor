import 'package:flutter/foundation.dart';
import 'package:flow_editor/core/input/behavior_core/canvas_behavior.dart';
import 'package:flow_editor/core/input/behavior_core/behavior_context.dart';
import 'package:flow_editor/core/input/event/input_event.dart';
import 'package:flow_editor/core/input/event/input_event_type.dart';
import 'package:flow_editor/core/models/config/input_config.dart';
import 'package:flow_editor/core/models/state/editor_state.dart';
import 'package:flow_editor/core/models/state/interaction_transient_state.dart';

class EdgeHoverBehavior implements CanvasBehavior {
  final BehaviorContext context;

  EdgeHoverBehavior(this.context);

  @override
  int get priority => context.getState().behaviorPriority.edgeHover;

  @override
  bool canHandle(InputEvent ev, EditorState state) {
    return ev.type == InputEventType.pointerHover ||
        ev.type == InputEventType.pointerExit;
  }

  @override
  void handle(InputEvent ev, BehaviorContext context) {
    switch (ev.type) {
      case InputEventType.pointerHover:
        final canvasPos = ev.canvasPos!;
        final edgeHitResult = context.hitTester.hitTestEdgeModel(canvasPos);

        if (edgeHitResult != null) {
          final edgeId = edgeHitResult.id;
          final currentHover = context.getState().interaction.hoveringEdgeId;

          if (currentHover != edgeId) {
            debugPrint('[EdgeHover] Hovering edge changed to $edgeId');
            context.controller.interaction.hoverEdge(edgeId);
            context.updateInteraction(
              InteractionState.hoveringEdge(edgeId: edgeId),
            );
          }
        } else {
          if (context.getState().interaction.isHoveringEdge) {
            debugPrint('[EdgeHover] No edge hover detected, clearing state.');
            context.controller.interaction.clearHover();
            context.updateInteraction(const InteractionState.idle());
          }
        }
        break;

      case InputEventType.pointerExit:
        if (context.getState().interaction.isHoveringEdge) {
          debugPrint('[EdgeHover] Pointer exited, clearing hover state.');
          context.controller.interaction.clearHover();
          context.updateInteraction(const InteractionState.idle());
        }
        break;

      default:
        break;
    }
  }

  @override
  bool enabled(InputConfig config) => config.enableEdgeHover;
}
