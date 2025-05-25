// import 'package:flutter/material.dart';
// import 'package:flow_editor/core/models/node_model.dart';
// import 'package:flow_editor/core/models/edge_model.dart';
// import 'package:flow_editor/ui/node/factories/node_widget_factory_impl.dart';
// import 'package:flow_editor/ui/node/node_widget_registry_initializer.dart';

// class SubgraphDragData {
//   final List<NodeModel> nodes;
//   final List<EdgeModel> edges;

//   SubgraphDragData({required this.nodes, required this.edges});
// }

// class FlowNodeSidebar extends StatelessWidget {
//   const FlowNodeSidebar({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final registry = initNodeWidgetRegistry();
//     final nodeFactory = NodeWidgetFactoryImpl(registry: registry);

//     final availableNodes = [
//       // const NodeModel(
//       //   id: 'start_template',
//       //   type: 'start',
//       //   position: Offset.zero,
//       //   size: Size(200, 40),
//       //   title: 'Start',
//       // ),
//       // const NodeModel(
//       //   id: 'end_template',
//       //   type: 'end',
//       //   position: Offset.zero,
//       //   size: Size(200, 40),
//       //   title: 'End',
//       // ),
//       const NodeModel(
//         id: 'placeholder_template',
//         type: 'placeholder',
//         position: Offset.zero,
//         size: Size(200, 40),
//         title: 'Placeholder',
//       ),
//       const NodeModel(
//         id: 'middle_template',
//         type: 'middle',
//         position: Offset.zero,
//         size: Size(200, 40),
//         title: 'Middle',
//       ),
//     ];

//     final groupDragData = SubgraphDragData(
//       nodes: [
//         const NodeModel(
//           id: 'group_template',
//           type: 'group',
//           position: Offset(0, 0),
//           size: Size(200, 40),
//           title: 'Group Node',
//         ),
//         const NodeModel(
//           id: 'group_inner_node1',
//           type: 'middle',
//           position: Offset(10, 40),
//           size: Size(200, 40),
//           parentId: 'group_template',
//           title: 'Inner Node 1',
//         ),
//         const NodeModel(
//           id: 'group_inner_node2',
//           type: 'middle',
//           position: Offset(120, 40),
//           size: Size(200, 40),
//           parentId: 'group_template',
//           title: 'Inner Node 2',
//         ),
//       ],
//       edges: [
//         EdgeModel.generated(
//           sourceNodeId: 'group_inner_node1',
//           targetNodeId: 'group_inner_node2',
//         ),
//       ],
//     );

//     return Container(
//       width: 220,
//       padding: const EdgeInsets.all(8),
//       color: Theme.of(context).colorScheme.surfaceContainerHighest,
//       child: ListView(
//         children: [
//           // 单个节点拖拽
//           ...availableNodes.map(
//             (node) => Draggable<NodeModel>(
//               data: node,
//               feedback: Opacity(
//                 opacity: 0.7,
//                 child: SizedBox(
//                   width: node.size.width,
//                   height: node.size.height,
//                   child: nodeFactory.createNodeWidget(node),
//                 ),
//               ),
//               childWhenDragging: Opacity(
//                 opacity: 0.3,
//                 child: nodeFactory.createNodeWidget(node),
//               ),
//               child: nodeFactory.createNodeWidget(node),
//             ),
//           ),

//           const SizedBox(height: 20),

//           // 拖拽子图（包含Group和两个内部节点）
//           Draggable<SubgraphDragData>(
//             data: groupDragData,
//             feedback: Opacity(
//               opacity: 0.7,
//               child: Container(
//                 width: groupDragData.nodes.first.size.width,
//                 height: groupDragData.nodes.first.size.height,
//                 decoration: BoxDecoration(
//                   color: Colors.grey.shade300,
//                   borderRadius: BorderRadius.circular(4),
//                   border: Border.all(color: Colors.blueAccent, width: 1),
//                 ),
//                 child: Center(
//                   child: Text(
//                     groupDragData.nodes.first.title ?? '',
//                     style: const TextStyle(fontWeight: FontWeight.bold),
//                   ),
//                 ),
//               ),
//             ),
//             childWhenDragging: Opacity(
//               opacity: 0.3,
//               child: Container(
//                 padding: const EdgeInsets.all(8),
//                 decoration: BoxDecoration(
//                   color: Colors.grey.shade300,
//                   borderRadius: BorderRadius.circular(4),
//                   border: Border.all(color: Colors.blueAccent, width: 1),
//                 ),
//                 child: Center(
//                   child: Text(groupDragData.nodes.first.title ?? ''),
//                 ),
//               ),
//             ),
//             child: Container(
//               padding: const EdgeInsets.all(8),
//               decoration: BoxDecoration(
//                 color: Colors.grey.shade300,
//                 borderRadius: BorderRadius.circular(4),
//                 border: Border.all(color: Colors.blueAccent, width: 1),
//               ),
//               child: Center(
//                 child: Text(groupDragData.nodes.first.title ?? ''),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flow_editor/core/models/node_model.dart';
import 'package:flow_editor/core/models/edge_model.dart';
import 'package:flow_editor/core/models/canvas_insert_element.dart';
import 'package:flow_editor/ui/node/factories/node_widget_factory_impl.dart';
import 'package:flow_editor/ui/node/node_widget_registry_initializer.dart';

class FlowNodeSidebar extends StatelessWidget {
  const FlowNodeSidebar({super.key});

  @override
  Widget build(BuildContext context) {
    final registry = initNodeWidgetRegistry();
    final nodeFactory = NodeWidgetFactoryImpl(registry: registry);

    final availableNodes = [
      const NodeModel(
        id: 'placeholder_template',
        type: 'placeholder',
        position: Offset.zero,
        size: Size(200, 40),
        title: 'Placeholder',
      ),
      const NodeModel(
        id: 'middle_template',
        type: 'middle',
        position: Offset.zero,
        size: Size(200, 40),
        title: 'Middle',
      ),
    ];

    final groupDragData = CanvasInsertElement.group(
      position: Offset.zero,
      size: const Size(200, 40), // 明确指定group的尺寸
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
          type: 'middle',
          position: Offset(10, 40),
          size: Size(200, 40),
          parentId: 'group_template',
          title: 'Inner Node 1',
        ),
        const NodeModel(
          id: 'group_inner_node2',
          type: 'middle',
          position: Offset(120, 40),
          size: Size(200, 40),
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
          // ✅ 单个节点拖拽（修正为使用CanvasInsertElement）
          ...availableNodes.map(
            (node) {
              final nodeData = CanvasInsertElement.node(
                node: node,
                position: Offset.zero,
                size: node.size, // 显式指定大小
              );

              return Draggable<CanvasInsertElement>(
                data: nodeData,
                feedback: Opacity(
                  opacity: 0.7,
                  child: SizedBox(
                    width: nodeData.size.width,
                    height: nodeData.size.height,
                    child: nodeFactory.createNodeWidget(node),
                  ),
                ),
                childWhenDragging: Opacity(
                  opacity: 0.3,
                  child: nodeFactory.createNodeWidget(node),
                ),
                child: nodeFactory.createNodeWidget(node),
              );
            },
          ),

          const SizedBox(height: 20),

          // ✅ 拖拽子图（使用group模式）
          Draggable<CanvasInsertElement>(
            data: groupDragData,
            feedback: Opacity(
              opacity: 0.7,
              child: Container(
                width: groupDragData.size.width,
                height: groupDragData.size.height,
                decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(4),
                  border: Border.all(color: Colors.blueAccent, width: 1),
                ),
                child: Center(
                  child: Text(
                    groupDragData.rootGroupNode?.title ?? '',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
            childWhenDragging: Opacity(
              opacity: 0.3,
              child: Container(
                width: groupDragData.size.width,
                height: groupDragData.size.height,
                decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(4),
                  border: Border.all(color: Colors.blueAccent, width: 1),
                ),
                child: Center(
                  child: Text(groupDragData.rootGroupNode?.title ?? ''),
                ),
              ),
            ),
            child: Container(
              width: groupDragData.size.width,
              height: groupDragData.size.height,
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(4),
                border: Border.all(color: Colors.blueAccent, width: 1),
              ),
              child: Center(
                child: Text(groupDragData.rootGroupNode?.title ?? ''),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
