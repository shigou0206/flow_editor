import 'package:flutter_test/flutter_test.dart';
import 'package:flow_editor/core/command/command_manager.dart';
import 'package:flow_editor/core/command/command_context.dart';
import 'package:flow_editor/core/command/edit/delete_edge_command.dart';
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
    // 预先准备两条边 e1, e2
    final e1 = EdgeModel(
      id: 'e1',
      sourceNodeId: 'n1',
      targetNodeId: 'n2',
      edgeType: 't',
      waypoints: [],
    );
    final e2 = EdgeModel(
      id: 'e2',
      sourceNodeId: 'n2',
      targetNodeId: 'n3',
      edgeType: 't',
      waypoints: [],
    );
    edgeState = EdgeState(edgesByWorkflow: {
      wfId: [e1, e2]
    });
    viewportState = const CanvasViewportState();

    holder = _Holder(
      canvases: {wfId: canvState},
      activeWorkflowId: wfId,
      nodes: nodeState,
      edges: edgeState,
      viewport: viewportState,
    );

    ctx = CommandContext(
      getState: () => holder.toEditorState(),
      updateState: (st) => holder.fromEditorState(st),
    );

    mgr = CommandManager(ctx);
  });

  test('execute removes the specified edge', () async {
    final cmd = DeleteEdgeCommand(ctx, 'e1');
    await mgr.executeCommand(cmd);

    final ids = holder.edges.edgesOf(wfId).map((e) => e.id).toList();
    expect(ids, ['e2']);
    expect(mgr.canUndo, isTrue);
    expect(mgr.canRedo, isFalse);
  });

  test('undo restores the removed edge at original position', () async {
    final cmd = DeleteEdgeCommand(ctx, 'e1');
    await mgr.executeCommand(cmd);
    expect(holder.edges.edgesOf(wfId).map((e) => e.id).toList(), ['e2']);

    await mgr.undo();
    expect(holder.edges.edgesOf(wfId).map((e) => e.id).toList(), ['e1', 'e2']);
    expect(mgr.canUndo, isFalse);
    expect(mgr.canRedo, isTrue);
  });

  test('redo re-deletes the edge after undo', () async {
    final cmd = DeleteEdgeCommand(ctx, 'e1');
    await mgr.executeCommand(cmd);
    await mgr.undo();
    expect(holder.edges.edgesOf(wfId).map((e) => e.id).toList(), ['e1', 'e2']);

    await mgr.redo();
    expect(holder.edges.edgesOf(wfId).map((e) => e.id).toList(), ['e2']);
    expect(mgr.canUndo, isTrue);
    expect(mgr.canRedo, isFalse);
  });

  test('execute with non-existent id throws', () async {
    final cmd = DeleteEdgeCommand(ctx, 'not_exist');
    await expectLater(mgr.executeCommand(cmd), throwsException);
    // 失败时不加入历史
    expect(mgr.canUndo, isFalse);
    expect(mgr.canRedo, isFalse);
  });
}

/// 简易 Holder，用于 Adapter EditorState ⇄ 独立字段
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
