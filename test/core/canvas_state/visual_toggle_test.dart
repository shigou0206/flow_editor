import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flow_editor/core/state_management/providers/canvas_state_provider.dart';

void main() {
  const wf = 'wf_visual';

  test('toggle grid & minimap, switch theme', () {
    final c = ProviderContainer();
    final visN = c.read(canvasVisualProvider(wf).notifier);

    visN.toggleGrid();
    expect(c.read(canvasVisualProvider(wf)).showGrid, isFalse);
  });
}
