// test/cache/world_node_cache_test.dart
import 'dart:ui';
import 'package:flutter_test/flutter_test.dart';
import 'package:flow_editor/core/cache/cache_manager.dart';

void main() {
  group('WorldNodeCache', () {
    final cm = CacheManager.gm;
    const nodeId = 'n-1';
    final rect = Rect.fromLTWH(10, 20, 100, 50);

    setUp(cm.clearAll);

    test('upsert & query center', () {
      cm.upsertNodeBounds(nodeId, rect);
      expect(cm.nodeBounds(nodeId), equals(rect));
      expect(cm.nodeCenter(nodeId), equals(rect.center));
    });

    test('remove node bounds', () {
      cm.upsertNodeBounds(nodeId, rect);
      cm.removeNodeBounds(nodeId);
      expect(cm.nodeBounds(nodeId), isNull);
    });
  });
}
