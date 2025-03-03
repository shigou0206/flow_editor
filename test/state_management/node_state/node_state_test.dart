import 'package:flutter_test/flutter_test.dart';
import 'package:flow_editor/core/state_management/node_state/node_state.dart';
import 'package:flow_editor/core/node/models/node_model.dart';
import 'package:flow_editor/core/anchor/models/anchor_model.dart';
import 'package:flow_editor/core/types/position_enum.dart';

void main() {
  group('NodeState Tests', () {
    late NodeState initialState;
    final nodeA = NodeModel(
      id: 'node-a',
      x: 10,
      y: 10,
      width: 100,
      height: 50,
      type: 'typeA',
      title: 'Node A',
      anchors: [
        AnchorModel(id: 'anchor-1', position: Position.left, nodeId: 'node-a'),
      ],
    );
    final nodeB = NodeModel(
      id: 'node-b',
      x: 50,
      y: 50,
      width: 150,
      height: 75,
      type: 'typeB',
      title: 'Node B',
      anchors: [
        AnchorModel(id: 'anchor-2', position: Position.right, nodeId: 'node-b'),
      ],
    );

    setUp(() {
      initialState = const NodeState();
    });

    test('Initial state should be empty', () {
      expect(initialState.nodesByWorkflow, isEmpty);
      expect(initialState.nodeIdsByType, isEmpty);
      expect(initialState.version, 1);
    });

    test('updateWorkflowNodes should correctly add nodes', () {
      final updatedState = initialState.updateWorkflowNodes('workflow-1', {
        nodeA.id: nodeA,
        nodeB.id: nodeB,
      });

      expect(updatedState.nodesOf('workflow-1').length, 2);
      expect(updatedState.version, initialState.version + 1);

      final typeAIds = updatedState.nodesByType('typeA');
      expect(typeAIds.contains('node-a'), isTrue);
      expect(typeAIds.length, 1);

      final typeBIds = updatedState.nodesByType('typeB');
      expect(typeBIds.contains('node-b'), isTrue);
      expect(typeBIds.length, 1);
    });

    test('updateWorkflowNodes should overwrite existing nodes', () {
      final stateWithNodeA = initialState.updateWorkflowNodes('workflow-1', {
        nodeA.id: nodeA,
      });

      final updatedNodeA = nodeA.copyWith(title: 'Node A Updated');
      final updatedState = stateWithNodeA
          .updateWorkflowNodes('workflow-1', {nodeA.id: updatedNodeA});

      expect(updatedState.nodesOf('workflow-1').length, 1);
      expect(updatedState.nodesOf('workflow-1')['node-a']?.title,
          'Node A Updated');
      expect(updatedState.version, stateWithNodeA.version + 1);
    });

    test('rebuildIndexes should correctly rebuild type indexes', () {
      final intermediateState = initialState.copyWith(
        nodesByWorkflow: {
          'workflow-1': {nodeA.id: nodeA},
          'workflow-2': {nodeB.id: nodeB},
        },
      );

      final rebuiltState =
          intermediateState.rebuildIndexes(intermediateState.nodesByWorkflow);

      expect(rebuiltState.nodeIdsByType['typeA'], contains('node-a'));
      expect(rebuiltState.nodeIdsByType['typeB'], contains('node-b'));
      expect(rebuiltState.version, initialState.version);
    });

    test('removeWorkflow should correctly remove workflow', () {
      final stateWithWorkflows = initialState.copyWith(
        nodesByWorkflow: {
          'workflow-1': {nodeA.id: nodeA},
          'workflow-2': {nodeB.id: nodeB},
        },
      );

      final updatedState = stateWithWorkflows.removeWorkflow('workflow-1');

      expect(updatedState.nodesByWorkflow.containsKey('workflow-1'), isFalse);
      expect(updatedState.nodesByWorkflow.containsKey('workflow-2'), isTrue);
      expect(updatedState.version, stateWithWorkflows.version);
    });

    test('removeWorkflow on non-existent workflow should not change state', () {
      final stateWithWorkflow = initialState.copyWith(
        nodesByWorkflow: {
          'workflow-1': {nodeA.id: nodeA},
        },
      );

      final updatedState =
          stateWithWorkflow.removeWorkflow('non-existent-workflow');

      expect(updatedState, equals(stateWithWorkflow));
    });

    test('copyWith without arguments should return identical state', () {
      final copiedState = initialState.copyWith();

      expect(copiedState, equals(initialState));
    });

    test('nodesByType should return empty set if type does not exist', () {
      expect(initialState.nodesByType('non-existent-type'), isEmpty);
    });

    test('nodesOf should return empty map if workflow does not exist', () {
      expect(initialState.nodesOf('non-existent-workflow'), isEmpty);
    });
  });
}
