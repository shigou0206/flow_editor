// lib/flow_editor/core/graph_editor/graph_editor_sidebar.dart
import 'package:flutter/material.dart';
import 'package:flow_editor/core/node/models/node_model.dart';

class GraphEditorSidebar extends StatelessWidget {
  final List<NodeModel> availableNodes;
  final bool isCollapsed;

  const GraphEditorSidebar({
    super.key,
    required this.availableNodes,
    this.isCollapsed = false,
  });

  /// 当侧边栏折叠时，仅展示图标
  factory GraphEditorSidebar.collapsed(
      {required List<NodeModel> availableNodes}) {
    return GraphEditorSidebar(
      availableNodes: availableNodes,
      isCollapsed: true,
    );
  }

  @override
  Widget build(BuildContext context) {
    return isCollapsed
        ? _buildCollapsedList(context)
        : _buildExpandedList(context);
  }

  Widget _buildCollapsedList(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(8),
      itemCount: availableNodes.length,
      itemBuilder: (context, index) {
        final template = availableNodes[index];
        // 这里只展示简单图标，利用 Draggable 将 NodeModel 数据传出
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Draggable<NodeModel>(
            data: template,
            feedback: Material(
              color: Colors.transparent,
              child: Container(
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  color: Colors.blue.withOpacity(0.8),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: const Icon(Icons.widgets, size: 16, color: Colors.white),
              ),
            ),
            childWhenDragging: Opacity(
              opacity: 0.5,
              child: _buildIconItem(),
            ),
            child: _buildIconItem(),
          ),
        );
      },
    );
  }

  Widget _buildIconItem() {
    return Container(
      padding: const EdgeInsets.all(6),
      decoration: BoxDecoration(
        color: Colors.blue.shade200,
        borderRadius: BorderRadius.circular(4),
      ),
      child: const Icon(Icons.widgets, size: 16, color: Colors.white),
    );
  }

  /// 展开状态直接使用完整列表组件，由上层传入或内部实现
  Widget _buildExpandedList(BuildContext context) {
    // 此处你可以直接使用已有的 NodeListWidget，也可以自定义
    // 这里只是占位返回一个 Container
    return Container(
      alignment: Alignment.center,
      child: const Text('Expanded Node List'),
    );
  }
}
