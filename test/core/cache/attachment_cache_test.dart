// test/cache/attachment_cache_test.dart
import 'dart:ui';
import 'package:flutter_test/flutter_test.dart';
import 'package:flow_editor/core/cache/cache_manager.dart';
import 'package:flow_editor/core/models/edge_attachment_model.dart';
import 'package:flow_editor/core/models/edge_model.dart';
import 'package:flow_editor/core/utils/edge_utils.dart';
import 'package:flow_editor/core/models/enums.dart';

void main() {
  group('AttachmentCache', () {
    final cm = CacheManager.gm;
    setUp(cm.clearAll);

    test('refreshAttachmentCache stores world positions', () {
      final edge = EdgeModel(
        start: Offset.zero,
        end: const Offset(100, 0),
        attachments: [
          EdgeAttachmentModel(
              id: 'a', kind: EdgeAttachmentKind.handle, seg: 0, t: .5),
        ],
      );

      // 构造一条简单直线
      final path = Path()
        ..moveTo(0, 0)
        ..lineTo(100, 0);

      // 先锁一次，确保 offset 合法
      BezierUtils.lockAttachments(edge, path);

      cm.refreshAttachmentCache(edge.id, path, edge);
      final p = cm.attachmentWorld(edge.id, 'a');
      expect(p, isNotNull);
      expect(p!.dx, 50);
      expect(p.dy, 0);
    });
  });
}
