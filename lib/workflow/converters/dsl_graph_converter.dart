import 'package:flow_editor/workflow/models/flow/workflow_dsl.dart';
import 'package:flow_editor/core/models/ui/node_model.dart';
import 'package:flow_editor/core/models/ui/edge_model.dart';
import 'package:flutter/material.dart';

class DslGraphConverter {
  static Map<String, dynamic> toGraph(WorkflowDSL workflow) {
    const groupId = 'group_root';

    final nodes = <NodeModel>[
      const NodeModel(
        id: groupId,
        type: 'group',
        title: 'Workflow Group',
        position: Offset.zero,
        size: Size.zero,
        isGroup: true,
      ),
      const NodeModel(
        id: 'start_node',
        type: 'start',
        title: 'Start',
        position: Offset.zero,
        size: Size(60, 30),
        parentId: groupId,
      ),
    ];

    final edges = <EdgeModel>[];

    workflow.states.forEach((id, state) {
      state.when(
        task: (task) {
          nodes.add(NodeModel(
            id: id,
            type: 'Task',
            data: {'stateId': id},
            parentId: groupId,
          ));
          if (task.next != null) {
            edges.add(EdgeModel.generated(
              sourceNodeId: id,
              targetNodeId: task.next!,
            ));
          }
        },
        pass: (pass) {
          nodes.add(NodeModel(
            id: id,
            type: 'Pass',
            data: {'stateId': id},
            parentId: groupId,
          ));
          if (pass.next != null) {
            edges.add(EdgeModel.generated(
              sourceNodeId: id,
              targetNodeId: pass.next!,
            ));
          }
        },
        choice: (choice) {
          nodes.add(NodeModel(
            id: id,
            type: 'Choice',
            data: {'stateId': id},
            parentId: groupId,
          ));
          for (final c in choice.choices) {
            edges.add(EdgeModel.generated(
              sourceNodeId: id,
              targetNodeId: c.next,
              extra: {'condition': c.condition.toJson()},
            ));
          }
          if (choice.defaultNext != null) {
            edges.add(EdgeModel.generated(
              sourceNodeId: id,
              targetNodeId: choice.defaultNext!,
              extra: {'isDefault': true},
            ));
          }
        },
        succeed: (succeed) {
          nodes.add(NodeModel(
            id: id,
            type: 'Succeed',
            data: {'stateId': id},
            parentId: groupId,
          ));
        },
        fail: (fail) {
          nodes.add(NodeModel(
            id: id,
            type: 'Fail',
            data: {'stateId': id},
            parentId: groupId,
          ));
        },
        wait: (wait) {
          nodes.add(NodeModel(
            id: id,
            type: 'Wait',
            data: {'stateId': id},
            parentId: groupId,
          ));
          if (wait.next != null) {
            edges.add(EdgeModel.generated(
              sourceNodeId: id,
              targetNodeId: wait.next!,
            ));
          }
        },
      );
    });

    edges.add(EdgeModel.generated(
      sourceNodeId: 'start_node',
      targetNodeId: workflow.startAt,
    ));

    nodes.add(const NodeModel(
      id: 'end_node',
      type: 'end',
      title: 'End',
      position: Offset.zero,
      size: Size(60, 30),
      parentId: groupId,
    ));

    workflow.states.forEach((id, state) {
      final hasNext = state.maybeWhen(
        task: (s) => s.next != null,
        pass: (s) => s.next != null,
        choice: (_) => true,
        wait: (s) => s.next != null,
        orElse: () => false,
      );

      final isEnd = state.maybeWhen(
        succeed: (_) => true,
        fail: (_) => true,
        task: (s) => s.end == true,
        pass: (s) => s.end == true,
        wait: (s) => s.end == true,
        orElse: () => false,
      );

      if (!hasNext && isEnd) {
        edges.add(EdgeModel.generated(
          sourceNodeId: id,
          targetNodeId: 'end_node',
        ));
      }
    });

    return {
      'startAt': workflow.startAt,
      'nodes': nodes,
      'edges': edges,
    };
  }
}
