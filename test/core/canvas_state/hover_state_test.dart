import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flow_editor/core/state_management/providers/canvas_state_provider.dart';
import 'package:flow_editor/core/state_management/models/hover_state.dart';

void main() {
  const wf = 'wf_hover';

  test('set & clear hover edge', () {
    final c = ProviderContainer();

    // 进入
    c.read(hoverProvider(wf).notifier).state = const HoverState(edgeId: 'e7');
    expect(c.read(hoverProvider(wf)).edgeId, 'e7');

    // 离开
    c.read(hoverProvider(wf).notifier).state =
        c.read(hoverProvider(wf)).copyWith(clearEdge: true);
    expect(c.read(hoverProvider(wf)).edgeId, isNull);
  });
}
