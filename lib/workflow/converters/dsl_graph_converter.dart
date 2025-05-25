import 'package:flow_editor/workflow/models/flow/workflow_dsl.dart';
import 'package:flow_editor/core/models/node_model.dart';
import 'package:flow_editor/core/models/edge_model.dart';
import 'package:flutter/material.dart';

class DslGraphConverter {
  static Map<String, dynamic> toGraph(WorkflowDSL workflow) {
    const String groupId = 'group_root';

    // 🚩 创建统一的 Group 节点
    const NodeModel groupNode = NodeModel(
      id: groupId,
      type: 'group',
      title: 'Workflow Group',
      position: Offset.zero,
      size: Size.zero,
      isGroup: true,
    );

    final List<NodeModel> nodes = [groupNode]; // 加入group节点
    final List<EdgeModel> edges = [];

    // 🚩 添加 Start 节点并放入 group
    const NodeModel startNode = NodeModel(
      id: 'start_node',
      type: 'start',
      title: 'Start',
      position: Offset.zero,
      size: Size(60, 30),
      parentId: groupId,
    );
    nodes.add(startNode);

    // 🚩 转换 DSL 状态节点，并全部放入 group
    workflow.states.forEach((id, state) {
      final type = state['type'] as String;
      nodes.add(NodeModel(
        id: id,
        type: type,
        data: state,
        parentId: groupId,
      ));

      if (type == 'Choice') {
        final choices = state['choices'] as List<dynamic>? ?? [];

        for (var choice in choices) {
          edges.add(EdgeModel.generated(
            sourceNodeId: id,
            targetNodeId: choice['next'],
            extra: {
              'condition': choice['condition'], // 条件信息
            },
          ));
        }

        if (state.containsKey('defaultNext')) {
          edges.add(EdgeModel.generated(
            sourceNodeId: id,
            targetNodeId: state['defaultNext'],
            extra: {'isDefault': true}, // 默认路径
          ));
        }
      } else if (state.containsKey('next')) {
        edges.add(EdgeModel.generated(
          sourceNodeId: id,
          targetNodeId: state['next'],
        ));
      }
    });

    // 🚩 从 Start 节点连接到第一个状态节点 (startAt)
    edges.add(EdgeModel.generated(
      sourceNodeId: 'start_node',
      targetNodeId: workflow.startAt,
    ));

    // 🚩 添加统一 End 节点并放入 group
    const NodeModel endNode = NodeModel(
      id: 'end_node',
      type: 'end',
      title: 'End',
      position: Offset.zero,
      size: Size(60, 30),
      parentId: groupId,
    );
    nodes.add(endNode);

    // 🚩 所有终止状态 (end=true) 连接到统一的 End 节点
    workflow.states.forEach((id, state) {
      final hasNext = state.containsKey('next');
      final isEnd = state['end'] == true;

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
