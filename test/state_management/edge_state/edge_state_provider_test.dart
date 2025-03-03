// import 'package:flutter_test/flutter_test.dart';
// import 'package:riverpod/riverpod.dart';

// // 假设以下路径要根据你项目实际结构做相应修改
// import 'package:flow_editor/core/edge/models/edge_model.dart';
// import 'package:flow_editor/core/state_management/edge_state/edge_state_provider.dart';

// void main() {
//   group('EdgeStateProvider Tests', () {
//     late ProviderContainer container;
//     late EdgeStateNotifier edgeNotifier;

//     setUp(() {
//       // 每次测试前重置一个新的ProviderContainer
//       container = ProviderContainer();
//       // 获取 StateNotifier
//       edgeNotifier = container.read(edgeStateProvider.notifier);
//     });

//     test('default EdgeState is empty', () {
//       final state = container.read(edgeStateProvider);
//       expect(state.edgesByWorkflow.isEmpty, isTrue);
//       expect(state.edgeIdsByType.isEmpty, isTrue);
//       expect(state.version, 1);
//     });

//     test('upsertEdge inserts a new edge', () {
//       final edgeA = EdgeModel(
//         id: 'edgeA',
//         sourceNodeId: 'node1',
//         sourceAnchorId: 'anchor1',
//         edgeType: 'flow',
//       );

//       // 执行增改
//       edgeNotifier.upsertEdge('main', edgeA);

//       // 现在的EdgeState
//       final state = container.read(edgeStateProvider);

//       expect(state.edgesOf('main').length, 1);
//       expect(state.edgesOf('main').containsKey('edgeA'), isTrue);
//       // type index
//       expect(state.edgeIdsByType['flow']?.contains('edgeA'), isTrue);
//     });

//     test('update existing edge changes type index', () {
//       final edgeA = EdgeModel(
//         id: 'edgeA',
//         sourceNodeId: 'node1',
//         sourceAnchorId: 'anchor1',
//         edgeType: 'flow',
//       );
//       edgeNotifier.upsertEdge('main', edgeA);
//       {
//         final state = container.read(edgeStateProvider);
//         expect(state.edgeIdsByType['flow']?.contains('edgeA'), isTrue);
//       }

//       // 更新edgeA, 改edgeType='dependency'
//       final updatedA = edgeA.copyWith(edgeType: 'dependency');
//       edgeNotifier.upsertEdge('main', updatedA);

//       final state2 = container.read(edgeStateProvider);
//       // 原flow索引里应移除
//       expect(state2.edgeIdsByType['flow']?.contains('edgeA') ?? false, isFalse);
//       // 新dependency索引里应出现
//       expect(state2.edgeIdsByType['dependency']?.contains('edgeA') ?? false,
//           isTrue);
//     });

//     test('removeEdge deletes single edge', () {
//       final edgeA = EdgeModel(
//         id: 'edgeA',
//         sourceNodeId: 'n1',
//         sourceAnchorId: 'a1',
//         edgeType: 'flow',
//       );
//       edgeNotifier.upsertEdge('main', edgeA);

//       // remove
//       edgeNotifier.removeEdge('main', 'edgeA');

//       final state = container.read(edgeStateProvider);
//       expect(state.edgesOf('main').isEmpty, isTrue);
//       expect(state.edgeIdsByType['flow']?.contains('edgeA') ?? false, isFalse);
//     });

//     test('removeEdgesOfNode', () {
//       final e1 = EdgeModel(
//         id: 'e1',
//         sourceNodeId: 'nodeA',
//         sourceAnchorId: 'a1',
//         targetNodeId: 'nodeB',
//         targetAnchorId: 'b1',
//         edgeType: 'flow',
//       );
//       final e2 = EdgeModel(
//         id: 'e2',
//         sourceNodeId: 'nodeA',
//         sourceAnchorId: 'a2',
//         targetNodeId: 'nodeX',
//         targetAnchorId: 'x1',
//         edgeType: 'flow',
//       );

//       edgeNotifier.upsertEdge('w1', e1);
//       edgeNotifier.upsertEdge('w1', e2);

//       expect(container.read(edgeStateProvider).edgesOf('w1').length, 2);

//       edgeNotifier.removeEdgesOfNode('w1', 'nodeA');
//       final st = container.read(edgeStateProvider);
//       expect(st.edgesOf('w1').length, 0);
//     });

//     test('setWorkflowEdges replaces entire workflow set', () {
//       final e1 = EdgeModel(
//           id: 'e1', sourceNodeId: 'n1', sourceAnchorId: 'a1', edgeType: 'flow');
//       final e2 = EdgeModel(
//           id: 'e2',
//           sourceNodeId: 'n2',
//           sourceAnchorId: 'a2',
//           edgeType: 'dependency');

//       // Replace w1 with e1 & e2
//       edgeNotifier.setWorkflowEdges('w1', {e1.id: e1, e2.id: e2});
//       var st = container.read(edgeStateProvider);
//       expect(st.edgesOf('w1').length, 2);

//       // Then replace w1 with only e1
//       edgeNotifier.setWorkflowEdges('w1', {e1.id: e1});
//       st = container.read(edgeStateProvider);
//       expect(st.edgesOf('w1').length, 1);
//       expect(st.edgesOf('w1').containsKey('e2'), isFalse);
//     });

//     test('removeWorkflow removes entire workflow from state', () {
//       final e1 = EdgeModel(id: 'e1', sourceNodeId: 'n1', sourceAnchorId: 'a1');
//       final e2 = EdgeModel(id: 'e2', sourceNodeId: 'n2', sourceAnchorId: 'a2');
//       // upsert edges to two different workflows
//       edgeNotifier.upsertEdge('flowA', e1);
//       edgeNotifier.upsertEdge('flowB', e2);

//       var st = container.read(edgeStateProvider);
//       expect(st.edgesByWorkflow.keys.length, 2);

//       // remove flowA
//       edgeNotifier.removeWorkflow('flowA');
//       st = container.read(edgeStateProvider);
//       expect(st.edgesByWorkflow.keys.length, 1);
//       expect(st.edgesByWorkflow.containsKey('flowA'), isFalse);
//     });
//   });
// }
