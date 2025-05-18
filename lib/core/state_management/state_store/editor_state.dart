import 'package:flow_editor/core/models/state/canvas_state.dart';
import 'package:flow_editor/core/models/state/node_state.dart';
import 'package:flow_editor/core/models/state/edge_state.dart';
import 'package:flow_editor/core/models/state/canvas_viewport_state.dart';
import 'package:flow_editor/core/models/state/selection_state.dart';
import 'package:flow_editor/core/models/node_model.dart';
import 'package:flow_editor/core/models/edge_model.dart';

/// 整个编辑器（Editor）的状态，包含画布、节点、边、视口等
class EditorState {
  /// 所有工作流对应的 CanvasState
  final Map<String, CanvasState> canvases;

  /// 当前活跃的工作流 ID
  final String activeWorkflowId;

  /// 所有工作流对应的 NodeState
  final NodeState nodes;

  /// 所有工作流对应的 EdgeState
  final EdgeState edges;

  /// 可选的全局视口状态
  final CanvasViewportState viewport;

  final SelectionState selection;

  const EditorState({
    required this.canvases,
    required this.activeWorkflowId,
    required this.nodes,
    required this.edges,
    this.viewport = const CanvasViewportState(),
    this.selection = const SelectionState(),
  });

  /// 当前活跃画布状态的快捷访问
  CanvasState get activeCanvas => canvases[activeWorkflowId]!;

  /// 当前活跃工作流的节点列表
  List<NodeModel> get activeNodes => nodes.nodesOf(activeWorkflowId);

  /// 当前活跃工作流的边列表
  List<EdgeModel> get activeEdges => edges.edgesOf(activeWorkflowId);

  /// 拷贝并更新部分字段
  EditorState copyWith({
    Map<String, CanvasState>? canvases,
    String? activeWorkflowId,
    NodeState? nodes,
    EdgeState? edges,
    CanvasViewportState? viewport,
    SelectionState? selection,
  }) {
    return EditorState(
      canvases: canvases ?? this.canvases,
      activeWorkflowId: activeWorkflowId ?? this.activeWorkflowId,
      nodes: nodes ?? this.nodes,
      edges: edges ?? this.edges,
      viewport: viewport ?? this.viewport,
      selection: selection ?? this.selection,
    );
  }

  /// 序列化为 JSON
  Map<String, dynamic> toJson() => {
        'activeWorkflowId': activeWorkflowId,
        'canvases': canvases.map((id, cs) => MapEntry(id, cs.toJson())),
        'nodes': nodes.toJson(), // 你需要在 NodeState 中实现 toJson()
        'edges': edges.toJson(), // 你需要在 EdgeState 中实现 toJson()
        'viewport': viewport.toJson(),
        'selection': selection.toJson(),
      };

  /// 从 JSON 恢复
  factory EditorState.fromJson(Map<String, dynamic> json) {
    final canvasesJson = (json['canvases'] as Map<String, dynamic>);
    final canvases = canvasesJson.map(
      (id, csJson) => MapEntry(id, CanvasState.fromJson(csJson)),
    );
    return EditorState(
      activeWorkflowId: json['activeWorkflowId'] as String,
      canvases: canvases,
      nodes: NodeState.fromJson(json['nodes'] as Map<String, dynamic>),
      edges: EdgeState.fromJson(json['edges'] as Map<String, dynamic>),
      viewport: CanvasViewportState.fromJson(
          json['viewport'] as Map<String, dynamic>),
      selection:
          SelectionState.fromJson(json['selection'] as Map<String, dynamic>),
    );
  }
}
