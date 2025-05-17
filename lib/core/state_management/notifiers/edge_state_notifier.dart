// lib/flow_editor/core/state_management/edge_state/edge_state_notifier.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/edge_state.dart';
import 'package:flow_editor/core/models/edge_model.dart';
import 'package:flow_editor/core/cache/cache_manager.dart';

class EdgeStateNotifier extends StateNotifier<EdgeState> {
  EdgeStateNotifier({required this.workflowId}) : super(const EdgeState());

  final String workflowId;

  // ───────────────────────── helpers ─────────────────────────
  List<EdgeModel> _list() => state.edgesOf(workflowId);

  // ───────────────────────── CRUD ────────────────────────────
  List<EdgeModel> getEdges() => _list();

  void updateEdges(List<EdgeModel> edges) {
    state = state.updateWorkflowEdges(workflowId, edges);
    _refreshCacheList(edges);
  }

  void upsertEdge(EdgeModel edge) {
    final updatedList = [..._list().where((e) => e.id != edge.id), edge];
    state = state.updateWorkflowEdges(workflowId, updatedList);
    _refreshCache(edge);
  }

  void removeEdge(String edgeId) {
    final updatedList = _list().where((e) => e.id != edgeId).toList();
    if (updatedList.length != _list().length) {
      state = state.updateWorkflowEdges(workflowId, updatedList);
      CacheManager.gm.clearAttachmentCache(edgeId);
    }
  }

  void removeEdgesOfNode(String nodeId) {
    final updatedList = _list()
        .where((e) =>
            (e.sourceNodeId ?? '') != nodeId &&
            (e.targetNodeId ?? '') != nodeId)
        .toList();
    if (updatedList.length != _list().length) {
      state = state.updateWorkflowEdges(workflowId, updatedList);
      _refreshCacheList(updatedList);
    }
  }

  void setWorkflowEdges(List<EdgeModel> edges) => updateEdges(edges); // 直接复用

  void removeWorkflow() => state = state.removeWorkflow(workflowId);

  // ────────────────────── selection ──────────────────────
  void toggleSelectEdge(String edgeId) {
    final s = {...state.selectedEdgeIds};
    s.contains(edgeId) ? s.remove(edgeId) : s.add(edgeId);
    state = state.copyWith(selectedEdgeIds: s);
  }

  void selectEdge(String edgeId, {bool multiSelect = false}) {
    final s = multiSelect ? {...state.selectedEdgeIds} : <String>{};
    s.add(edgeId);
    state = state.copyWith(selectedEdgeIds: s);
  }

  void deselectEdge(String edgeId) {
    final s = {...state.selectedEdgeIds}..remove(edgeId);
    state = state.copyWith(selectedEdgeIds: s);
  }

  void clearSelection() => state = state.copyWith(selectedEdgeIds: <String>{});

  // ──────────────── Ghost Edge 拖拽 ────────────────
  void startEdgeDrag(EdgeModel tempEdge, Offset startPos) {
    upsertEdge(tempEdge);
    state = state.copyWith(
      draggingEdgeId: tempEdge.id,
      draggingEnd: startPos,
    );
  }

  void updateEdgeDrag(Offset currentPos) {
    if (state.draggingEdgeId == null) return;
    state = state.copyWith(draggingEnd: currentPos);
  }

  void endEdgeDrag({
    required bool canceled,
    String? targetNodeId,
    String? targetAnchorId,
  }) {
    final id = state.draggingEdgeId;
    if (id == null) return;

    if (canceled || targetNodeId == null || targetAnchorId == null) {
      removeEdge(id);
    } else {
      finalizeEdge(
        edgeId: id,
        targetNodeId: targetNodeId,
        targetAnchorId: targetAnchorId,
      );
    }
    debugPrint(
        '清理前 draggingEdgeId=${state.draggingEdgeId}, draggingEnd=${state.draggingEnd}');
    state = state.copyWith(clearDraggingEdgeId: true, clearDraggingEnd: true);
    debugPrint(
        '清理后 draggingEdgeId=${state.draggingEdgeId}, draggingEnd=${state.draggingEnd}');
  }

  void finalizeEdge({
    required String edgeId,
    required String targetNodeId,
    required String targetAnchorId,
  }) {
    final old = _list().firstWhere((e) => e.id == edgeId);

    // 起终相同直接丢弃
    if (old.sourceNodeId == targetNodeId ||
        old.sourceAnchorId == targetAnchorId) {
      removeEdge(edgeId);
      return;
    }

    upsertEdge(old.copyWith(
      targetNodeId: targetNodeId,
      targetAnchorId: targetAnchorId,
      isConnected: true,
    ));
  }

  // ────────────────────── 批量操作 ──────────────────────
  void removeEdges(List<String> ids) {
    final updated = _list().where((e) => !ids.contains(e.id)).toList();
    if (updated.length != _list().length) {
      state = state.updateWorkflowEdges(workflowId, updated);
      for (final id in ids) {
        CacheManager.gm.clearAttachmentCache(id);
      }
    }
  }

  void addEdges(List<EdgeModel> edges) {
    final updated = [..._list(), ...edges];
    state = state.updateWorkflowEdges(workflowId, updated);
    _refreshCacheList(edges);
  }

  // ────────────────── 路由点 Waypoints ──────────────────
  void updateEdgeWaypoints(Map<String, List<Offset>> routes) {
    final updated = _list().map((e) {
      if (routes.containsKey(e.id)) {
        return e.copyWith(waypoints: routes[e.id]);
      }
      return e;
    }).toList();
    state = state.updateWorkflowEdges(workflowId, updated);
    _refreshCacheList(updated);
  }

  // ────────────────── cache helpers ──────────────────
  void _refreshCache(EdgeModel e) {
    final p = CacheManager.gm.edgePath(e.id);
    if (p != null) {
      CacheManager.gm.refreshAttachmentCache(e.id, p, e);
    }
  }

  void _refreshCacheList(List<EdgeModel> list) {
    for (final e in list) {
      final p = CacheManager.gm.edgePath(e.id);
      if (p != null) {
        CacheManager.gm.refreshAttachmentCache(e.id, p, e, notify: false);
      }
    }
    CacheManager.gm.revision.value++; // 批量一次性通知
  }
}
