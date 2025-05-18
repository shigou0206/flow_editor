import 'package:flow_editor/core/input/behavior_core/canvas_behavior.dart';
import 'package:flow_editor/core/input/behavior_core/behavior_context.dart';
import 'package:flow_editor/core/input/event/input_event.dart';
import 'package:flow_editor/core/input/event/input_event_type.dart';
import 'package:flow_editor/core/models/state/canvas_state.dart';

class CanvasPanBehavior implements CanvasBehavior {
  final BehaviorContext context;

  CanvasPanBehavior(this.context);

  @override
  int get priority => 50;

  @override
  bool canHandle(InputEvent ev, CanvasState state) {
    // 开始拖动：点击空白区域
    if (ev.type == InputEventType.pointerDown && ev.canvasPos != null) {
      return state.interactionConfig.enablePan &&
          context.hitTester.hitTestElement(ev.canvasPos!) == null;
    }

    // 拖动中：仅当 interactionState.isPanning 为 true
    if ((ev.type == InputEventType.pointerMove ||
            ev.type == InputEventType.pointerUp ||
            ev.type == InputEventType.pointerCancel) &&
        state.interactionState.isPanning) {
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
            isPanning: true,
            panStartPos: ev.canvasPos,
          ));
        }
        break;

      case InputEventType.pointerMove:
        if (ev.canvasPosDelta != null) {
          context.controller.panBy(ev.canvasPosDelta!);
        }
        break;

      case InputEventType.pointerUp:
      case InputEventType.pointerCancel:
        context.updateInteraction(interaction.copyWith(
          isPanning: false,
          panStartPos: null,
        ));
        break;

      default:
        break;
    }
  }
}
