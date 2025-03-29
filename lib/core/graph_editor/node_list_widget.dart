import 'package:flutter/material.dart';
import 'package:flow_editor/core/node/models/node_model.dart';
import 'package:flow_editor/core/node/models/node_enums.dart';

class NodeListWidget extends StatelessWidget {
  final List<NodeModel> availableNodes;
  final ValueChanged<NodeModel> onDragCompleted;

  const NodeListWidget({
    super.key,
    required this.availableNodes,
    required this.onDragCompleted,
  });

  @override
  Widget build(BuildContext context) {
    // 过滤掉 Start 和 End 节点
    final list = availableNodes
        .where(
            (node) => node.role != NodeRole.start && node.role != NodeRole.end)
        .toList();
    return Container(
      width: 250,
      color: Colors.grey.shade100,
      child: ListView.separated(
        itemCount: list.length,
        separatorBuilder: (_, __) => const Divider(height: 1),
        itemBuilder: (context, index) {
          final nodeTemplate = list[index];
          return Draggable<NodeModel>(
            data: nodeTemplate,
            feedback: Opacity(
              opacity: 0.7,
              child: ListTile(
                leading: _buildNodeIcon(nodeTemplate),
                title: Text(nodeTemplate.title),
              ),
            ),
            childWhenDragging: Container(
              color: Colors.grey.shade200,
              child: ListTile(
                leading: _buildNodeIcon(nodeTemplate),
                title: Text(nodeTemplate.title),
              ),
            ),
            child: ListTile(
              leading: _buildNodeIcon(nodeTemplate),
              title: Text(nodeTemplate.title),
            ),
            // 注意：真正添加节点的逻辑放在 DragTarget 中实现，
            // 此处 onDragCompleted 仅作回调提示（也可不使用）
            onDragEnd: (details) {
              onDragCompleted(nodeTemplate);
            },
          );
        },
      ),
    );
  }

  Widget _buildNodeIcon(NodeModel node) {
    // 根据节点类型简单返回一个 Icon
    // 这里仅示例 task 类型；实际可根据你的需求扩展
    switch (node.role) {
      case NodeRole.middle:
        return const Icon(Icons.task, color: Colors.blue);
      case NodeRole.custom:
        return const Icon(Icons.call_split, color: Colors.purple);
      case NodeRole.placeholder:
        return const Icon(Icons.hourglass_empty, color: Colors.orange);
      default:
        return const Icon(Icons.description, color: Colors.grey);
    }
  }
}
