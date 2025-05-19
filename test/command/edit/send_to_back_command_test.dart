import 'dart:ui';

import 'package:flutter_test/flutter_test.dart';
import 'package:flow_editor/core/command/command_manager.dart';
import 'package:flow_editor/core/command/command_context.dart';
import 'package:flow_editor/core/command/edit/send_to_back_command.dart';
import 'package:flow_editor/core/models/node_model.dart';
import 'package:flow_editor/core/models/state/canvas_state.dart';
import 'package:flow_editor/core/models/state/node_state.dart';
import 'package:flow_editor/core/models/state/edge_state.dart';
import 'package:flow_editor/core/models/state/canvas_viewport_state.dart';
import 'package:flow_editor/core/state_management/state_store/editor_state.dart';

/// 简易的 Holder，用于桥接 EditorState 与 CommandContext
class EditorStateHolder {
  EditorStateHolder(this.state);
  EditorState state;

  EditorState toEditorState() => state;
  void fromEditorState(EditorState s) => state = s;
}

void main() {
  const wfId = 'wf1';

  late EditorStateHolder holder;
  late CommandContext ctx;
  late CommandManager mgr;

  setUp(() {
    // 初始节点顺序 [n1, n2, n3]
    final initialNodes = [
      NodeModel(id: 'n1', position: Offset.zero, size: const Size(1, 1)),
      NodeModel(id: 'n2', position: Offset.zero, size: const Size(1, 1)),
      NodeModel(id: 'n3', position: Offset.zero, size: const Size(1, 1)),
    ];
    final nodeState = NodeState(nodesByWorkflow: {wfId: initialNodes});
    const edgeState = EdgeState(edgesByWorkflow: {wfId: []});
    const canvasState = CanvasState();
    const viewportState = CanvasViewportState();

    holder = EditorStateHolder(
      EditorState(
        canvases: {wfId: canvasState},
        activeWorkflowId: wfId,
        nodes: nodeState,
        edges: edgeState,
        viewport: viewportState,
      ),
    );

    ctx = CommandContext(
      getState: holder.toEditorState,
      updateState: holder.fromEditorState,
    );
    mgr = CommandManager(ctx);
  });

  test('send to back moves node to front of list', () async {
    final cmd = SendToBackCommand(ctx, 'n2');
    await mgr.executeCommand(cmd);

    final ids = holder.state.nodes
        .nodesOf(wfId)
        .map((n) => n.id)
        .toList(growable: false);
    expect(ids, ['n2', 'n1', 'n3']);
    expect(mgr.canUndo, isTrue);
    expect(mgr.canRedo, isFalse);
  });

  test('undo restores original order', () async {
    final cmd = SendToBackCommand(ctx, 'n2');
    await mgr.executeCommand(cmd);
    // 确认已移动
    expect(
        holder.state.nodes.nodesOf(wfId).map((n) => n.id), ['n2', 'n1', 'n3']);

    await mgr.undo();
    final ids = holder.state.nodes.nodesOf(wfId).map((n) => n.id).toList();
    expect(ids, ['n1', 'n2', 'n3']);
    expect(mgr.canUndo, isFalse);
    expect(mgr.canRedo, isTrue);
  });

  test('redo re-applies send-to-back', () async {
    final cmd = SendToBackCommand(ctx, 'n2');
    await mgr.executeCommand(cmd);
    await mgr.undo();
    await mgr.redo();

    final ids = holder.state.nodes.nodesOf(wfId).map((n) => n.id).toList();
    expect(ids, ['n2', 'n1', 'n3']);
    expect(mgr.canUndo, isTrue);
    expect(mgr.canRedo, isFalse);
  });

  test('execute throws if node not found', () async {
    final cmd = SendToBackCommand(ctx, 'absent');
    await expectLater(mgr.executeCommand(cmd), throwsException);
    expect(mgr.canUndo, isFalse);
    expect(mgr.canRedo, isFalse);
  });
}
