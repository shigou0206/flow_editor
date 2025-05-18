import 'dart:ui';
import 'package:flutter_test/flutter_test.dart';
import 'package:flow_editor/core/command/command_context.dart';
import 'package:flow_editor/core/command/command_manager.dart';
import 'package:flow_editor/core/command/edit/insert_node_on_edge_command.dart';
import 'package:flow_editor/core/models/node_model.dart';
import 'package:flow_editor/core/models/edge_model.dart';
import 'package:flow_editor/core/models/state/canvas_state.dart';
import 'package:flow_editor/core/models/state/node_state.dart';
import 'package:flow_editor/core/models/state/edge_state.dart';
import 'package:flow_editor/core/models/state/canvas_viewport_state.dart';
import 'package:flow_editor/core/controller/impl/canvas_controller_impl.dart';
import 'package:flow_editor/core/state_management/state_store/editor_state.dart';
import 'package:flow_editor/test/_helpers/fake_canvas_controller.dart';

void main() {
  const wf = 'w1';
  late EditorStateHolder holder;
  late CommandContext ctx;
  late CommandManager mgr;

  setUp(() {
    // 初始：两个节点 n1->n2 通过 e0 相连
    final nodes = [
      NodeModel(id: 'n1', position: Offset.zero, size: const Size(10, 10)),
      NodeModel(
          id: 'n2', position: const Offset(20, 0), size: const Size(10, 10)),
    ];
    final edges = [
      EdgeModel(id: 'e0', sourceNodeId: 'n1', targetNodeId: 'n2'),
    ];

    holder = EditorStateHolder(
      canvases: {wf: const CanvasState()},
      activeWorkflowId: wf,
      nodes: NodeState(nodesByWorkflow: {wf: nodes}),
      edges: EdgeState(edgesByWorkflow: {wf: edges}),
      viewport: const CanvasViewportState(),
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

  test('insert node on edge, then undo/redo', () async {
    final newNode = NodeModel(
      id: 'nx',
      position: const Offset(10, 0),
      size: const Size(5, 5),
    );

    final cmd = InsertNodeOnEdgeCommand(
      ctx: ctx,
      edgeId: 'e0',
      node: newNode,
      newEdge1Id: 'e1',
      newEdge2Id: 'e2',
    );

    // 执行
    await mgr.executeCommand(cmd);
    final after = holder.nodes.nodesOf(wf);
    expect(after.map((n) => n.id), ['n1', 'n2', 'nx']);
    final afterEdges = holder.edges.edgesOf(wf);
    expect(afterEdges.map((e) => e.id).toSet(), {'e1', 'e2'});
    // 验证拓扑
    expect(afterEdges.firstWhere((e) => e.id == 'e1').sourceNodeId, 'n1');
    expect(afterEdges.firstWhere((e) => e.id == 'e1').targetNodeId, 'nx');
    expect(afterEdges.firstWhere((e) => e.id == 'e2').sourceNodeId, 'nx');
    expect(afterEdges.firstWhere((e) => e.id == 'e2').targetNodeId, 'n2');

    // undo
    await mgr.undo();
    expect(holder.nodes.nodesOf(wf).map((n) => n.id), ['n1', 'n2']);
    expect(holder.edges.edgesOf(wf).map((e) => e.id), ['e0']);

    // redo
    await mgr.redo();
    expect(holder.nodes.nodesOf(wf).map((n) => n.id), ['n1', 'n2', 'nx']);
    expect(holder.edges.edgesOf(wf).map((e) => e.id).toSet(), {'e1', 'e2'});
  });
}

/// 简易 Holder，将各部分拆开存，并提供 toEditorState()/fromEditorState()
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

  EditorState toEditorState() {
    return EditorState(
      canvases: canvases,
      activeWorkflowId: activeWorkflowId,
      nodes: nodes,
      edges: edges,
      viewport: viewport,
    );
  }

  void fromEditorState(EditorState st) {
    canvases = st.canvases;
    activeWorkflowId = st.activeWorkflowId;
    nodes = st.nodes;
    edges = st.edges;
    viewport = st.viewport;
  }
}
