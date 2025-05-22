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
    // 1) pointerDown 且命中了节点：可以开始 dragNode
    if (ev.type == InputEventType.pointerDown && ev.canvasPos != null) {
      return context.hitTester.hitTestNode(ev.canvasPos!) != null;
    }
    // 2) 如果当前正处于 DragNode 状态，就继续处理 Move/Up/Cancel
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
        // 通知 controller 开始低级拖拽
        ctx.controller.startNodeDrag(nodeId);
        // 进入 DragNode 临时状态，记录起点和当前位置
        ctx.updateInteraction(
          InteractionState.dragNode(
            nodeId: nodeId,
            startCanvas: p,
            lastCanvas: p,
          ),
        );
        break;

      case InputEventType.pointerMove:
        if (ev.canvasPos == null || it is! DragNode) return;
        final newPos = ev.canvasPos!;
        final delta = newPos - it.lastCanvas;
        // 1) 更新低级拖拽（画面上节点实时移动）
        ctx.controller.updateNodeDrag(delta);
        // 2) 更新 InteractionState.lastCanvas，用于 UI 渲染 & 后续计算
        ctx.updateInteraction(
          InteractionState.dragNode(
            nodeId: it.nodeId,
            startCanvas: it.startCanvas,
            lastCanvas: newPos,
          ),
        );
        break;

      case InputEventType.pointerUp:
      case InputEventType.pointerCancel:
        if (it is DragNode) {
          // 1) 结束低级拖拽
          ctx.controller.endNodeDrag();
          // 2) 计算总偏移并提交持久化命令
          final totalDelta = it.lastCanvas - it.startCanvas;
          ctx.controller.moveNode(it.nodeId, totalDelta);
          // 3) 重置为 idle 状态
          ctx.updateInteraction(const InteractionState.idle());
        }
        break;

      default:
        break;
    }
  }
}
