import 'package:flutter/material.dart';
import 'package:flow_editor/core/input/behavior_core/canvas_behavior.dart';
import 'package:flow_editor/core/input/behavior_core/behavior_context.dart';
import 'package:flow_editor/core/input/event/input_event.dart';
import 'package:flow_editor/core/input/event/input_event_type.dart';
import 'package:flow_editor/core/models/state/editor_state.dart';
import 'package:flow_editor/core/models/state/interaction_transient_state.dart';

class MarqueeSelectBehavior implements CanvasBehavior {
  final BehaviorContext context;

  MarqueeSelectBehavior(this.context);

  @override
  int get priority => 30;

  @override
  bool canHandle(InputEvent ev, EditorState state) {
    // 1) 开始框选：按下空白区域 + 启用框选
    if (ev.type == InputEventType.pointerDown && ev.canvasPos != null) {
      return context.hitTester.hitTestElement(ev.canvasPos!) == null &&
          state.activeCanvas.interactionConfig.enableMarqueeSelect;
    }

    // 2) 正在框选中：只要是 SelectingArea 状态
    final interaction = state.interaction;
    if (interaction is SelectingArea &&
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
        if (ev.canvasPos != null) {
          final rect = Rect.fromPoints(ev.canvasPos!, ev.canvasPos!);
          context.updateInteraction(
              InteractionState.selectingArea(selectionBox: rect));
        }
        break;

      case InputEventType.pointerMove:
        if (ev.canvasPos != null && interaction is SelectingArea) {
          final start = interaction.selectionBox.topLeft;
          final rect = Rect.fromPoints(start, ev.canvasPos!);
          context.controller.marqueeSelect(rect);
          context.updateInteraction(
              InteractionState.selectingArea(selectionBox: rect));
        }
        break;

      case InputEventType.pointerUp:
      case InputEventType.pointerCancel:
        context.controller.marqueeSelect(Rect.zero);
        context.updateInteraction(const InteractionState.idle());
        break;

      default:
        break;
    }
  }
}
