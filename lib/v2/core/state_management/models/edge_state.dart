// lib/flow_editor/core/state_management/edge_state/edge_state.dart
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flow_editor/v2/core/models/edge_model.dart';

class EdgeState extends Equatable {
  /// { workflowId : [EdgeModel, …] }
  final Map<String, List<EdgeModel>> edgesByWorkflow;

  /// { edgeType : { edgeId1, edgeId2, … } }
  final Map<String, Set<String>> edgeIdsByType;

  /// 每次 copyWith 自动 +1，用于 UI rebuild
  final int version;

  /// 当前选中的 edgeId 集合（已在 rebuildIndexes 时自动剔除失效 id）
  final Set<String> selectedEdgeIds;

  /// Ghost-Edge 拖拽中间态
  final String? draggingEdgeId;
  final Offset? draggingEnd;

  const EdgeState({
    this.edgesByWorkflow = const {},
    this.edgeIdsByType = const {},
    this.version = 1,
    this.selectedEdgeIds = const {},
    this.draggingEdgeId,
    this.draggingEnd,
  });

  // ─── helpers ────────────────────────────────────────────────
  List<EdgeModel> edgesOf(String wfId) => edgesByWorkflow[wfId] ?? [];

  // ─── copyWith (统一自增 version) ─────────────────────────────
  EdgeState copyWith({
    Map<String, List<EdgeModel>>? edgesByWorkflow,
    Map<String, Set<String>>? edgeIdsByType,
    int? version,
    Set<String>? selectedEdgeIds,
    String? draggingEdgeId,
    Offset? draggingEnd,
    bool clearDraggingEdgeId = false,
    bool clearDraggingEnd = false,
  }) {
    return EdgeState(
      edgesByWorkflow: edgesByWorkflow ?? this.edgesByWorkflow,
      edgeIdsByType: edgeIdsByType ?? this.edgeIdsByType,
      version: version ?? this.version + 1,
      selectedEdgeIds: selectedEdgeIds ?? this.selectedEdgeIds,
      draggingEdgeId:
          clearDraggingEdgeId ? null : (draggingEdgeId ?? this.draggingEdgeId),
      draggingEnd: clearDraggingEnd ? null : (draggingEnd ?? this.draggingEnd),
    );
  }

  // ─── rebuild index & keep selection alive ───────────────────
  EdgeState _rebuildIndexes(Map<String, List<EdgeModel>> data) {
    final idx = <String, Set<String>>{};
    for (final list in data.values) {
      for (final e in list) {
        idx.putIfAbsent(e.edgeType, () => <String>{}).add(e.id);
      }
    }

    final aliveIds = idx.values.expand((s) => s).toSet();
    final filteredSel = selectedEdgeIds.where(aliveIds.contains).toSet();

    return copyWith(
      edgesByWorkflow: data,
      edgeIdsByType: idx,
      selectedEdgeIds: filteredSel,
    );
  }

  // ─── public api ─────────────────────────────────────────────
  EdgeState updateWorkflowEdges(String wfId, List<EdgeModel> list) {
    final m = Map<String, List<EdgeModel>>.from(edgesByWorkflow)..[wfId] = list;
    return _rebuildIndexes(m);
  }

  EdgeState removeWorkflow(String wfId) {
    if (!edgesByWorkflow.containsKey(wfId)) return this;
    final m = Map<String, List<EdgeModel>>.from(edgesByWorkflow)..remove(wfId);
    return _rebuildIndexes(m);
  }

  @override
  List<Object?> get props => [
        edgesByWorkflow,
        edgeIdsByType,
        version,
        selectedEdgeIds,
        draggingEdgeId,
        draggingEnd,
      ];
}
