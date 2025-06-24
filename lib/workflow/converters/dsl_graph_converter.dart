// lib/workflow/converters/dsl_graph_converter.dart

import 'package:flutter/material.dart';
import 'package:flow_editor/workflow/models/dsl/flow/workflow_dsl.dart';
import 'package:flow_editor/core/models/ui/node_model.dart';
import 'package:flow_editor/core/models/ui/edge_model.dart';

class DslGraphConverter {
  static const groupId = 'group_root';
  static const startNodeId = 'start_node';
  static const endNodeId = 'end_node';

  /// 将 DSL 转为节点和边，用于前端渲染
  static Map<String, dynamic> toGraph(WorkflowDSL workflow) {
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
        id: startNodeId,
        type: 'start',
        title: 'Start',
        position: Offset.zero,
        size: Size(60, 30),
        parentId: groupId,
      ),
      const NodeModel(
        id: endNodeId,
        type: 'end',
        title: 'End',
        position: Offset.zero,
        size: Size(60, 30),
        parentId: groupId,
      ),
    ];

    final edges = <EdgeModel>[];

    // 添加每个 DSL 状态作为节点
    workflow.states.forEach((stateId, state) {
      final stateJson = state.toJson();
      final type = stateJson['type'] as String;

      // ✅ 构造节点（无 data，title 为 stateId）
      nodes.add(NodeModel(
        id: _generateNodeId(stateId),
        type: type,
        title: stateId,
        parentId: groupId,
      ));

      // ✅ 添加状态间的连线逻辑
      state.when(
        task: (t) => _addEdgeIfNextExists(edges, stateId, t.next),
        pass: (p) => _addEdgeIfNextExists(edges, stateId, p.next),
        wait: (w) => _addEdgeIfNextExists(edges, stateId, w.next),
        choice: (c) {
          for (final rule in c.choices) {
            edges.add(EdgeModel.generated(
              sourceNodeId: stateId,
              targetNodeId: rule.next,
              extra: {'condition': rule.condition.toJson()},
            ));
          }
          if (c.defaultNext != null) {
            edges.add(EdgeModel.generated(
              sourceNodeId: stateId,
              targetNodeId: c.defaultNext!,
              extra: {'isDefault': true},
            ));
          }
        },
        succeed: (_) {},
        fail: (_) {},
      );
    });

    // 起点连线
    edges.add(EdgeModel.generated(
      sourceNodeId: startNodeId,
      targetNodeId: workflow.startAt,
    ));

    // 自动补连 end_node
    workflow.states.forEach((stateId, state) {
      final hasNext = state.maybeWhen(
        task: (t) => t.next != null,
        pass: (p) => p.next != null,
        wait: (w) => w.next != null,
        choice: (_) => true,
        orElse: () => false,
      );
      final isEnd = state.maybeWhen(
        succeed: (_) => true,
        fail: (_) => true,
        task: (t) => t.end == true,
        pass: (p) => p.end == true,
        wait: (w) => w.end == true,
        orElse: () => false,
      );
      if (isEnd && !hasNext) {
        edges.add(EdgeModel.generated(
          sourceNodeId: stateId,
          targetNodeId: endNodeId,
        ));
      }
    });

    return {
      'startAt': workflow.startAt,
      'nodes': nodes,
      'edges': edges,
    };
  }

  static void _addEdgeIfNextExists(
    List<EdgeModel> edges,
    String from,
    String? next,
  ) {
    if (next != null && next.isNotEmpty) {
      edges.add(EdgeModel.generated(
        sourceNodeId: from,
        targetNodeId: next,
      ));
    }
  }

  /// 可选：如需为 UI 生成唯一 ID，可用这个函数（目前直接用 stateId）
  static String _generateNodeId(String stateId) => stateId;
}
