import 'package:flutter_test/flutter_test.dart';
import 'package:flow_editor/core/anchor/models/anchor_model.dart';
import 'package:flow_editor/core/types/position_enum.dart';
import 'package:flow_editor/core/anchor/models/anchor_enums.dart';
import 'package:flow_editor/core/node/models/node_model.dart';
import 'package:flow_editor/core/anchor/utils/anchor_position_utils.dart';

void main() {
  group('Anchor Position Calculation Tests', () {
    final node = NodeModel(
        id: 'node1', x: 100, y: 200, width: 200, height: 100, title: 'Node 1');

    test('Anchor on right border with no offset', () {
      final anchor = AnchorModel(
        id: 'anchor1',
        nodeId: 'node1',
        position: Position.right,
        ratio: 0.5,
      );

      final pos = computeAnchorWorldPosition(node, anchor);

      expect(pos, equals(const Offset(300, 250)));
    });

    test('Anchor on left border with inside offset', () {
      final anchor = AnchorModel(
        id: 'anchor2',
        nodeId: 'node1',
        position: Position.left,
        ratio: 0.5,
        placement: AnchorPlacement.inside,
        offsetDistance: 10,
      );

      final pos = computeAnchorWorldPosition(node, anchor);

      expect(pos, equals(const Offset(110, 250)));
    });

    test('Anchor on top border with outside offset and angle rotation', () {
      final anchor = AnchorModel(
        id: 'anchor3',
        nodeId: 'node1',
        position: Position.top,
        ratio: 0.5,
        placement: AnchorPlacement.outside,
        offsetDistance: 20,
        angle: 90,
      );

      final pos = computeAnchorWorldPosition(node, anchor);

      expect(pos.dx, closeTo(220, 0.001));
      expect(pos.dy, closeTo(200, 0.001));
    });

    test('Anchor on bottom-right corner outside, rotated 45 degrees', () {
      final anchor = AnchorModel(
        id: 'anchor4',
        nodeId: 'node1',
        position: Position.bottom,
        ratio: 1.0,
        placement: AnchorPlacement.outside,
        offsetDistance: 14.142135,
        angle: -45,
      );

      final pos = computeAnchorWorldPosition(node, anchor);

      expect(pos.dx, closeTo(310, 0.001));
      expect(pos.dy, closeTo(310, 0.001));
    });

    test('Anchor on left-top corner inside, rotated 135 degrees', () {
      final anchor = AnchorModel(
        id: 'anchor5',
        nodeId: 'node1',
        position: Position.left,
        ratio: 0.0,
        placement: AnchorPlacement.inside,
        offsetDistance: 14.142135,
        angle: 135,
      );

      final pos = computeAnchorWorldPosition(node, anchor);

      expect(pos.dx, closeTo(90, 0.001));
      expect(pos.dy, closeTo(210, 0.001));
    });
  });
}
