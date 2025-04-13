import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flow_editor/core/anchor/utils/anchor_position_utils.dart';
import 'package:flow_editor/core/anchor/models/anchor_model.dart';
import 'package:flow_editor/core/node/node_state/node_state_provider.dart';
import 'package:flow_editor/core/node/node_state/node_state.dart';
import 'package:flow_editor/core/node/models/node_model.dart';
import 'package:flow_editor/core/node/controllers/node_controller_interface.dart';
import 'package:flow_editor/core/node/controllers/events.dart';
import 'package:flow_editor/core/canvas/canvas_state/canvas_state_provider.dart';

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
      // 使用策略化删除，调用 MultiCanvasStateNotifier 中封装好的方法
      final multiCanvasController =
          container.read(multiCanvasStateProvider.notifier);
      multiCanvasController.deleteNodeWithStrategy(nodeId);

      // 删除后再执行全局校验，确保画布状态更新
      multiCanvasController.validateCanvas();

      // 触发回调通知
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
    final nodes = _state.nodesOf(workflowId);
    for (final node in nodes) {
      if (node.id == nodeId) return node;
    }
    return null;
  }

  @override
  List<NodeModel> getAllNodes() {
    return _state.nodesOf(workflowId);
  }

  @override
  List<NodeModel> getNodesByType(String type) {
    return _state
        .nodesOf(workflowId)
        .where((node) => node.type == type)
        .toList();
  }

  @override
  bool nodeExists(String nodeId) {
    return _state.nodesOf(workflowId).any((node) => node.id == nodeId);
  }

  NodeModel? findNode(bool Function(NodeModel) predicate) {
    try {
      return _state.nodesOf(workflowId).firstWhere(predicate);
    } catch (_) {
      return null;
    }
  }

  // region =========== 锚点命中检测 ===========

  @override
  AnchorModel? findAnchorNear(
    Offset worldPos,
    String excludeAnchorId, {
    double hitTestRadius = 20.0,
  }) {
    final nodes = getAllNodes();

    for (final node in nodes) {
      for (final anchor in node.anchors ?? []) {
        if (anchor.id == excludeAnchorId) continue;

        final anchorLocalPos = computeAnchorLocalPosition(
          anchor,
          node.size,
        );

        final padding = computeAnchorPadding(
          node.anchors ?? [],
          Size(node.size.width, node.size.height),
        );

        final anchorWorldPos = Offset(
          node.position.dx - padding.left + anchorLocalPos.dx,
          node.position.dy - padding.top + anchorLocalPos.dy,
        );

        final distance = (anchorWorldPos - worldPos).distance;
        if (distance <= hitTestRadius) {
          return anchor;
        }
      }
    }

    return null;
  }

  // endregion
}
