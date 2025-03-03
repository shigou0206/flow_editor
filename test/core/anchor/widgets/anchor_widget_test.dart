// import 'package:flutter/material.dart';
// import 'package:flutter/gestures.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:flow_editor/core/anchor/widgets/anchor_widget.dart';
// import 'package:flow_editor/core/anchor/models/anchor_model.dart';
// import 'package:flow_editor/core/anchor/models/anchor_enums.dart';
// import 'package:flow_editor/core/anchor/utils/anchor_position_utils.dart';
// import 'package:flow_editor/core/types/position_enum.dart';

// void main() {
//   group('AnchorWidget Interaction Tests', () {
//     final anchor = AnchorModel(
//       id: 'test_anchor',
//       position: Position.top,
//       nodeId: 'node1',
//     );

//     testWidgets('calls onTap when tapped', (tester) async {
//       bool tapped = false;
//       await tester.pumpWidget(
//         MaterialApp(
//           home: Scaffold(
//             body: AnchorWidget(
//               anchor: anchor,
//               onTap: () => tapped = true,
//             ),
//           ),
//         ),
//       );

//       await tester.tap(find.byType(AnchorWidget));
//       expect(tapped, isTrue);
//     });

//     testWidgets('calls hover callbacks correctly', (tester) async {
//       bool hoverEnterCalled = false;
//       bool hoverExitCalled = false;

//       final anchor = AnchorModel(
//         id: 'anchor1',
//         position: Position.top,
//         nodeId: 'node1',
//       );

//       await tester.pumpWidget(
//         MaterialApp(
//           home: Scaffold(
//             body: AnchorWidget(
//               anchor: anchor,
//               onHoverEnter: () => hoverEnterCalled = true,
//               onHoverExit: () => hoverExitCalled = true,
//             ),
//           ),
//         ),
//       );

//       final anchorFinder = find.byType(AnchorWidget);
//       expect(anchorFinder, findsOneWidget);

//       // 获取widget中心位置
//       final anchorLocation = tester.getCenter(anchorFinder);
//       final outsideLocation = anchorLocation + const Offset(100, 100);

//       // 创建并移动鼠标到anchor上方，触发hover enter
//       final gesture = await tester.createGesture(kind: PointerDeviceKind.mouse);
//       await gesture.addPointer(location: anchorLocation);
//       await tester.pumpAndSettle();

//       expect(hoverEnterCalled, isTrue,
//           reason: 'Hover enter callback should be called');

//       // 移动鼠标离开anchor，触发hover exit
//       await gesture.moveTo(outsideLocation);
//       await tester.pumpAndSettle();

//       expect(hoverExitCalled, isTrue,
//           reason: 'Hover exit callback should be called');

//       await gesture.removePointer();
//     });

//     testWidgets('updates hover state visually', (tester) async {
//       await tester.pumpWidget(
//         MaterialApp(
//           home: Scaffold(
//             body: AnchorWidget(anchor: anchor),
//           ),
//         ),
//       );

//       final gesture = await tester.createGesture(kind: PointerDeviceKind.mouse);
//       await gesture.addPointer();

//       await gesture.moveTo(tester.getCenter(find.byType(AnchorWidget)));
//       await tester.pumpAndSettle();

//       // Here you might verify visual state changes, depending on your implementation
//       // e.g., using Golden tests or internal state assertions.

//       await gesture.moveTo(Offset.zero);
//       await tester.pumpAndSettle();

//       // Additional verification if needed.
//     });

//     testWidgets('renders AnchorWidget correctly based on placement',
//         (WidgetTester tester) async {
//       final nodeSize = Size(200, 100);
//       final anchorInside = AnchorModel(
//         id: 'anchor_inside',
//         position: Position.right,
//         placement: AnchorPlacement.inside,
//         offsetDistance: 20,
//         nodeId: 'node1',
//       );
//       final anchorOutside = AnchorModel(
//         id: 'anchor_outside',
//         position: Position.right,
//         placement: AnchorPlacement.outside,
//         offsetDistance: 20,
//         nodeId: 'node1',
//       );

//       Widget buildTestWidget(AnchorModel anchor) {
//         final anchorLocalPos = computeAnchorLocalPosition(anchor, nodeSize);
//         return MaterialApp(
//           home: Scaffold(
//             body: Align(
//               alignment: Alignment.topLeft, // 改成从左上角对齐
//               child: SizedBox(
//                 width: nodeSize.width,
//                 height: nodeSize.height,
//                 child: Stack(
//                   children: [
//                     Positioned(
//                       left: anchorLocalPos.dx - 12, // widgetSize/2=12
//                       top: anchorLocalPos.dy - 12,
//                       child: AnchorWidget(anchor: anchor),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//         );
//       }

//       // inside位置
//       await tester.pumpWidget(buildTestWidget(anchorInside));
//       await tester.pumpAndSettle();

//       final Finder anchorInsideFinder = find.byType(AnchorWidget);
//       final RenderBox insideRenderBox = tester.renderObject(anchorInsideFinder);
//       final Offset insidePos = insideRenderBox.localToGlobal(Offset.zero);

//       expect(insidePos.dx, closeTo(200 - 20 - 12, 0.5)); // 168
//       expect(insidePos.dy, closeTo(50 - 12, 0.5)); // 38

//       // outside位置
//       await tester.pumpWidget(buildTestWidget(anchorOutside));
//       await tester.pumpAndSettle();

//       final Finder anchorOutsideFinder = find.byType(AnchorWidget);
//       final RenderBox outsideRenderBox =
//           tester.renderObject(anchorOutsideFinder);
//       final Offset outsidePos = outsideRenderBox.localToGlobal(Offset.zero);

//       expect(outsidePos.dx, closeTo(200 + 20 - 12, 0.5)); // 208
//       expect(outsidePos.dy, closeTo(50 - 12, 0.5)); // 38
//     });
//   });
// }
