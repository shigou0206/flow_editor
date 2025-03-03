import 'package:flutter_test/flutter_test.dart';
import 'package:flow_editor/core/state_management/node_state/node_state_provider.dart';
import 'package:flow_editor/core/node/models/node_model.dart';
import 'package:flow_editor/core/types/position_enum.dart';
import 'package:flow_editor/core/anchor/models/anchor_model.dart';

void main() {
  group('NodeStateNotifier Tests (Family Provider)', () {
    late NodeStateNotifier notifier;

    const workflowId = 'workflow-1';
    final nodeA = NodeModel(
      id: 'node-a',
      x: 100,
      y: 100,
      width: 200,
      height: 100,
      type: 'custom',
      title: 'Node A',
      anchors: [
        AnchorModel(id: 'anchor-1', position: Position.left, nodeId: 'node-a'),
      ],
    );

    final nodeB = NodeModel(
      id: 'node-b',
      x: 300,
      y: 150,
      width: 200,
      height: 100,
      type: 'custom',
      title: 'Node B',
      anchors: [
        AnchorModel(id: 'anchor-2', position: Position.right, nodeId: 'node-b'),
      ],
    );

    setUp(() {
      notifier = NodeStateNotifier(workflowId: workflowId);
    });

    test('Initial state should be empty', () {
      expect(notifier.state.nodesByWorkflow, isEmpty);
    });

    test('upsertNode should insert a new node', () {
      notifier.upsertNode(nodeA);

      expect(notifier.getNode(nodeA.id), equals(nodeA));
      expect(notifier.getNodes(), hasLength(1));
    });

    test('upsertNode should update existing node', () {
      notifier.upsertNode(nodeA);
      final updatedNodeA = nodeA.copyWith(x: 500, y: 500);

      notifier.upsertNode(updatedNodeA);

      expect(notifier.getNode(nodeA.id)?.x, 500);
      expect(notifier.getNode(nodeA.id)?.y, 500);
    });

    test('upsertNodes should insert multiple nodes', () {
      notifier.upsertNodes([nodeA, nodeB]);

      expect(notifier.getNodes(), hasLength(2));
      expect(notifier.getNode(nodeB.id), equals(nodeB));
    });

    test('removeNode should delete specified node', () {
      notifier.upsertNodes([nodeA, nodeB]);
      notifier.removeNode(nodeA.id);

      expect(notifier.getNodes(), hasLength(1));
      expect(notifier.getNode(nodeA.id), isNull);
    });

    test('removeNode with non-existent id should not change state', () {
      notifier.upsertNode(nodeA);

      notifier.removeNode('non-existent');

      expect(notifier.getNodes(), hasLength(1));
    });

    test('removeNodes should delete multiple nodes', () {
      notifier.upsertNodes([nodeA, nodeB]);

      notifier.removeNodes([nodeA.id, nodeB.id]);

      expect(notifier.getNodes(), isEmpty);
    });

    test('clearWorkflow should remove all nodes', () {
      notifier.upsertNodes([nodeA, nodeB]);

      notifier.clearWorkflow();

      expect(notifier.getNodes(), isEmpty);
    });

    test('removeWorkflow should remove entire workflow', () {
      notifier.upsertNode(nodeA);

      notifier.removeWorkflow();

      expect(notifier.state.nodesByWorkflow.containsKey(workflowId), isFalse);
    });

    test('nodeExists should correctly identify node existence', () {
      notifier.upsertNode(nodeA);

      expect(notifier.nodeExists(nodeA.id), isTrue);
      expect(notifier.nodeExists(nodeB.id), isFalse);
    });

    test('avoid unnecessary state updates', () {
      notifier.upsertNode(nodeA);
      final prevState = notifier.state;

      notifier.upsertNode(nodeA);

      expect(identical(notifier.state, prevState), isTrue);
    });
  });
}
