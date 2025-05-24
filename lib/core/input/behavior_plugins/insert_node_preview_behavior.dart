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

    return (ev.type == InputEventType.pointerMove &&
            interaction is InsertingNodePreview) ||
        (ev.type == InputEventType.pointerUp &&
            interaction is InsertingNodePreview);
  }

  @override
  void handle(InputEvent ev, BehaviorContext ctx) {
    final interaction = ctx.interaction as InsertingNodePreview;

    switch (ev.type) {
      case InputEventType.pointerMove:
        final mousePos = ev.canvasPos!;
        final highlightedEdgeId = ctx.hitTester.hitTestEdge(mousePos);
        ctx.controller.interaction.updateInsertingNodePreview(
          mousePos,
          highlightedEdgeId,
        );
        break;

      case InputEventType.pointerUp:
        final mousePos = ev.canvasPos!;
        final highlightedEdgeId = ctx.hitTester.hitTestEdge(mousePos);

        if (highlightedEdgeId != null) {
          final newNode = NodeModel(
            id: 'node_${_uuid.v4()}',
            type: interaction.nodeType,
            position: mousePos,
            size: interaction.nodeSize,
            title: interaction.nodeType,
          );

          ctx.controller.graph.insertNodeIntoEdge(newNode, highlightedEdgeId);
        }

        ctx.controller.interaction.endInsertingNodePreview();
        break;

      default:
        break;
    }
  }

  @override
  bool enabled(InputConfig config) => config.enableNodeInsertPreview;
}
