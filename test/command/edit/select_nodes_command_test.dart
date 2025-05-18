// test/command/edit/select_nodes_command_test.dart

import 'package:flutter_test/flutter_test.dart';
import 'package:flow_editor/core/command/command_manager.dart';
import 'package:flow_editor/core/command/command_context.dart';
import 'package:flow_editor/core/command/edit/select_nodes_command.dart';
import 'package:flow_editor/core/models/state/canvas_state.dart';
import 'package:flow_editor/core/models/state/node_state.dart';
import 'package:flow_editor/core/models/state/edge_state.dart';
import 'package:flow_editor/core/models/state/selection_state.dart';
import 'package:flow_editor/core/models/state/canvas_viewport_state.dart';
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

    canvState = const CanvasState();
    nodeState = const NodeState(nodesByWorkflow: {wfId: []});
    edgeState = const EdgeState(edgesByWorkflow: {wfId: []});
    viewportState = const CanvasViewportState();

    holder = EditorStateHolder(
      canvases: {wfId: canvState},
      activeWorkflowId: wfId,
      nodes: nodeState,
      edges: edgeState,
      viewport: viewportState,
      selection: const SelectionState(),
    );

    ctx = CommandContext(
      controller: controller,
      getState: () => holder.toEditorState(),
      updateState: (st) => holder.fromEditorState(st),
    );

    mgr = CommandManager(ctx);
  });

  test('execute selects the given node IDs', () async {
    // ⚠️ 这里传入 Set<String> 替代 List<String>
    final cmd = SelectNodesCommand(ctx, {'n1', 'n3'});

    await mgr.executeCommand(cmd);

    expect(holder.selection.nodeIds, equals({'n1', 'n3'}));
    expect(holder.selection.edgeIds, isEmpty);
    expect(mgr.canUndo, isTrue);
    expect(mgr.canRedo, isFalse);
  });

  test('undo restores previous selection', () async {
    // 初次选中 n2
    await mgr.executeCommand(SelectNodesCommand(ctx, {'n2'}));
    expect(holder.selection.nodeIds, equals({'n2'}));

    // 再选中 n1, n3
    await mgr.executeCommand(SelectNodesCommand(ctx, {'n1', 'n3'}));
    expect(holder.selection.nodeIds, equals({'n1', 'n3'}));

    // undo 回到 {'n2'}
    await mgr.undo();
    expect(holder.selection.nodeIds, equals({'n2'}));
    expect(mgr.canRedo, isTrue);
    expect(mgr.canUndo, isTrue);
  });

  test('redo re-applies a selection after undo', () async {
    final select1 = SelectNodesCommand(ctx, {'n1'});
    final select2 = SelectNodesCommand(ctx, {'n2'});

    await mgr.executeCommand(select1);
    await mgr.executeCommand(select2);
    expect(holder.selection.nodeIds, equals({'n2'}));

    await mgr.undo();
    expect(holder.selection.nodeIds, equals({'n1'}));

    await mgr.redo();
    expect(holder.selection.nodeIds, equals({'n2'}));
  });

  test('selecting empty set clears selection', () async {
    // 初次选中 n1, n2
    await mgr.executeCommand(SelectNodesCommand(ctx, {'n1', 'n2'}));
    expect(holder.selection.nodeIds, equals({'n1', 'n2'}));

    // 传入空集以清空选择
    await mgr.executeCommand(SelectNodesCommand(ctx, <String>{}));
    expect(holder.selection.nodeIds, isEmpty);

    // undo 应该还原到 {'n1','n2'}
    await mgr.undo();
    expect(holder.selection.nodeIds, equals({'n1', 'n2'}));
  });
}

/// 简易 Holder，将 EditorState 拆开存储，并提供 toEditorState/fromEditorState。
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
