import 'package:flow_editor/core/logic/strategy/workflow_strategy.dart';
import 'package:flow_editor/core/node/models/node_model.dart';
import 'package:flow_editor/core/edge/models/edge_model.dart';
import 'package:flow_editor/core/node/node_state/node_state_provider.dart';
import 'package:flow_editor/core/edge/edge_state/edge_state_provider.dart';
import 'package:flow_editor/core/node/models/node_enums.dart';

class GenericFlowStrategy implements WorkflowModeStrategy {
  final String workflowId;

  GenericFlowStrategy({required this.workflowId});

  @override
  void onNodeDeleted({
    required NodeModel deletedNode,
    required List<NodeModel> upstreamNodes,
    required List<NodeModel> downstreamNodes,
    required EdgeStateNotifier edgeNotifier,
    required NodeStateNotifier nodeNotifier,
  }) {
    // Step 1: 删除节点本身
    nodeNotifier.removeNode(deletedNode.id);

    // Step 2: 删除与该节点相关的所有边
    edgeNotifier.removeEdgesOfNode(deletedNode.id);

    // Step 3: 标记 downstream 节点为 orphaned（如果不再被任何边连接）
    final edges = edgeNotifier.getEdges();
    for (final node in downstreamNodes) {
      final hasOtherInput = edges.any((e) => e.targetNodeId == node.id);
      if (!hasOtherInput) {
        final updated = node.copyWith(status: NodeStatus.orphaned);
        nodeNotifier.upsertNode(updated);
      }
    }

    // Step 4: 可选：标记 upstream 节点为 unlinked（如果不再指向任何节点）
    for (final node in upstreamNodes) {
      final hasOtherOutput = edges.any((e) => e.sourceNodeId == node.id);
      if (!hasOtherOutput) {
        final updated = node.copyWith(status: NodeStatus.unlinked);
        nodeNotifier.upsertNode(updated);
      }
    }
  }

  @override
  void validate({
    required List<NodeModel> nodes,
    required List<EdgeModel> edges,
    required NodeStateNotifier nodeNotifier,
  }) {
    for (final node in nodes) {
      final hasInput = edges.any((e) => e.targetNodeId == node.id);
      final hasOutput = edges.any((e) => e.sourceNodeId == node.id);

      NodeStatus status;
      if (!hasInput && !hasOutput) {
        status = NodeStatus.orphaned;
      } else {
        status = NodeStatus.normal;
      }

      nodeNotifier.upsertNode(node.copyWith(status: status));
    }
  }
}
