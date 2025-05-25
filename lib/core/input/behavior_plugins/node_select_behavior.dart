import 'package:flutter/gestures.dart';
import 'package:flow_editor/core/input/behavior_core/canvas_behavior.dart';
import 'package:flow_editor/core/input/behavior_core/behavior_context.dart';
import 'package:flow_editor/core/input/event/input_event.dart';
import 'package:flow_editor/core/input/event/input_event_type.dart';
import 'package:flow_editor/core/models/config/input_config.dart';

class NodeSelectBehavior implements CanvasBehavior {
  final BehaviorContext context;

  NodeSelectBehavior(this.context);

  @override
  int get priority => context.getState().behaviorPriority.nodeSelect;

  @override
  bool enabled(InputConfig config) => config.enableNodeSelect;

  @override
  bool canHandle(InputEvent ev, dynamic _) {
    if (ev.type != InputEventType.pointerDown || ev.canvasPos == null) {
      return false;
    }

    final pointerEvent = ev.pointerEvent;
    if (pointerEvent is! PointerDownEvent ||
        pointerEvent.buttons != kPrimaryMouseButton) {
      return false; // 确保仅处理鼠标左键点击事件
    }

    final hitNodeId = context.hitTester.hitTestNode(ev.canvasPos!);
    return hitNodeId != null;
  }

  @override
  void handle(InputEvent ev, BehaviorContext ctx) {
    final nodeId = ctx.hitTester.hitTestNode(ev.canvasPos!);
    if (nodeId != null) {
      ctx.controller.graph.selectNodes({nodeId});
    } else {
      ctx.controller.graph.clearSelection();
    }
  }
}
