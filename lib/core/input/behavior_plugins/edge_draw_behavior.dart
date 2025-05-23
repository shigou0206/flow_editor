import 'package:flutter/foundation.dart';
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
      debugPrint(
          '[EdgeDraw] pointerDown at ${ev.canvasPos}, anchor hit: ${result != null}');
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

          debugPrint('[EdgeDraw] Start edge from anchor:');
          debugPrint('  - nodeId: $nodeId');
          debugPrint('  - anchorId: ${anchor.id}');
          debugPrint('  - anchorPos: ${anchor.position}');
          debugPrint('  - at canvasPos: ${ev.canvasPos}');

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

          debugPrint('[EdgeDraw] DragEdge started with id: $edgeId');
        } else {
          debugPrint('[EdgeDraw] No anchor hit at ${ev.canvasPos}');
        }
        break;

      case InputEventType.pointerMove:
        if (ev.canvasPos != null) {
          debugPrint('[EdgeDraw] DragEdge moved to ${ev.canvasPos}');
          context.controller.interaction.updateEdgeDrag(ev.canvasPos!);
        }
        break;

      case InputEventType.pointerUp:
        debugPrint('[EdgeDraw] DragEdge released');
        context.controller.interaction.endEdgeDrag();
        context.updateInteraction(const InteractionState.idle());
        break;

      case InputEventType.pointerCancel:
        debugPrint('[EdgeDraw] DragEdge cancelled');
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
