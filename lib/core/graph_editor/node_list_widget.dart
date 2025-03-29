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
    // 过滤掉 Start / End
    final list = availableNodes.where((node) {
      return node.role != NodeRole.start && node.role != NodeRole.end;
    }).toList();

    return Container(
      width: 250,
      color: Colors.grey.shade100,
      child: ListView.separated(
        itemCount: list.length,
        separatorBuilder: (_, __) => const Divider(height: 1),
        itemBuilder: (context, index) {
          final template = list[index];
          return Draggable<NodeModel>(
            data: template,
            feedback: Material(
              color: Colors.transparent,
              child: Container(
                color: Colors.blue.withOpacity(0.7),
                padding: const EdgeInsets.all(8),
                child: Row(
                  children: [
                    const Icon(Icons.add, color: Colors.white),
                    const SizedBox(width: 8),
                    Text(
                      'Drag: ${template.title}',
                      style: const TextStyle(color: Colors.white),
                    ),
                  ],
                ),
              ),
            ),
            childWhenDragging: Container(
              color: Colors.grey.shade200,
              child: ListTile(
                leading: const Icon(Icons.add),
                title: Text('[Dragging] ${template.title}'),
              ),
            ),
            child: ListTile(
              leading: const Icon(Icons.add),
              title: Text(template.title),
            ),

            // 调试日志
            onDragStarted: () {
              debugPrint('>>> Draggable onDragStarted: ${template.title}');
            },
            onDragEnd: (details) {
              debugPrint(
                  '>>> Draggable onDragEnd: ${template.title}, offset=${details.offset}');
            },
            onDraggableCanceled: (velocity, offset) {
              debugPrint(
                  '>>> Draggable onDraggableCanceled: ${template.title}, offset=$offset');
            },
          );
        },
      ),
    );
  }
}
