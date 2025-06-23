import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flow_editor/core/controller/impl/canvas_controller_impl.dart';
import 'package:flow_editor/core/models/ui_state/editor_state.dart';
import 'package:flow_editor/core/models/ui_state/selection_state.dart';
import 'package:flow_editor/core/models/ui_state/interaction_transient_state.dart';
import 'package:flow_editor/core/models/ui_state/canvas_state.dart';
import 'package:flow_editor/core/models/ui_state/node_state.dart';
import 'package:flow_editor/core/models/ui_state/edge_state.dart';
import 'package:flow_editor/core/state_management/editor_store_notifier.dart';

// 当前活跃 workflowId
final activeWorkflowIdProvider = StateProvider<String>((ref) => 'default');

// 每个 workflowId 对应一个 EditorStore
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

// 当前激活的 EditorState
final activeEditorStateProvider = Provider<EditorState>((ref) {
  final id = ref.watch(activeWorkflowIdProvider);
  return ref.watch(editorStoreFamilyProvider(id));
});

// 当前 Editor 的控制器
final activeEditorNotifierProvider = Provider<EditorStoreNotifier>((ref) {
  final id = ref.watch(activeWorkflowIdProvider);
  return ref.watch(editorStoreFamilyProvider(id).notifier);
});

// 当前 workflow 的选区状态（统一选中状态）
final selectionProvider = Provider<SelectionState>((ref) {
  return ref.watch(activeEditorStateProvider.select((s) => s.selection));
});

// 当前交互状态
final interactionProvider = Provider<InteractionState>((ref) {
  return ref.watch(activeEditorStateProvider.select((s) => s.interaction));
});

// 当前是否可撤销 / 重做
final canUndoProvider = Provider<bool>((ref) {
  return ref.watch(activeEditorNotifierProvider).canUndo;
});

final canRedoProvider = Provider<bool>((ref) {
  return ref.watch(activeEditorNotifierProvider).canRedo;
});

// 每个 workflow 独享 CanvasControllerImpl
final canvasControllerFamilyProvider =
    Provider.family<CanvasControllerImpl, String>((ref, workflowId) {
  final storeNotifier =
      ref.watch(editorStoreFamilyProvider(workflowId).notifier);
  return CanvasControllerImpl(storeNotifier.commandContext);
});

// 当前激活 workflow 的 controller
final activeCanvasControllerProvider = Provider<CanvasControllerImpl>((ref) {
  final workflowId = ref.watch(activeWorkflowIdProvider);
  return ref.watch(canvasControllerFamilyProvider(workflowId));
});
