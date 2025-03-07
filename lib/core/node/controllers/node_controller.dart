import 'package:flutter/foundation.dart'; // for debugPrint
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../state_management/node_state/node_state_provider.dart';
import '../../state_management/node_state/node_state.dart';
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

  /// 拖拽开始时调用
  @override
  void onNodeDragStart(NodeModel node, DragStartDetails details) {
    debugPrint('Node drag started: ${node.id}');
    // 可根据需要在拖拽开始时执行其他逻辑
  }

  /// 拖拽过程中调用，更新节点位置并同步状态
  @override
  void onNodeDragUpdate(NodeModel node, DragUpdateDetails details) {
    node.x += details.delta.dx;
    node.y += details.delta.dy;
    upsertNode(node);
    debugPrint('Node drag updated: ${node.id}');
  }

  /// 拖拽结束时调用
  @override
  void onNodeDragEnd(NodeModel node, DragEndDetails details) {
    debugPrint('Node drag ended: ${node.id}');
    // 可根据需要在拖拽结束时执行其他逻辑
  }
}
