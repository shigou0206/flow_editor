// import 'package:flutter_test/flutter_test.dart';
// import 'package:flutter/material.dart';
// import 'package:flow_editor/core/canvas/renderers/canvas_renderer.dart';
// import 'package:flow_editor/core/node/models/node_model.dart';
// import 'package:flow_editor/core/anchor/models/anchor_model.dart';
// import 'package:flow_editor/core/types/position_enum.dart';
// import 'package:flow_editor/core/state_management/node_state/node_state.dart';
// import 'package:flow_editor/core/state_management/edge_state/edge_state.dart';
// import 'package:flow_editor/core/edge/models/edge_model.dart';
// import 'package:flow_editor/core/canvas/models/canvas_visual_config.dart';
// import 'package:flow_editor/core/node/behaviors/node_behavior.dart';
// import 'package:flow_editor/core/node/widgets/commons/node_widget.dart';

// void main() {
//   group('CanvasRenderer Widget Tests', () {
//     late NodeState nodeState;
//     late EdgeState edgeState;
//     late CanvasVisualConfig visualConfig;

//     setUp(() {
//       nodeState = NodeState(
//         nodesByWorkflow: {
//           'main': {
//             'node1': NodeModel(
//               id: 'node1',
//               title: 'Node 1',
//               x: 100,
//               y: 100,
//               width: 120,
//               height: 60,
//               // 这里要确保 anchors 有你 edge 需要的 anchor
//               anchors: [
//                 AnchorModel(
//                     id: 'right', position: Position.right, nodeId: 'node1')
//               ],
//             ),
//           },
//         },
//       );

//       edgeState = EdgeState(
//         edgesByWorkflow: {
//           'main': {
//             'edge1': EdgeModel(
//               id: 'edge1',
//               sourceNodeId: 'node1',
//               sourceAnchorId: 'right',
//               targetNodeId: 'node2',
//               targetAnchorId: 'left',
//               isConnected: true,
//             ),
//           },
//         },
//       );

//       visualConfig = CanvasVisualConfig(
//         backgroundColor: Colors.grey.shade100,
//         showGrid: true,
//         gridSpacing: 20,
//         gridColor: Colors.grey.shade300,
//       );
//     });

//     testWidgets('passes behavior to NodeWidgets correctly',
//         (WidgetTester tester) async {
//       bool tapped = false;

//       final nodeBehavior = TestNodeBehavior(
//         onTapCallback: (node) {
//           tapped = true;
//         },
//       );

//       await tester.pumpWidget(
//         MaterialApp(
//           home: Scaffold(
//             body: SizedBox(
//               width: 800,
//               height: 600,
//               child: CanvasRenderer(
//                 nodeState: nodeState,
//                 edgeState: edgeState,
//                 canvasVisualConfig: visualConfig,
//                 nodeBehavior: nodeBehavior,
//               ),
//             ),
//           ),
//         ),
//       );

//       // 确保NodeWidget可见
//       expect(find.byType(NodeWidget), findsWidgets);

//       // 查找GestureDetector (在NodeWidget的内部)
//       final gestureFinder =
//           find.byKey(const Key('node_gesture_detector')).first;
//       expect(gestureFinder, findsOneWidget);

//       // 获取GestureDetector的中心坐标
//       final center = tester.getCenter(gestureFinder);

//       // 模拟点击该坐标
//       await tester.tapAt(center);

//       // 等待超过300ms, 使onTapUp的定时器逻辑执行完
//       await tester.pump(const Duration(milliseconds: 350));

//       expect(tapped, isTrue, reason: 'Behavior.onTap should have been called.');
//     });
//   });
// }

// class TestNodeBehavior extends NodeBehavior {
//   final void Function(NodeModel node)? onTapCallback;

//   TestNodeBehavior({this.onTapCallback});

//   @override
//   void onTap(NodeModel node) {
//     onTapCallback?.call(node);
//   }
// }
