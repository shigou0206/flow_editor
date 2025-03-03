// // test/edge_renderer_test.dart
// import 'package:flutter_test/flutter_test.dart';
// import 'dart:ui';
// import 'package:flow_editor/core/edge/edge_renderer.dart';
// import 'package:flow_editor/core/edge/models/edge_model.dart';
// import 'package:flow_editor/core/edge/models/edge_line_style.dart';
// import 'package:flow_editor/core/node/models/node_model.dart';
// import 'package:flow_editor/core/anchor/models/anchor_model.dart';
// import 'package:flow_editor/core/types/position_enum.dart';

// void main() {
//   group('EdgeRenderer', () {
//     test('should paint edges without exceptions', () {
//       final nodes = [
//         NodeModel(
//           id: 'node1',
//           title: 'node1',
//           x: 100,
//           y: 100,
//           width: 100,
//           height: 100,
//           anchors: [
//             AnchorModel(id: 'a1', position: Position.right),
//           ],
//         ),
//         NodeModel(
//           id: 'node2',
//           title: 'node2',
//           x: 300,
//           y: 100,
//           width: 100,
//           height: 100,
//           anchors: [
//             AnchorModel(id: 'a2', position: Position.left),
//           ],
//         ),
//       ];

//       final edges = [
//         EdgeModel(
//           id: 'edge1',
//           sourceNodeId: 'node1',
//           sourceAnchorId: 'a1',
//           targetNodeId: 'node2',
//           targetAnchorId: 'a2',
//           isConnected: true,
//           lineStyle: const EdgeLineStyle(
//             colorHex: '#ff0000',
//             strokeWidth: 2.0,
//             dashPattern: [4, 2],
//           ),
//         ),
//       ];

//       final painter = EdgeRenderer(
//         nodes: nodes,
//         edges: edges,
//         canvasOffset: Offset.zero,
//         canvasScale: 1.0,
//         selectedEdgeIds: {'edge1'},
//       );

//       final pictureRecorder = PictureRecorder();
//       final canvas = Canvas(pictureRecorder);
//       final size = const Size(500, 500);

//       expect(() => painter.paint(canvas, size), returnsNormally);
//     });

//     test('should paint dragging edge without exceptions', () {
//       final nodes = [
//         NodeModel(
//           id: 'node1',
//           title: 'node1',
//           x: 100,
//           y: 100,
//           width: 100,
//           height: 100,
//           anchors: [
//             AnchorModel(id: 'a1', position: Position.right),
//           ],
//         ),
//       ];

//       final edges = [
//         EdgeModel(
//           id: 'draggingEdge',
//           sourceNodeId: 'node1',
//           sourceAnchorId: 'a1',
//           isConnected: false,
//         ),
//       ];

//       final painter = EdgeRenderer(
//         nodes: nodes,
//         edges: edges,
//         draggingEdgeId: 'draggingEdge',
//         draggingEnd: const Offset(300, 300),
//       );

//       final pictureRecorder = PictureRecorder();
//       final canvas = Canvas(pictureRecorder);
//       final size = const Size(500, 500);

//       expect(() => painter.paint(canvas, size), returnsNormally);
//     });
//   });
// }
