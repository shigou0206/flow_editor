import 'package:flutter/material.dart';
import 'package:flow_editor/core/input/behavior_core/canvas_behavior.dart';
import 'package:flow_editor/core/input/behavior_core/behavior_context.dart';
import 'package:flow_editor/core/input/event/input_event.dart';
import 'package:flow_editor/core/input/event/input_event_type.dart';
import 'package:flow_editor/core/models/config/input_config.dart';
import 'package:flow_editor/core/models/ui_state/editor_state.dart';

class NodeContextMenuBehavior implements CanvasBehavior {
  final BehaviorContext context;

  NodeContextMenuBehavior(this.context);

  @override
  int get priority => context.getState().behaviorPriority.nodeContextMenu;

  @override
  bool enabled(InputConfig config) => config.enableNodeContextMenu;

  @override
  bool canHandle(InputEvent ev, EditorState state) {
    return ev.type == InputEventType.pointerRightClick &&
        ev.canvasPos != null &&
        context.hitTester.hitTestNode(ev.canvasPos!) != null;
  }

  @override
  void handle(InputEvent ev, BehaviorContext ctx) {
    if (ev.type != InputEventType.pointerRightClick || ev.canvasPos == null) {
      return;
    }

    final nodeId = ctx.hitTester.hitTestNode(ev.canvasPos!);
    if (nodeId == null) return;

    final globalPos = (ev.pointerEvent as PointerDownEvent?)?.position;
    if (globalPos == null) return;

    _showContextMenu(nodeId, globalPos);
  }

  void _showContextMenu(String nodeId, Offset globalPosition) {
    final overlay = Overlay.of(context.buildContext).context.findRenderObject()
        as RenderBox;

    showMenu<String>(
      context: context.buildContext,
      position: RelativeRect.fromRect(
        globalPosition & const Size(40, 40),
        Offset.zero & overlay.size,
      ),
      items: const [
        PopupMenuItem(value: 'edit', child: Text('Edit')),
        PopupMenuItem(value: 'delete', child: Text('Delete')),
      ],
    ).then((selected) {
      if (selected == 'edit') {
        _handleEdit(nodeId);
      } else if (selected == 'delete') {
        _handleDelete(nodeId);
      }
    });
  }

  void _handleEdit(String nodeId) {
    // 暂时先打印日志，可稍后完善编辑功能
    debugPrint('Edit node: $nodeId');
  }

  void _handleDelete(String nodeId) {
    context.controller.graph.deleteNodeWithAutoReconnect(nodeId);
  }
}
