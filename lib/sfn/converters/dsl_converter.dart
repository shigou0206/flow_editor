import 'dart:convert';
import '../models.dart';

class DslConverter {
  /// 将节点和边转换为 DSL 定义
  static String convertToDsl(List<NodeModel> nodes, List<EdgeModel> edges) {
    // 创建 DSL 结构
    final Map<String, dynamic> dsl = {
      'version': '1.0',
      'type': 'workflow',
      'start': _findStartNode(nodes).id,
      'states': {},
    };

    // 为每个节点创建状态定义
    for (final node in nodes) {
      dsl['states'][node.id] = _createStateForNode(node, edges);
    }

    return jsonEncode(dsl);
  }

  /// 从 DSL 定义解析为节点和边
  static (List<NodeModel>, List<EdgeModel>) parseFromDsl(String dslJson) {
    final dsl = jsonDecode(dslJson);
    final List<NodeModel> nodes = [];
    final List<EdgeModel> edges = [];

    // 解析版本和类型
    final version = dsl['version'];
    final type = dsl['type'];

    // 找到起始节点
    final startNodeId = dsl['start'];

    // 解析所有状态
    final states = dsl['states'] as Map<String, dynamic>;

    // 节点位置计算辅助变量
    int row = 0;
    int col = 0;

    // 创建起始节点
    if (startNodeId.isNotEmpty) {
      nodes.add(NodeModel(
        id: 'start',
        type: 'start',
        title: 'Start',
        x: 150.0,
        y: 100.0,
        width: 100.0,
        height: 60.0,
      ));

      // 创建从起始节点到第一个状态的边
      edges.add(EdgeModel(
        id: 'edge_start_${startNodeId}',
        sourceId: 'start',
        targetId: startNodeId,
      ));
    }

    // 处理每个状态
    states.forEach((nodeId, stateConfig) {
      // 计算节点位置
      final x = 150.0 + col * 200.0;
      final y = 200.0 + row * 150.0;

      // 创建节点
      final node = _createNodeFromState(nodeId, stateConfig, x, y);
      nodes.add(node);

      // 处理转换
      final transitions = _getTransitionsFromState(stateConfig);
      for (final transition in transitions.entries) {
        final targetId = transition.value;
        edges.add(EdgeModel(
          id: 'edge_${nodeId}_${targetId}',
          sourceId: nodeId,
          targetId: targetId,
        ));
      }

      // 更新位置计算
      col++;
      if (col > 2) {
        col = 0;
        row++;
      }
    });

    return (nodes, edges);
  }

  /// 查找起始节点
  static NodeModel _findStartNode(List<NodeModel> nodes) {
    return nodes.firstWhere(
      (node) => node.type == 'start',
      orElse: () => nodes.isEmpty ? nodes.first : nodes.first,
    );
  }

  /// 为节点创建状态定义
  static Map<String, dynamic> _createStateForNode(
      NodeModel node, List<EdgeModel> edges) {
    // 基于节点类型创建不同的状态定义
    switch (node.type) {
      case 'task':
        return {
          'Type': 'Task',
          'Resource': node.data['resource'] ?? '',
          'Next': _findNextNodeId(node.id, edges),
        };

      case 'choice':
        return {
          'Type': 'Choice',
          'Choices': _createChoicesFromNode(node, edges),
          'Default': _findDefaultNextNodeId(node.id, edges),
        };

      case 'wait':
        return {
          'Type': 'Wait',
          'Seconds': node.data['seconds'] ?? 60,
          'Next': _findNextNodeId(node.id, edges),
        };

      case 'parallel':
        return {
          'Type': 'Parallel',
          'Branches': _createBranchesFromNode(node, edges),
          'Next': _findNextNodeId(node.id, edges),
        };

      case 'end':
        return {
          'Type': 'Succeed',
        };

      case 'fail':
        return {
          'Type': 'Fail',
          'Error': node.data['error'] ?? 'DefaultError',
          'Cause': node.data['cause'] ?? 'Unknown error',
        };

      default:
        return {
          'Type': 'Pass',
          'Next': _findNextNodeId(node.id, edges),
        };
    }
  }

  /// 查找节点的下一个节点ID
  static String _findNextNodeId(String sourceId, List<EdgeModel> edges) {
    final edge = edges.firstWhere(
      (e) => e.sourceId == sourceId,
      orElse: () => EdgeModel(id: '', sourceId: '', targetId: ''),
    );
    return edge.targetId ?? '';
  }

  /// 查找默认的下一个节点ID（用于Choice节点）
  static String _findDefaultNextNodeId(String sourceId, List<EdgeModel> edges) {
    // 在实际应用中，您需要区分默认边和条件边
    // 这里简化处理，假设最后一条边是默认边
    final sourceEdges = edges.where((e) => e.sourceId == sourceId).toList();
    if (sourceEdges.isEmpty) return '';
    return sourceEdges.last.targetId ?? '';
  }

  /// 从Choice节点创建选择条件
  static List<Map<String, dynamic>> _createChoicesFromNode(
      NodeModel node, List<EdgeModel> edges) {
    // 在实际应用中，您需要从节点数据中提取条件
    // 这里简化处理，创建一些示例条件
    final choices = <Map<String, dynamic>>[];
    final sourceEdges = edges.where((e) => e.sourceId == node.id).toList();

    for (int i = 0; i < sourceEdges.length - 1; i++) {
      choices.add({
        'Variable': r'$.condition',
        'StringEquals': 'option${i + 1}',
        'Next': sourceEdges[i].targetId,
      });
    }

    return choices;
  }

  /// 从Parallel节点创建分支
  static List<Map<String, dynamic>> _createBranchesFromNode(
      NodeModel node, List<EdgeModel> edges) {
    // 在实际应用中，您需要从节点数据中提取分支信息
    // 这里简化处理，创建一些示例分支
    final branches = <Map<String, dynamic>>[];
    final sourceEdges = edges.where((e) => e.sourceId == node.id).toList();

    for (final edge in sourceEdges) {
      branches.add({
        'StartAt': edge.targetId ?? '',
        'States': {
          // 简化处理，实际应用中需要递归构建分支状态
          edge.targetId ?? '': {
            'Type': 'Pass',
            'End': true,
          },
        },
      });
    }

    return branches;
  }

  /// 从状态定义创建节点
  static NodeModel _createNodeFromState(
      String nodeId, Map<String, dynamic> stateConfig, double x, double y) {
    final type = stateConfig['Type']?.toLowerCase() ?? 'pass';

    switch (type) {
      case 'task':
        return NodeModel(
          id: nodeId,
          type: 'task',
          title: 'Task: $nodeId',
          x: x,
          y: y,
          width: 120.0,
          height: 80.0,
          data: {
            'resource': stateConfig['Resource'] ?? '',
          },
        );

      case 'choice':
        return NodeModel(
          id: nodeId,
          type: 'choice',
          title: 'Choice: $nodeId',
          x: x,
          y: y,
          width: 120.0,
          height: 80.0,
        );

      case 'wait':
        return NodeModel(
          id: nodeId,
          type: 'wait',
          title: 'Wait: $nodeId',
          x: x,
          y: y,
          width: 120.0,
          height: 80.0,
          data: {
            'seconds': stateConfig['Seconds'] ?? 60,
          },
        );

      case 'parallel':
        return NodeModel(
          id: nodeId,
          type: 'parallel',
          title: 'Parallel: $nodeId',
          x: x,
          y: y,
          width: 120.0,
          height: 80.0,
        );

      case 'succeed':
        return NodeModel(
          id: nodeId,
          type: 'end',
          title: 'Succeed',
          x: x,
          y: y,
          width: 100.0,
          height: 60.0,
        );

      case 'fail':
        return NodeModel(
          id: nodeId,
          type: 'fail',
          title: 'Fail: $nodeId',
          x: x,
          y: y,
          width: 100.0,
          height: 60.0,
          data: {
            'error': stateConfig['Error'] ?? 'DefaultError',
            'cause': stateConfig['Cause'] ?? 'Unknown error',
          },
        );

      default:
        return NodeModel(
          id: nodeId,
          type: 'pass',
          title: 'Pass: $nodeId',
          x: x,
          y: y,
          width: 100.0,
          height: 60.0,
        );
    }
  }

  /// 从状态定义获取转换
  static Map<String, String> _getTransitionsFromState(
      Map<String, dynamic> stateConfig) {
    final transitions = <String, String>{};

    // 处理 Next 字段
    if (stateConfig.containsKey('Next')) {
      transitions['next'] = stateConfig['Next'];
    }

    // 处理 Choices 字段
    if (stateConfig.containsKey('Choices')) {
      final choices = stateConfig['Choices'] as List;
      for (int i = 0; i < choices.length; i++) {
        final choice = choices[i];
        if (choice.containsKey('Next')) {
          transitions['choice_$i'] = choice['Next'];
        }
      }
    }

    // 处理 Default 字段
    if (stateConfig.containsKey('Default')) {
      transitions['default'] = stateConfig['Default'];
    }

    return transitions;
  }
}
