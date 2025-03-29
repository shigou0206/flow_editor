import 'package:flow_editor/core/logic/strategy/workflow_strategy.dart';
import 'package:flow_editor/core/node/models/node_model.dart';
import 'package:flow_editor/core/edge/models/edge_model.dart';
import 'package:flow_editor/core/node/node_state/node_state_provider.dart';
import 'package:flow_editor/core/edge/edge_state/edge_state_provider.dart';
import 'package:flow_editor/core/node/models/node_enums.dart';
import 'package:flutter/material.dart';

class StateMachineStrategy implements WorkflowModeStrategy {
  final String workflowId;

  StateMachineStrategy({required this.workflowId});

  @override
  void onNodeDeleted({
    required NodeModel deletedNode,
    required List<NodeModel> upstreamNodes,
    required List<NodeModel> downstreamNodes,
    required EdgeStateNotifier edgeNotifier,
    required NodeStateNotifier nodeNotifier,
  }) {
    // Step 1: 删除节点
    nodeNotifier.removeNode(deletedNode.id);

    // Step 2: 删除所有相关边
    edgeNotifier.removeEdgesOfNode(deletedNode.id);

    final edges = edgeNotifier.getEdges();

    // Step 3: 标记上游节点为 unlinked（如果断开后不再指向其他节点）
    for (final node in upstreamNodes) {
      final hasOutput = edges.any((e) => e.sourceNodeId == node.id);
      if (!hasOutput) {
        nodeNotifier.upsertNode(node.copyWith(status: NodeStatus.unlinked));
      }
    }

    // Step 4: 标记下游节点为 orphaned（如果没人指向它了）
    for (final node in downstreamNodes) {
      final hasInput = edges.any((e) => e.targetNodeId == node.id);
      if (!hasInput) {
        nodeNotifier.upsertNode(node.copyWith(status: NodeStatus.orphaned));
      }
    }
  }

  @override
  void validate({
    required List<NodeModel> nodes,
    required List<EdgeModel> edges,
    required NodeStateNotifier nodeNotifier,
  }) {
    int startCount = 0;

    for (final node in nodes) {
      final isStart = node.role == NodeRole.start;
      final isEnd = node.role == NodeRole.end;
      final hasInput = edges.any((e) => e.targetNodeId == node.id);
      final hasOutput = edges.any((e) => e.sourceNodeId == node.id);

      NodeStatus status = NodeStatus.normal;

      if (isStart) {
        startCount += 1;
        if (!hasOutput) {
          status = NodeStatus.unlinked; // Start 节点必须连接出去
        }
      } else if (isEnd) {
        if (!hasInput) {
          status = NodeStatus.orphaned; // End 节点必须有入口
        }
      } else {
        if (!hasInput && !hasOutput) {
          status = NodeStatus.orphaned;
        } else if (!hasInput) {
          status = NodeStatus.unlinked;
        } else if (!hasOutput) {
          status = NodeStatus.unlinked;
        }
      }

      nodeNotifier.upsertNode(node.copyWith(status: status));
    }

    // 可以加入更多校验（如路径检测、死循环检测等）

    if (startCount == 0) {
      debugPrint('❌ 校验失败：缺少 Start 节点');
    } else if (startCount > 1) {
      debugPrint('❌ 校验失败：Start 节点数量超过 1');
    }
  }
}
