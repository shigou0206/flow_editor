// test/command/edit/add_node_command_test.dart

import 'dart:ui';

import 'package:flutter_test/flutter_test.dart';
import 'package:flow_editor/core/command/command_manager.dart';
import 'package:flow_editor/core/command/command_context.dart';
import 'package:flow_editor/core/command/edit/add_node_command.dart';
import 'package:flow_editor/core/models/node_model.dart';
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

  late CanvasController controller;
  late CanvasState canvState;
  late NodeState nodeState;
  late EdgeState edgeState;
  late CanvasViewportState viewportState;
  late EditorStateHolder holder;
  late CommandContext ctx;
  late CommandManager mgr;

  setUp(() {
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

    // 初始各部分状态
    canvState = const CanvasState(
      workflowMode: WorkflowMode.generic,
      interactionMode: CanvasInteractionMode.panCanvas,
      visualConfig: CanvasVisualConfig(),
      interactionConfig: CanvasInteractionConfig(),
    );
    nodeState = const NodeState(nodesByWorkflow: {wfId: []});
    edgeState = const EdgeState(edgesByWorkflow: {wfId: []});
    viewportState = const CanvasViewportState();

    // 将它们包装到一个简单 holder，方便 getState/updateState
    holder = EditorStateHolder(
      canvases: {wfId: canvState},
      activeWorkflowId: wfId,
      nodes: nodeState,
      edges: edgeState,
      viewport: viewportState,
    );

    ctx = CommandContext(
      controller: controller,
      // 这里的 getState/updateState 只关心节点部分
      getState: () => holder.toEditorState(),
      updateState: (newState) => holder.fromEditorState(newState),
    );

    mgr = CommandManager(ctx);
  });

  test('execute adds node to active workflow', () async {
    final node = NodeModel(
      id: 'n1',
      position: const Offset(5, 5),
      size: const Size(10, 10),
    );
    final cmd = AddNodeCommand(ctx, node);

    await mgr.executeCommand(cmd);

    final nodes = holder.nodes.nodesOf(wfId);
    expect(nodes, [node]);
    expect(mgr.canUndo, isTrue);
    expect(mgr.canRedo, isFalse);
  });

  test('undo removes the previously added node', () async {
    final node = NodeModel(
      id: 'n1',
      position: const Offset(5, 5),
      size: const Size(10, 10),
    );
    final cmd = AddNodeCommand(ctx, node);

    await mgr.executeCommand(cmd);
    expect(holder.nodes.nodesOf(wfId), [node]);

    await mgr.undo();
    expect(holder.nodes.nodesOf(wfId), isEmpty);
    expect(mgr.canUndo, isFalse);
    expect(mgr.canRedo, isTrue);
  });

  test('redo re-adds the node after undo', () async {
    final node = NodeModel(
      id: 'n1',
      position: const Offset(5, 5),
      size: const Size(10, 10),
    );
    final cmd = AddNodeCommand(ctx, node);

    await mgr.executeCommand(cmd);
    await mgr.undo();
    expect(holder.nodes.nodesOf(wfId), isEmpty);

    await mgr.redo();
    expect(holder.nodes.nodesOf(wfId), [node]);
    expect(mgr.canUndo, isTrue);
    expect(mgr.canRedo, isFalse);
  });
}

/// 为了简单测试，把 EditorState 的几个字段拆成独立变量，并提供
/// toEditorState/fromEditorState 方法，以兼容 CommandContext 的接口。
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

  /// 构造真实的 EditorState
  EditorState toEditorState() {
    return EditorState(
      canvases: canvases,
      activeWorkflowId: activeWorkflowId,
      nodes: nodes,
      edges: edges,
      viewport: viewport,
    );
  }

  /// 从新的 EditorState 更新到 Holder
  void fromEditorState(EditorState st) {
    canvases = st.canvases;
    activeWorkflowId = st.activeWorkflowId;
    nodes = st.nodes;
    edges = st.edges;
    viewport = st.viewport;
  }
}
