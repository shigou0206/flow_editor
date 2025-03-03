// import 'package:flutter_test/flutter_test.dart';
// import 'package:riverpod/riverpod.dart';

// import 'package:flow_editor/core/edge/models/edge_model.dart';
// import 'package:flow_editor/core/edge/models/edge_animation_config.dart';
// // 若 "edge_state.dart" 和 "edge_state_provider.dart" 路径不同，请相应修改
// import 'package:flow_editor/core/state_management/edge_state/edge_state.dart';
// import 'package:flow_editor/core/state_management/edge_state/edge_state_provider.dart';

// void main() {
//   group('EdgeState basic tests', () {
//     test('Default constructor has empty maps', () {
//       const state = EdgeState();
//       expect(state.edgesByWorkflow.isEmpty, isTrue);
//       expect(state.edgeIdsByType.isEmpty, isTrue);
//       expect(state.version, 1);
//       // 如果有selectedEdgeIds,可测 expect(state.selectedEdgeIds.isEmpty, isTrue);
//     });

//     test('updateWorkflowEdges replaces workflow edges, rebuild indexes', () {
//       const edgeA = EdgeModel(
//         id: 'edgeA',
//         sourceNodeId: 'node1',
//         sourceAnchorId: 'anchor1',
//         targetNodeId: 'node2',
//         targetAnchorId: 'anchor2',
//         edgeType: 'flow',
//       );
//       const edgeB = EdgeModel(
//         id: 'edgeB',
//         sourceNodeId: 'node3',
//         sourceAnchorId: 'anchor3',
//         targetNodeId: 'node4',
//         targetAnchorId: 'anchor4',
//         edgeType: 'dependency',
//       );

//       var state = const EdgeState();
//       final newMap = {
//         edgeA.id: edgeA,
//         edgeB.id: edgeB,
//       };

//       // update workflow 'default'
//       state = state.updateWorkflowEdges('default', newMap);

//       expect(state.edgesByWorkflow.length, 1);
//       expect(state.edgesByWorkflow['default']?.length, 2);

//       // check typeIndex
//       expect(state.edgeIdsByType['flow']?.contains('edgeA'), isTrue);
//       expect(state.edgeIdsByType['dependency']?.contains('edgeB'), isTrue);

//       // version incremented
//       expect(state.version, 2);
//     });

//     test('removeWorkflow removes entire workflow', () {
//       const edgeA = EdgeModel(
//         id: 'edgeA',
//         sourceNodeId: 'node1',
//         sourceAnchorId: 'anchor1',
//         edgeType: 'flow',
//       );

//       // version=1 => updateWorkflowEdges => version=2 => again => version=3
//       final state = const EdgeState()
//           .updateWorkflowEdges('main', {edgeA.id: edgeA}) // => version=2
//           .updateWorkflowEdges('sub', {}); // => version=3

//       expect(state.edgesByWorkflow.keys.length, 2);

//       final removed = state.removeWorkflow('sub'); // => version=4
//       expect(removed.edgesByWorkflow.length, 1);
//       expect(removed.edgesByWorkflow.containsKey('sub'), isFalse);
//       expect(removed.version, 4);
//     });
//   });

//   group('EdgeStateNotifier tests', () {
//     late ProviderContainer container;
//     late EdgeStateNotifier notifier;

//     setUp(() {
//       container = ProviderContainer();
//       notifier = container.read(edgeStateProvider.notifier);
//     });

//     test('default EdgeStateNotifier init', () {
//       final state = container.read(edgeStateProvider);
//       expect(state.edgesByWorkflow.isEmpty, isTrue);
//       expect(state.version, 1);
//       // 也可 expect(state.selectedEdgeIds, isEmpty);
//     });

//     test('upsertEdge inserts or updates single edge', () {
//       const edgeA = EdgeModel(
//         id: 'edgeA',
//         sourceNodeId: 'node1',
//         sourceAnchorId: 'anchor1',
//         edgeType: 'flow',
//       );

//       notifier.upsertEdge('main', edgeA);

//       var state = container.read(edgeStateProvider);
//       expect(state.edgesOf('main').length, 1);
//       expect(state.edgeIdsByType['flow']?.contains('edgeA') ?? false, isTrue);

//       // update edgeA with new type => 'dependency'
//       final edgeA2 = edgeA.copyWith(edgeType: 'dependency');
//       notifier.upsertEdge('main', edgeA2);

//       state = container.read(edgeStateProvider);
//       expect(state.edgesOf('main').length, 1);
//       expect(state.edgeIdsByType['flow']?.contains('edgeA') ?? false, isFalse);
//       expect(state.edgeIdsByType['dependency']?.contains('edgeA') ?? false,
//           isTrue);
//     });

//     test('removeEdge deletes single edge', () {
//       final edgeA = EdgeModel(
//         id: 'edgeA',
//         sourceNodeId: 'node1',
//         sourceAnchorId: 'a1',
//         edgeType: 'flow',
//       );
//       notifier.upsertEdge('main', edgeA);

//       expect(container.read(edgeStateProvider).edgesOf('main').length, 1);

//       notifier.removeEdge('main', 'edgeA');
//       final state = container.read(edgeStateProvider);
//       expect(state.edgesOf('main').length, 0);

//       // typeIndex check
//       expect(state.edgeIdsByType['flow'], anyOf(isNull, isEmpty));
//     });

//     test('removeEdgesOfNode removes edges referencing node', () {
//       const edge1 = EdgeModel(
//         id: 'edge1',
//         sourceNodeId: 'nodeA',
//         sourceAnchorId: 'a1',
//         targetNodeId: 'nodeB',
//         targetAnchorId: 'b1',
//         edgeType: 'flow',
//       );
//       const edge2 = EdgeModel(
//         id: 'edge2',
//         sourceNodeId: 'nodeA',
//         sourceAnchorId: 'a2',
//         targetNodeId: 'nodeC',
//         targetAnchorId: 'c2',
//         edgeType: 'flow',
//       );
//       const edge3 = EdgeModel(
//         id: 'edge3',
//         sourceNodeId: 'nodeX',
//         sourceAnchorId: 'x1',
//         targetNodeId: 'nodeY',
//         targetAnchorId: 'y1',
//         edgeType: 'dependency',
//       );

//       notifier.upsertEdge('main', edge1);
//       notifier.upsertEdge('main', edge2);
//       notifier.upsertEdge('main', edge3);

//       final stateBefore = container.read(edgeStateProvider);
//       expect(stateBefore.edgesOf('main').length, 3);

//       // remove edges referencing nodeA
//       notifier.removeEdgesOfNode('main', 'nodeA');

//       final stateAfter = container.read(edgeStateProvider);
//       expect(stateAfter.edgesOf('main').length, 1);
//       expect(stateAfter.edgesOf('main').containsKey('edge3'), isTrue);
//     });

//     test('setWorkflowEdges replaces entire workflow', () {
//       const eA = EdgeModel(
//         id: 'eA',
//         sourceNodeId: 's1',
//         sourceAnchorId: 'sa1',
//         edgeType: 'flow',
//       );
//       const eB = EdgeModel(
//         id: 'eB',
//         sourceNodeId: 's2',
//         sourceAnchorId: 'sa2',
//         edgeType: 'dependency',
//       );

//       // set edges => 'main'
//       notifier.setWorkflowEdges('main', {eA.id: eA, eB.id: eB});
//       final state = container.read(edgeStateProvider);
//       expect(state.edgesOf('main').length, 2);
//       expect(state.edgeIdsByType['flow']?.contains('eA') ?? false, isTrue);
//       expect(
//           state.edgeIdsByType['dependency']?.contains('eB') ?? false, isTrue);

//       // replace with only eA
//       notifier.setWorkflowEdges('main', {eA.id: eA});
//       final newState = container.read(edgeStateProvider);
//       expect(newState.edgesOf('main').length, 1);
//       expect(newState.edgesOf('main').containsKey('eB'), isFalse);
//     });

//     test('removeWorkflow removes entire workflow from state', () {
//       const e1 = EdgeModel(
//         id: 'e1',
//         sourceNodeId: 'n1',
//         sourceAnchorId: 'a1',
//         edgeType: 'flow',
//       );
//       const e2 = EdgeModel(
//         id: 'e2',
//         sourceNodeId: 'n2',
//         sourceAnchorId: 'a2',
//         edgeType: 'flow',
//       );
//       notifier.upsertEdge('flowA', e1);
//       notifier.upsertEdge('flowB', e2);

//       var st = container.read(edgeStateProvider);
//       expect(st.edgesByWorkflow.keys.length, 2);

//       notifier.removeWorkflow('flowA');
//       st = container.read(edgeStateProvider);
//       expect(st.edgesByWorkflow.keys.length, 1);
//       expect(st.edgesByWorkflow.containsKey('flowA'), isFalse);
//     });

//     test('locked edge is still removed (no special lock logic)', () {
//       final lockedEdge = const EdgeModel(
//         id: 'edgeLock1',
//         sourceNodeId: 'nodeA',
//         sourceAnchorId: 'anchorA',
//         locked: true,
//       );
//       notifier.upsertEdge('main', lockedEdge);

//       // Attempt to remove
//       notifier.removeEdge('main', 'edgeLock1');

//       final state = container.read(edgeStateProvider);
//       // 期待 lockedEdge 已被删除
//       expect(
//         state.edgesOf('main').containsKey('edgeLock1'),
//         isFalse,
//         reason: 'Currently locked edge is treated the same, and gets removed',
//       );
//     });

//     test('upsertEdge with half-connected edge does not break indexing', () {
//       final halfEdge = const EdgeModel(
//         id: 'edgeHalf',
//         sourceNodeId: 'nodeX',
//         sourceAnchorId: 'anchorX',
//         // no target => isConnected = false
//         isConnected: false,
//         edgeType: 'flow',
//       );

//       notifier.upsertEdge('main', halfEdge);
//       final state = container.read(edgeStateProvider);

//       // halfEdge is stored in edgesOf('main')
//       expect(state.edgesOf('main').containsKey('edgeHalf'), isTrue);
//       // if your code still indexes it by 'flow'
//       expect(
//           state.edgeIdsByType['flow']?.contains('edgeHalf') ?? false, isTrue);

//       // finalize connect
//       final connectedEdge = halfEdge.copyWith(
//         targetNodeId: 'nodeY',
//         targetAnchorId: 'anchorY',
//         isConnected: true,
//       );
//       notifier.upsertEdge('main', connectedEdge);

//       final updated = container.read(edgeStateProvider);
//       final finalEdge = updated.edgesOf('main')['edgeHalf']!;
//       expect(finalEdge.isConnected, isTrue);
//       expect(finalEdge.targetNodeId, 'nodeY');
//     });

//     test('toggleSelectEdge toggles selected set', () {
//       // 1) Insert an edge
//       const edgeA = EdgeModel(
//         id: 'edgeA',
//         sourceNodeId: 'node1',
//         sourceAnchorId: 'anchor1',
//       );
//       notifier.upsertEdge('main', edgeA);

//       // 2) Toggle => add 'edgeA' to selection
//       notifier.toggleSelectEdge('edgeA');
//       var st = container.read(edgeStateProvider);
//       expect(st.selectedEdgeIds.contains('edgeA'), isTrue);

//       // 3) toggle => remove from selection
//       notifier.toggleSelectEdge('edgeA');
//       st = container.read(edgeStateProvider);
//       expect(st.selectedEdgeIds.contains('edgeA'), isFalse);
//     });

//     test('update edge waypoints', () {
//       final edgeWps = const EdgeModel(
//         id: 'edgeWp',
//         sourceNodeId: 'nodeA',
//         sourceAnchorId: 'aA',
//         waypoints: [
//           [150, 200],
//           [250, 200],
//         ],
//       );
//       notifier.upsertEdge('main', edgeWps);

//       var st = container.read(edgeStateProvider);
//       expect(st.edgesOf('main').containsKey('edgeWp'), isTrue);

//       // update waypoints
//       final newEdge = edgeWps.copyWith(
//         waypoints: [
//           [150, 200],
//           [200, 300],
//           [250, 250],
//           [300, 200],
//         ],
//       );
//       notifier.upsertEdge('main', newEdge);

//       st = container.read(edgeStateProvider);
//       final updatedEdge = st.edgesOf('main')['edgeWp']!;
//       expect(updatedEdge.waypoints!.length, 4);
//       expect(updatedEdge.waypoints![1], [200, 300]);
//     });

//     test('upsertEdge preserves animConfig changes', () {
//       const anim = EdgeAnimationConfig(
//         animate: true,
//         animationType: 'dashFlow',
//         dashFlowPhase: 0.3,
//       );
//       const edgeAnim = EdgeModel(
//         id: 'edgeAnim',
//         sourceNodeId: 'nodeAnim',
//         sourceAnchorId: 'anchorAnim',
//         animConfig: anim,
//       );
//       notifier.upsertEdge('main', edgeAnim);

//       final st = container.read(edgeStateProvider);
//       final stored = st.edgesOf('main')['edgeAnim']!;
//       expect(stored.animConfig.animate, isTrue);
//       expect(stored.animConfig.dashFlowPhase, 0.3);

//       // update phase
//       final newEdge = stored.copyWith(
//         animConfig: stored.animConfig.copyWith(dashFlowPhase: 0.7),
//       );
//       notifier.upsertEdge('main', newEdge);

//       final st2 = container.read(edgeStateProvider);
//       final updated = st2.edgesOf('main')['edgeAnim']!;
//       expect(updated.animConfig.dashFlowPhase, 0.7);
//     });
//   });
// }
