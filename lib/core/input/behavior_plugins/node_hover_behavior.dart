import 'package:flutter/foundation.dart';
import 'package:flow_editor/core/input/behavior_core/canvas_behavior.dart';
import 'package:flow_editor/core/input/behavior_core/behavior_context.dart';
import 'package:flow_editor/core/input/event/input_event.dart';
import 'package:flow_editor/core/input/event/input_event_type.dart';
import 'package:flow_editor/core/models/config/input_config.dart';
import 'package:flow_editor/core/models/state/interaction_transient_state.dart';

class NodeHoverBehavior implements CanvasBehavior {
  final BehaviorContext context;

  NodeHoverBehavior(this.context);

  @override
  int get priority => context.getState().behaviorPriority.nodeHover;

  @override
  bool canHandle(InputEvent ev, dynamic _) {
    return ev.type == InputEventType.pointerHover && ev.canvasPos != null;
  }

  @override
  void handle(InputEvent ev, BehaviorContext ctx) {
    final nodeId = ctx.hitTester.hitTestNode(ev.canvasPos!);

    final currentInteraction = ctx.interaction;

    if (nodeId != null) {
      // 鼠标悬浮在节点上
      if (currentInteraction is HoveringNode &&
          currentInteraction.nodeId == nodeId) {
        // 已经悬浮在此节点，无需变化
        return;
      }

      // 新的hover节点或之前未悬浮节点，更新状态
      ctx.updateInteraction(InteractionState.hoveringNode(nodeId: nodeId));

      debugPrint('[NodeHover] Hovering node: $nodeId');
    } else {
      // 鼠标未悬浮在任何节点上，恢复空闲状态（如果之前是hover状态）
      if (currentInteraction is HoveringNode) {
        ctx.updateInteraction(const InteractionState.idle());
        debugPrint('[NodeHover] Hover ended');
      }
    }
  }

  @override
  bool enabled(InputConfig config) => config.enableNodeHover;
}
