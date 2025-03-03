import 'package:flutter/material.dart';
import '../../models/workflow_node_model.dart';
import '../../models/node_enums.dart';

/// AutomationWorkflowNodeWidget
/// 专门用于渲染AutomationWorkflowNodeModel的数据:
/// - Header: 标题 & 拖拽
/// - Body: 显示运行状态 (status)
/// - Footer: 运行/删除/取消等按钮(hover显示)
class WorkflowNodeWidget extends StatefulWidget {
  final WorkflowNodeModel node;
  final VoidCallback onDelete;
  final VoidCallback onRun;
  final VoidCallback onCancel;
  // 父组件若要管理拖拽事件:
  final void Function(DragUpdateDetails)? onDragUpdate;

  const WorkflowNodeWidget({
    super.key,
    required this.node,
    required this.onDelete,
    required this.onRun,
    required this.onCancel,
    this.onDragUpdate,
  });

  @override
  State<WorkflowNodeWidget> createState() => _WorkflowNodeWidgetState();
}

class _WorkflowNodeWidgetState extends State<WorkflowNodeWidget> {
  bool isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => isHovered = true),
      onExit: (_) => setState(() => isHovered = false),
      child: Container(
        width: widget.node.width, // 取自父类 NodeModel
        // 或者写死一个默认值
        decoration: BoxDecoration(
          color: Colors.grey.shade100,
          borderRadius: BorderRadius.circular(8),
          boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 4)],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // 1. Header
            _buildHeader(),

            // 2. Body (根据 AutomationWorkflowNodeModel 的 status 渲染)
            _buildBody(),

            // 3. Footer: hover时出现
            if (isHovered) _buildFooter(),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return GestureDetector(
      onPanUpdate: widget.onDragUpdate,
      child: Container(
        height: 34,
        padding: const EdgeInsets.symmetric(horizontal: 8),
        decoration: const BoxDecoration(
          color: Colors.blueGrey,
          borderRadius: BorderRadius.vertical(top: Radius.circular(8)),
        ),
        alignment: Alignment.centerLeft,
        child: Row(
          children: [
            Expanded(
              child: Text(
                widget.node.title, // 继承自 NodeModel
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
            // 如果需要别的图标/按钮，也可以放在右侧
          ],
        ),
      ),
    );
  }

  Widget _buildBody() {
    return Container(
      height: 60,
      margin: const EdgeInsets.symmetric(vertical: 8),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.grey.shade300),
      ),
      // 展示不同状态
      child: _buildStatusContent(widget.node.status),
    );
  }

  Widget _buildStatusContent(NodeStatus status) {
    switch (status) {
      case NodeStatus.none:
        return const Icon(Icons.hourglass_empty, size: 30, color: Colors.grey);
      case NodeStatus.running:
        return const Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
                width: 24,
                height: 24,
                child: CircularProgressIndicator(strokeWidth: 2)),
            SizedBox(width: 8),
            Text('运行中...', style: TextStyle(color: Colors.black87)),
          ],
        );
      case NodeStatus.completed:
        return const Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.check_circle, color: Colors.green, size: 28),
            SizedBox(width: 6),
            Text('完成', style: TextStyle(color: Colors.green)),
          ],
        );
      case NodeStatus.error:
        return const Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.error_outline, color: Colors.redAccent, size: 28),
            SizedBox(width: 6),
            Text('出错', style: TextStyle(color: Colors.redAccent)),
          ],
        );
    }
  }

  Widget _buildFooter() {
    return Container(
      height: 36,
      padding: const EdgeInsets.symmetric(horizontal: 8),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(8)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          IconButton(
            tooltip: '删除',
            icon: const Icon(Icons.delete, color: Colors.redAccent),
            onPressed: widget.onDelete,
          ),
          IconButton(
            tooltip: '运行',
            icon: const Icon(Icons.play_arrow, color: Colors.green),
            onPressed: widget.onRun,
          ),
          IconButton(
            tooltip: '取消运行',
            icon: const Icon(Icons.close, color: Colors.orange),
            onPressed: widget.onCancel,
          ),
        ],
      ),
    );
  }
}
