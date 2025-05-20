import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flow_editor/core/models/node_model.dart';

part 'node_state.freezed.dart';
part 'node_state.g.dart';

@freezed
class NodeState with _$NodeState {
  const NodeState._(); // 允许写自定义方法

  const factory NodeState({
    @Default({}) Map<String, List<NodeModel>> nodesByWorkflow,
    @Default(1) int version,
  }) = _NodeState;

  factory NodeState.fromJson(Map<String, dynamic> json) =>
      _$NodeStateFromJson(json);

  /// 获取指定工作流的所有节点
  List<NodeModel> nodesOf(String workflowId) =>
      nodesByWorkflow[workflowId] ?? [];

  /// 更新指定工作流的节点，并更新版本号
  NodeState updateWorkflowNodes(String workflowId, List<NodeModel> nodes) {
    final updated = Map<String, List<NodeModel>>.from(nodesByWorkflow)
      ..[workflowId] = nodes;
    return copyWith(nodesByWorkflow: updated, version: version + 1);
  }

  /// 移除指定工作流
  NodeState removeWorkflow(String workflowId) {
    if (!nodesByWorkflow.containsKey(workflowId)) return this;
    final updated = Map<String, List<NodeModel>>.from(nodesByWorkflow)
      ..remove(workflowId);
    return copyWith(nodesByWorkflow: updated, version: version + 1);
  }
}
