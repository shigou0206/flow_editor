import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flow_editor/core/node/node_state/node_state.dart';
import 'package:flow_editor/core/node/models/node_model.dart';
import 'package:flutter/material.dart';

class NodeStateNotifier extends StateNotifier<NodeState> {
  final String workflowId;

  NodeStateNotifier({required this.workflowId}) : super(const NodeState());

  void upsertNode(NodeModel node) {
    final nodes = state.nodesOf(workflowId);
    final updated = [
      ...nodes.where((n) => n.id != node.id),
      node,
    ];
    state = state.updateWorkflowNodes(workflowId, updated);
  }

  void upsertNodes(List<NodeModel> newNodes) {
    final oldNodes = state.nodesOf(workflowId);
    final Map<String, NodeModel> nodeMap = {
      for (var node in oldNodes) node.id: node
    };
    bool hasChanges = false;

    for (var node in newNodes) {
      if (nodeMap[node.id] != node) {
        nodeMap[node.id] = node;
        hasChanges = true;
      }
    }

    if (hasChanges) {
      state = state.updateWorkflowNodes(workflowId, nodeMap.values.toList());
    }
  }

  void removeNode(String nodeId) {
    final nodes = state.nodesOf(workflowId);
    final updated = nodes.where((n) => n.id != nodeId).toList();
    if (updated.length != nodes.length) {
      state = state.updateWorkflowNodes(workflowId, updated);
    }
  }

  void removeNodes(List<String> nodeIds) {
    final nodes = state.nodesOf(workflowId);
    final updated = nodes.where((n) => !nodeIds.contains(n.id)).toList();
    if (updated.length != nodes.length) {
      state = state.updateWorkflowNodes(workflowId, updated);
    }
  }

  void moveNode(String nodeId, Offset delta) {
    final nodes = state.nodesOf(workflowId);
    final updated = nodes.map((node) {
      if (node.id == nodeId) {
        return node.copyWith(x: node.x + delta.dx, y: node.y + delta.dy);
      }
      return node;
    }).toList();
    state = state.updateWorkflowNodes(workflowId, updated);
  }

  void clearWorkflow() {
    if (state.nodesOf(workflowId).isEmpty) return;
    state = state.updateWorkflowNodes(workflowId, []);
  }

  void removeWorkflow() {
    state = state.removeWorkflow(workflowId);
  }

  NodeModel? getNode(String nodeId) {
    final nodes = state.nodesOf(workflowId);
    for (final node in nodes) {
      if (node.id == nodeId) return node;
    }
    return null;
  }

  List<NodeModel> getNodes() {
    return state.nodesOf(workflowId);
  }

  bool nodeExists(String nodeId) {
    return state.nodesOf(workflowId).any((node) => node.id == nodeId);
  }
}

final nodeStateProvider =
    StateNotifierProvider.family<NodeStateNotifier, NodeState, String>(
  (ref, workflowId) => NodeStateNotifier(workflowId: workflowId),
);
