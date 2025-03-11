import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:flow_editor/core/anchor/utils/anchor_position_utils.dart';
import 'package:flow_editor/core/anchor/models/anchor_model.dart';
import 'package:flow_editor/core/node/node_state/node_state_provider.dart';
import 'package:flow_editor/core/node/node_state/node_state.dart';
import 'package:flow_editor/core/node/models/node_model.dart';
import 'package:flow_editor/core/node/controllers/node_controller_interface.dart';
import 'package:flow_editor/core/node/controllers/events.dart';

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
  }

  @override
  void upsertNodes(List<NodeModel> nodes) {
    if (nodes.isEmpty) return;
    _notifier.upsertNodes(nodes);
    for (final node in nodes) {
      onNodeAdded?.call(node);
    }
  }

  @override
  void removeNode(String nodeId) {
    final node = getNode(nodeId);
    if (node != null) {
      _notifier.removeNode(nodeId);
      onNodeRemoved?.call(node);
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

  // region =========== 新增: 锚点命中检测 ===========

  /// 遍历所有节点及其 anchors，计算 anchor 的世界坐标，
  /// 若与 [worldPos] 距离 <= [hitTestRadius]，则返回该 AnchorModel；
  /// [excludeAnchorId] 用于排除自己正在拖拽的 anchor。
  @override
  AnchorModel? findAnchorNear(
    Offset worldPos,
    String excludeAnchorId, {
    double hitTestRadius = 20.0,
  }) {
    // 获取所有 NodeModel
    final nodes = getAllNodes();

    for (final node in nodes) {
      // 这里假设 NodeModel 里有 anchors: List<AnchorModel> anchors
      for (final anchor in node.anchors) {
        // 跳过要排除的 anchor
        if (anchor.id == excludeAnchorId) continue;

        // 计算 anchor 在节点本地坐标
        final anchorLocalPos = computeAnchorLocalPosition(
          anchor,
          Size(node.width, node.height),
        );

        // 计算 anchor 在节点上可能的 Padding
        final padding = computeAnchorPadding(
          node.anchors,
          Size(node.width, node.height),
        );

        // 将本地坐标转换成世界坐标
        final anchorWorldPos = Offset(
          node.x - padding.left + anchorLocalPos.dx,
          node.y - padding.top + anchorLocalPos.dy,
        );

        final distance = (anchorWorldPos - worldPos).distance;
        if (distance <= hitTestRadius) {
          return anchor;
        }
      }
    }

    // 没有命中
    return null;
  }

  // endregion
}
