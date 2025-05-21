import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flow_editor/core/models/state/editor_state.dart';
import 'package:flow_editor/core/models/state/selection_state.dart';
import 'package:flow_editor/core/models/state/interaction_transient_state.dart';
import 'package:flow_editor/core/models/state/canvas_state.dart';
import 'package:flow_editor/core/models/state/node_state.dart';
import 'package:flow_editor/core/models/state/edge_state.dart';
import 'package:flow_editor/core/state_management/editor_store_notifier.dart';

/// 管理当前活跃 workflowId（用于 tab 切换等）
final activeWorkflowIdProvider = StateProvider<String>((ref) => 'default');

/// 每个 workflowId 对应一个独立 EditorStore
final editorStoreFamilyProvider =
    StateNotifierProvider.family<EditorStoreNotifier, EditorState, String>(
  (ref, workflowId) {
    return EditorStoreNotifier(const EditorState(
      canvasState: CanvasState(),
      nodeState: NodeState(),
      edgeState: EdgeState(),
    ));
  },
);

/// 当前激活的 EditorState（方便 UI 直接读）
final activeEditorStateProvider = Provider<EditorState>((ref) {
  final id = ref.watch(activeWorkflowIdProvider);
  return ref.watch(editorStoreFamilyProvider(id));
});

/// 当前 Editor 的控制器
final activeEditorNotifierProvider = Provider<EditorStoreNotifier>((ref) {
  final id = ref.watch(activeWorkflowIdProvider);
  return ref.watch(editorStoreFamilyProvider(id).notifier);
});

/// 当前 workflow 的选区
final selectionProvider = Provider<SelectionState>((ref) {
  return ref.watch(activeEditorStateProvider.select((s) => s.selection));
});

/// 当前交互状态
final interactionProvider = Provider<InteractionState>((ref) {
  return ref.watch(activeEditorStateProvider.select((s) => s.interaction));
});

/// 当前是否可撤销 / 重做
final canUndoProvider = Provider<bool>((ref) {
  return ref.watch(activeEditorNotifierProvider).canUndo;
});

final canRedoProvider = Provider<bool>((ref) {
  return ref.watch(activeEditorNotifierProvider).canRedo;
});
