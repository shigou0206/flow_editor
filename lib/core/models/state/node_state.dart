import 'package:equatable/equatable.dart';
import 'package:flow_editor/core/models/node_model.dart';

class NodeState extends Equatable {
  final Map<String, List<NodeModel>> nodesByWorkflow;
  final int version;

  const NodeState({
    this.nodesByWorkflow = const {},
    this.version = 1,
  });

  List<NodeModel> nodesOf(String workflowId) =>
      nodesByWorkflow[workflowId] ?? [];

  NodeState copyWith({
    Map<String, List<NodeModel>>? nodesByWorkflow,
    int? version,
  }) {
    return NodeState(
      nodesByWorkflow: nodesByWorkflow ?? this.nodesByWorkflow,
      version: version ?? this.version,
    );
  }

  NodeState updateWorkflowNodes(String workflowId, List<NodeModel> nodes) {
    final updated = Map<String, List<NodeModel>>.from(nodesByWorkflow)
      ..[workflowId] = nodes;
    return copyWith(nodesByWorkflow: updated, version: version + 1);
  }

  NodeState removeWorkflow(String workflowId) {
    if (!nodesByWorkflow.containsKey(workflowId)) return this;
    final updated = Map<String, List<NodeModel>>.from(nodesByWorkflow)
      ..remove(workflowId);
    return copyWith(nodesByWorkflow: updated, version: version + 1);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = {};
    json['nodes'] = nodesByWorkflow.map((workflowId, nodes) =>
        MapEntry(workflowId, nodes.map((node) => node.toJson()).toList()));
    return json;
  }

  factory NodeState.fromJson(Map<String, dynamic> json) {
    final nodesJson = json['nodes'] as Map<String, dynamic>;
    final nodesByWorkflow = <String, List<NodeModel>>{};

    nodesJson.forEach((workflowId, nodesList) {
      nodesByWorkflow[workflowId] = (nodesList as List<dynamic>)
          .map((nodeJson) =>
              NodeModel.fromJson(nodeJson as Map<String, dynamic>))
          .toList();
    });

    return NodeState(nodesByWorkflow: nodesByWorkflow);
  }

  @override
  List<Object?> get props => [nodesByWorkflow, version];
}
