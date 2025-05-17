// lib/flow_editor/core/cache/world_node_cache.dart
import 'dart:ui';
import 'package:flutter/foundation.dart';

class WorldNodeEntry {
  WorldNodeEntry({
    required this.id,
    required this.bounds,
  });

  final String id;
  Rect bounds;

  Offset get center => bounds.center;
}

class WorldNodeCache {
  final Map<String, WorldNodeEntry> _map = {};
  final ValueNotifier<int> revision = ValueNotifier<int>(0);

  // ----------- 读 -----------
  WorldNodeEntry? operator [](String nodeId) => _map[nodeId];

  // ----------- 写 -----------
  void upsert(String nodeId, Rect worldBounds, {bool notify = true}) {
    _map[nodeId] = WorldNodeEntry(id: nodeId, bounds: worldBounds);
    if (notify) revision.value++;
  }

  void remove(String nodeId, {bool notify = true}) {
    _map.remove(nodeId);
    if (notify) revision.value++;
  }

  void clear({bool notify = true}) {
    _map.clear();
    if (notify) revision.value++;
  }

  // ----------- 批量查询 -----------
  Iterable<WorldNodeEntry> get entries => _map.values;

  // 距离最近节点 (示例)
  WorldNodeEntry? nearest(Offset worldPos) {
    WorldNodeEntry? best;
    double bestDist = double.infinity;
    for (final e in _map.values) {
      final d = (e.center - worldPos).distance;
      if (d < bestDist) {
        bestDist = d;
        best = e;
      }
    }
    return best;
  }

  // ----------- 单例 -----------
  static final WorldNodeCache _inst = WorldNodeCache._internal();
  factory WorldNodeCache() => _inst;
  WorldNodeCache._internal();
}
