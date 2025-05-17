// test/models/node_and_anchor_model_test.dart

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flow_editor/core/models/anchor_model.dart';
import 'package:flow_editor/core/models/enums.dart';
import 'package:flow_editor/core/models/node_model.dart';
import 'package:flow_editor/core/models/style/node_style.dart';

void main() {
  group('AnchorModel', () {
    test('defaults and property normalization', () {
      final anchor = AnchorModel(
        id: 'a1',
        width: 10,
        height: 20,
        position: Position.bottom,
        ratio: 1.2, // out of bounds → should clamp to 1.0
        nodeId: 'node1',
      );
      expect(anchor.id, equals('a1'));
      expect(anchor.width, equals(10));
      expect(anchor.height, equals(20));
      expect(anchor.position, equals(Position.bottom));
      expect(anchor.ratio, equals(1.0));
      expect(anchor.nodeId, equals('node1'));
      expect(anchor.offsetDistance, equals(0.0));
      expect(anchor.angle, equals(0.0));
      expect(anchor.locked, isFalse);
    });

    test('copyWith preserves and overrides correctly', () {
      final base = AnchorModel(
        id: 'a2',
        width: 8,
        height: 8,
        position: Position.left,
        ratio: 0.3,
        nodeId: 'n1',
      );
      final copy = base.copyWith(
        width: 16,
        ratio: -0.5, // out of bounds → clamp to 0.0
        nodeId: 'n2',
        offsetDistance: 5,
        angle: 45.0,
      );
      expect(copy.id, equals('a2'));
      expect(copy.width, equals(16));
      expect(copy.height, equals(8));
      expect(copy.position, equals(Position.left));
      expect(copy.ratio, equals(0.0));
      expect(copy.nodeId, equals('n2'));
      expect(copy.offsetDistance, equals(5.0));
      expect(copy.angle, equals(45.0));
    });

    test('toJson and fromJson round-trip', () {
      final original = AnchorModel(
        id: 'a3',
        width: 12,
        height: 12,
        position: Position.right,
        ratio: 0.7,
        direction: AnchorDirection.inOnly,
        maxConnections: 2,
        acceptedEdgeTypes: ['flow', 'dep'],
        shape: AnchorShape.square,
        arrowDirection: ArrowDirection.outward,
        locked: true,
        version: 5,
        lockedByUser: 'user1',
        plusButtonColorHex: '#fff',
        plusButtonSize: 6.0,
        iconName: 'icon',
        data: {'k': 1},
        placement: AnchorPlacement.inside,
        offsetDistance: 3.0,
        angle: 30.0,
        nodeId: 'nodeX',
      );
      final json = original.toJson();
      final parsed = AnchorModel.fromJson(json);

      expect(parsed.id, equals(original.id));
      expect(parsed.width, equals(original.width));
      expect(parsed.height, equals(original.height));
      expect(parsed.position, equals(original.position));
      expect(parsed.ratio, equals(original.ratio));
      expect(parsed.direction, equals(original.direction));
      expect(parsed.maxConnections, equals(original.maxConnections));
      expect(parsed.acceptedEdgeTypes, equals(original.acceptedEdgeTypes));
      expect(parsed.shape, equals(original.shape));
      expect(parsed.arrowDirection, equals(original.arrowDirection));
      expect(parsed.locked, equals(original.locked));
      expect(parsed.version, equals(original.version));
      expect(parsed.lockedByUser, equals(original.lockedByUser));
      expect(parsed.plusButtonColorHex, equals(original.plusButtonColorHex));
      expect(parsed.plusButtonSize, equals(original.plusButtonSize));
      expect(parsed.iconName, equals(original.iconName));
      expect(parsed.data, equals(original.data));
      expect(parsed.placement, equals(original.placement));
      expect(parsed.offsetDistance, equals(original.offsetDistance));
      expect(parsed.angle, equals(original.angle));
      expect(parsed.nodeId, equals(original.nodeId));
    });
  });

  group('NodeModel', () {
    const sampleId = 'node1';
    const samplePosition = Offset(5, 15);
    const sampleSize = Size(80, 40);
    const sampleStyle = NodeStyle(
      borderColorHex: '#00FF00', // green in hex
      fillColorHex: '#FFFF00', // yellow in hex
    );

    test('defaults and rect', () {
      final node = NodeModel(
        id: sampleId,
        position: samplePosition,
        size: sampleSize,
      );
      expect(node.id, equals(sampleId));
      expect(node.position, equals(samplePosition));
      expect(node.size, equals(sampleSize));
      expect(node.anchors, isEmpty);
      expect(node.data, isEmpty);
      expect(node.rect, equals(const Rect.fromLTWH(5, 15, 80, 40)));
      expect(node.dragMode, equals(DragMode.full));
      expect(node.role, equals(NodeRole.middle));
      expect(node.status, equals(NodeStatus.none));
    });

    test('copyWith overrides and preserves', () {
      final node = NodeModel(
        id: sampleId,
        position: samplePosition,
        size: sampleSize,
      );
      final updated = node.copyWith(
        position: const Offset(0, 0),
        size: const Size(10, 10),
        dragMode: DragMode.handle,
        type: 'T',
        role: NodeRole.start,
        title: 'T1',
        anchors: [
          AnchorModel(
              id: 'a1',
              width: 5,
              height: 5,
              position: Position.top,
              nodeId: sampleId)
        ],
        isGroup: true,
        isGroupRoot: true,
        status: NodeStatus.running,
        parentId: 'p',
        zIndex: 9,
        enabled: false,
        locked: true,
        description: 'd',
        style: sampleStyle,
        version: 7,
        createdAt: DateTime(2000),
        updatedAt: DateTime(2001),
        data: {'x': 2},
      );
      expect(updated.position, equals(const Offset(0, 0)));
      expect(updated.size, equals(const Size(10, 10)));
      expect(updated.dragMode, equals(DragMode.handle));
      expect(updated.type, equals('T'));
      expect(updated.role, equals(NodeRole.start));
      expect(updated.title, equals('T1'));
      expect(updated.anchors.first.id, equals('a1'));
      expect(updated.isGroup, isTrue);
      expect(updated.isGroupRoot, isTrue);
      expect(updated.status, equals(NodeStatus.running));
      expect(updated.parentId, equals('p'));
      expect(updated.zIndex, equals(9));
      expect(updated.enabled, isFalse);
      expect(updated.locked, isTrue);
      expect(updated.description, equals('d'));
      expect(updated.style, equals(sampleStyle));
      expect(updated.version, equals(7));
      expect(updated.createdAt, equals(DateTime(2000)));
      expect(updated.updatedAt, equals(DateTime(2001)));
      expect(updated.data, equals({'x': 2}));
    });

    test('toJson/fromJson round-trip including anchors', () {
      final node = NodeModel(
        id: sampleId,
        position: samplePosition,
        size: sampleSize,
        dragMode: DragMode.handle,
        type: 'custom',
        role: NodeRole.custom,
        title: 'Title',
        anchors: [
          AnchorModel(
            id: 'a1',
            width: 5,
            height: 5,
            position: Position.left,
            nodeId: sampleId,
          )
        ],
        isGroup: true,
        isGroupRoot: false,
        status: NodeStatus.completed,
        parentId: 'P',
        zIndex: 3,
        enabled: false,
        locked: true,
        description: 'desc',
        style: sampleStyle,
        version: 4,
        createdAt: DateTime(1999),
        updatedAt: DateTime(2002),
        data: {'y': 5},
      );
      final json = node.toJson();
      final parsed = NodeModel.fromJson(json);

      expect(parsed.id, equals(node.id));
      expect(parsed.position, equals(node.position));
      expect(parsed.size, equals(node.size));
      expect(parsed.dragMode, equals(node.dragMode));
      expect(parsed.type, equals(node.type));
      expect(parsed.role, equals(node.role));
      expect(parsed.title, equals(node.title));
      expect(parsed.anchors.length, equals(1));
      expect(parsed.anchors.first.nodeId, equals(sampleId));
      expect(parsed.isGroup, equals(node.isGroup));
      expect(parsed.status, equals(node.status));
      expect(parsed.parentId, equals(node.parentId));
      expect(parsed.zIndex, equals(node.zIndex));
      expect(parsed.enabled, equals(node.enabled));
      expect(parsed.locked, equals(node.locked));
      expect(parsed.description, equals(node.description));
      expect(parsed.style, equals(node.style));
      expect(parsed.version, equals(node.version));
      expect(parsed.createdAt, equals(node.createdAt));
      expect(parsed.updatedAt, equals(node.updatedAt));
      expect(parsed.data, equals(node.data));
    });

    test('enum fallback on unknown values', () {
      final json = {
        'id': sampleId,
        'position': {'dx': 1, 'dy': 2},
        'size': {'width': 3, 'height': 4},
        'dragMode': 'DragMode.none',
        'role': 'NodeRole.unknown',
        'status': 'NodeStatus.ghost',
      };
      final node = NodeModel.fromJson(json);
      expect(node.dragMode, equals(DragMode.full));
      expect(node.role, equals(NodeRole.middle));
      expect(node.status, equals(NodeStatus.none));
    });
  });
}
