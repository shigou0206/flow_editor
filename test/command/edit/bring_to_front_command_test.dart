// test/command/edit/bring_to_front_command_test.dart

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flow_editor/core/command/command_manager.dart';
import 'package:flow_editor/core/command/command_context.dart';
import 'package:flow_editor/core/command/edit/bring_to_front_command.dart';
import 'package:flow_editor/core/controller/impl/canvas_controller_impl.dart';
import 'package:flow_editor/core/models/node_model.dart';
import 'package:flow_editor/core/models/state/canvas_state.dart';
import 'package:flow_editor/core/models/state/edge_state.dart';
import 'package:flow_editor/core/models/state/node_state.dart';
import 'package:flow_editor/core/models/state/canvas_viewport_state.dart';
import 'package:flow_editor/core/state_management/state_store/editor_state.dart';
import 'package:flow_editor/test/_helpers/fake_canvas_controller.dart';

/// 简易的 holder，用于桥接 EditorState 与 CommandContext
class EditorStateHolder {
  EditorStateHolder(this.state);

  /// 当前完整的编辑器状态
  EditorState state;

  /// 用于 CommandContext.getState
  EditorState toEditorState() => state;

  /// 用于 CommandContext.updateState
  void fromEditorState(EditorState s) {
    state = s;
  }
}

void main() {
  const wfId = 'wf1';

  late EditorStateHolder holder;
  late CommandContext ctx;
  late CommandManager mgr;

  setUp(() {
    // 初始节点列表：[n1, n2, n3]
    final initialNodes = [
      NodeModel(id: 'n1', position: const Offset(0, 0), size: const Size(1, 1)),
      NodeModel(id: 'n2', position: const Offset(0, 0), size: const Size(1, 1)),
      NodeModel(id: 'n3', position: const Offset(0, 0), size: const Size(1, 1)),
    ];

    // 构造 NodeState、EdgeState、CanvasState、ViewportState
    final nodeState = NodeState(nodesByWorkflow: {wfId: initialNodes});
    const edgeState = EdgeState(edgesByWorkflow: {wfId: []});
    const canvasState = CanvasState();
    const viewportState = CanvasViewportState();

    // 组装初始 EditorState
    holder = EditorStateHolder(
      EditorState(
        canvases: {wfId: canvasState},
        activeWorkflowId: wfId,
        nodes: nodeState,
        edges: edgeState,
        viewport: viewportState,
      ),
    );

    // 构造 CommandContext
    ctx = CommandContext(
      controller: CanvasController(CommandContext(
        controller: FakeCanvasController(),
        getState: holder.toEditorState,
        updateState: holder.fromEditorState,
      )),
      getState: holder.toEditorState,
      updateState: holder.fromEditorState,
    );

    mgr = CommandManager(ctx);
  });

  test('bring node to front changes order correctly', () async {
    // 将 'n2' 带到最前面
    final cmd = BringToFrontCommand(ctx, 'n2');
    await mgr.executeCommand(cmd);

    final ids = holder.state.nodes
        .nodesOf(wfId)
        .map((n) => n.id)
        .toList(growable: false);
    expect(ids, ['n1', 'n3', 'n2']);
    expect(mgr.canUndo, isTrue);
    expect(mgr.canRedo, isFalse);
  });

  test('undo restores original order', () async {
    final cmd = BringToFrontCommand(ctx, 'n2');
    await mgr.executeCommand(cmd);
    // 确保已执行
    expect(
        holder.state.nodes.nodesOf(wfId).map((n) => n.id), ['n1', 'n3', 'n2']);

    await mgr.undo();
    final ids = holder.state.nodes.nodesOf(wfId).map((n) => n.id).toList();
    expect(ids, ['n1', 'n2', 'n3']);
    expect(mgr.canUndo, isFalse);
    expect(mgr.canRedo, isTrue);
  });

  test('redo re-applies bring-to-front', () async {
    final cmd = BringToFrontCommand(ctx, 'n2');
    await mgr.executeCommand(cmd);
    await mgr.undo();
    // redo
    await mgr.redo();

    final ids = holder.state.nodes.nodesOf(wfId).map((n) => n.id).toList();
    expect(ids, ['n1', 'n3', 'n2']);
    expect(mgr.canUndo, isTrue);
    expect(mgr.canRedo, isFalse);
  });

  test('execute throws if node not found', () async {
    final cmd = BringToFrontCommand(ctx, 'absent');
    await expectLater(mgr.executeCommand(cmd), throwsException);
    expect(mgr.canUndo, isFalse);
    expect(mgr.canRedo, isFalse);
  });
}
