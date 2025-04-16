// lib/flow_editor/core/drag_drop/widgets/draggable_sidebar.dart
import 'package:flutter/material.dart';

class DraggableSidebar extends StatelessWidget {
  const DraggableSidebar({super.key});

  @override
  Widget build(BuildContext context) {
    // 示例：侧边栏展示两个拖拽项
    return Container(
      width: 150,
      color: Colors.grey[200],
      child: ListView(
        padding: const EdgeInsets.all(8),
        children: [
          _buildDraggableItem(context, '组件 A', Colors.blue),
          const SizedBox(height: 10),
          _buildDraggableItem(context, '组件 B', Colors.green),
        ],
      ),
    );
  }

  Widget _buildDraggableItem(BuildContext context, String label, Color color) {
    return Draggable<String>(
      data: label,
      feedback: Material(
        // 用 Material 包裹 feedback 确保视觉一致性
        elevation: 4.0,
        child: Container(
          padding: const EdgeInsets.all(8),
          color: color,
          child: Text(
            label,
            style: const TextStyle(color: Colors.white),
          ),
        ),
      ),
      childWhenDragging: Opacity(
        opacity: 0.5,
        child: Container(
          padding: const EdgeInsets.all(8),
          color: color,
          child: Text(
            label,
            style: const TextStyle(color: Colors.white),
          ),
        ),
      ),
      child: Container(
        padding: const EdgeInsets.all(8),
        color: color,
        child: Text(
          label,
          style: const TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
