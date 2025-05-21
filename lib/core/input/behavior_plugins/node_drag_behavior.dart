// lib/core/input/behavior_plugins/node_drag_behavior.dart

import 'package:flow_editor/core/input/behavior_core/canvas_behavior.dart';
import 'package:flow_editor/core/input/behavior_core/behavior_context.dart';
import 'package:flow_editor/core/input/event/input_event.dart';
import 'package:flow_editor/core/input/event/input_event_type.dart';
import 'package:flow_editor/core/models/state/interaction_transient_state.dart';

class NodeDragBehavior implements CanvasBehavior {
  final BehaviorContext context;

  NodeDragBehavior(this.context);

  @override
  int get priority => 10;

  @override
  bool canHandle(InputEvent ev, dynamic _) {
    final it = context.interaction;
    if (ev.type == InputEventType.pointerDown && ev.canvasPos != null) {
      return context.hitTester.hitTestNode(ev.canvasPos!) != null;
    }
    if (it is DragNode &&
        (ev.type == InputEventType.pointerMove ||
            ev.type == InputEventType.pointerUp ||
            ev.type == InputEventType.pointerCancel)) {
      return true;
    }
    return false;
  }

  @override
  void handle(InputEvent ev, BehaviorContext ctx) {
    final it = ctx.interaction;
    switch (ev.type) {
      case InputEventType.pointerDown:
        final p = ev.canvasPos!;
        final nodeId = ctx.hitTester.hitTestNode(p)!;
        ctx.updateInteraction(
          InteractionState.dragNode(
            nodeId: nodeId,
            startCanvas: p,
            lastCanvas: p,
          ),
        );
        break;

      case InputEventType.pointerMove:
        if (ev.canvasPos == null) return;
        if (it is DragNode) {
          ctx.updateInteraction(
            InteractionState.dragNode(
              nodeId: it.nodeId,
              startCanvas: it.startCanvas,
              lastCanvas: ev.canvasPos!,
            ),
          );
        }
        break;

      case InputEventType.pointerUp:
      case InputEventType.pointerCancel:
        if (it is DragNode) {
          final delta = it.lastCanvas - it.startCanvas;
          // 松手时提交真正的移动命令
          ctx.controller.moveNode(it.nodeId, delta).then((_) => null);
          ctx.updateInteraction(const InteractionState.idle());
        }
        break;
      default:
        break;
    }
  }
}
