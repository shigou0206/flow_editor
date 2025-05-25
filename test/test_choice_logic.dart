import 'package:flow_editor/workflow/models/flow/workflow_dsl.dart';
import 'package:flow_editor/workflow/converters/dsl_graph_converter.dart';
import 'package:flow_editor/workflow/converters/graph_dsl_converter.dart';

void main() {
  final originalDsl = WorkflowDSL.fromJson({
    'startAt': 'EvaluateScore',
    'states': {
      'EvaluateScore': {
        'type': 'Choice',
        'choices': [
          {
            'condition': {
              'variable': '\$.score',
              'operator': 'GreaterThan',
              'value': 90
            },
            'next': 'HighScore'
          }
        ],
        'defaultNext': 'LowScore'
      },
      'HighScore': {'type': 'Succeed'},
      'LowScore': {'type': 'Fail'}
    }
  });

  final graph = DslGraphConverter.toGraph(originalDsl);
  final restoredDsl = GraphDslConverter.toDsl(
    nodes: graph['nodes'],
    edges: graph['edges'],
    startAt: originalDsl.startAt,
  );

  print('Original DSL:\n${originalDsl.toJson()}');
  print('Restored DSL:\n${restoredDsl.toJson()}');
}
