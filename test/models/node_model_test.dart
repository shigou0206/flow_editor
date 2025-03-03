import 'package:flutter_test/flutter_test.dart';
import 'package:flow_editor/core/node/models/node_model.dart';
import 'package:flow_editor/core/anchor/models/anchor_model.dart';
import 'package:flow_editor/core/types/position_enum.dart';
import 'package:flow_editor/core/node/models/node_enums.dart';

void main() {
  group('NodeModel Tests', () {
    late NodeModel basicNode;
    late NodeModel fullNode;

    setUp(() {
      // 基础节点 - 最小必需字段
      basicNode = NodeModel(
        id: 'node-1',
        x: 100,
        y: 200,
        width: 80,
        height: 40,
        type: 'default',
        title: 'Basic Node',
        anchors: [],
      );

      // 完整节点 - 所有字段
      fullNode = NodeModel(
        id: 'node-2',
        x: 150,
        y: 250,
        width: 100,
        height: 60,
        dragMode: DragMode.handle,
        type: 'custom',
        role: NodeRole.start,
        title: 'Full Node',
        anchors: [
          AnchorModel(
            id: 'anchor-1',
            nodeId: 'node-2',
            position: Position.left,
            ratio: 0.5,
          ),
          AnchorModel(
            id: 'anchor-2',
            nodeId: 'node-2',
            position: Position.right,
            ratio: 0.5,
          ),
        ],
        status: NodeStatus.running,
        parentId: 'parent-1',
        zIndex: 2,
        enabled: true,
        locked: false,
        description: 'Test node',
        style: const NodeStyle(
          fillColorHex: '#FF0000',
          borderColorHex: '#000000',
          borderWidth: 2.0,
          borderRadius: 8.0,
        ),
        version: 2,
        createdAt: DateTime(2024),
        updatedAt: DateTime(2024),
        inputs: {'input1': 'value1'},
        outputs: {'output1': 'value1'},
        config: {'config1': 'value1'},
        data: {'key1': 'value1'},
      );
    });

    group('Constructor & Getters', () {
      test('should create basic node with default values', () {
        expect(basicNode.id, 'node-1');
        expect(basicNode.x, 100);
        expect(basicNode.y, 200);
        expect(basicNode.width, 80);
        expect(basicNode.height, 40);
        expect(basicNode.dragMode, DragMode.full);
        expect(basicNode.role, NodeRole.middle);
        expect(basicNode.status, NodeStatus.none);
        expect(basicNode.anchors, isEmpty);
        expect(basicNode.inputs, isEmpty);
        expect(basicNode.outputs, isEmpty);
        expect(basicNode.config, isEmpty);
        expect(basicNode.data, isEmpty);
      });

      test('should create full node with all values', () {
        expect(fullNode.id, 'node-2');
        expect(fullNode.dragMode, DragMode.handle);
        expect(fullNode.role, NodeRole.start);
        expect(fullNode.status, NodeStatus.running);
        expect(fullNode.anchors.length, 2);
        expect(fullNode.style?.fillColorHex, '#FF0000');
        expect(fullNode.inputs['input1'], 'value1');
        expect(fullNode.version, 2);
      });

      test('rect getter should return correct Rect', () {
        final rect = basicNode.rect;
        expect(rect.left, basicNode.x);
        expect(rect.top, basicNode.y);
        expect(rect.width, basicNode.width);
        expect(rect.height, basicNode.height);
      });
    });

    group('Anchor Position Tests', () {
      test('should calculate correct anchor positions', () {
        final leftAnchor = AnchorModel(
          id: 'left',
          nodeId: 'node-2',
          position: Position.left,
          ratio: 0.5,
        );
        final rightAnchor = AnchorModel(
          id: 'right',
          nodeId: 'node-2',
          position: Position.right,
          ratio: 0.5,
        );

        final leftPos = basicNode.getAnchorOffset(leftAnchor);
        final rightPos = basicNode.getAnchorOffset(rightAnchor);

        expect(leftPos.dx, basicNode.x);
        expect(leftPos.dy, basicNode.y + basicNode.height * 0.5);
        expect(rightPos.dx, basicNode.x + basicNode.width);
        expect(rightPos.dy, basicNode.y + basicNode.height * 0.5);
      });
    });

    group('copyWith Tests', () {
      test('should create new instance with updated fields', () {
        final updated = basicNode.copyWith(
          x: 300,
          y: 400,
          status: NodeStatus.completed,
          data: {'newKey': 'newValue'},
        );

        expect(updated.id, basicNode.id);
        expect(updated.x, 300);
        expect(updated.y, 400);
        expect(updated.status, NodeStatus.completed);
        expect(updated.data['newKey'], 'newValue');
        expect(updated, isNot(same(basicNode)));
      });
    });

    group('Serialization Tests', () {
      test('should correctly serialize to JSON', () {
        final json = fullNode.toJson();

        expect(json['id'], fullNode.id);
        expect(json['x'], fullNode.x);
        expect(json['y'], fullNode.y);
        expect(json['type'], fullNode.type);
        expect(json['role'], fullNode.role.toString());
        expect(json['status'], fullNode.status.toString());
        expect(json['style']?['fillColorHex'], fullNode.style?.fillColorHex);
        expect(json['inputs'], fullNode.inputs);
        expect(json['data'], fullNode.data);
      });

      test('should correctly deserialize from JSON', () {
        final json = fullNode.toJson();
        final recovered = NodeModel.fromJson(json);

        expect(recovered.id, fullNode.id);
        expect(recovered.x, fullNode.x);
        expect(recovered.y, fullNode.y);
        expect(recovered.type, fullNode.type);
        expect(recovered.role, fullNode.role);
        expect(recovered.status, fullNode.status);
        expect(recovered.style?.fillColorHex, fullNode.style?.fillColorHex);
        expect(recovered.inputs, fullNode.inputs);
        expect(recovered.data, fullNode.data);
      });
    });
  });
}
