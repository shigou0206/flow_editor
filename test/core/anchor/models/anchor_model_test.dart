// file: test/core/anchor/models/anchor_model_test.dart

import 'package:flutter_test/flutter_test.dart';
import 'package:flow_editor/core/types/position_enum.dart';
import 'package:flow_editor/core/anchor/models/anchor_enums.dart';
import 'package:flow_editor/core/anchor/models/anchor_model.dart';

void main() {
  group('AnchorModel Tests', () {
    test('Default constructor sets expected default values', () {
      final anchor = AnchorModel(
        id: 'anchor1',
        nodeId: 'node1',
        position: Position.left,
      );

      expect(anchor.id, 'anchor1');
      expect(anchor.position, Position.left);
      expect(anchor.ratio, 0.5);
      expect(anchor.direction, AnchorDirection.inout);
      expect(anchor.maxConnections, isNull);
      expect(anchor.acceptedEdgeTypes, isNull);
      expect(anchor.shape, AnchorShape.circle);
      expect(anchor.arrowDirection, ArrowDirection.none);
      expect(anchor.locked, false);
      expect(anchor.version, 1);
      expect(anchor.lockedByUser, isNull);
      expect(anchor.plusButtonColorHex, isNull);
      expect(anchor.plusButtonSize, isNull);
      expect(anchor.iconName, isNull);
      expect(anchor.data.isEmpty, true);

      // 新增字段
      expect(anchor.placement, AnchorPlacement.border);
      expect(anchor.offsetDistance, 0.0);
      expect(anchor.angle, 0.0);
    });

    test('ratio is clamped between 0 and 1', () {
      final anchorNegative = AnchorModel(
        id: 'anchorNeg',
        nodeId: 'node1',
        position: Position.right,
        ratio: -1.5,
      );
      expect(anchorNegative.ratio, 0.0, reason: 'Should clamp to 0.0');

      final anchorTooLarge = AnchorModel(
        id: 'anchorLarge',
        nodeId: 'node1',
        position: Position.bottom,
        ratio: 10.0,
      );
      expect(anchorTooLarge.ratio, 1.0, reason: 'Should clamp to 1.0');

      final anchorValid = AnchorModel(
        id: 'anchorValid',
        nodeId: 'node1',
        position: Position.top,
        ratio: 0.75,
      );
      expect(anchorValid.ratio, 0.75);
    });

    test('copyWith updates fields selectively', () {
      final original = AnchorModel(
        id: 'anchor1',
        nodeId: 'node1',
        position: Position.left,
        ratio: 0.2,
        direction: AnchorDirection.inOnly,
        locked: true,
        offsetDistance: 10.0,
      );

      final updated = original.copyWith(
        position: Position.right,
        ratio: 0.8,
        offsetDistance: 25.0,
        locked: false,
      );

      // 不修改的字段保持原值
      expect(updated.id, 'anchor1');
      expect(updated.direction, AnchorDirection.inOnly);

      // 修改过的字段
      expect(updated.position, Position.right);
      expect(updated.ratio, 0.8);
      expect(updated.locked, false);
      expect(updated.offsetDistance, 25.0);
    });

    test('toJson and fromJson serialize/deserialize correctly', () {
      final anchor = AnchorModel(
        id: 'testAnchor',
        nodeId: 'node1',
        position: Position.bottom,
        ratio: 0.7,
        direction: AnchorDirection.outOnly,
        maxConnections: 3,
        acceptedEdgeTypes: ['flow', 'dependency'],
        shape: AnchorShape.diamond,
        arrowDirection: ArrowDirection.outward,
        locked: true,
        version: 2,
        lockedByUser: 'tester',
        plusButtonColorHex: '#AA00FF',
        plusButtonSize: 12.0,
        iconName: 'my_anchor_icon',
        data: {'extra': 'info'},
        placement: AnchorPlacement.outside,
        offsetDistance: 15.5,
        angle: 45.0,
      );

      final json = anchor.toJson();

      // 检查关键字段
      expect(json['id'], 'testAnchor');
      expect(json['position'], 'bottom');
      expect(json['ratio'], 0.7);
      expect(json['direction'], 'outOnly');
      expect(json['maxConnections'], 3);
      expect(json['acceptedEdgeTypes'], ['flow', 'dependency']);
      expect(json['shape'], 'diamond');
      expect(json['arrowDirection'], 'outward');
      expect(json['locked'], true);
      expect(json['version'], 2);
      expect(json['lockedByUser'], 'tester');
      expect(json['plusButtonColorHex'], '#AA00FF');
      expect(json['plusButtonSize'], 12.0);
      expect(json['iconName'], 'my_anchor_icon');
      expect(json['data'], {'extra': 'info'});
      // 新增字段
      expect(json['placement'], 'outside');
      expect(json['offsetDistance'], 15.5);
      expect(json['angle'], 45.0);

      final restored = AnchorModel.fromJson(json);

      expect(restored.id, 'testAnchor');
      expect(restored.position, Position.bottom);
      expect(restored.ratio, 0.7);
      expect(restored.direction, AnchorDirection.outOnly);
      expect(restored.maxConnections, 3);
      expect(restored.acceptedEdgeTypes, ['flow', 'dependency']);
      expect(restored.shape, AnchorShape.diamond);
      expect(restored.arrowDirection, ArrowDirection.outward);
      expect(restored.locked, true);
      expect(restored.version, 2);
      expect(restored.lockedByUser, 'tester');
      expect(restored.plusButtonColorHex, '#AA00FF');
      expect(restored.plusButtonSize, 12.0);
      expect(restored.iconName, 'my_anchor_icon');
      expect(restored.data, {'extra': 'info'});
      // 新增字段
      expect(restored.placement, AnchorPlacement.outside);
      expect(restored.offsetDistance, 15.5);
      expect(restored.angle, 45.0);
    });

    test('handles invalid JSON gracefully', () {
      final badJson = {
        'id': 123, // not a string
        'position': 999, // not valid
        'ratio': 'NaN',
        'offsetDistance': 'Infinity',
        'placement': 'unknown_value'
      };

      // 可能会产生类型错误，但你可以决定怎么处理
      // 若你希望 fromJson 强制抛异常，可测试 throwsA
      // 若你允许 fallback => 让 parse函数使用默认值
      final anchor = AnchorModel.fromJson(badJson.cast<String, dynamic>());

      // check fallback
      expect(anchor.id, isA<String>(),
          reason: 'id 预期解析失败或 fallback, 也可在 parse逻辑中抛异常');
      expect(anchor.position, Position.left,
          reason: 'unknown position => fallback to left');
      expect(anchor.ratio, 0.5, reason: 'NaN => fallback to 0.5');
      expect(anchor.offsetDistance, 0.0, reason: 'Infinity => fallback to 0.0');
      expect(anchor.placement, AnchorPlacement.border,
          reason: 'unknown_value => fallback border');
    });
  });
}
