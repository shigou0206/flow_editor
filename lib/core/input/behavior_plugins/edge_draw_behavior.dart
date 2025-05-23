import 'package:flow_editor/core/input/behavior_core/canvas_behavior.dart';
import 'package:flow_editor/core/input/behavior_core/behavior_context.dart';
import 'package:flow_editor/core/input/event/input_event.dart';
import 'package:flow_editor/core/input/event/input_event_type.dart';
import 'package:flow_editor/core/models/config/input_config.dart';
import 'package:flow_editor/core/models/state/editor_state.dart';
import 'package:flow_editor/core/models/state/interaction_transient_state.dart';

class EdgeDrawBehavior implements CanvasBehavior {
  final BehaviorContext context;

  EdgeDrawBehavior(this.context);

  @override
  int get priority => 20;

  @override
  bool canHandle(InputEvent ev, EditorState state) {
    final interaction = state.interaction;

    if (ev.type == InputEventType.pointerDown) {
      final result = context.hitTester.hitTestAnchorResult(ev.canvasPos!);
      return result != null;
    }

    if (interaction is DragEdge &&
        (ev.type == InputEventType.pointerMove ||
            ev.type == InputEventType.pointerUp ||
            ev.type == InputEventType.pointerCancel)) {
      return true;
    }

    return false;
  }

  @override
  void handle(InputEvent ev, BehaviorContext context) {
    switch (ev.type) {
      case InputEventType.pointerDown:
        final result = context.hitTester.hitTestAnchorResult(ev.canvasPos!);
        if (result != null) {
          final anchor = result.anchor;
          final nodeId = result.nodeId;
          final edgeId = context.controller.interaction.generateTempEdgeId(
            nodeId,
            anchor.id,
          );
          context.controller.interaction.startEdgeDrag(nodeId, anchor.id);
          context.updateInteraction(
            InteractionState.dragEdge(
              edgeId: edgeId,
              startCanvas: ev.canvasPos!,
              lastCanvas: ev.canvasPos!,
              sourceAnchor: anchor,
            ),
          );
        }
        break;

      case InputEventType.pointerMove:
        if (ev.canvasPos != null) {
          context.controller.interaction.updateEdgeDrag(ev.canvasPos!);
        }
        break;

      case InputEventType.pointerUp:
      case InputEventType.pointerCancel:
        context.controller.interaction.endEdgeDrag();
        context.updateInteraction(const InteractionState.idle());
        break;

      default:
        break;
    }
  }

  @override
  bool enabled(InputConfig config) => config.enableEdgeDraw;
}
