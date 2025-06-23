import 'package:flutter/gestures.dart';
import 'package:flow_editor/core/input/behavior_core/canvas_behavior.dart';
import 'package:flow_editor/core/input/behavior_core/behavior_context.dart';
import 'package:flow_editor/core/input/event/input_event.dart';
import 'package:flow_editor/core/input/event/input_event_type.dart';
import 'package:flow_editor/core/models/config/input_config.dart';
import 'package:flow_editor/core/models/ui_state/editor_state.dart';

class CanvasZoomBehavior implements CanvasBehavior {
  final BehaviorContext context;

  CanvasZoomBehavior(this.context);

  @override
  int get priority => context.getState().behaviorPriority.canvasZoom;

  @override
  bool canHandle(InputEvent ev, EditorState state) {
    return ev.type == InputEventType.pointerSignal &&
        state.canvasState.interactionConfig.enableZoom;
  }

  @override
  void handle(InputEvent ev, BehaviorContext context) {
    if (ev.type != InputEventType.pointerSignal) return;

    // 🚩 修改这里，使用pointerEvent明确类型安全
    final signal = ev.pointerEvent as PointerScrollEvent?;
    if (signal == null) return; // 增加类型安全检查

    final zoomDelta = -signal.scrollDelta.dy * 0.001;

    if (ev.canvasPos != null && zoomDelta.abs() > 0.0001) {
      context.controller.viewport.zoomAt(ev.canvasPos!, zoomDelta);
    }
  }

  @override
  bool enabled(InputConfig config) => config.enableZoom;
}
