import 'package:flutter/material.dart';
import 'package:flow_editor/core/input/behavior_core/canvas_behavior.dart';
import 'package:flow_editor/core/input/behavior_core/behavior_context.dart';
import 'package:flow_editor/core/input/event/input_event.dart';
import 'package:flow_editor/core/input/event/input_event_type.dart';
import 'package:flow_editor/core/models/state/canvas_state.dart';

class MarqueeSelectBehavior implements CanvasBehavior {
  final BehaviorContext context;

  MarqueeSelectBehavior(this.context);

  @override
  int get priority => 30;

  @override
  bool canHandle(InputEvent ev, CanvasState state) {
    final interaction = state.interactionState;

    if (ev.type == InputEventType.pointerDown) {
      return context.hitTester.hitTestElement(ev.canvasPos!) == null;
    }

    if (interaction.marqueeRect != null &&
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
          context.updateInteraction(interaction.copyWith(
            marqueeRect: Rect.fromPoints(ev.canvasPos!, ev.canvasPos!),
          ));
        }
        break;

      case InputEventType.pointerMove:
        if (ev.canvasPos != null && interaction.marqueeRect != null) {
          final start = interaction.marqueeRect!.topLeft;
          final rect = Rect.fromPoints(start, ev.canvasPos!);
          context.controller.marqueeSelect(rect);
          context.updateInteraction(interaction.copyWith(marqueeRect: rect));
        }
        break;

      case InputEventType.pointerUp:
      case InputEventType.pointerCancel:
        context.updateInteraction(interaction.copyWith(marqueeRect: null));
        context.controller.marqueeSelect(Rect.zero); // 清除选区
        break;

      default:
        break;
    }
  }
}
