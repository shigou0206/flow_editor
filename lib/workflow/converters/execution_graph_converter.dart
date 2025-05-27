import 'package:flow_editor/workflow/models/execution/workflow_execution.dart';
import 'package:flow_editor/core/models/node_model.dart';
import 'dsl_graph_converter.dart';

class ExecutionGraphConverter {
  static Map<String, dynamic> toGraph(WorkflowExecution execution) {
    final baseGraph = DslGraphConverter.toGraph(execution.workflowTemplate);
    final nodes = (baseGraph['nodes'] as List<NodeModel>).map((node) {
      final execState = execution.states[node.id];
      return node.copyWith(data: {
        ...node.data,
        'executionStatus': execState?.status,
        'executionInput': execState?.input,
        'executionOutput': execState?.result,
      });
    }).toList();

    return {'nodes': nodes, 'edges': baseGraph['edges']};
  }
}
