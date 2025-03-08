import 'package:equatable/equatable.dart';
import 'package:flow_editor/core/node/models/node_model.dart';

class NodeState extends Equatable {
  final Map<String, Map<String, NodeModel>> nodesByWorkflow;
  final Map<String, Set<String>> nodeIdsByType;
  final int version;

  const NodeState({
    this.nodesByWorkflow = const {},
    this.nodeIdsByType = const {},
    this.version = 1,
  });

  Map<String, NodeModel> nodesOf(String workflowId) =>
      nodesByWorkflow[workflowId] ?? {};

  Set<String> nodesByType(String type) => nodeIdsByType[type] ?? {};

  NodeState copyWith({
    Map<String, Map<String, NodeModel>>? nodesByWorkflow,
    Map<String, Set<String>>? nodeIdsByType,
    int? version,
  }) {
    return NodeState(
      nodesByWorkflow: nodesByWorkflow ?? this.nodesByWorkflow,
      nodeIdsByType: nodeIdsByType ?? this.nodeIdsByType,
      version: version ?? this.version,
    );
  }

  NodeState updateWorkflowNodes(
      String workflowId, Map<String, NodeModel> nodes) {
    final updatedNodes =
        Map<String, Map<String, NodeModel>>.from(nodesByWorkflow);
    updatedNodes[workflowId] = nodes;

    return rebuildIndexes(updatedNodes, version: version + 1);
  }

  NodeState rebuildIndexes(
      Map<String, Map<String, NodeModel>> updatedNodesByWorkflow,
      {int? version}) {
    final typeIndex = <String, Set<String>>{};

    updatedNodesByWorkflow.forEach((_, nodes) {
      nodes.forEach((nodeId, node) {
        typeIndex.putIfAbsent(node.type, () => {}).add(nodeId);
      });
    });

    return copyWith(
      nodesByWorkflow: updatedNodesByWorkflow,
      nodeIdsByType: typeIndex,
      version: version,
    );
  }

  NodeState removeWorkflow(String workflowId) {
    if (!nodesByWorkflow.containsKey(workflowId)) return this;

    final updatedWorkflows =
        Map<String, Map<String, NodeModel>>.from(nodesByWorkflow)
          ..remove(workflowId);

    return copyWith(nodesByWorkflow: updatedWorkflows);
  }

  @override
  List<Object?> get props => [nodesByWorkflow, nodeIdsByType, version];
}
