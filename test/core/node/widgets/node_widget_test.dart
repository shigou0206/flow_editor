// import 'package:flutter/material.dart';
// import 'dart:ui' show PointerDeviceKind;
// import 'package:flutter/gestures.dart';
// import 'package:flutter_test/flutter_test.dart';

// // 根据项目实际情况修改导入路径
// import 'package:flow_editor/core/node/widgets/commons/node_widget.dart';
// import 'package:flow_editor/core/node/models/node_model.dart';
// import 'package:flow_editor/core/node/behaviors/node_behavior.dart';

// // 如果 kSecondaryMouseButton 未定义, 自行声明:
// const int kSecondaryMouseButton = 2;

// void main() {
//   group('NodeWidget Advanced Tests', () {
//     testWidgets('renders child text', (WidgetTester tester) async {
//       // 设置足够大的屏幕, 避免越界点击
//       tester.view.physicalSize = const Size(1000, 800);
//       addTearDown(tester.view.resetPhysicalSize);

//       final node = NodeModel(
//         id: 'node-1',
//         x: 50,
//         y: 100,
//         width: 100,
//         height: 50,
//         type: 'default',
//         title: 'Test Node',
//         anchors: [],
//       );

//       await tester.pumpWidget(
//         MaterialApp(
//           home: Stack(
//             children: [
//               NodeWidget(
//                 node: node,
//                 child: const Text('Hello Node'),
//                 behavior: null, // 无行为
//               ),
//             ],
//           ),
//         ),
//       );

//       expect(find.text('Hello Node'), findsOneWidget);
//     });

//     testWidgets('calls onTap in NodeBehavior when single tapped',
//         (WidgetTester tester) async {
//       tester.view.physicalSize = const Size(1200, 800);
//       addTearDown(tester.view.resetPhysicalSize);

//       bool tapped = false;
//       final mockBehavior = _MockBehavior(
//         onTapImpl: (node) => tapped = true,
//       );

//       final node = NodeModel(
//         id: 'node-tap',
//         x: 10,
//         y: 20,
//         width: 80,
//         height: 40,
//         type: 'default',
//         title: 'Tap Node',
//         anchors: [],
//       );

//       await tester.pumpWidget(
//         MaterialApp(
//           home: Scaffold(
//             body: Material(
//               child: Center(
//                 child: Stack(
//                   children: [
//                     NodeWidget(
//                       node: node,
//                       child: Container(
//                         width: node.width,
//                         height: node.height,
//                         color: Colors.blue,
//                         alignment: Alignment.center,
//                         child: const Text('Tap Me'),
//                       ),
//                       behavior: mockBehavior,
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//         ),
//       );

//       final textFinder = find.text('Tap Me');
//       expect(textFinder, findsOneWidget);

//       // 模拟单击后等待 300 毫秒，确保 onTap 回调触发
//       await tester.tap(textFinder, warnIfMissed: false);
//       await tester.pump(const Duration(milliseconds: 300));

//       expect(tapped, isTrue);
//     });

//     testWidgets('calls onDoubleTap in NodeBehavior when double tapped',
//         (WidgetTester tester) async {
//       tester.view.physicalSize = const Size(1200, 800);
//       addTearDown(tester.view.resetPhysicalSize);

//       bool doubleTapped = false;
//       final mockBehavior = _MockBehavior(
//         onDoubleTapImpl: (node) => doubleTapped = true,
//       );

//       final node = NodeModel(
//         id: 'node-dbltap',
//         x: 30,
//         y: 40,
//         width: 80,
//         height: 40,
//         type: 'default',
//         title: 'DoubleTap Node',
//         anchors: [],
//       );

//       await tester.pumpWidget(
//         MaterialApp(
//           home: Scaffold(
//             body: Material(
//               child: Center(
//                 child: Stack(
//                   children: [
//                     NodeWidget(
//                       node: node,
//                       child: Container(
//                         width: node.width,
//                         height: node.height,
//                         color: Colors.orange,
//                         alignment: Alignment.center,
//                         child: const Text('DoubleTap Me'),
//                       ),
//                       behavior: mockBehavior,
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//         ),
//       );

//       final textFinder = find.text('DoubleTap Me');
//       expect(textFinder, findsOneWidget);

//       // 模拟双击：
//       await tester.tap(textFinder, warnIfMissed: false);
//       await tester.pump(const Duration(milliseconds: 100));
//       await tester.tap(textFinder, warnIfMissed: false);
//       await tester.pumpAndSettle();

//       expect(doubleTapped, isTrue);
//     });

//     testWidgets('calls onDelete in NodeBehavior when delete icon pressed',
//         (WidgetTester tester) async {
//       tester.view.physicalSize = const Size(1000, 600);
//       addTearDown(tester.view.resetPhysicalSize);

//       bool deleted = false;

//       final mockBehavior = _MockBehavior(
//         onDeleteImpl: (node) => deleted = true,
//       );

//       final node = NodeModel(
//         id: 'node-del',
//         x: 10,
//         y: 20,
//         width: 60,
//         height: 30,
//         type: 'default',
//         title: 'Delete Node',
//         anchors: [],
//       );

//       await tester.pumpWidget(
//         MaterialApp(
//           home: Scaffold(
//             body: Material(
//               child: Center(
//                 child: Stack(
//                   children: [
//                     NodeWidget(
//                       node: node,
//                       child: Container(
//                         width: node.width,
//                         height: node.height,
//                         color: Colors.green,
//                       ),
//                       behavior: mockBehavior,
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//         ),
//       );

//       final deleteIconFinder = find.byIcon(Icons.delete);
//       expect(deleteIconFinder, findsOneWidget);

//       await tester.tap(deleteIconFinder, warnIfMissed: false);
//       await tester.pump();

//       expect(deleted, isTrue);
//     });

//     testWidgets('calls onContextMenu in NodeBehavior on right-click',
//         (WidgetTester tester) async {
//       tester.view.physicalSize = const Size(1200, 800);
//       addTearDown(tester.view.resetPhysicalSize);

//       Offset? contextPos;

//       final mockBehavior = _MockBehavior(
//         onContextMenuImpl: (node, pos) => contextPos = pos,
//       );

//       final node = NodeModel(
//         id: 'node-ctx',
//         x: 50,
//         y: 50,
//         width: 80,
//         height: 40,
//         type: 'default',
//         title: 'RightClick Node',
//         anchors: [],
//       );

//       await tester.pumpWidget(
//         MaterialApp(
//           home: Scaffold(
//             body: Material(
//               child: Center(
//                 child: Stack(
//                   children: [
//                     NodeWidget(
//                       node: node,
//                       child: Container(
//                         width: node.width,
//                         height: node.height,
//                         color: Colors.red,
//                         child: const Text('RC Node'),
//                       ),
//                       behavior: mockBehavior,
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//         ),
//       );

//       final textFinder = find.text('RC Node');
//       expect(textFinder, findsOneWidget);

//       final center = tester.getCenter(textFinder);

//       // 模拟右键点击: pointerDown+pointerUp
//       await tester.sendEventToBinding(PointerDownEvent(
//         position: center,
//         buttons: kSecondaryMouseButton,
//       ));
//       await tester.pump();
//       await tester.sendEventToBinding(PointerUpEvent(
//         position: center,
//         buttons: kSecondaryMouseButton,
//       ));
//       await tester.pumpAndSettle();

//       expect(contextPos, isNotNull,
//           reason: 'onContextMenu should have been called');
//     });

//     testWidgets('calls onHover in NodeBehavior on mouse enter/exit',
//         (WidgetTester tester) async {
//       tester.view.physicalSize = const Size(1200, 800);
//       addTearDown(tester.view.resetPhysicalSize);

//       bool? hoverValue;

//       final mockBehavior = _MockBehavior(
//         onHoverImpl: (node, isHover) => hoverValue = isHover,
//       );

//       final node = NodeModel(
//         id: 'node-hover',
//         x: 100,
//         y: 100,
//         width: 100,
//         height: 50,
//         type: 'default',
//         title: 'Hover Node',
//         anchors: [],
//       );

//       await tester.pumpWidget(
//         MaterialApp(
//           home: Scaffold(
//             body: Material(
//               child: Center(
//                 child: Stack(
//                   children: [
//                     NodeWidget(
//                       node: node,
//                       child: Container(
//                         width: node.width,
//                         height: node.height,
//                         alignment: Alignment.center,
//                         color: Colors.blue,
//                         child: const Text('Hover Test'),
//                       ),
//                       behavior: mockBehavior,
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//         ),
//       );

//       final textFinder = find.text('Hover Test');
//       expect(textFinder, findsOneWidget);

//       final center = tester.getCenter(textFinder);

//       // 模拟鼠标进入
//       final gesture = await tester.createGesture(kind: PointerDeviceKind.mouse);
//       await gesture.moveTo(center);
//       await tester.pump();
//       expect(hoverValue, isTrue,
//           reason: 'Should receive hover=true on mouse enter');

//       // 模拟鼠标移出
//       await gesture.moveTo(const Offset(0, 0));
//       await tester.pump();
//       expect(hoverValue, isFalse,
//           reason: 'Should receive hover=false on mouse exit');

//       await gesture.removePointer();
//     });
//   });
// }

// class _MockBehavior implements NodeBehavior {
//   final void Function(NodeModel)? onTapImpl;
//   final void Function(NodeModel)? onDoubleTapImpl;
//   final void Function(NodeModel)? onDeleteImpl;
//   final void Function(NodeModel, bool)? onHoverImpl;
//   final void Function(NodeModel, Offset)? onContextMenuImpl;

//   _MockBehavior({
//     this.onTapImpl,
//     this.onDoubleTapImpl,
//     this.onDeleteImpl,
//     this.onHoverImpl,
//     this.onContextMenuImpl,
//   });

//   @override
//   void onTap(NodeModel node) => onTapImpl?.call(node);
//   @override
//   void onDoubleTap(NodeModel node) => onDoubleTapImpl?.call(node);
//   @override
//   void onDelete(NodeModel node) => onDeleteImpl?.call(node);
//   @override
//   void onHover(NodeModel node, bool isHover) =>
//       onHoverImpl?.call(node, isHover);
//   @override
//   void onContextMenu(NodeModel node, Offset position) =>
//       onContextMenuImpl?.call(node, position);
// }
