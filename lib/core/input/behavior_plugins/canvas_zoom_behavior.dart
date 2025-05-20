import 'package:flutter/gestures.dart';
import 'package:flow_editor/core/input/behavior_core/canvas_behavior.dart';
import 'package:flow_editor/core/input/behavior_core/behavior_context.dart';
import 'package:flow_editor/core/input/event/input_event.dart';
import 'package:flow_editor/core/input/event/input_event_type.dart';
import 'package:flow_editor/core/models/state/editor_state.dart';

class CanvasZoomBehavior implements CanvasBehavior {
  final BehaviorContext context;

  CanvasZoomBehavior(this.context);

  @override
  int get priority => 60;

  @override
  bool canHandle(InputEvent ev, EditorState state) {
    return ev.type == InputEventType.pointerSignal &&
        state.activeCanvas.interactionConfig.enableZoom;
  }

  @override
  void handle(InputEvent ev, BehaviorContext context) {
    if (ev.type != InputEventType.pointerSignal) return;

    final signal = ev.raw as PointerScrollEvent;
    final zoomDelta = -signal.scrollDelta.dy * 0.001;

    if (ev.canvasPos != null && zoomDelta.abs() > 0.0001) {
      context.controller.zoomAt(ev.canvasPos!, zoomDelta);
    }
  }
}
