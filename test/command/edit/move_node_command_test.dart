import 'dart:ui';

import 'package:flutter_test/flutter_test.dart';
import 'package:flow_editor/core/command/command_manager.dart';
import 'package:flow_editor/core/command/command_context.dart';
import 'package:flow_editor/core/command/edit/move_node_command.dart';
import 'package:flow_editor/core/models/node_model.dart';
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

    // 两个初始节点
    final n1 = NodeModel(
        id: 'n1', position: const Offset(0, 0), size: const Size(10, 10));
    final n2 = NodeModel(
        id: 'n2', position: const Offset(5, 5), size: const Size(20, 20));
    nodeState = NodeState(nodesByWorkflow: {
      wfId: [n1, n2]
    });

    edgeState = const EdgeState(edgesByWorkflow: {wfId: []});
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

  test('execute moves the node by given delta', () async {
    final cmd = MoveNodeCommand(ctx, 'n1', const Offset(3, 4));
    await mgr.executeCommand(cmd);

    final moved = holder.nodes.nodesOf(wfId).firstWhere((n) => n.id == 'n1');
    expect(moved.position, const Offset(3, 4));
    expect(mgr.canUndo, isTrue);
    expect(mgr.canRedo, isFalse);
  });

  test('undo restores original position', () async {
    final cmd = MoveNodeCommand(ctx, 'n2', const Offset(-2, 10));
    await mgr.executeCommand(cmd);
    expect(holder.nodes.nodesOf(wfId).firstWhere((n) => n.id == 'n2').position,
        const Offset(3, 15));

    await mgr.undo();
    expect(holder.nodes.nodesOf(wfId).firstWhere((n) => n.id == 'n2').position,
        const Offset(5, 5));
    expect(mgr.canUndo, isFalse);
    expect(mgr.canRedo, isTrue);
  });

  test('redo reapplies the move after undo', () async {
    final cmd = MoveNodeCommand(ctx, 'n1', const Offset(7, 1));
    await mgr.executeCommand(cmd);
    await mgr.undo();
    expect(holder.nodes.nodesOf(wfId).firstWhere((n) => n.id == 'n1').position,
        const Offset(0, 0));

    await mgr.redo();
    expect(holder.nodes.nodesOf(wfId).firstWhere((n) => n.id == 'n1').position,
        const Offset(7, 1));
    expect(mgr.canUndo, isTrue);
    expect(mgr.canRedo, isFalse);
  });

  test('execute with non-existent id throws', () async {
    final cmd = MoveNodeCommand(ctx, 'not_exist', const Offset(1, 1));
    await expectLater(mgr.executeCommand(cmd), throwsException);
    expect(mgr.canUndo, isFalse);
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
