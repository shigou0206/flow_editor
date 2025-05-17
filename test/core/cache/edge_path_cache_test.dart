// test/cache/edge_path_cache_test.dart
import 'dart:ui';
import 'package:flutter_test/flutter_test.dart';
import 'package:flow_editor/core/cache/cache_manager.dart';

void main() {
  group('EdgePathCache', () {
    final cm = CacheManager.gm;
    const edgeId = 'e-1';
    late int oldRev;

    setUp(() {
      cm.clearAll();
      oldRev = cm.revision.value;
    });

    test('updateEdgePath writes & bumps revision', () {
      final p = Path()..lineTo(100, 0);
      cm.updateEdgePath(edgeId, p);
      expect(cm.edgePath(edgeId), equals(p));
      expect(cm.revision.value, equals(oldRev + 1));
    });

    test('removeEdgePath clears & bumps', () {
      cm.updateEdgePath(edgeId, Path());
      cm.removeEdgePath(edgeId);
      expect(cm.edgePath(edgeId), isNull);
      expect(cm.revision.value, equals(oldRev + 2)); // 两次 bump
    });
  });
}
