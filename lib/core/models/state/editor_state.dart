import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flow_editor/core/models/state/canvas_state.dart';
import 'package:flow_editor/core/models/state/node_state.dart';
import 'package:flow_editor/core/models/state/edge_state.dart';
import 'package:flow_editor/core/models/state/canvas_viewport_state.dart';
import 'package:flow_editor/core/models/state/selection_state.dart';
import 'package:flow_editor/core/models/state/interaction_transient_state.dart';
import 'package:flow_editor/core/models/node_model.dart';
import 'package:flow_editor/core/models/edge_model.dart';

part 'editor_state.freezed.dart';
part 'editor_state.g.dart';

@freezed
class EditorState with _$EditorState {
  const EditorState._(); // for custom getters

  const factory EditorState({
    required Map<String, CanvasState> canvases,
    required String activeWorkflowId,
    required NodeState nodes,
    required EdgeState edges,
    @Default(CanvasViewportState()) CanvasViewportState viewport,
    @Default(SelectionState()) SelectionState selection,
    @Default(InteractionState.idle()) InteractionState interaction,
  }) = _EditorState;

  factory EditorState.fromJson(Map<String, dynamic> json) =>
      _$EditorStateFromJson(json);

  // === 自定义 getter 保留 ===

  CanvasState get activeCanvas => canvases[activeWorkflowId]!;

  List<NodeModel> get activeNodes => nodes.nodesOf(activeWorkflowId);

  List<EdgeModel> get activeEdges => edges.edgesOf(activeWorkflowId);
}
