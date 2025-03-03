// file: test/edge/controllers/edge_interaction_manager_test.dart
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:mockito/mockito.dart';
// or 'package:mocktail/mocktail.dart' if you prefer
import 'package:flow_editor/core/state_management/edge_state/edge_state_provider.dart';
import 'package:flow_editor/core/edge/interaction/edge_interaction_manager.dart';

class MockEdgeStateNotifier extends Mock implements EdgeStateNotifier {}

void main() {
  group('EdgeInteractionManager Tests', () {
    late MockEdgeStateNotifier mockNotifier;
    late EdgeInteractionManager manager;

    // We'll define a "mockRead" function that, when it's asked for edgeStateProvider.notifier,
    // we return our mockNotifier. For other providers, if any, we can handle them or return null.
    T mockRead<T>(provider) {
      if (provider == edgeStateProvider.notifier) {
        return mockNotifier as T;
      }
      throw UnimplementedError(
          'mockRead only handles edgeStateProvider.notifier');
    }

    setUp(() {
      mockNotifier = MockEdgeStateNotifier();
      manager = EdgeInteractionManager(read: mockRead);
    });

    test('createEdge calls upsertEdge with correct new EdgeModel', () {
      final edge = manager.createEdge(
        workflowId: 'main',
        sourceNodeId: 'nodeA',
        sourceAnchorId: 'aA',
        targetNodeId: 'nodeB',
        targetAnchorId: 'aB',
        edgeType: 'flow',
      );

      expect(edge.id, startsWith('edge-')); // or check length or etc
      expect(edge.sourceNodeId, 'nodeA');
      expect(edge.targetNodeId, 'nodeB');
      expect(edge.edgeType, 'flow');

      // verify mockNotifier was called with the same edge
      verify(mockNotifier.upsertEdge('main', edge)).called(1);
    });

    test('deleteEdge calls removeEdge', () {
      manager.deleteEdge('main', 'edgeX');
      verify(mockNotifier.removeEdge('main', 'edgeX')).called(1);
    });

    test('deleteEdgesOfNode calls removeEdgesOfNode', () {
      manager.deleteEdgesOfNode('main', 'nodeZ');
      verify(mockNotifier.removeEdgesOfNode('main', 'nodeZ')).called(1);
    });

    test(
        'onEdgeTap just prints, but we can check no crash & logs if you wrap debugPrint',
        () {
      // For demonstration, we'll just ensure it doesn't throw
      expect(
        () => manager.onEdgeTap('main', 'edge1', const Offset(10, 10)),
        returnsNormally,
      );
      // If you had a real selection logic => you'd test that.
      // e.g. manager => selectionManager.selectEdge(edgeId)?
    });

    test('onEdgeHover does nothing by default => no crash', () {
      expect(
        () => manager.onEdgeHover('main', 'edge2', true),
        returnsNormally,
      );
    });

    test(
        'onDragEdgeEndpoint is partial => you can test if you implement re-hittest etc.',
        () {
      // currently just a stub. If you want to test "Edge re-connection" you'd do:
      manager.onDragEdgeEndpoint(
        workflowId: 'main',
        edgeId: 'edge3',
        isSourceSide: true,
        newWorldPos: const Offset(200, 200),
      );
      // we can verify no calls happen or partial if you had code in it
      // e.g. verify(mockNotifier.upsertEdge()).called(1); if your code does that
    });
  });
}
