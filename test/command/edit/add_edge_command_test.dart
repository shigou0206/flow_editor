// test/command/edit/add_edge_command_test.dart

import 'package:flutter_test/flutter_test.dart';
import 'package:flow_editor/core/command/command_manager.dart';
import 'package:flow_editor/core/command/command_context.dart';
import 'package:flow_editor/core/command/edit/add_edge_command.dart';
import 'package:flow_editor/core/models/edge_model.dart';
import 'package:flow_editor/core/models/state/canvas_state.dart';
import 'package:flow_editor/core/models/state/node_state.dart';
import 'package:flow_editor/core/models/state/edge_state.dart';
import 'package:flow_editor/core/models/state/canvas_viewport_state.dart';
import 'package:flow_editor/core/logic/strategy/workflow_mode.dart';
import 'package:flow_editor/core/models/enums/canvas_interaction_mode.dart';
import 'package:flow_editor/core/models/styles/canvas_visual_config.dart';
import 'package:flow_editor/core/models/styles/canvas_interaction_config.dart';
import 'package:flow_editor/core/state_management/state_store/editor_state.dart';
import 'package:flow_editor/test/_helpers/fake_canvas_controller.dart';

void main() {
  const wfId = 'wf1';

  late CanvasState canvState;
  late NodeState nodeState;
  late EdgeState edgeState;
  late CanvasViewportState viewportState;
  late _Holder holder;
  late CommandContext ctx;
  late CommandManager mgr;

  setUp(() {
    canvState = const CanvasState(
      workflowMode: WorkflowMode.generic,
      interactionMode: CanvasInteractionMode.panCanvas,
      visualConfig: CanvasVisualConfig(),
      interactionConfig: CanvasInteractionConfig(),
    );
    nodeState = const NodeState(nodesByWorkflow: {wfId: []});
    edgeState = const EdgeState(edgesByWorkflow: {wfId: []});
    viewportState = const CanvasViewportState();

    holder = _Holder(
      canvases: {wfId: canvState},
      activeWorkflowId: wfId,
      nodes: nodeState,
      edges: edgeState,
      viewport: viewportState,
    );

    // 这里我们传入 FakeController
    ctx = CommandContext(
      controller: FakeCanvasController(),
      getState: () => holder.toEditorState(),
      updateState: (st) => holder.fromEditorState(st),
    );
    mgr = CommandManager(ctx);
  });

  test('execute adds edge to active workflow', () async {
    final edge = EdgeModel(
      id: 'e1',
      sourceNodeId: 'n1',
      targetNodeId: 'n2',
      edgeType: 'default',
      waypoints: [],
    );
    await mgr.executeCommand(AddEdgeCommand(ctx, edge));
    expect(holder.edges.edgesOf(wfId), [edge]);
    expect(mgr.canUndo, isTrue);
    expect(mgr.canRedo, isFalse);
  });

  test('undo removes the previously added edge', () async {
    final edge = EdgeModel(
      id: 'e1',
      sourceNodeId: 'n1',
      targetNodeId: 'n2',
      edgeType: 'default',
      waypoints: [],
    );
    await mgr.executeCommand(AddEdgeCommand(ctx, edge));
    await mgr.undo();
    expect(holder.edges.edgesOf(wfId), isEmpty);
    expect(mgr.canUndo, isFalse);
    expect(mgr.canRedo, isTrue);
  });

  test('redo re-adds the edge after undo', () async {
    final edge = EdgeModel(
      id: 'e1',
      sourceNodeId: 'n1',
      targetNodeId: 'n2',
      edgeType: 'default',
      waypoints: [],
    );
    await mgr.executeCommand(AddEdgeCommand(ctx, edge));
    await mgr.undo();
    await mgr.redo();
    expect(holder.edges.edgesOf(wfId).map((e) => e.id), ['e1']);
    expect(mgr.canUndo, isTrue);
    expect(mgr.canRedo, isFalse);
  });
}

/// Holder 用于在测试中把 EditorState ↔ 各个子状态互转
class _Holder {
  Map<String, CanvasState> canvases;
  String activeWorkflowId;
  NodeState nodes;
  EdgeState edges;
  CanvasViewportState viewport;

  _Holder({
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
