// file: test/edge/controllers/edge_controller_test.dart

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:riverpod/riverpod.dart';

import 'package:flow_editor/core/edge/controllers/edge_controller.dart';
import 'package:flow_editor/core/edge/behaviors/edge_behavior.dart';
import 'package:flow_editor/core/edge/models/edge_model.dart';
import 'package:flow_editor/core/state_management/edge_state/edge_state_provider.dart';

class MockEdgeBehavior extends Mock implements EdgeBehavior {}

void main() {
  group('EdgeController Tests', () {
    late ProviderContainer container;
    late EdgeController controller;
    late MockEdgeBehavior mockBehavior;

    setUp(() {
      mockBehavior = MockEdgeBehavior();

      container = ProviderContainer(
        overrides: [
          edgeStateProvider.overrideWith((ref) => EdgeStateNotifier()),
        ],
      );

      controller = EdgeController(container: container, behavior: mockBehavior);
    });

    test('createEdge calls behavior.onEdgeCreated and updates state', () {
      final edge =
          EdgeModel(id: 'edge1', sourceNodeId: 'n1', sourceAnchorId: 'a1');
      controller.createEdge('wf1', edge);

      verify(mockBehavior.onEdgeCreated(edge)).called(1);

      final state = container.read(edgeStateProvider);
      expect(state.edgesOf('wf1').containsKey('edge1'), true);
    });

    test('updateEdge only updates when data changed', () {
      final originalEdge =
          EdgeModel(id: 'edge1', sourceNodeId: 'n1', sourceAnchorId: 'a1');
      final updatedEdge = originalEdge.copyWith(sourceNodeId: 'n2');

      container
          .read(edgeStateProvider.notifier)
          .upsertEdge('wf1', originalEdge);

      controller.updateEdge('wf1', originalEdge, updatedEdge);

      verify(mockBehavior.onEdgeUpdated(originalEdge, updatedEdge)).called(1);

      final state = container.read(edgeStateProvider);
      expect(state.edgesOf('wf1')['edge1']?.sourceNodeId, 'n2');

      // 尝试用相同数据更新
      controller.updateEdge('wf1', updatedEdge, updatedEdge);
      verifyNever(mockBehavior.onEdgeUpdated(updatedEdge, updatedEdge));
    });

    test('deleteEdge deletes unlocked edge and skips locked edge', () {
      final lockedEdge = EdgeModel(
          id: 'lockedEdge',
          sourceNodeId: 'n1',
          sourceAnchorId: 'a1',
          locked: true);
      final unlockedEdge =
          EdgeModel(id: 'edge2', sourceNodeId: 'n2', sourceAnchorId: 'a2');

      final notifier = container.read(edgeStateProvider.notifier);
      notifier.upsertEdge('wf1', lockedEdge);
      notifier.upsertEdge('wf1', unlockedEdge);

      controller.deleteEdge('wf1', unlockedEdge);
      verify(mockBehavior.onEdgeDelete(unlockedEdge)).called(1);

      var state = container.read(edgeStateProvider);
      expect(state.edgesOf('wf1').containsKey('edge2'), false);

      controller.deleteEdge('wf1', lockedEdge);
      verifyNever(mockBehavior.onEdgeDelete(lockedEdge));

      state = container.read(edgeStateProvider);
      expect(state.edgesOf('wf1').containsKey('lockedEdge'), true);
    });

    // test('selectEdge selects existing edge and ignores non-existent edge', () {
    //   final edge =
    //       EdgeModel(id: 'edge3', sourceNodeId: 'n3', sourceAnchorId: 'a3');
    //   container.read(edgeStateProvider.notifier).upsertEdge('wf1', edge);

    //   controller.selectEdge('edge3');

    //   verify(mockBehavior.onEdgeSelected(edge)).called(1);
    //   final state = container.read(edgeStateProvider);
    //   expect(state.selectedEdgeIds.contains('edge3'), true);

    //   // 尝试选中不存在的边
    //   controller.selectEdge('nonExistingEdge');
    //   verifyNever(mockBehavior.onEdgeSelected(argThat(isA<EdgeModel>())));
    // });

    test('deselectEdge deselects edge', () {
      final edge =
          EdgeModel(id: 'edge4', sourceNodeId: 'n4', sourceAnchorId: 'a4');
      final notifier = container.read(edgeStateProvider.notifier);
      notifier.upsertEdge('wf1', edge);
      notifier.selectEdge('edge4');

      controller.deselectEdge('edge4');

      verify(mockBehavior.onEdgeDeselected(edge)).called(1);
      final state = container.read(edgeStateProvider);
      expect(state.selectedEdgeIds.contains('edge4'), false);
    });
  });
}
