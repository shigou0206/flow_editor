import 'package:flutter/material.dart';
import 'package:flow_editor/core/models/ui/node_model.dart';
import 'package:flow_editor/core/models/ui/edge_model.dart';
import 'package:flow_editor/core/models/ui/anchor_model.dart';
import 'package:flow_editor/core/models/enums/position_enum.dart';
import 'package:flow_editor/core/models/ui/canvas_insert_element.dart';
import 'package:flow_editor/ui/node/node_widget_registry_initializer.dart';

class FlowNodeSidebar extends StatelessWidget {
  const FlowNodeSidebar({super.key});

  @override
  Widget build(BuildContext context) {
    initNodeWidgetRegistry();

    final availableNodes = [
      const NodeModel(
        id: 'task_template',
        type: 'Task',
        position: Offset.zero,
        size: Size(200, 100),
        title: 'Task',
        anchors: [
          AnchorModel(
            id: 'top',
            position: Position.top,
            size: Size(10, 10),
            offset: Offset(-5, -5),
          ),
          AnchorModel(
            id: 'bottom',
            position: Position.bottom,
            size: Size(10, 10),
            offset: Offset(-5, -5),
          ),
          AnchorModel(
            id: 'left',
            position: Position.left,
            size: Size(10, 10),
            offset: Offset(-5, -5),
          ),
          AnchorModel(
            id: 'right',
            position: Position.right,
            size: Size(10, 10),
            offset: Offset(-5, -5),
          ),
        ],
      ),
      const NodeModel(
        id: 'pass_template',
        type: 'Pass',
        position: Offset.zero,
        size: Size(200, 40),
        title: 'Pass',
      ),
      const NodeModel(
        id: 'choice_template',
        type: 'Choice',
        position: Offset.zero,
        size: Size(200, 40),
        title: 'Choice',
      ),
      const NodeModel(
        id: 'succeed_template',
        type: 'Succeed',
        position: Offset.zero,
        size: Size(200, 40),
        title: 'Succeed',
      ),
      const NodeModel(
        id: 'fail_template',
        type: 'Fail',
        position: Offset.zero,
        size: Size(200, 40),
        title: 'Fail',
      ),
      const NodeModel(
        id: 'wait_template',
        type: 'Wait',
        position: Offset.zero,
        size: Size(200, 40),
        title: 'Wait',
      ),
      const NodeModel(
        id: 'parallel_template',
        type: 'Parallel',
        position: Offset.zero,
        size: Size(200, 40),
        title: 'Parallel',
      ),
      const NodeModel(
        id: 'map_template',
        type: 'Map',
        position: Offset.zero,
        size: Size(200, 40),
        title: 'Map',
      ),
    ];

    final groupDragData = CanvasInsertElement.group(
      position: Offset.zero,
      size: const Size(200, 40),
      groupNode: const NodeModel(
        id: 'group_template',
        type: 'group',
        position: Offset.zero,
        size: Size(200, 40),
        title: 'Group Node',
        isGroup: true,
      ),
      children: [
        const NodeModel(
          id: 'group_inner_node1',
          type: 'start',
          position: Offset(10, 40),
          size: Size(60, 30),
          parentId: 'group_template',
          title: 'Inner Node 1',
        ),
        const NodeModel(
          id: 'group_inner_node2',
          type: 'end',
          position: Offset(120, 40),
          size: Size(60, 30),
          parentId: 'group_template',
          title: 'Inner Node 2',
        ),
      ],
      edges: [
        EdgeModel.generated(
          sourceNodeId: 'group_inner_node1',
          targetNodeId: 'group_inner_node2',
        ),
      ],
    );

    return Container(
      width: 220,
      padding: const EdgeInsets.all(8),
      color: Theme.of(context).colorScheme.surfaceContainerHighest,
      child: ListView(
        children: [
          ...availableNodes.map((node) {
            final nodeData = CanvasInsertElement.node(
              node: node,
              position: Offset.zero,
              size: node.size,
            );

            return Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: Draggable<CanvasInsertElement>(
                data: nodeData,
                feedback: Opacity(
                  opacity: 0.7,
                  child: _buildNodePreview(node),
                ),
                childWhenDragging: Opacity(
                  opacity: 0.3,
                  child: _buildNodePreview(node),
                ),
                child: _buildNodePreview(node),
              ),
            );
          }),
          const SizedBox(height: 20),
          Draggable<CanvasInsertElement>(
            data: groupDragData,
            feedback: Opacity(
              opacity: 0.7,
              child: _buildGroupPreview(groupDragData),
            ),
            childWhenDragging: Opacity(
              opacity: 0.3,
              child: _buildGroupPreview(groupDragData),
            ),
            child: _buildGroupPreview(groupDragData),
          ),
        ],
      ),
    );
  }

  // 🚩 修改为直接展示 type name
  Widget _buildNodePreview(NodeModel node) {
    return Container(
      width: node.size.width,
      height: node.size.height,
      decoration: BoxDecoration(
        color: Colors.grey.shade300,
        borderRadius: BorderRadius.circular(4),
        border: Border.all(color: Colors.blueAccent, width: 1),
      ),
      alignment: Alignment.center,
      child: Text(
        node.type, // 直接使用 type name
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
      ),
    );
  }

  Widget _buildGroupPreview(CanvasInsertElement groupData) {
    return Container(
      width: groupData.size.width,
      height: groupData.size.height,
      decoration: BoxDecoration(
        color: Colors.grey.shade300,
        borderRadius: BorderRadius.circular(4),
        border: Border.all(color: Colors.blueAccent, width: 1),
      ),
      child: Center(
        child: Text(
          groupData.rootGroupNode?.title ?? '',
          style:
              const TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
        ),
      ),
    );
  }
}
