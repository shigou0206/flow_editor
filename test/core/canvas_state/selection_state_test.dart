import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flow_editor/core/state_management/providers/canvas_state_provider.dart';
import 'package:flow_editor/core/state_management/models/selection_state.dart';

void main() {
  const wf = 'wf_select';

  test('edge & node multi-selection', () {
    final c = ProviderContainer();

    // 选两条边
    c.read(selectionProvider(wf).notifier).state =
        const SelectionState(edgeIds: {'e1', 'e2'});
    expect(c.read(selectionProvider(wf)).edgeIds.length, 2);

    // 加节点
    c.read(selectionProvider(wf).notifier).state =
        c.read(selectionProvider(wf)).copyWith(nodeIds: {'n4'});
    expect(c.read(selectionProvider(wf)).nodeIds, {'n4'});

    // clear
    c.read(selectionProvider(wf).notifier).state = const SelectionState();
    expect(c.read(selectionProvider(wf)).isEmpty, isTrue);
  });
}
