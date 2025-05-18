import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flow_editor/core/command/command_manager.dart';
import 'package:flow_editor/core/command/command_context.dart';
import 'package:flow_editor/core/command/edit/group_nodes_command.dart';
import 'package:flow_editor/core/models/node_model.dart';
import 'package:flow_editor/core/models/state/selection_state.dart';
import 'package:flow_editor/core/models/state/node_state.dart';
import 'package:flow_editor/core/models/state/edge_state.dart';
import 'package:flow_editor/core/models/state/canvas_state.dart';
import 'package:flow_editor/core/models/state/canvas_viewport_state.dart';
import 'package:flow_editor/core/logic/strategy/workflow_mode.dart';
import 'package:flow_editor/core/models/enums/canvas_interaction_mode.dart';
import 'package:flow_editor/core/models/styles/canvas_visual_config.dart';
import 'package:flow_editor/core/models/styles/canvas_interaction_config.dart';
import 'package:flow_editor/core/state_management/state_store/editor_state.dart';
import 'package:flow_editor/core/controller/impl/canvas_controller_impl.dart';
import 'package:flow_editor/test/_helpers/fake_canvas_controller.dart';

void main() {
  const wf = 'w1';
  late CommandManager mgr;
  late CommandContext ctx;
  late EditorStateHolder holder;

  setUp(() {
    // 初始一个空画布和两个节点
    final canvases = {
      wf: const CanvasState(
        workflowMode: WorkflowMode.generic,
        interactionMode: CanvasInteractionMode.panCanvas,
        visualConfig: CanvasVisualConfig(),
        interactionConfig: CanvasInteractionConfig(),
      )
    };
    final nodes = [
      NodeModel(
          id: 'n1', position: const Offset(0, 0), size: const Size(10, 10)),
      NodeModel(
          id: 'n2', position: const Offset(20, 5), size: const Size(5, 5)),
    ];

    holder = EditorStateHolder(
      canvases: canvases,
      activeWorkflowId: wf,
      nodes: NodeState(nodesByWorkflow: {wf: nodes}),
      edges: const EdgeState(edgesByWorkflow: {wf: []}),
      viewport: const CanvasViewportState(),
      selection: const SelectionState(nodeIds: {'n1', 'n2'}),
    );

    ctx = CommandContext(
      controller: CanvasController(CommandContext(
        controller: FakeCanvasController(),
        getState: () => holder.toEditorState(),
        updateState: (st) => holder.fromEditorState(st),
      )),
      getState: () => holder.toEditorState(),
      updateState: (st) => holder.fromEditorState(st),
    );

    mgr = CommandManager(ctx);
  });

  test('group then undo/redo works', () async {
    // 分组
    final cmd = GroupNodesCommand(ctx, ['n1', 'n2']);
    await mgr.executeCommand(cmd);

    // 执行后——只有一个组节点 + 两个子节点
    final all = holder.nodes.nodesOf(holder.activeWorkflowId);
    expect(all.length, 3);
    final group = all.firstWhere((n) => n.isGroupRoot);
    expect(group.position, const Offset(0, 0));
    expect(group.size, const Size(25, 10)); // 包含两个原节点
    expect(holder.selection.nodeIds, {group.id});
    // 子节点 parentId 都被更新
    expect(all.where((n) => n.id == 'n1').single.parentId, group.id);
    expect(all.where((n) => n.id == 'n2').single.parentId, group.id);

    // undo
    await mgr.undo();
    final afterUndo = holder.nodes.nodesOf(holder.activeWorkflowId);
    expect(afterUndo.map((n) => n.id), ['n1', 'n2']);
    expect(holder.selection.nodeIds, {'n1', 'n2'});

    // redo
    await mgr.redo();
    final afterRedo = holder.nodes.nodesOf(holder.activeWorkflowId);
    expect(afterRedo.length, 3);
    expect(holder.selection.nodeIds.length, 1);
  });
}

/// 一个简单的 holder 用来包裹 EditorState
class EditorStateHolder {
  Map<String, CanvasState> canvases;
  String activeWorkflowId;
  NodeState nodes;
  EdgeState edges;
  CanvasViewportState viewport;
  SelectionState selection;

  EditorStateHolder({
    required this.canvases,
    required this.activeWorkflowId,
    required this.nodes,
    required this.edges,
    required this.viewport,
    required this.selection,
  });

  EditorState toEditorState() => EditorState(
        canvases: canvases,
        activeWorkflowId: activeWorkflowId,
        nodes: nodes,
        edges: edges,
        viewport: viewport,
        selection: selection,
      );

  void fromEditorState(EditorState st) {
    canvases = st.canvases;
    activeWorkflowId = st.activeWorkflowId;
    nodes = st.nodes;
    edges = st.edges;
    viewport = st.viewport;
    selection = st.selection;
  }
}
