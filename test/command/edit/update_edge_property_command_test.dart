import 'package:flutter_test/flutter_test.dart';
import 'package:flow_editor/core/command/command_manager.dart';
import 'package:flow_editor/core/command/command_context.dart';
import 'package:flow_editor/core/command/edit/update_edge_property_command.dart';
import 'package:flow_editor/core/models/edge_model.dart';
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
  const wf = 'wf';
  late CommandManager mgr;
  late CommandContext ctx;
  late EditorStateHolder holder;

  setUp(() {
    // 初始状态：一个工作流，内含一条边 e1
    final canvases = {
      wf: const CanvasState(
        workflowMode: WorkflowMode.generic,
        interactionMode: CanvasInteractionMode.panCanvas,
        visualConfig: CanvasVisualConfig(),
        interactionConfig: CanvasInteractionConfig(),
      ),
    };
    // 边模型假设有 sourceId, targetId, 及 label 属性
    final edges = [
      EdgeModel(
          id: 'e1', sourceNodeId: 'n1', targetNodeId: 'n2', label: 'oldLabel'),
    ];

    holder = EditorStateHolder(
      canvases: canvases,
      activeWorkflowId: wf,
      nodes: const NodeState(nodesByWorkflow: {wf: []}),
      edges: EdgeState(edgesByWorkflow: {wf: edges}),
      viewport: const CanvasViewportState(),
    );

    ctx = CommandContext(
      getState: () => holder.toEditorState(),
      updateState: (st) => holder.fromEditorState(st),
    );
    mgr = CommandManager(ctx);
  });

  test('execute updates the edge property', () async {
    // 将 e1 的 label 从 'oldLabel' 改为 'newLabel'
    final cmd = UpdateEdgePropertyCommand(
      ctx,
      'e1',
      (e) => e.copyWith(label: 'newLabel'),
    );

    await mgr.executeCommand(cmd);

    final updated = holder.edges.edgesOf(wf);
    expect(updated.length, 1);
    expect(updated.first.label, 'newLabel');
    expect(mgr.canUndo, isTrue);
    expect(mgr.canRedo, isFalse);
  });

  test('undo reverts to the old property', () async {
    final cmd = UpdateEdgePropertyCommand(
      ctx,
      'e1',
      (e) => e.copyWith(label: 'newLabel'),
    );

    await mgr.executeCommand(cmd);
    expect(holder.edges.edgesOf(wf).first.label, 'newLabel');

    await mgr.undo();
    expect(holder.edges.edgesOf(wf).first.label, 'oldLabel');
    expect(mgr.canRedo, isTrue);
  });

  test('redo reapplies the new property', () async {
    final cmd = UpdateEdgePropertyCommand(
      ctx,
      'e1',
      (e) => e.copyWith(label: 'newLabel'),
    );

    await mgr.executeCommand(cmd);
    await mgr.undo();
    await mgr.redo();
    expect(holder.edges.edgesOf(wf).first.label, 'newLabel');
    expect(mgr.canUndo, isTrue);
    expect(mgr.canRedo, isFalse);
  });

  test('throws if edge not found', () async {
    final bad = UpdateEdgePropertyCommand(
      ctx,
      'nonexistent',
      (e) => e.copyWith(label: 'x'),
    );
    await expectLater(mgr.executeCommand(bad), throwsException);
    expect(mgr.canUndo, isFalse);
  });
}

/// 辅助 holder，用来在 test 中保存并更新 EditorState
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
