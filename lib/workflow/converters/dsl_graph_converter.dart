import 'package:flow_editor/workflow/models/flow/workflow_dsl.dart';
import 'package:flow_editor/core/models/node_model.dart';
import 'package:flow_editor/core/models/edge_model.dart';

class DslGraphConverter {
  static Map<String, dynamic> toGraph(WorkflowDSL workflow) {
    List<NodeModel> nodes = [];
    List<EdgeModel> edges = [];

    workflow.states.forEach((id, state) {
      final type = state['type'] as String;
      nodes.add(NodeModel(id: id, type: type, data: state));

      if (type == 'Choice') {
        final choices = state['choices'] as List<dynamic>? ?? [];
        for (var choice in choices) {
          edges.add(EdgeModel.generated(
              sourceNodeId: id, targetNodeId: choice['next']));
        }
        if (state.containsKey('defaultNext')) {
          edges.add(EdgeModel.generated(
              sourceNodeId: id, targetNodeId: state['defaultNext']));
        }
      } else if (state.containsKey('next')) {
        edges.add(
            EdgeModel.generated(sourceNodeId: id, targetNodeId: state['next']));
      }
    });

    return {
      'startAt': workflow.startAt,
      'nodes': nodes,
      'edges': edges,
    };
  }
}
