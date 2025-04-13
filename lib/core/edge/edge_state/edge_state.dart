import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flow_editor/core/edge/models/edge_model.dart';

class EdgeState extends Equatable {
  /// { workflowId : [EdgeModel, ...] }
  final Map<String, List<EdgeModel>> edgesByWorkflow;

  /// { edgeType : { edgeId1, edgeId2, ... } }
  final Map<String, Set<String>> edgeIdsByType;

  final int version;
  final Set<String> selectedEdgeIds;

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

  /// 获取指定工作流下的所有边
  List<EdgeModel> edgesOf(String workflowId) =>
      edgesByWorkflow[workflowId] ?? [];

  /// 获取某类型的所有 edgeId（不分 workflow）
  Set<String> edgesByTypeOf(String edgeType) => edgeIdsByType[edgeType] ?? {};

  EdgeState copyWith({
    Map<String, List<EdgeModel>>? edgesByWorkflow,
    Map<String, Set<String>>? edgeIdsByType,
    int? version,
    Set<String>? selectedEdgeIds,
    String? draggingEdgeId,
    Offset? draggingEnd,
  }) {
    return EdgeState(
      edgesByWorkflow: edgesByWorkflow ?? this.edgesByWorkflow,
      edgeIdsByType: edgeIdsByType ?? this.edgeIdsByType,
      version: version ?? this.version,
      selectedEdgeIds: selectedEdgeIds ?? this.selectedEdgeIds,
      draggingEdgeId: draggingEdgeId ?? this.draggingEdgeId,
      draggingEnd: draggingEnd ?? this.draggingEnd,
    );
  }

  /// 替换某工作流下所有边
  EdgeState updateWorkflowEdges(
    String workflowId,
    List<EdgeModel> newEdges,
  ) {
    final updated = Map<String, List<EdgeModel>>.from(edgesByWorkflow);
    updated[workflowId] = newEdges;
    return rebuildIndexes(updated, version: version + 1);
  }

  /// 移除某个 workflow
  EdgeState removeWorkflow(String workflowId) {
    if (!edgesByWorkflow.containsKey(workflowId)) return this;
    final updatedEdges = Map<String, List<EdgeModel>>.from(edgesByWorkflow)
      ..remove(workflowId);

    return rebuildIndexes(updatedEdges, version: version + 1);
  }

  /// 重建 type 索引
  EdgeState rebuildIndexes(
    Map<String, List<EdgeModel>> updatedEdgesByWorkflow, {
    int? version,
  }) {
    final typeIndex = <String, Set<String>>{};

    for (final edges in updatedEdgesByWorkflow.values) {
      for (final edge in edges) {
        typeIndex.putIfAbsent(edge.edgeType, () => {}).add(edge.id);
      }
    }

    return copyWith(
      edgesByWorkflow: updatedEdgesByWorkflow,
      edgeIdsByType: typeIndex,
      version: version ?? this.version,
    );
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
