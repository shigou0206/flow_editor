import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'node_state.dart';
import '../models/node_model.dart';
import 'package:flutter/material.dart';

class NodeStateNotifier extends StateNotifier<NodeState> {
  final String workflowId;

  NodeStateNotifier({required this.workflowId}) : super(const NodeState());

  void upsertNode(NodeModel node) {
    final workflowNodes = state.nodesOf(workflowId);
    final updatedNodes = Map<String, NodeModel>.from(workflowNodes);
    updatedNodes[node.id] = node;
    state = state.updateWorkflowNodes(workflowId, updatedNodes);
  }

  void moveNode(String nodeId, Offset delta) {
    final workflowNodes = state.nodesOf(workflowId);
    final node = workflowNodes[nodeId];
    if (node == null) return;
    final updatedNode =
        node.copyWith(x: node.x + delta.dx, y: node.y + delta.dy);
    final updatedMap = {...workflowNodes, nodeId: updatedNode};
    state = state.updateWorkflowNodes(workflowId, updatedMap);
  }

  void upsertNodes(List<NodeModel> nodes) {
    final workflowNodes = state.nodesOf(workflowId);
    final updatedNodes = Map<String, NodeModel>.from(workflowNodes);
    bool hasChanges = false;
    for (final node in nodes) {
      if (updatedNodes[node.id] != node) {
        updatedNodes[node.id] = node;
        hasChanges = true;
      }
    }
    if (hasChanges) {
      state = state.updateWorkflowNodes(workflowId, updatedNodes);
    }
  }

  void removeNode(String nodeId) {
    final workflowNodes = state.nodesOf(workflowId);
    if (!workflowNodes.containsKey(nodeId)) return;
    final updatedNodes = Map<String, NodeModel>.from(workflowNodes)
      ..remove(nodeId);
    state = state.updateWorkflowNodes(workflowId, updatedNodes);
  }

  void removeNodes(List<String> nodeIds) {
    final workflowNodes = state.nodesOf(workflowId);
    final updatedNodes = Map<String, NodeModel>.from(workflowNodes);
    bool hasChanges = false;
    for (final nodeId in nodeIds) {
      if (updatedNodes.containsKey(nodeId)) {
        updatedNodes.remove(nodeId);
        hasChanges = true;
      }
    }
    if (hasChanges) {
      state = state.updateWorkflowNodes(workflowId, updatedNodes);
    }
  }

  void clearWorkflow() {
    if (state.nodesOf(workflowId).isEmpty) return;
    state = state.updateWorkflowNodes(workflowId, {});
  }

  void removeWorkflow() {
    if (!state.nodesByWorkflow.containsKey(workflowId)) return;
    state = state.removeWorkflow(workflowId);
  }

  NodeModel? getNode(String nodeId) {
    return state.nodesOf(workflowId)[nodeId];
  }

  List<NodeModel> getNodes() {
    return state.nodesOf(workflowId).values.toList();
  }

  bool nodeExists(String nodeId) {
    return state.nodesOf(workflowId).containsKey(nodeId);
  }
}

final nodeStateProvider =
    StateNotifierProvider.family<NodeStateNotifier, NodeState, String>(
  (ref, workflowId) => NodeStateNotifier(workflowId: workflowId),
);
