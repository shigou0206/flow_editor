// lib/flow_editor/core/cache/cache_manager.dart
import 'dart:ui';
import 'package:flutter/foundation.dart';
import 'package:flow_editor/v2/core/models/edge_model.dart';

/// 运行期缓存总管（单例）
/// 负责：
///   • 边 Path          (_edgePathCache)
///   • 附件世界坐标      (_attachmentCache)
///   • 节点世界边界      (_nodeBoundsCache)
class CacheManager {
  // --------------------------------------------------------------------------
  // 通用通知 —— UI 层可监听 revision 触发 repaint
  // --------------------------------------------------------------------------
  final ValueNotifier<int> revision = ValueNotifier<int>(0);
  void _bump() => revision.value++;

  // --------------------------------------------------------------------------
  // 1. Edge Path Cache  [edgeId ➜ Path]
  // --------------------------------------------------------------------------
  final Map<String, Path> _edgePathCache = {};

  Path? edgePath(String edgeId) => _edgePathCache[edgeId];

  void updateEdgePath(String edgeId, Path path, {bool notify = true}) {
    _edgePathCache[edgeId] = path;
    if (notify) _bump();
  }

  void removeEdgePath(String edgeId, {bool notify = true}) {
    _edgePathCache.remove(edgeId);
    if (notify) _bump();
  }

  // --------------------------------------------------------------------------
  // 2. Attachment Cache  [edgeId ➜ {attId ➜ world Offset}]
  // --------------------------------------------------------------------------
  final Map<String, Map<String, Offset>> _attachmentCache = {};

  Offset? attachmentWorld(String edgeId, String attId) =>
      _attachmentCache[edgeId]?[attId];

  void refreshAttachmentCache(String edgeId, Path path, EdgeModel edge,
      {bool notify = true}) {
    final ms = path.computeMetrics().toList();
    final map = <String, Offset>{};
    for (final a in edge.attachments) {
      final seg = a.seg.clamp(0, ms.length - 1);
      map[a.id] = ms[seg].getTangentForOffset(ms[seg].length * a.t)!.position +
          a.offset;
    }
    _attachmentCache[edgeId] = map;
    if (notify) _bump();
  }

  void clearAttachmentCache(String edgeId, {bool notify = true}) {
    _attachmentCache.remove(edgeId);
    if (notify) _bump();
  }

  // --------------------------------------------------------------------------
  // 3. World Node Bounds Cache  [nodeId ➜ Rect (world)]
  // --------------------------------------------------------------------------
  final Map<String, Rect> _nodeBoundsCache = {};

  Rect? nodeBounds(String nodeId) => _nodeBoundsCache[nodeId];

  Offset? nodeCenter(String nodeId) => _nodeBoundsCache[nodeId]?.center;

  void upsertNodeBounds(String nodeId, Rect worldBounds, {bool notify = true}) {
    _nodeBoundsCache[nodeId] = worldBounds;
    if (notify) _bump();
  }

  void removeNodeBounds(String nodeId, {bool notify = true}) {
    _nodeBoundsCache.remove(nodeId);
    if (notify) _bump();
  }

  // --------------------------------------------------------------------------
  // 批量清理
  // --------------------------------------------------------------------------
  void clearAll() {
    _edgePathCache.clear();
    _attachmentCache.clear();
    _nodeBoundsCache.clear();
    _bump();
  }

  // --------------------------------------------------------------------------
  // 单例 wiring
  // --------------------------------------------------------------------------
  static final CacheManager _inst = CacheManager._internal();
  factory CacheManager() => _inst;
  CacheManager._internal();

  static CacheManager get gm => _inst;
}

/// 语法糖：CacheManager.gm
extension GlobalCache on CacheManager {
  static final gm = CacheManager();
}
