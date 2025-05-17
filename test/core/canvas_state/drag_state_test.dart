import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flow_editor/core/state_management/providers/canvas_state_provider.dart';
import 'package:flow_editor/core/state_management/models/drag_state.dart';

void main() {
  const wf = 'wf_drag';

  test('drag start / move / end', () {
    final c = ProviderContainer();
    final dragN = c.read(dragProvider(wf).notifier);

    // start
    dragN.state = DragState(edgeId: 'ghost', draggingEnd: Offset.zero);
    expect(c.read(dragProvider(wf)).active, isTrue);

    // move
    dragN.state =
        c.read(dragProvider(wf)).copyWith(draggingEnd: const Offset(50, 50));
    expect(c.read(dragProvider(wf)).draggingEnd, const Offset(50, 50));

    // end
    dragN.state = const DragState();
    expect(c.read(dragProvider(wf)).active, isFalse);
  });
}
