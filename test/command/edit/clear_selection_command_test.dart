// test/command/edit/clear_selection_command_test.dart

import 'package:flutter_test/flutter_test.dart';
import 'package:flow_editor/core/command/command_manager.dart';
import 'package:flow_editor/core/command/command_context.dart';
import 'package:flow_editor/core/command/edit/clear_selection_command.dart';
import 'package:flow_editor/core/models/state/canvas_state.dart';
import 'package:flow_editor/core/models/state/node_state.dart';
import 'package:flow_editor/core/models/state/edge_state.dart';
import 'package:flow_editor/core/models/state/selection_state.dart';
import 'package:flow_editor/core/models/state/canvas_viewport_state.dart';
import 'package:flow_editor/core/state_management/state_store/editor_state.dart';

void main() {
  const wfId = 'wf1';

  late CanvasState canvState;
  late NodeState nodeState;
  late EdgeState edgeState;
  late CanvasViewportState viewportState;
  late SelectionState initialSelection;
  late EditorStateHolder holder;
  late CommandContext ctx;
  late CommandManager mgr;

  setUp(() {
    canvState = const CanvasState();
    nodeState = const NodeState(nodesByWorkflow: {wfId: []});
    edgeState = const EdgeState(edgesByWorkflow: {wfId: []});
    viewportState = const CanvasViewportState();
    // 初始 selection 中有一些 ID
    initialSelection = const SelectionState(
      nodeIds: {'n1', 'n2'},
      edgeIds: {'e1'},
    );

    holder = EditorStateHolder(
      canvases: {wfId: canvState},
      activeWorkflowId: wfId,
      nodes: nodeState,
      edges: edgeState,
      viewport: viewportState,
      selection: initialSelection,
    );

    ctx = CommandContext(
      getState: () => holder.toEditorState(),
      updateState: (st) => holder.fromEditorState(st),
    );

    mgr = CommandManager(ctx);
  });

  test('execute clears both node and edge selections', () async {
    final cmd = ClearSelectionCommand(ctx);
    await mgr.executeCommand(cmd);

    expect(holder.selection.nodeIds, isEmpty,
        reason: 'node selection should be cleared');
    expect(holder.selection.edgeIds, isEmpty,
        reason: 'edge selection should be cleared');
    expect(mgr.canUndo, isTrue);
    expect(mgr.canRedo, isFalse);
  });

  test('undo restores previous selection', () async {
    final cmd = ClearSelectionCommand(ctx);
    await mgr.executeCommand(cmd);
    expect(holder.selection.nodeIds, isEmpty);
    expect(holder.selection.edgeIds, isEmpty);

    await mgr.undo();
    expect(holder.selection.nodeIds, equals({'n1', 'n2'}),
        reason: 'undo should restore node selection');
    expect(holder.selection.edgeIds, equals({'e1'}),
        reason: 'undo should restore edge selection');

    expect(mgr.canRedo, isTrue);
    expect(mgr.canUndo, isFalse);
  });

  test('redo re-clears selection after undo', () async {
    final cmd = ClearSelectionCommand(ctx);
    await mgr.executeCommand(cmd);
    await mgr.undo();
    // now original selection restored
    expect(holder.selection.nodeIds, equals({'n1', 'n2'}));
    expect(holder.selection.edgeIds, equals({'e1'}));

    await mgr.redo();
    expect(holder.selection.nodeIds, isEmpty,
        reason: 'redo should clear node selection again');
    expect(holder.selection.edgeIds, isEmpty,
        reason: 'redo should clear edge selection again');
    expect(mgr.canUndo, isTrue);
    expect(mgr.canRedo, isFalse);
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
