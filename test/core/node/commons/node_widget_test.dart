// import 'package:flutter/material.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:flow_editor/core/node/models/node_model.dart';
// import 'package:flow_editor/core/node/behaviors/node_behavior.dart';
// import 'package:flow_editor/core/node/widgets/commons/node_widget.dart';

// class MockNodeBehavior implements NodeBehavior {
//   bool tapped = false;
//   bool doubleTapped = false;
//   bool hoveredEnter = false;
//   bool hoveredExit = false;
//   Offset? contextMenuPos;
//   bool deleted = false;

//   @override
//   void onTap(NodeModel node) => tapped = true;

//   @override
//   void onDoubleTap(NodeModel node) => doubleTapped = true;

//   @override
//   void onHover(NodeModel node, bool isHover) =>
//       isHover ? hoveredEnter = true : hoveredExit = true;

//   @override
//   void onContextMenu(NodeModel node, Offset position) =>
//       contextMenuPos = position;

//   @override
//   void onDelete(NodeModel node) => deleted = true;
// }

// void main() {
//   group('NodeWidget 完整交互链条测试', () {
//     late NodeModel node;
//     late MockNodeBehavior mockBehavior;

//     setUp(() {
//       node = NodeModel(
//         id: 'node-1',
//         x: 50,
//         y: 100,
//         width: 100,
//         height: 50,
//         type: 'default',
//         title: 'Test Node',
//         anchors: [],
//       );
//       mockBehavior = MockNodeBehavior();
//     });

//     testWidgets('节点正常展示', (WidgetTester tester) async {
//       tester.view.physicalSize = const Size(800, 600);
//       tester.view.devicePixelRatio = 1.0;

//       addTearDown(() {
//         tester.view.resetPhysicalSize();
//         tester.view.resetDevicePixelRatio();
//       });

//       await tester.pumpWidget(
//         MaterialApp(
//           home: Scaffold(
//             body: SizedBox.expand(
//               child: Stack(
//                 children: [
//                   NodeWidget(
//                     node: node,
//                     behavior: mockBehavior,
//                     child: Container(color: Colors.blue),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       );

//       await tester.pumpAndSettle();
//       expect(find.byType(NodeWidget), findsOneWidget);
//     });

//     testWidgets('测试单击触发 onTap', (WidgetTester tester) async {
//       await tester.pumpWidget(
//         MaterialApp(
//           home: Scaffold(
//             body: SizedBox.expand(
//               child: Stack(
//                 children: [
//                   NodeWidget(
//                     node: node,
//                     behavior: mockBehavior,
//                     child: Container(color: Colors.blue),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       );

//       await tester.tap(find.byKey(const Key('node_gesture_detector')));
//       await tester.pump(const Duration(milliseconds: 300));

//       expect(mockBehavior.tapped, isTrue, reason: '单击应触发 onTap');
//       expect(mockBehavior.doubleTapped, isFalse, reason: '不应触发双击');
//     });

//     testWidgets('测试删除按钮触发 onDelete', (WidgetTester tester) async {
//       await tester.pumpWidget(
//         MaterialApp(
//           home: Scaffold(
//             body: SizedBox.expand(
//               child: Stack(
//                 children: [
//                   NodeWidget(
//                     node: node,
//                     behavior: mockBehavior,
//                     child: Container(color: Colors.blue),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       );

//       await tester.tap(find.byKey(const Key('delete_button')));
//       await tester.pump();

//       expect(mockBehavior.deleted, isTrue, reason: '点击删除按钮应触发 onDelete');
//     });

//     // 可以在此基础上继续增加其他交互测试，如双击、右键、悬停等
//   });
// }
