import 'dart:ui';

import 'package:flutter_test/flutter_test.dart';
import 'package:flow_editor/core/command/command_manager.dart';
import 'package:flow_editor/core/command/command_context.dart';
import 'package:flow_editor/core/command/edit/delete_node_command.dart';
import 'package:flow_editor/core/models/node_model.dart';
import 'package:flow_editor/core/models/state/canvas_state.dart';
import 'package:flow_editor/core/models/state/node_state.dart';
import 'package:flow_editor/core/models/state/edge_state.dart';
import 'package:flow_editor/core/models/state/canvas_viewport_state.dart';
import 'package:flow_editor/core/logic/strategy/workflow_mode.dart';
import 'package:flow_editor/core/models/enums/canvas_interaction_mode.dart';
import 'package:flow_editor/core/models/styles/canvas_visual_config.dart';
import 'package:flow_editor/core/models/styles/canvas_interaction_config.dart';
import 'package:flow_editor/core/controller/impl/canvas_controller_impl.dart';
import 'package:flow_editor/core/state_management/state_store/editor_state.dart';
import 'package:flow_editor/test/_helpers/fake_canvas_controller.dart';

void main() {
  const wfId = 'wf1';

  late CanvasController controller;
  late CanvasState canvState;
  late NodeState nodeState;
  late EdgeState edgeState;
  late CanvasViewportState viewportState;
  late EditorStateHolder holder;
  late CommandContext ctx;
  late CommandManager mgr;

  setUp(() {
    controller = CanvasController(CommandContext(
      controller: FakeCanvasController(),
      getState: () => EditorState(
        canvases: {wfId: canvState},
        activeWorkflowId: wfId,
        nodes: nodeState,
        edges: edgeState,
        viewport: viewportState,
      ),
      updateState: (st) => {},
    ));

    // 初始各部分状态：有两个节点 n1, n2
    canvState = const CanvasState(
      workflowMode: WorkflowMode.generic,
      interactionMode: CanvasInteractionMode.panCanvas,
      visualConfig: CanvasVisualConfig(),
      interactionConfig: CanvasInteractionConfig(),
    );
    nodeState = NodeState(nodesByWorkflow: {
      wfId: [
        NodeModel(
            id: 'n1', position: const Offset(0, 0), size: const Size(10, 10)),
        NodeModel(
            id: 'n2', position: const Offset(5, 5), size: const Size(20, 20)),
      ]
    });
    edgeState = const EdgeState(edgesByWorkflow: {wfId: []});
    viewportState = const CanvasViewportState();

    // Holder 包装
    holder = EditorStateHolder(
      canvases: {wfId: canvState},
      activeWorkflowId: wfId,
      nodes: nodeState,
      edges: edgeState,
      viewport: viewportState,
    );

    ctx = CommandContext(
      controller: controller,
      getState: () => holder.toEditorState(),
      updateState: (st) => holder.fromEditorState(st),
    );

    mgr = CommandManager(ctx);
  });

  test('execute removes the specified node', () async {
    // 删除 n1
    final cmd = DeleteNodeCommand(ctx, 'n1');
    await mgr.executeCommand(cmd);

    final remaining = holder.nodes.nodesOf(wfId);
    expect(remaining.map((n) => n.id), ['n2']);
    expect(mgr.canUndo, isTrue);
    expect(mgr.canRedo, isFalse);
  });

  test('undo restores the deleted node in original position', () async {
    final cmd = DeleteNodeCommand(ctx, 'n1');
    await mgr.executeCommand(cmd);
    expect(holder.nodes.nodesOf(wfId).map((n) => n.id), ['n2']);

    await mgr.undo();
    final restored = holder.nodes.nodesOf(wfId);
    expect(restored.map((n) => n.id), ['n1', 'n2']);
    expect(restored.first.id, 'n1');
    expect(restored.first.position, const Offset(0, 0));
    expect(mgr.canRedo, isTrue);
    expect(mgr.canUndo, isFalse);
  });

  test('redo re-deletes the node after undo', () async {
    final cmd = DeleteNodeCommand(ctx, 'n1');
    await mgr.executeCommand(cmd);
    await mgr.undo();
    expect(holder.nodes.nodesOf(wfId).map((n) => n.id), ['n1', 'n2']);

    await mgr.redo();
    expect(holder.nodes.nodesOf(wfId).map((n) => n.id), ['n2']);
    expect(mgr.canUndo, isTrue);
    expect(mgr.canRedo, isFalse);
  });

  test('deleting non-existent node does nothing and is undoable', () async {
    final cmd = DeleteNodeCommand(ctx, 'no-such');
    await mgr.executeCommand(cmd);

    // 原始顺序不变
    expect(holder.nodes.nodesOf(wfId).map((n) => n.id), ['n1', 'n2']);
    expect(mgr.canUndo, isTrue);

    // undo 也不改变
    await mgr.undo();
    expect(holder.nodes.nodesOf(wfId).map((n) => n.id), ['n1', 'n2']);
  });
}

/// 与 add_node_command_test.dart 中保持一致的 Holder
class EditorStateHolder {
  Map<String, CanvasState> canvases;
  String activeWorkflowId;
  NodeState nodes;
  EdgeState edges;
  CanvasViewportState viewport;

  EditorStateHolder({
    required this.canvases,
    required this.activeWorkflowId,
    required this.nodes,
    required this.edges,
    required this.viewport,
  });

  EditorState toEditorState() => EditorState(
        canvases: canvases,
        activeWorkflowId: activeWorkflowId,
        nodes: nodes,
        edges: edges,
        viewport: viewport,
      );

  void fromEditorState(EditorState st) {
    canvases = st.canvases;
    activeWorkflowId = st.activeWorkflowId;
    nodes = st.nodes;
    edges = st.edges;
    viewport = st.viewport;
  }
}
