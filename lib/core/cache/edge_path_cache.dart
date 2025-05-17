// lib/flow_editor/core/cache/edge_path_cache.dart
import 'dart:ui';
import 'package:flutter/foundation.dart';

class EdgePathCache {
  // ----------- 内部存储 -----------
  final Map<String, Path> _paths = {};

  /// 每次更新都会 +1，Widget 可监听 ValueListenable 触发 rebuild
  final ValueNotifier<int> revision = ValueNotifier<int>(0);

  // ----------- 读 -----------
  Path? operator [](String edgeId) => _paths[edgeId];

  // ----------- 写 -----------
  void update(String edgeId, Path path, {bool notify = true}) {
    _paths[edgeId] = path;
    if (notify) revision.value++;
  }

  void remove(String edgeId, {bool notify = true}) {
    _paths.remove(edgeId);
    if (notify) revision.value++;
  }

  void clear({bool notify = true}) {
    _paths.clear();
    if (notify) revision.value++;
  }

  // ----------- 单例 -----------
  static final EdgePathCache _inst = EdgePathCache._internal();
  factory EdgePathCache() => _inst;
  EdgePathCache._internal();
}
