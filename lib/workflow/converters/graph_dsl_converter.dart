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

    for (var node in nodes) {
      final stateData = Map<String, dynamic>.from(node.data);
      stateData.remove('id');

      final outgoingEdges =
          edges.where((e) => e.sourceNodeId == node.id).toList();

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

    return WorkflowDSL(
      comment: comment,
      version: version,
      startAt: startAt,
      states: states,
    );
  }
}
