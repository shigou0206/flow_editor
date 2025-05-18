import 'package:flow_editor/core/input/behavior_core/canvas_behavior.dart';
import 'package:flow_editor/core/input/behavior_core/behavior_context.dart';
import 'package:flow_editor/core/input/event/input_event.dart';
import 'package:flow_editor/core/input/event/input_event_type.dart';
import 'package:flow_editor/core/models/state/canvas_state.dart';

class EdgeDrawBehavior implements CanvasBehavior {
  final BehaviorContext context;

  EdgeDrawBehavior(this.context);

  @override
  int get priority => 20;

  @override
  bool canHandle(InputEvent ev, CanvasState state) {
    final interaction = state.interactionState;

    if (ev.type == InputEventType.pointerDown) {
      final hit = context.hitTester.hitTestAnchor(ev.canvasPos!);
      return hit != null;
    }

    if (interaction.isDraggingEdge &&
        (ev.type == InputEventType.pointerMove ||
            ev.type == InputEventType.pointerUp ||
            ev.type == InputEventType.pointerCancel)) {
      return true;
    }

    return false;
  }

  @override
  void handle(InputEvent ev, BehaviorContext context) {
    final state = context.getState();
    final interaction = state.interactionState;

    switch (ev.type) {
      case InputEventType.pointerDown:
        final anchorId = context.hitTester.hitTestAnchor(ev.canvasPos!);
        if (anchorId != null) {
          context.controller.startEdgeDrag(anchorId);
          context.updateInteraction(interaction.copyWith(
            isDraggingEdge: true,
            drawingFromAnchorId: anchorId,
          ));
        }
        break;

      case InputEventType.pointerMove:
        if (ev.canvasPos != null) {
          context.controller.updateEdgeDrag(ev.canvasPos!);
        }
        break;

      case InputEventType.pointerUp:
      case InputEventType.pointerCancel:
        context.controller.endEdgeDrag();
        context.updateInteraction(interaction.copyWith(
          isDraggingEdge: false,
          drawingFromAnchorId: null,
        ));
        break;

      default:
        break;
    }
  }
}
