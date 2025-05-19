import 'dart:ui';

import 'package:flutter_test/flutter_test.dart';
import 'package:flow_editor/core/command/command_manager.dart';
import 'package:flow_editor/core/command/command_context.dart';
import 'package:flow_editor/core/command/edit/update_node_property_command.dart';
import 'package:flow_editor/core/models/node_model.dart';
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
    // 初始状态：一个工作流，内含一个节点 n1
    final canvases = {
      wf: const CanvasState(
        workflowMode: WorkflowMode.generic,
        interactionMode: CanvasInteractionMode.panCanvas,
        visualConfig: CanvasVisualConfig(),
        interactionConfig: CanvasInteractionConfig(),
      ),
    };
    final nodes = [
      NodeModel(
        id: 'n1',
        position: const Offset(0, 0),
        size: const Size(10, 10),
        title: 'old',
      ),
    ];

    holder = EditorStateHolder(
      canvases: canvases,
      activeWorkflowId: wf,
      nodes: NodeState(nodesByWorkflow: {wf: nodes}),
      edges: const EdgeState(edgesByWorkflow: {wf: []}),
      viewport: const CanvasViewportState(),
    );

    ctx = CommandContext(
      getState: () => holder.toEditorState(),
      updateState: (st) => holder.fromEditorState(st),
    );
    mgr = CommandManager(ctx);
  });

  test('execute updates the node property', () async {
    // 将 n1 的 title 从 'old' 改为 'new'
    final cmd = UpdateNodePropertyCommand(
      ctx,
      'n1',
      (n) => n.copyWith(title: 'new'),
    );

    await mgr.executeCommand(cmd);

    final updated = holder.nodes.nodesOf(wf);
    expect(updated.length, 1);
    expect(updated.first.title, 'new');
    expect(mgr.canUndo, isTrue);
    expect(mgr.canRedo, isFalse);
  });

  test('undo reverts to the old property', () async {
    final cmd = UpdateNodePropertyCommand(
      ctx,
      'n1',
      (n) => n.copyWith(title: 'new'),
    );

    await mgr.executeCommand(cmd);
    expect(holder.nodes.nodesOf(wf).first.title, 'new');

    await mgr.undo();
    expect(holder.nodes.nodesOf(wf).first.title, 'old');
    expect(mgr.canRedo, isTrue);
  });

  test('redo reapplies the new property', () async {
    final cmd = UpdateNodePropertyCommand(
      ctx,
      'n1',
      (n) => n.copyWith(title: 'new'),
    );

    await mgr.executeCommand(cmd);
    await mgr.undo();
    await mgr.redo();
    expect(holder.nodes.nodesOf(wf).first.title, 'new');
    expect(mgr.canUndo, isTrue);
    expect(mgr.canRedo, isFalse);
  });

  test('throws if node not found', () async {
    final bad = UpdateNodePropertyCommand(
      ctx,
      'nonexistent',
      (n) => n.copyWith(title: 'x'),
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
