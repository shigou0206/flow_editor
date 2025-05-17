// test/cache/integration_lock_and_cache_test.dart
import 'dart:ui';
import 'package:flutter_test/flutter_test.dart';
import 'package:flow_editor/core/cache/cache_manager.dart';
import 'package:flow_editor/core/models/edge_attachment_model.dart';
import 'package:flow_editor/core/models/edge_model.dart';
import 'package:flow_editor/core/utils/edge_utils.dart';
import 'package:flow_editor/core/models/enums.dart';

void main() {
  test('Bezier lock + cache refresh full pipeline', () {
    final cm = CacheManager.gm;
    cm.clearAll();

    final edge = EdgeModel(
      id: 'e',
      start: Offset.zero,
      end: const Offset(100, 0),
      attachments: [
        EdgeAttachmentModel(
            id: 'label',
            kind: EdgeAttachmentKind.label,
            seg: 0,
            t: .5,
            text: 'mid'),
      ],
    );

    final path = Path()
      ..moveTo(0, 0)
      ..cubicTo(0, 50, 100, -50, 100, 0);

    // ① 锁定 geometry
    BezierUtils.lockAttachments(edge, path);

    // ② 写 path & attachment cache
    cm.updateEdgePath(edge.id, path, notify: false);
    cm.refreshAttachmentCache(edge.id, path, edge);

    // ③ 校验缓存里的 world 坐标
    final p = cm.attachmentWorld(edge.id, 'label');
    expect(p, isNotNull);
    // 曲线对称，y≈0，x≈50
    expect((p! - const Offset(50, 0)).distance, lessThanOrEqualTo(0.5));
  });
}
