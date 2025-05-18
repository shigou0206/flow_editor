import 'package:flow_editor/core/input/behavior_core/canvas_behavior.dart';
import 'package:flow_editor/core/input/behavior_core/behavior_context.dart';
import 'package:flow_editor/core/input/event/input_event.dart';
import 'package:flow_editor/core/input/event/input_event_type.dart';
import 'package:flow_editor/core/models/state/canvas_state.dart';

class NodeDragBehavior implements CanvasBehavior {
  final BehaviorContext context;

  NodeDragBehavior(this.context);

  @override
  int get priority => 10;

  @override
  bool canHandle(InputEvent ev, CanvasState state) {
    final interaction = state.interactionState;

    if (ev.type == InputEventType.pointerDown) {
      final hit = context.hitTester.hitTestNode(ev.canvasPos!);
      return hit != null;
    }

    if (interaction.isDraggingNode &&
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
        final nodeId = context.hitTester.hitTestNode(ev.canvasPos!);
        if (nodeId != null) {
          context.controller.startNodeDrag(nodeId);
          context.updateInteraction(interaction.copyWith(
            isDraggingNode: true,
            draggingNodeId: nodeId,
            nodeDragStartPos: ev.canvasPos,
          ));
        }
        break;

      case InputEventType.pointerMove:
        if (ev.canvasPosDelta != null) {
          context.controller.updateNodeDrag(ev.canvasPosDelta!);
        }
        break;

      case InputEventType.pointerUp:
      case InputEventType.pointerCancel:
        context.controller.endNodeDrag();
        context.updateInteraction(interaction.copyWith(
          isDraggingNode: false,
          draggingNodeId: null,
          nodeDragStartPos: null,
        ));
        break;

      default:
        break;
    }
  }
}
