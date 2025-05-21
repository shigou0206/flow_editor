// lib/core/input/behavior_plugins/node_drag_behavior.dart

import 'package:flow_editor/core/input/behavior_core/canvas_behavior.dart';
import 'package:flow_editor/core/input/behavior_core/behavior_context.dart';
import 'package:flow_editor/core/input/event/input_event.dart';
import 'package:flow_editor/core/input/event/input_event_type.dart';
import 'package:flow_editor/core/models/state/interaction_transient_state.dart';
import 'package:flutter/foundation.dart';

class NodeDragBehavior implements CanvasBehavior {
  final BehaviorContext context;

  NodeDragBehavior(this.context);

  @override
  int get priority => 10;

  @override
  bool canHandle(InputEvent ev, dynamic _) {
    final interaction = context.interaction;
    debugPrint('canHandle: ${ev.type}');

    // 1) pointerDown 且命中了节点：可以开始 dragNode
    if (ev.type == InputEventType.pointerDown && ev.canvasPos != null) {
      debugPrint('canHandle: ${context.hitTester.hitTestNode(ev.canvasPos!)}');
      return context.hitTester.hitTestNode(ev.canvasPos!) != null;
    }

    // 2) 如果当前正处于 dragNode 状态，就继续处理 Move/Up/Cancel
    if (interaction is DragNode &&
        (ev.type == InputEventType.pointerMove ||
            ev.type == InputEventType.pointerUp ||
            ev.type == InputEventType.pointerCancel)) {
      return true;
    }

    return false;
  }

  @override
  void handle(InputEvent ev, BehaviorContext context) {
    final interaction = context.interaction;
    debugPrint('handle: ${ev.type}');
    switch (ev.type) {
      case InputEventType.pointerDown:
        final pos = ev.canvasPos!;
        final nodeId = context.hitTester.hitTestNode(pos)!;
        // 通知 controller 开始拖拽
        context.controller.startNodeDrag(nodeId);
        // 进入 DragNode 状态，并记录起始点
        context.updateInteraction(
          InteractionState.dragNode(nodeId: nodeId, lastCanvas: pos),
        );
        break;

      case InputEventType.pointerMove:
        if (ev.canvasPos == null) return;
        if (interaction is DragNode) {
          final pos = ev.canvasPos!;
          // 计算从上一次位置到当前的增量
          final delta = pos - interaction.lastCanvas;
          context.controller.updateNodeDrag(delta);
          // 更新 InteractionState.lastCanvas
          context.updateInteraction(
            InteractionState.dragNode(
                nodeId: interaction.nodeId, lastCanvas: pos),
          );
        }
        break;

      case InputEventType.pointerUp:
      case InputEventType.pointerCancel:
        if (interaction is DragNode) {
          context.controller.endNodeDrag();
          // 恢复空闲状态
          context.updateInteraction(const InteractionState.idle());
        }
        break;

      default:
        break;
    }
  }
}
