import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flow_editor/core/node/controllers/node_controller.dart';
import 'package:flow_editor/core/node/models/node_model.dart';
import 'package:flow_editor/core/types/position_enum.dart';
import 'package:flow_editor/core/anchor/models/anchor_model.dart';

void main() {
  group('NodeController Tests', () {
    late ProviderContainer container;
    late NodeController controller;
    const workflowId = 'test-workflow';

    final nodeA = NodeModel(
      id: 'node-a',
      x: 100,
      y: 100,
      width: 200,
      height: 100,
      type: 'custom',
      title: 'Node A',
      anchors: [
        AnchorModel(id: 'anchor-1', position: Position.left, nodeId: 'node-a')
      ],
    );

    final nodeB = NodeModel(
      id: 'node-b',
      x: 300,
      y: 200,
      width: 150,
      height: 80,
      type: 'default',
      title: 'Node B',
      anchors: [
        AnchorModel(id: 'anchor-2', position: Position.right, nodeId: 'node-b')
      ],
    );

    setUp(() {
      container = ProviderContainer();
      controller = NodeController(container: container, workflowId: workflowId);
    });

    tearDown(() => container.dispose());

    test('should upsert and retrieve node', () {
      controller.upsertNode(nodeA);
      expect(controller.getNode(nodeA.id), equals(nodeA));
    });

    test('should remove node correctly', () {
      controller.upsertNode(nodeA);
      controller.removeNode(nodeA.id);
      expect(controller.getNode(nodeA.id), isNull);
    });

    test('should clear all nodes', () {
      controller.upsertNodes([nodeA, nodeB]);
      controller.clearNodes();
      expect(controller.getAllNodes(), isEmpty);
    });

    test('should retrieve nodes by type', () {
      controller.upsertNodes([nodeA, nodeB]);
      final customNodes = controller.getNodesByType('custom');
      expect(customNodes, equals([nodeA]));
    });

    test('nodeExists returns correct result', () {
      controller.upsertNode(nodeA);
      expect(controller.nodeExists(nodeA.id), isTrue);
      expect(controller.nodeExists('non-existent'), isFalse);
    });

    test('should trigger event callbacks', () {
      NodeModel? addedNode;
      NodeModel? removedNode;

      controller.onNodeAdded = (node) => addedNode = node;
      controller.onNodeRemoved = (node) => removedNode = node;

      controller.upsertNode(nodeA);
      expect(addedNode, equals(nodeA));

      controller.removeNode(nodeA.id);
      expect(removedNode, equals(nodeA));
    });

    test('findNode works correctly', () {
      controller.upsertNodes([nodeA, nodeB]);
      final foundNode = controller.findNode((node) => node.title == 'Node B');
      expect(foundNode, equals(nodeB));
    });

    test('should handle upserting duplicate node correctly', () {
      controller.upsertNode(nodeA);
      final updatedNodeA = nodeA.copyWith(x: 500);
      controller.upsertNode(updatedNodeA);

      final fetchedNode = controller.getNode(nodeA.id);
      expect(fetchedNode?.x, equals(500));
    });

    test('should handle removing non-existent node gracefully', () {
      expect(() => controller.removeNode('non-existent-id'), returnsNormally);
    });

    test('upsertNodes with empty list should not change state', () {
      controller.upsertNodes([]);
      expect(controller.getAllNodes(), isEmpty);
    });

    test('removeNodes with empty list should not change state', () {
      controller.upsertNode(nodeA);
      controller.removeNodes([]);
      expect(controller.getAllNodes(), [nodeA]);
    });

    test('should trigger callbacks correctly on batch insert', () {
      final addedNodes = <NodeModel>[];
      controller.onNodeAdded = (node) => addedNodes.add(node);

      controller.upsertNodes([nodeA, nodeB]);
      expect(addedNodes.length, equals(2));
    });

    test('should trigger callbacks correctly on clearNodes', () {
      final removedNodes = <NodeModel>[];
      controller.onNodeRemoved = (node) => removedNodes.add(node);

      controller.upsertNodes([nodeA, nodeB]);
      controller.clearNodes();
      expect(removedNodes, containsAll([nodeA, nodeB]));
    });

    test('findNode returns null if no match found', () {
      controller.upsertNode(nodeA);
      final foundNode = controller.findNode((node) => node.id == 'invalid-id');
      expect(foundNode, isNull);
    });
  });
}
