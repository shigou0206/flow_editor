import 'package:flutter/foundation.dart';
import 'package:uuid/uuid.dart';
import 'package:flow_editor/core/input/behavior_core/canvas_behavior.dart';
import 'package:flow_editor/core/input/behavior_core/behavior_context.dart';
import 'package:flow_editor/core/input/event/input_event.dart';
import 'package:flow_editor/core/input/event/input_event_type.dart';
import 'package:flow_editor/core/models/config/input_config.dart';
import 'package:flow_editor/core/models/state/editor_state.dart';
import 'package:flow_editor/core/models/state/interaction_transient_state.dart';
import 'package:flow_editor/core/models/edge_model.dart';

class EdgeDrawBehavior implements CanvasBehavior {
  final BehaviorContext context;
  final _uuid = const Uuid();

  EdgeDrawBehavior(this.context);

  @override
  int get priority => 20;

  @override
  bool canHandle(InputEvent ev, EditorState state) {
    final interaction = state.interaction;

    if (ev.type == InputEventType.pointerDown) {
      final result = context.hitTester.hitTestAnchorResult(ev.canvasPos!);
      debugPrint(
        '[EdgeDraw] pointerDown at ${ev.canvasPos}, anchor hit: ${result != null}',
      );
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
          final anchorId = result.anchor.id;
          final nodeId = result.nodeId;

          debugPrint('[EdgeDraw] Start edge from anchor:');
          debugPrint('  - nodeId: $nodeId');
          debugPrint('  - anchorId: $anchorId');
          debugPrint('  - at canvasPos: ${ev.canvasPos}');

          final edgeId = 'temp_edge_${_uuid.v4()}';

          context.controller.interaction.startEdgeDrag(nodeId, anchorId);
          context.updateInteraction(
            InteractionState.dragEdge(
              edgeId: edgeId,
              sourceNodeId: nodeId,
              sourceAnchorId: anchorId,
              startCanvas: ev.canvasPos!,
              lastCanvas: ev.canvasPos!,
            ),
          );

          debugPrint('[EdgeDraw] DragEdge started with id: $edgeId');
        } else {
          debugPrint('[EdgeDraw] No anchor hit at ${ev.canvasPos}');
        }
        break;

      case InputEventType.pointerMove:
        if (ev.canvasPos != null) {
          context.controller.interaction.updateEdgeDrag(ev.canvasPos!);
          context.updateInteraction(
            context.getState().interaction.maybeMap(
                  dragEdge: (state) =>
                      state.copyWith(lastCanvas: ev.canvasPos!),
                  orElse: () => context.getState().interaction,
                ),
          );
        }
        break;

      case InputEventType.pointerUp:
        debugPrint('[EdgeDraw] DragEdge released at ${ev.canvasPos}');

        final drag = context.getState().interaction as DragEdge;
        final targetResult =
            context.hitTester.hitTestAnchorResult(ev.canvasPos!);

        if (targetResult != null) {
          debugPrint('[EdgeDraw] Anchor hit at release point:');
          debugPrint('  - targetNodeId: ${targetResult.nodeId}');
          debugPrint('  - targetAnchorId: ${targetResult.anchor.id}');

          final newEdge = EdgeModel(
            id: 'edge_${_uuid.v4()}',
            sourceNodeId: drag.sourceNodeId,
            sourceAnchorId: drag.sourceAnchorId,
            targetNodeId: targetResult.nodeId,
            targetAnchorId: targetResult.anchor.id,
          );

          // ✅ 使用 GraphController 正确添加Edge到持久层
          context.controller.graph.addEdge(newEdge);
          debugPrint('[EdgeDraw] New edge created: ${newEdge.id}');
        } else {
          debugPrint('[EdgeDraw] No anchor hit at release point');
        }

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
