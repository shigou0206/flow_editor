// lib/flow_editor/core/drag_drop/drag_drop_screen.dart
import 'package:flutter/material.dart';
import 'widgets/draggable_sidebar.dart';
import 'widgets/generic_drop_target.dart';

class DragDropScreen extends StatefulWidget {
  const DragDropScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _DragDropScreenState createState() => _DragDropScreenState();
}

class _DragDropScreenState extends State<DragDropScreen> {
  // 存储画布上已放置的数据项信息
  final List<_PlacedItem> _placedItems = [];

  void _handleDrop(String data, Offset position) {
    setState(() {
      _placedItems.add(_PlacedItem(data: data, position: position));
    });
    debugPrint('放置了 "$data" 在 $position');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('拖拽功能示例')),
      body: Row(
        children: [
          // 侧边栏（独立封装）
          const DraggableSidebar(),
          // 画布区域，使用通用拖拽目标接受拖拽项
          Expanded(
            child: GenericDropTarget<String>(
              onDrop: _handleDrop,
              onWillAccept: (data) => data != null && data.isNotEmpty,
              // 当拖拽项进入时可自定义目标区域的外观
              builder: (context, isDraggingOver, child) {
                return Container(
                  color: isDraggingOver ? Colors.grey[300] : Colors.white,
                  child: child,
                );
              },
              child: Stack(
                children: [
                  // 画布背景
                  Positioned.fill(
                    child: Container(color: Colors.white),
                  ),
                  // 渲染所有放置到画布上的项
                  for (final item in _placedItems)
                    Positioned(
                      left: item.position.dx,
                      top: item.position.dy,
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        color: Colors.orangeAccent,
                        child: Text(item.data),
                      ),
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// 辅助类，用于记录拖拽放置的项数据
class _PlacedItem {
  final String data;
  final Offset position;

  _PlacedItem({required this.data, required this.position});
}
