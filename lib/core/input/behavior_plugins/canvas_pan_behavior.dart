import 'package:flow_editor/core/input/behavior_core/canvas_behavior.dart';
import 'package:flow_editor/core/input/behavior_core/behavior_context.dart';
import 'package:flow_editor/core/input/event/input_event.dart';
import 'package:flow_editor/core/input/event/input_event_type.dart';
import 'package:flow_editor/core/models/config/input_config.dart';
import 'package:flow_editor/core/models/ui_state/editor_state.dart';
import 'package:flow_editor/core/models/ui_state/interaction_transient_state.dart';

class CanvasPanBehavior implements CanvasBehavior {
  final BehaviorContext context;

  CanvasPanBehavior(this.context);

  @override
  int get priority => context.getState().behaviorPriority.canvasPan;

  @override
  bool canHandle(InputEvent ev, EditorState state) {
    final interaction = state.interaction;

    // —— 永远不要在节点/连线拖拽时平移画布 ——
    if (interaction is DragNode ||
        interaction is DragEdge ||
        interaction is DragWaypoint) {
      return false;
    }

    // 1) 鼠标按下：空白区 && 允许平移
    if (ev.type == InputEventType.pointerDown && ev.canvasPos != null) {
      final hit = context.hitTester.hitTestElement(ev.canvasPos!);
      final ok = state.canvasState.interactionConfig.enablePan && hit == null;
      return ok;
    }

    // 2) 移动/抬起/取消：必须是在 PanCanvas 临时状态时才接管
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
    final interaction = context.interaction;

    switch (ev.type) {
      case InputEventType.pointerDown:
        // 进入临时平移状态，记录起点和最新点
        context.updateInteraction(
          InteractionState.panCanvas(
            startGlobal: ev.canvasPos!,
            lastGlobal: ev.canvasPos!,
          ),
        );
        break;

      case InputEventType.pointerMove:
        if (ev.canvasPos != null && interaction is PanCanvas) {
          // 只更新临时 lastGlobal
          context.updateInteraction(
            InteractionState.panCanvas(
              startGlobal: interaction.startGlobal,
              lastGlobal: ev.canvasPos!,
            ),
          );
        }
        break;

      case InputEventType.pointerUp:
      case InputEventType.pointerCancel:
        if (interaction is PanCanvas) {
          // 计算总偏移 = 抬起点 - 起始点
          final delta = interaction.lastGlobal - interaction.startGlobal;
          // 一次性写入持久态
          context.controller.viewport.panBy(delta);
          // 退出临时状态
          context.updateInteraction(const InteractionState.idle());
        }
        break;

      default:
        break;
    }
  }

  @override
  bool enabled(InputConfig config) => config.enablePan;
}
