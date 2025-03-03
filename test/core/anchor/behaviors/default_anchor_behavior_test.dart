// import 'package:flutter_test/flutter_test.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:flow_editor/core/anchor/models/anchor_model.dart';
// import 'package:flow_editor/core/anchor/models/anchor_enums.dart';
// import 'package:flow_editor/core/types/position_enum.dart';
// import 'package:flow_editor/core/anchor/behaviors/default_anchor_behavior.dart';

// void main() {
//   group('DefaultAnchorBehavior Tests', () {
//     late DefaultAnchorBehavior behavior;
//     late AnchorModel anchor;
//     late ProviderContainer container;

//     setUp(() {
//       container = ProviderContainer();
//       behavior = DefaultAnchorBehavior(ref: container);
//       anchor = AnchorModel(
//         id: 'test-anchor',
//         nodeId: 'test-node',
//         position: Position.right,
//         shape: AnchorShape.circle,
//         placement: AnchorPlacement.border,
//       );
//     });

//     test('onAnchorTap logs correctly', () {
//       expect(() => behavior.onAnchorTap(anchor),
//           prints('DefaultAnchorBehavior: onAnchorTap => test-anchor\n'));
//     });

//     test('onAnchorDoubleTap logs correctly', () {
//       expect(() => behavior.onAnchorDoubleTap(anchor),
//           prints('DefaultAnchorBehavior: onAnchorDoubleTap => test-anchor\n'));
//     });

//     test('onAnchorHover logs hover true', () {
//       expect(
//           () => behavior.onAnchorHover(anchor, true),
//           prints(
//               'DefaultAnchorBehavior: onAnchorHover => test-anchor, isHover=true\n'));
//     });

//     test('onAnchorHover logs hover false', () {
//       expect(
//           () => behavior.onAnchorHover(anchor, false),
//           prints(
//               'DefaultAnchorBehavior: onAnchorHover => test-anchor, isHover=false\n'));
//     });

//     test('onAnchorContextMenu logs correctly', () {
//       final localPos = Offset(10, 15);
//       expect(
//           () => behavior.onAnchorContextMenu(anchor, localPos),
//           prints(
//               'DefaultAnchorBehavior: onAnchorContextMenu => test-anchor at Offset(10.0, 15.0)\n'));
//     });

//     test('onAnchorDragStart logs correctly', () {
//       final startPos = Offset(5, 5);
//       expect(
//           () => behavior.onAnchorDragStart(anchor, startPos),
//           prints(
//               'DefaultAnchorBehavior: onAnchorDragStart => test-anchor, startPos=Offset(5.0, 5.0)\n'));
//     });

//     test('onAnchorDragUpdate logs correctly', () {
//       final currentPos = Offset(20, 20);
//       expect(
//           () => behavior.onAnchorDragUpdate(anchor, currentPos),
//           prints(
//               'DefaultAnchorBehavior: onAnchorDragUpdate => test-anchor, currentPos=Offset(20.0, 20.0)\n'));
//     });

//     test('onAnchorDragEnd logs correctly (not canceled)', () {
//       final endPos = Offset(25, 25);
//       expect(
//           () => behavior.onAnchorDragEnd(anchor, endPos, canceled: false),
//           prints(
//               'DefaultAnchorBehavior: onAnchorDragEnd => test-anchor, endPos=Offset(25.0, 25.0), canceled=false\n'));
//     });

//     test('onAnchorDragEnd logs correctly (canceled)', () {
//       final endPos = Offset(30, 30);
//       expect(
//           () => behavior.onAnchorDragEnd(anchor, endPos, canceled: true),
//           prints(
//               'DefaultAnchorBehavior: onAnchorDragEnd => test-anchor, endPos=Offset(30.0, 30.0), canceled=true\n'));
//     });
//   });
// }
