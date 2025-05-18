import 'dart:ui';

import 'package:flutter_test/flutter_test.dart';
import 'package:flow_editor/core/command/command_manager.dart';
import 'package:flow_editor/core/command/command_context.dart';
import 'package:flow_editor/core/command/edit/move_edge_command.dart';
import 'package:flow_editor/core/models/edge_model.dart';
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
  const edgeId = 'e1';

  late CanvasController controller;
  late CanvasState canvState;
  late NodeState nodeState;
  late EdgeState edgeState;
  late CanvasViewportState viewportState;
  late EditorStateHolder holder;
  late CommandContext ctx;
  late CommandManager mgr;

  setUp(() {
    // Initialize canvState first
    canvState = const CanvasState(
      workflowMode: WorkflowMode.generic,
      interactionMode: CanvasInteractionMode.panCanvas,
      visualConfig: CanvasVisualConfig(),
      interactionConfig: CanvasInteractionConfig(),
    );

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

    nodeState = const NodeState(nodesByWorkflow: {wfId: []});

    // 初始只有一条简单折线：两个点 (0,0) -> (10, 0)
    final edge = EdgeModel(
      id: edgeId,
      edgeType: 'default',
      waypoints: [Offset.zero, const Offset(10, 0)],
      sourceNodeId: 'n1',
      targetNodeId: 'n2',
    );
    edgeState = EdgeState(edgesByWorkflow: {
      wfId: [edge]
    });
    viewportState = const CanvasViewportState();

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
      updateState: (newState) => holder.fromEditorState(newState),
    );
    mgr = CommandManager(ctx);
  });

  test('execute moves all waypoints by delta', () async {
    final cmd = MoveEdgeCommand(ctx, edgeId, const Offset(5, 5));
    await mgr.executeCommand(cmd);

    final moved = holder.edges.edgesOf(wfId).single;
    expect(moved.waypoints, [const Offset(5, 5), const Offset(15, 5)]);
    expect(mgr.canUndo, isTrue);
    expect(mgr.canRedo, isFalse);
  });

  test('undo restores original waypoints', () async {
    final cmd = MoveEdgeCommand(ctx, edgeId, const Offset(5, 5));
    await mgr.executeCommand(cmd);

    await mgr.undo();
    final restored = holder.edges.edgesOf(wfId).single;
    expect(restored.waypoints, [Offset.zero, const Offset(10, 0)]);
    expect(mgr.canUndo, isFalse);
    expect(mgr.canRedo, isTrue);
  });

  test('redo reapplies the move', () async {
    final cmd = MoveEdgeCommand(ctx, edgeId, const Offset(5, 5));
    await mgr.executeCommand(cmd);
    await mgr.undo();

    await mgr.redo();
    final movedAgain = holder.edges.edgesOf(wfId).single;
    expect(movedAgain.waypoints, [const Offset(5, 5), const Offset(15, 5)]);
    expect(mgr.canUndo, isTrue);
    expect(mgr.canRedo, isFalse);
  });

  test('execute on nonexistent edge throws and does not push', () async {
    final bad = MoveEdgeCommand(ctx, 'no_such', const Offset(1, 1));
    await expectLater(mgr.executeCommand(bad), throwsException);
    expect(mgr.canUndo, isFalse);
    expect(mgr.canRedo, isFalse);
  });
}

/// 简易 Holder，把 EditorState 拆开存储并提供转换方法
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
