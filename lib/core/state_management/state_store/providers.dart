// lib/core/providers.dart

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flow_editor/core/state_management/state_store/editor_state.dart';
import 'package:flow_editor/core/models/state/canvas_state.dart';
import 'package:flow_editor/core/models/node_model.dart';
import 'package:flow_editor/core/models/edge_model.dart';
import 'package:flow_editor/core/models/state/node_state.dart';
import 'package:flow_editor/core/models/state/edge_state.dart';
import 'package:flow_editor/core/models/state/canvas_viewport_state.dart';
import 'package:flow_editor/core/models/state/selection_state.dart';
import 'editor_store_notifier.dart';

/// The main editor store provider.
final editorStoreProvider =
    StateNotifierProvider<EditorStoreNotifier, EditorState>(
  (ref) {
    // You can pass an initial EditorState here if needed:
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
  },
);

/// A convenience provider for the active CanvasState.
final activeCanvasStateProvider = Provider<CanvasState>(
  (ref) => ref.watch(editorStoreProvider).activeCanvas,
);

/// A convenience provider for the current nodes in the active workflow.
final activeNodesProvider = Provider<List<NodeModel>>(
  (ref) => ref.watch(editorStoreProvider.select((state) => state.activeNodes)),
);

/// A convenience provider for the current edges in the active workflow.
final activeEdgesProvider = Provider<List<EdgeModel>>(
  (ref) => ref.watch(editorStoreProvider.select((state) => state.activeEdges)),
);

/// A convenience provider for the global viewport state.
final viewportProvider = Provider<CanvasViewportState>(
  (ref) => ref.watch(editorStoreProvider).viewport,
);

final canUndoProvider = Provider<bool>(
  (ref) => ref.watch(editorStoreProvider.notifier).canUndo,
);
final canRedoProvider = Provider<bool>(
  (ref) => ref.watch(editorStoreProvider.notifier).canRedo,
);

final selectionProvider = Provider<SelectionState>(
  (ref) => ref.watch(editorStoreProvider).selection,
);
