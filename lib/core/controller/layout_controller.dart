// import 'package:collection/collection.dart';
// import 'package:flow_editor/core/models/node_model.dart';
// import 'package:flow_editor/core/models/edge_model.dart';
// import 'package:flow_layout/graph/graph.dart';
// import 'package:flow_layout/layout/layout.dart';

// class LayoutController {
//   /// 执行自动布局
//   void performAutoLayout(List<NodeModel> nodes, List<EdgeModel> edges) {
//     _performLayout(nodes, edges, parentId: null);
//   }

//   /// 递归布局Group节点
//   void _performLayout(List<NodeModel> nodes, List<EdgeModel> edges,
//       {String? parentId}) {
//     final groups = nodes.where((n) => n.parentId == parentId && n.isGroup);
//     for (final group in groups) {
//       _performLayout(nodes, edges, parentId: group.id);
//       _performGraphLayoutForGroup(group, nodes, edges);
//     }
//   }

//   void _performGraphLayoutForGroup(
//       NodeModel group, List<NodeModel> nodes, List<EdgeModel> edges) {
//     final children = nodes.where((n) => n.parentId == group.id).toList();
//     if (children.isEmpty) return;

//     final graph = Graph();
//     for (final node in children) {
//       graph.setNode(node.id, {
//         'width': node.size.width,
//         'height': node.size.height,
//       });
//     }

//     for (final edge in edges) {
//       final src = children.firstWhereOrNull((n) => n.id == edge.sourceNodeId);
//       final tgt = children.firstWhereOrNull((n) => n.id == edge.targetNodeId);
//       if (src != null && tgt != null) {
//         graph.setEdge(src.id, tgt.id);
//       }
//     }

//     graph.setGraph({'rankdir': 'TB', 'marginx': 20, 'marginy': 20});
//     layout(graph);

//     // 更新节点坐标
//     for (final node in children) {
//       final nd = graph.node(node.id)!;
//       final newX = (nd['x'] as num).toDouble() - node.size.width / 2;
//       final newY = (nd['y'] as num).toDouble() - node.size.height / 2;
//       node.position = Offset(newX, newY);
//     }

//     // 更新group大小
//     final label = graph.label;
//     group.size = Size(label['width'], label['height']);

//     // 更新边路由点
//     for (final edge in edges) {
//       final points =
//           graph.edge(edge.sourceNodeId, edge.targetNodeId)?['points'];
//       if (points != null) {
//         edge.waypoints = [
//           for (final p in points)
//             Offset((p['x'] as num).toDouble(), (p['y'] as num).toDouble())
//         ];
//       }
//     }
//   }
// }
