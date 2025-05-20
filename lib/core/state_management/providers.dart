import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flow_editor/core/models/state/editor_state.dart';
import 'package:flow_editor/core/models/state/canvas_state.dart';
import 'package:flow_editor/core/models/state/canvas_viewport_state.dart';
import 'package:flow_editor/core/models/state/node_state.dart';
import 'package:flow_editor/core/models/state/edge_state.dart';
import 'package:flow_editor/core/models/state/selection_state.dart';
import 'package:flow_editor/core/models/node_model.dart';
import 'package:flow_editor/core/models/edge_model.dart';
import 'package:flow_editor/core/models/state/interaction_transient_state.dart';
import 'package:flow_editor/core/state_management/editor_store_notifier.dart';

/// 编辑器主状态管理器
final editorStoreProvider =
    StateNotifierProvider<EditorStoreNotifier, EditorState>((ref) {
  return EditorStoreNotifier(const EditorState(
    canvases: {
      'default': CanvasState(),
    },
    activeWorkflowId: 'default',
    nodes: NodeState(),
    edges: EdgeState(),
    viewport: CanvasViewportState(),
    selection: SelectionState(),
  ));
});

/// 状态控制器：用于执行命令（undo、drag、add 等）
final editorStoreNotifierProvider = Provider<EditorStoreNotifier>(
  (ref) => ref.watch(editorStoreProvider.notifier),
);

/// 当前活跃的画布
final activeCanvasProvider = Provider<CanvasState>(
  (ref) => ref.watch(editorStoreProvider).activeCanvas,
);

/// 当前活跃节点列表
final activeNodesProvider = Provider<List<NodeModel>>(
  (ref) => ref.watch(editorStoreProvider.select((s) => s.activeNodes)),
);

/// 当前活跃边列表
final activeEdgesProvider = Provider<List<EdgeModel>>(
  (ref) => ref.watch(editorStoreProvider.select((s) => s.activeEdges)),
);

/// 当前视口（缩放 + 偏移）
final viewportProvider = Provider<CanvasViewportState>(
  (ref) => ref.watch(editorStoreProvider).viewport,
);

/// 当前交互状态（如 dragNode、dragEdge 等）
final interactionProvider = Provider<InteractionState>(
  (ref) => ref.watch(editorStoreProvider).interaction,
);

/// 当前选择状态（选中节点/边等）
final selectionProvider = Provider<SelectionState>(
  (ref) => ref.watch(editorStoreProvider).selection,
);

/// 当前工作流 ID
final activeWorkflowIdProvider = Provider<String>(
  (ref) => ref.watch(editorStoreProvider.select((s) => s.activeWorkflowId)),
);

/// undo/redo 状态
final canUndoProvider = Provider<bool>(
  (ref) => ref.watch(editorStoreProvider.notifier).canUndo,
);

final canRedoProvider = Provider<bool>(
  (ref) => ref.watch(editorStoreProvider.notifier).canRedo,
);


// TODO； configProvider、pluginProvider 或特定行为逻辑