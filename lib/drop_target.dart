import 'package:flutter/material.dart';
import 'package:flow_editor/core/drag_drop/widgets/draggable_sidebar.dart';
import 'package:flow_editor/core/drag_drop/widgets/generic_drop_target.dart';

void main() {
  runApp(const MyApp());
}

/// 程序入口，整合侧边栏和拖拽目标（画布）
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '拖拽 Demo',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const DragDropDemoScreen(),
    );
  }
}

/// 示例页面：左右分栏，左侧为拖拽侧边栏，右侧为拖拽目标（画布）
class DragDropDemoScreen extends StatefulWidget {
  const DragDropDemoScreen({super.key});

  @override
  _DragDropDemoScreenState createState() => _DragDropDemoScreenState();
}

class _DragDropDemoScreenState extends State<DragDropDemoScreen> {
  // 用于记录画布上已放置的数据项，支持任意类型，这里以 String 为例
  final List<_PlacedItem> _placedItems = [];

  /// 拖拽释放时回调，将数据和拖拽释放的局部坐标保存下来
  void _handleDrop(String data, Offset position) {
    setState(() {
      _placedItems.add(_PlacedItem(data: data, position: position));
    });
    debugPrint('放置了 "$data" 在 $position');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('拖拽 Demo')),
      body: Row(
        children: [
          // 侧边栏（单独封装）：提供可拖拽的组件列表
          const DraggableSidebar(),
          // 画布区域：使用 GenericDropTarget 接收拖拽项
          Expanded(
            child: GenericDropTarget<String>(
              onDrop: _handleDrop,
              // 自定义拖拽状态下的外观，例如拖拽进入时背景色变浅
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
                  // 渲染所有放置到画布上的拖拽项
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

/// 辅助类，用于记录画布上放置的拖拽项信息
class _PlacedItem {
  final String data;
  final Offset position;

  _PlacedItem({required this.data, required this.position});
}
