import 'package:flow_editor/core/input/behavior_core/canvas_behavior.dart';
import 'package:flow_editor/core/input/behavior_core/behavior_context.dart';
import 'package:flow_editor/core/input/event/input_event.dart';
import 'package:flow_editor/core/input/event/input_event_type.dart';
import 'package:flow_editor/core/models/state/editor_state.dart';
import 'package:flow_editor/core/models/state/interaction_transient_state.dart';

class CanvasPanBehavior implements CanvasBehavior {
  final BehaviorContext context;

  CanvasPanBehavior(this.context);

  @override
  int get priority => 50;

  @override
  bool canHandle(InputEvent ev, EditorState state) {
    final interaction = state.interaction;

    // 开始拖动：点击空白区域 && pan 可用
    if (ev.type == InputEventType.pointerDown && ev.canvasPos != null) {
      return state.canvasState.interactionConfig.enablePan &&
          context.hitTester.hitTestElement(ev.canvasPos!) == null;
    }

    // 拖动中：交互状态是正在平移
    if ((ev.type == InputEventType.pointerMove ||
            ev.type == InputEventType.pointerUp ||
            ev.type == InputEventType.pointerCancel) &&
        interaction is PanCanvas) {
      return true;
    }

    return false;
  }

  @override
  void handle(InputEvent ev, BehaviorContext context) {
    switch (ev.type) {
      case InputEventType.pointerDown:
        if (ev.canvasPos != null) {
          context.updateInteraction(
            InteractionState.panCanvas(
              startGlobal: ev.canvasPos!,
              lastGlobal: ev.canvasPos!,
            ),
          );
        }
        break;

      case InputEventType.pointerMove:
        if (ev.canvasPosDelta != null) {
          context.controller.panBy(ev.canvasPosDelta!);
        }
        break;

      case InputEventType.pointerUp:
      case InputEventType.pointerCancel:
        context.updateInteraction(const InteractionState.idle());
        break;

      default:
        break;
    }
  }
}
