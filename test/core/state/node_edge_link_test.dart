import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flow_editor/core/state_management/providers/node_state_provider.dart';
import 'package:flow_editor/core/state_management/providers/edge_state_provider.dart';
import 'package:flow_editor/core/models/node_model.dart';
import 'package:flow_editor/core/models/edge_model.dart';
import 'dart:ui';

void main() {
  const wf = 'wf_link';

  test('remove node clears attached edges', () {
    final c = ProviderContainer();

    // 1. add node
    c.read(nodeStateProvider(wf).notifier).upsertNode(
        NodeModel(id: 'nA', position: Offset.zero, size: const Size(100, 100)));

    // 2. add edge with correct sourceNodeId
    c.read(edgeStateProvider(wf).notifier).upsertEdge(
          EdgeModel(
            id: 'eA',
            start: Offset.zero,
            end: const Offset(10, 0),
            sourceNodeId: 'nA', // ★ 必须写上
          ),
        );

    // 3. delete node
    c.read(nodeStateProvider(wf).notifier).removeNode('nA');

    // 4. expect edges empty
    final edges = c.read(edgeStateProvider(wf)).edgesOf(wf);
    expect(edges, isEmpty);
  });
}
