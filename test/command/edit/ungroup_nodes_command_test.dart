import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flow_editor/core/command/command_manager.dart';
import 'package:flow_editor/core/command/command_context.dart';
import 'package:flow_editor/core/command/edit/ungroup_nodes_command.dart';
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

void main() {
  const wf = 'w1';
  late CommandManager mgr;
  late CommandContext ctx;
  late EditorStateHolder holder;

  setUp(() {
    // 初始画布
    final canvases = {
      wf: const CanvasState(
        workflowMode: WorkflowMode.generic,
        interactionMode: CanvasInteractionMode.panCanvas,
        visualConfig: CanvasVisualConfig(),
        interactionConfig: CanvasInteractionConfig(),
      )
    };

    // 一个分组根和两个子节点
    final group = NodeModel(
      id: 'g1',
      position: const Offset(0, 0),
      size: const Size(30, 10),
      isGroup: true,
      isGroupRoot: true,
    );
    final child1 = NodeModel(
      id: 'n1',
      position: const Offset(0, 0),
      size: const Size(10, 10),
      parentId: 'g1',
    );
    final child2 = NodeModel(
      id: 'n2',
      position: const Offset(10, 0),
      size: const Size(10, 10),
      parentId: 'g1',
    );

    holder = EditorStateHolder(
      canvases: canvases,
      activeWorkflowId: wf,
      nodes: NodeState(nodesByWorkflow: {
        wf: [group, child1, child2]
      }),
      edges: const EdgeState(edgesByWorkflow: {wf: []}),
      viewport: const CanvasViewportState(),
      selection: const SelectionState(nodeIds: {'g1'}),
    );

    ctx = CommandContext(
      getState: () => holder.toEditorState(),
      updateState: (st) => holder.fromEditorState(st),
    );

    mgr = CommandManager(ctx);
  });

  test('execute ungroups and selects children', () async {
    final cmd = UngroupNodesCommand(ctx, 'g1');
    await mgr.executeCommand(cmd);

    final nodes = holder.nodes.nodesOf(wf);
    // 根节点被移除，只剩两个 child
    expect(nodes.map((n) => n.id), ['n1', 'n2']);
    // 选区变成子节点集合
    expect(holder.selection.nodeIds, {'n1', 'n2'});
  });

  test('undo restores group and selection', () async {
    final cmd = UngroupNodesCommand(ctx, 'g1');
    await mgr.executeCommand(cmd);

    await mgr.undo();
    final nodes = holder.nodes.nodesOf(wf);
    expect(nodes.map((n) => n.id), ['g1', 'n1', 'n2']);
    expect(holder.selection.nodeIds, {'g1'});
  });

  test('redo re-applies ungroup', () async {
    final cmd = UngroupNodesCommand(ctx, 'g1');
    await mgr.executeCommand(cmd);
    await mgr.undo();

    await mgr.redo();
    final nodes = holder.nodes.nodesOf(wf);
    expect(nodes.map((n) => n.id), ['n1', 'n2']);
    expect(holder.selection.nodeIds, {'n1', 'n2'});
  });
}

/// 简单的 Holder，用来转换 EditorState
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
