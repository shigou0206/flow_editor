import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flow_editor/core/state_management/providers/canvas_state_provider.dart';

void main() {
  const wf = 'wf_geom';

  test('pan & zoom update geom', () {
    final c = ProviderContainer();

    // 初始值
    var geom = c.read(canvasGeomProvider(wf));
    expect(geom.offset, Offset.zero);
    expect(geom.scale, 1);

    // 平移
    c.read(canvasGeomProvider(wf).notifier).pan(const Offset(15, -5));
    geom = c.read(canvasGeomProvider(wf));
    expect(geom.offset, const Offset(15, -5));

    // 缩放并 clamp
    c.read(canvasGeomProvider(wf).notifier).zoom(10); // 超过 max=3
    geom = c.read(canvasGeomProvider(wf));
    expect(geom.scale, 3); // 被 clamp
  });
}
