import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flow_editor/core/state_management/providers/edge_state_provider.dart';
import '../utils/test_helpers.dart';

void main() {
  const wf = 'wf_test';

  test('Edge CRUD & selection', () {
    final c = ProviderContainer();
    final n = c.read(edgeStateProvider(wf).notifier);

    // upsert
    n.upsertEdge(makeEdge(id: 'e1'));
    expect(n.getEdges().length, 1);

    // select / toggle
    n.selectEdge('e1');
    expect(c.read(edgeStateProvider(wf)).selectedEdgeIds, {'e1'});

    n.toggleSelectEdge('e1');
    expect(c.read(edgeStateProvider(wf)).selectedEdgeIds, isEmpty);

    // remove
    n.removeEdge('e1');
    expect(n.getEdges(), isEmpty);
  });
}
