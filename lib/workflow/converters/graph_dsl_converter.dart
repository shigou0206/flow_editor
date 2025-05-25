import 'package:flow_editor/workflow/models/flow/workflow_dsl.dart';
import 'package:flow_editor/core/models/node_model.dart';
import 'package:flow_editor/core/models/edge_model.dart';

class GraphDslConverter {
  static WorkflowDSL toDsl({
    required List<NodeModel> nodes,
    required List<EdgeModel> edges,
    required String startAt,
    String? comment,
    String version = '1.0.0',
  }) {
    final states = <String, dynamic>{};

    // 🚩 定义特殊节点ID集合，明确排除
    const specialNodeIds = {'start_node', 'end_node', 'group_root'};

    for (var node in nodes) {
      if (specialNodeIds.contains(node.id)) continue; // 🚩 跳过特殊节点

      final stateData = Map<String, dynamic>.from(node.data);
      stateData.remove('id');

      // 🚩 排除所有连接到特殊节点的边
      final outgoingEdges = edges
          .where(
            (e) =>
                e.sourceNodeId == node.id &&
                !specialNodeIds.contains(e.targetNodeId),
          )
          .toList();

      if (node.type == 'Choice') {
        final choices = <Map<String, dynamic>>[];
        String? defaultNext;

        for (var edge in outgoingEdges) {
          if (edge.data['isDefault'] == true) {
            defaultNext = edge.targetNodeId;
          } else if (edge.data['condition'] != null) {
            choices.add({
              'condition': edge.data['condition'],
              'next': edge.targetNodeId,
            });
          }
        }

        stateData['choices'] = choices;
        if (defaultNext != null) {
          stateData['defaultNext'] = defaultNext;
        }
      } else {
        if (outgoingEdges.isNotEmpty) {
          stateData['next'] = outgoingEdges.first.targetNodeId;
          stateData.remove('end');
        } else {
          stateData['end'] = true;
          stateData.remove('next');
        }
      }

      states[node.id] = stateData;
    }

    // 🚩 修正 startAt（如果传入的startAt特殊节点，自动修正）
    String correctedStartAt = startAt;
    if (startAt == 'start_node') {
      final startEdge = edges.firstWhere(
        (e) => e.sourceNodeId == 'start_node',
        orElse: () =>
            throw Exception('Start node is missing an outgoing edge.'),
      );
      correctedStartAt = startEdge.targetNodeId ?? '';
    }

    return WorkflowDSL(
      comment: comment,
      version: version,
      startAt: correctedStartAt,
      states: states,
    );
  }
}
