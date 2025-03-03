import 'package:flutter_test/flutter_test.dart';
import 'package:flow_editor/core/anchor/models/anchor_model.dart';
import 'package:flow_editor/core/types/position_enum.dart';
import 'package:flow_editor/core/anchor/models/anchor_enums.dart';

void main() {
  group('AnchorModel Tests', () {
    late AnchorModel basicAnchor;
    late AnchorModel fullAnchor;

    setUp(() {
      // 基础锚点 - 最小必需字段
      basicAnchor = AnchorModel(
        id: 'anchor-1',
        nodeId: 'node-a',
        position: Position.left,
      );

      // 完整锚点 - 所有字段
      fullAnchor = AnchorModel(
        id: 'anchor-2',
        nodeId: 'node-b',
        position: Position.right,
        ratio: 0.7,
        direction: AnchorDirection.outOnly,
        maxConnections: 3,
        acceptedEdgeTypes: ['flow', 'data'],
        shape: AnchorShape.diamond,
        arrowDirection: ArrowDirection.outward,
        locked: true,
        version: 2,
        lockedByUser: 'user1',
        plusButtonColorHex: '#FF0000',
        plusButtonSize: 16.0,
        iconName: 'custom_icon',
        data: {'key1': 'value1'},
      );
    });

    group('Constructor & Default Values', () {
      test('should create basic anchor with default values', () {
        expect(basicAnchor.id, 'anchor-1');
        expect(basicAnchor.position, Position.left);
        expect(basicAnchor.ratio, 0.5); // default
        expect(basicAnchor.direction, AnchorDirection.inout); // default
        expect(basicAnchor.shape, AnchorShape.circle); // default
        expect(basicAnchor.arrowDirection, ArrowDirection.none); // default
        expect(basicAnchor.locked, false);
        expect(basicAnchor.version, 1);
        expect(basicAnchor.data, isEmpty);
      });

      test('should create full anchor with all values', () {
        expect(fullAnchor.id, 'anchor-2');
        expect(fullAnchor.position, Position.right);
        expect(fullAnchor.ratio, 0.7);
        expect(fullAnchor.direction, AnchorDirection.outOnly);
        expect(fullAnchor.maxConnections, 3);
        expect(fullAnchor.acceptedEdgeTypes, ['flow', 'data']);
        expect(fullAnchor.shape, AnchorShape.diamond);
        expect(fullAnchor.arrowDirection, ArrowDirection.outward);
        expect(fullAnchor.locked, true);
        expect(fullAnchor.version, 2);
        expect(fullAnchor.lockedByUser, 'user1');
        expect(fullAnchor.plusButtonColorHex, '#FF0000');
        expect(fullAnchor.plusButtonSize, 16.0);
        expect(fullAnchor.iconName, 'custom_icon');
        expect(fullAnchor.data['key1'], 'value1');
      });
    });

    group('Ratio Validation', () {
      test('should clamp ratio values', () {
        final anchorUnder = AnchorModel(
          id: 'test',
          nodeId: 'node-a',
          position: Position.left,
          ratio: -0.5,
        );
        expect(anchorUnder.ratio, 0.0);

        final anchorOver = AnchorModel(
          id: 'test',
          nodeId: 'node-a',
          position: Position.left,
          ratio: 1.5,
        );
        expect(anchorOver.ratio, 1.0);
      });
    });

    group('copyWith Tests', () {
      test('should create new instance with updated fields', () {
        final updated = basicAnchor.copyWith(
          position: Position.top,
          ratio: 0.8,
          direction: AnchorDirection.inOnly,
          shape: AnchorShape.square,
        );

        expect(updated.id, basicAnchor.id);
        expect(updated.position, Position.top);
        expect(updated.ratio, 0.8);
        expect(updated.direction, AnchorDirection.inOnly);
        expect(updated.shape, AnchorShape.square);
        expect(updated, isNot(same(basicAnchor)));
      });
    });

    group('Serialization Tests', () {
      test('should correctly serialize to JSON', () {
        final json = fullAnchor.toJson();

        expect(json['id'], fullAnchor.id);
        expect(json['position'], 'right');
        expect(json['ratio'], 0.7);
        expect(json['direction'], 'outOnly');
        expect(json['maxConnections'], 3);
        expect(json['acceptedEdgeTypes'], ['flow', 'data']);
        expect(json['shape'], 'diamond');
        expect(json['arrowDirection'], 'outward');
        expect(json['locked'], true);
        expect(json['version'], 2);
        expect(json['plusButtonColorHex'], '#FF0000');
        expect(json['data']['key1'], 'value1');
      });

      test('should correctly deserialize from JSON', () {
        final json = {
          'id': 'anchor-3',
          'position': 'top',
          'ratio': 0.3,
          'direction': 'inOnly',
          'shape': 'square',
          'arrowDirection': 'inward',
          'maxConnections': 2,
          'acceptedEdgeTypes': ['flow'],
          'data': {'custom': 'value'},
        };

        final anchor = AnchorModel.fromJson(json);

        expect(anchor.id, 'anchor-3');
        expect(anchor.position, Position.top);
        expect(anchor.ratio, 0.3);
        expect(anchor.direction, AnchorDirection.inOnly);
        expect(anchor.shape, AnchorShape.square);
        expect(anchor.arrowDirection, ArrowDirection.inward);
        expect(anchor.maxConnections, 2);
        expect(anchor.acceptedEdgeTypes, ['flow']);
        expect(anchor.data['custom'], 'value');
      });

      test('should handle invalid JSON values', () {
        final json = {
          'id': 'anchor-4',
          'position': 'invalid',
          'ratio': 'not-a-number',
          'direction': 'invalid',
          'shape': 'invalid',
          'arrowDirection': 'invalid',
        };

        final anchor = AnchorModel.fromJson(json);

        expect(anchor.position, Position.left); // default
        expect(anchor.ratio, 0.5); // default
        expect(anchor.direction, AnchorDirection.inout); // default
        expect(anchor.shape, AnchorShape.circle); // default
        expect(anchor.arrowDirection, ArrowDirection.none); // default
      });
    });
  });
}
