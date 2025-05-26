import 'package:flow_editor/workflow/models/flow/workflow_dsl.dart';
import 'package:flow_editor/workflow/models/flow/workflow_state.dart';
import 'package:flow_editor/core/models/node_model.dart';
import 'package:flow_editor/core/models/edge_model.dart';
import 'package:flow_editor/workflow/models/states/task_state.dart';
import 'package:flow_editor/workflow/models/states/pass_state.dart';
import 'package:flow_editor/workflow/models/states/choice_state.dart';
import 'package:flow_editor/workflow/models/states/succeed_state.dart';
import 'package:flow_editor/workflow/models/states/fail_state.dart';
import 'package:flow_editor/workflow/models/states/wait_state.dart';
import 'package:flow_editor/workflow/models/logic/choice_rule.dart';
import 'package:flow_editor/workflow/models/logic/choice_logic.dart';
import 'package:collection/collection.dart';

class GraphDslConverter {
  static WorkflowDSL toDsl({
    required List<NodeModel> nodes,
    required List<EdgeModel> edges,
    required String startAt,
    String? comment,
    String version = '1.0.0',
  }) {
    final states = <String, WorkflowState>{};

    const specialNodeIds = {'start_node', 'end_node', 'group_root'};

    for (final node in nodes) {
      if (specialNodeIds.contains(node.id)) continue;

      final outgoingEdges = edges
          .where((e) =>
              e.sourceNodeId == node.id &&
              !specialNodeIds.contains(e.targetNodeId))
          .toList();

      final stateId = node.data['stateId'] as String?;
      if (stateId == null) {
        throw Exception('Node ${node.id} missing "stateId".');
      }

      final workflowState = switch (node.type) {
        'Task' => WorkflowState.task(TaskState(
            resource: node.data['resource'] ?? 'defaultResource', // 🚩改用实际数据
            next: outgoingEdges.firstOrNull?.targetNodeId,
            end: outgoingEdges.isEmpty,
          )),
        'Pass' => WorkflowState.pass(PassState(
            next: outgoingEdges.firstOrNull?.targetNodeId,
            end: outgoingEdges.isEmpty,
          )),
        'Choice' => WorkflowState.choice(ChoiceState(
            choices: outgoingEdges
                .where((e) => e.data['condition'] != null)
                .map((e) => ChoiceRule(
                      condition: ChoiceLogic.fromJson(e.data['condition']),
                      next: e.targetNodeId!,
                    ))
                .toList(),
            defaultNext: outgoingEdges
                .firstWhereOrNull((e) => e.data['isDefault'] == true)
                ?.targetNodeId,
          )),
        'Succeed' => const WorkflowState.succeed(SucceedState()),
        'Fail' => const WorkflowState.fail(FailState()),
        'Wait' => WorkflowState.wait(WaitState(
            next: outgoingEdges.firstOrNull?.targetNodeId,
            end: outgoingEdges.isEmpty,
            seconds: node.data['seconds'],
            timestamp: node.data['timestamp'],
          )),
        _ => throw Exception('Unsupported node type: ${node.type}'),
      };

      states[stateId] = workflowState;
    }

    final correctedStartAt = startAt == 'start_node'
        ? edges
            .firstWhereOrNull((e) => e.sourceNodeId == 'start_node')
            ?.targetNodeId
        : startAt;

    if (correctedStartAt == null || correctedStartAt.isEmpty) {
      throw Exception(
          'Start node is missing an outgoing edge or targetNodeId.');
    }

    return WorkflowDSL(
      comment: comment,
      version: version,
      startAt: correctedStartAt,
      states: states,
    );
  }
}
