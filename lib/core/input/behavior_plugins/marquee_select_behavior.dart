// core/input/behavior_plugins/marquee_select_behavior.dart

import 'package:flutter/material.dart';
import 'package:flow_editor/core/input/behavior_core/canvas_behavior.dart';
import 'package:flow_editor/core/input/behavior_core/behavior_context.dart';
import 'package:flow_editor/core/input/event/input_event.dart';
import 'package:flow_editor/core/input/event/input_event_type.dart';

class MarqueeSelectBehavior implements CanvasBehavior {
  final BehaviorContext context;

  MarqueeSelectBehavior(this.context);

  @override
  int get priority => 30;

  @override
  bool canHandle(InputEvent ev, dynamic canvasState) {
    final state = context.getState();

    // 1) 指针按下 且 在空白区 且 已启用框选
    if (ev.type == InputEventType.pointerDown && ev.canvasPos != null) {
      return context.hitTester.hitTestElement(ev.canvasPos!) == null &&
          state.interactionConfig.enableMarqueeSelect;
    }

    // 2) 有正在进行的框选时，Move/Up/Cancel 都可处理
    final marquee = state.interactionState.marqueeRect;
    if (marquee != null &&
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

    switch (ev.type) {
      case InputEventType.pointerDown:
        // 初始化一个零大小的选框
        if (ev.canvasPos != null) {
          final rect = Rect.fromPoints(ev.canvasPos!, ev.canvasPos!);
          context.updateInteraction(interaction.copyWith(
            marqueeRect: rect,
          ));
        }
        break;

      case InputEventType.pointerMove:
        // 更新选框大小并通知 controller
        if (ev.canvasPos != null && interaction.marqueeRect != null) {
          final start = interaction.marqueeRect!.topLeft;
          final rect = Rect.fromPoints(start, ev.canvasPos!);
          context.controller.marqueeSelect(rect);
          context.updateInteraction(interaction.copyWith(
            marqueeRect: rect,
          ));
        }
        break;

      case InputEventType.pointerUp:
      case InputEventType.pointerCancel:
        // 显式清空选框状态，并发出清除命令
        context.updateInteraction(interaction.copyWith(
          resetMarquee: true,
        ));
        context.controller.marqueeSelect(Rect.zero);
        break;

      default:
        break;
    }
  }
}
