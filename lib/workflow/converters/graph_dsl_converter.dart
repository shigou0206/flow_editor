// lib/workflow/converters/graph_dsl_converter.dart

import 'package:collection/collection.dart';
import 'package:flow_editor/workflow/models/flow/workflow_dsl.dart';
import 'package:flow_editor/workflow/models/flow/workflow_state.dart';
import 'package:flow_editor/core/models/ui/node_model.dart';
import 'package:flow_editor/core/models/ui/edge_model.dart';
import 'package:flow_editor/workflow/models/logic/choice_rule.dart';
import 'package:flow_editor/workflow/models/logic/choice_logic.dart';

class GraphDslConverter {
  static WorkflowDSL toDsl({
    required WorkflowDSL original,
    required List<NodeModel> nodes,
    required List<EdgeModel> edges,
    required String startAt,
    String? comment,
    String? version,
  }) {
    final outComment = comment ?? original.comment;
    final outVersion = version ?? original.version;

    const special = {'start_node', 'end_node', 'group_root'};

    final Map<String, WorkflowState> newStates = {};

    for (final node in nodes) {
      if (special.contains(node.id)) continue;

      final stateId = node.data['stateId'] as String;
      final origState = original.states[stateId]!;

      final outgoing = edges
          .where((e) =>
              e.sourceNodeId == node.id && !special.contains(e.targetNodeId))
          .toList();

      final singleNext = outgoing.firstOrNull?.targetNodeId;

      final defaultEdge = outgoing
          .firstWhereOrNull((e) => e.data['isDefault'] == true)
          ?.targetNodeId;
      final choiceEdges = outgoing.where((e) => e.data['condition'] != null);

      final rebuilt = origState.map(
        task: (tw) => WorkflowState.task(tw.task.copyWith(
          next: singleNext ?? tw.task.next,
          end: tw.task.end,
        )),
        pass: (pw) => WorkflowState.pass(pw.pass.copyWith(
          next: singleNext ?? pw.pass.next,
          end: pw.pass.end,
        )),
        wait: (ww) => WorkflowState.wait(ww.wait.copyWith(
          next: singleNext ?? ww.wait.next,
          end: ww.wait.end,
        )),
        succeed: (sw) => WorkflowState.succeed(sw.succeed.copyWith(
          end: sw.succeed.end,
        )),
        fail: (fw) => WorkflowState.fail(fw.fail.copyWith(
          next: fw.fail.next,
          end: fw.fail.end,
        )),
        choice: (cw) {
          final cs = cw.choice;
          final newChoices = choiceEdges.map((e) {
            final raw = e.data['condition'];
            final parsed = (raw is Map<String, dynamic>)
                ? raw
                : Map<String, dynamic>.from(raw as Map);
            return ChoiceRule(
              condition: ChoiceLogic.fromJson(parsed),
              next: e.targetNodeId!,
            );
          }).toList();

          return WorkflowState.choice(cs.copyWith(
            choices: newChoices.isNotEmpty ? newChoices : cs.choices,
            defaultNext: defaultEdge ?? cs.defaultNext,
            next: cs.next,
            end: cs.end,
          ));
        },
      );

      newStates[stateId] = rebuilt;
    }

    final correctedStartAt = (startAt == 'start_node')
        ? edges
            .firstWhereOrNull((e) => e.sourceNodeId == 'start_node')
            ?.targetNodeId
        : startAt;

    return WorkflowDSL(
      comment: outComment,
      version: outVersion,
      startAt: correctedStartAt ?? original.startAt,
      states: newStates,
    );
  }
}
