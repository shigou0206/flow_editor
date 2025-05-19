// test/command/edit/delete_node_with_edges_command_test.dart

import 'dart:ui'; // Offset、Size
import 'package:flutter_test/flutter_test.dart';
import 'package:flow_editor/core/command/command_context.dart';
import 'package:flow_editor/core/command/command_manager.dart';
import 'package:flow_editor/core/command/edit/delete_node_with_edges_command.dart';
import 'package:flow_editor/core/models/node_model.dart';
import 'package:flow_editor/core/models/edge_model.dart';
import 'package:flow_editor/core/models/state/canvas_state.dart';
import 'package:flow_editor/core/models/state/node_state.dart';
import 'package:flow_editor/core/models/state/edge_state.dart';
import 'package:flow_editor/core/models/state/canvas_viewport_state.dart';
import 'package:flow_editor/core/state_management/state_store/editor_state.dart';

void main() {
  const wf = 'wf';
  late EditorStateHolder holder;
  late CommandContext ctx;
  late CommandManager mgr;

  setUp(() {
    // 构造：1 个节点 n，3 条边 e1,e2,e3，
    // 其中 e1/e2 与节点 n 相连，e3 与它无关
    holder = EditorStateHolder(
      canvases: {wf: const CanvasState()},
      activeWorkflowId: wf,
      nodes: NodeState(nodesByWorkflow: {
        wf: [NodeModel(id: 'n', position: Offset.zero, size: Size.zero)]
      }),
      edges: EdgeState(edgesByWorkflow: {
        wf: [
          EdgeModel(id: 'e1', sourceNodeId: 'n', targetNodeId: 'x'),
          EdgeModel(id: 'e2', sourceNodeId: 'y', targetNodeId: 'n'),
          EdgeModel(id: 'e3', sourceNodeId: 'a', targetNodeId: 'b'),
        ]
      }),
      viewport: const CanvasViewportState(),
    );

    ctx = CommandContext(
      getState: () => holder.toEditorState(),
      updateState: (st) => holder.fromEditorState(st),
    );
    mgr = CommandManager(ctx);
  });

  test('delete node with edges, then undo/redo', () async {
    final cmd = DeleteNodeWithEdgesCommand(ctx, 'n');
    await mgr.executeCommand(cmd);

    // 执行后：节点 n 被删，e1/e2 被删，e3 保留
    expect(holder.nodes.nodesOf(wf), isEmpty);
    expect(holder.edges.edgesOf(wf).map((e) => e.id), ['e3']);

    // undo：恢复原状
    await mgr.undo();
    expect(holder.nodes.nodesOf(wf).map((n) => n.id), ['n']);
    expect(
        holder.edges.edgesOf(wf).map((e) => e.id).toSet(), {'e1', 'e2', 'e3'});

    // redo：又删回去
    await mgr.redo();
    expect(holder.nodes.nodesOf(wf), isEmpty);
    expect(holder.edges.edgesOf(wf).map((e) => e.id), ['e3']);
  });
}

/// 用来在测试中包装 EditorState 的简单 Holder
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

  /// 转为真正的 EditorState
  EditorState toEditorState() {
    // 这里请根据你的项目实际 EditorState 所在包名调整以下导入
    return EditorState(
      canvases: canvases,
      activeWorkflowId: activeWorkflowId,
      nodes: nodes,
      edges: edges,
      viewport: viewport,
    );
  }

  /// 从 EditorState 更新回 Holder
  void fromEditorState(EditorState st) {
    canvases = st.canvases;
    activeWorkflowId = st.activeWorkflowId;
    nodes = st.nodes;
    edges = st.edges;
    viewport = st.viewport;
  }
}
