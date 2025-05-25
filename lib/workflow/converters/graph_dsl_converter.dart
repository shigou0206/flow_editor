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
      var stateData = Map<String, dynamic>.from(node.data);
      stateData.remove('id');

      final outgoingEdges =
          edges.where((e) => e.sourceNodeId == node.id).toList();

      if (node.type != 'Choice') {
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
