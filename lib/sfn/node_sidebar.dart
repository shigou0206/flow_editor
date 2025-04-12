import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'models.dart';
import 'providers.dart';
import 'step_function_canvas.dart';

class NodeSidebar extends ConsumerWidget {
  const NodeSidebar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      children: [
        const SizedBox(height: 16),
        const Text(
          'Node Templates',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        // 拖拽 "Task" 节点
        Draggable<NodeModel>(
          data: NodeModel(
            id: 'task_template',
            title: 'Task',
            type: NodeType.normal,
          ),
          feedback: _dragFeedback('Task'),
          child: _sidebarItem('Task'),
        ),
        const SizedBox(height: 12),
        // 拖拽 "Choice" 节点
        Draggable<NodeModel>(
          data: NodeModel(
            id: 'choice_template',
            title: 'Choice',
            type: NodeType.choice,
          ),
          feedback: _dragFeedback('Choice'),
          child: _sidebarItem('Choice'),
        ),
        const SizedBox(height: 12),
        // Reset 按钮
        ElevatedButton(
          onPressed: () {
            // 重置为初始状态
            ref.read(nodesProvider.notifier).state = [
              NodeModel(
                id: 'start',
                title: 'Start',
                type: NodeType.normal,
                x: 200,
                y: 100,
              ),
              NodeModel(
                id: 'end',
                title: 'End',
                type: NodeType.normal,
                x: 200,
                y: 300,
              ),
            ];
            ref.read(edgesProvider.notifier).state = [
              EdgeModel(
                  id: 'edge_start_end', sourceId: 'start', targetId: 'end'),
            ];
            ref.read(nodeCounterProvider.notifier).state = 1;
            ref.read(edgeRoutesProvider.notifier).state = {};
            
            // 触发重新布局
            WidgetsBinding.instance.addPostFrameCallback((_) {
              // 查找 StepFunctionCanvas 的 State 并调用其 performLayout 方法
              final canvasState = context.findAncestorStateOfType<StepFunctionCanvasState>();
              if (canvasState != null) {
                canvasState.performLayout();
              }
            });
          },
          child: const Text('Reset'),
        ),
      ],
    );
  }

  static Widget _sidebarItem(String label) {
    return Container(
      width: 100,
      height: 40,
      alignment: Alignment.center,
      margin: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.blue.shade100,
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(label),
    );
  }

  static Widget _dragFeedback(String label) {
    return Material(
      color: Colors.transparent,
      child: Container(
        width: 100,
        height: 40,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: Colors.blue.shade300,
          borderRadius: BorderRadius.circular(4),
        ),
        child: Text(label, style: const TextStyle(color: Colors.white)),
      ),
    );
  }
}
