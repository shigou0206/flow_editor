import 'package:flutter/foundation.dart'; // for debugPrint
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../node_state/node_state_provider.dart';
import '../node_state/node_state.dart';
import '../models/node_model.dart';
import 'node_controller_interface.dart';
import 'events.dart';

class NodeController implements INodeController {
  final ProviderContainer container;
  final String workflowId;
  NodeEventCallback? onNodeAdded;
  NodeEventCallback? onNodeRemoved;

  NodeController({
    required this.container,
    required this.workflowId,
    this.onNodeAdded,
    this.onNodeRemoved,
  });

  NodeStateNotifier get _notifier =>
      container.read(nodeStateProvider(workflowId).notifier);
  NodeState get _state => container.read(nodeStateProvider(workflowId));

  @override
  void upsertNode(NodeModel node) {
    _notifier.upsertNode(node);
    onNodeAdded?.call(node);
    debugPrint('Node upserted: ${node.id}');
  }

  @override
  void upsertNodes(List<NodeModel> nodes) {
    if (nodes.isEmpty) return;
    _notifier.upsertNodes(nodes);
    for (final node in nodes) {
      onNodeAdded?.call(node);
      debugPrint('Node batch upserted: ${node.id}');
    }
  }

  @override
  void removeNode(String nodeId) {
    final node = getNode(nodeId);
    if (node != null) {
      _notifier.removeNode(nodeId);
      onNodeRemoved?.call(node);
      debugPrint('Node removed: ${node.id}');
    }
  }

  @override
  void removeNodes(List<String> nodeIds) {
    if (nodeIds.isEmpty) return;
    for (final nodeId in nodeIds) {
      removeNode(nodeId);
    }
  }

  @override
  void clearNodes() {
    final nodes = getAllNodes();
    _notifier.clearWorkflow();
    for (final node in nodes) {
      onNodeRemoved?.call(node);
      debugPrint('Node cleared: ${node.id}');
    }
  }

  @override
  NodeModel? getNode(String nodeId) {
    return _state.nodesOf(workflowId)[nodeId];
  }

  @override
  List<NodeModel> getAllNodes() {
    return _state.nodesOf(workflowId).values.toList();
  }

  @override
  List<NodeModel> getNodesByType(String type) {
    return _state
        .nodesOf(workflowId)
        .values
        .where((node) => node.type == type)
        .toList();
  }

  @override
  bool nodeExists(String nodeId) {
    return _state.nodesOf(workflowId).containsKey(nodeId);
  }

  NodeModel? findNode(bool Function(NodeModel) predicate) {
    try {
      return _state.nodesOf(workflowId).values.firstWhere(predicate);
    } catch (_) {
      return null;
    }
  }
}
