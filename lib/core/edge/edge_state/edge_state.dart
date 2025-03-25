import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flow_editor/core/edge/models/edge_model.dart';

/// EdgeState: 多工作流场景的边数据，支持：
///   1) workflowId -> (edgeId -> EdgeModel)
///   2) 按edgeType 分组索引
///   3) 选中集合 selectedEdgeIds
///   4) 拖拽相关: draggingEdgeId / draggingEnd
class EdgeState extends Equatable {
  /// { workflowId : { edgeId : EdgeModel } }
  final Map<String, Map<String, EdgeModel>> edgesByWorkflow;

  /// { edgeType : { edgeId1, edgeId2, ... } }
  final Map<String, Set<String>> edgeIdsByType;

  /// 每次更新递增
  final int version;

  /// 当前选中的 edgeId 集合
  final Set<String> selectedEdgeIds;

  /// 正在拖拽的边 ID (半连接 / ghost line)
  final String? draggingEdgeId;

  /// 拖拽终点(世界坐标) 用于 ghost line
  final Offset? draggingEnd;

  const EdgeState({
    this.edgesByWorkflow = const {},
    this.edgeIdsByType = const {},
    this.version = 1,
    this.selectedEdgeIds = const {},
    this.draggingEdgeId,
    this.draggingEnd,
  });

  /// 取得指定 workflowId 下的所有边
  Map<String, EdgeModel> edgesOf(String workflowId) =>
      edgesByWorkflow[workflowId] ?? {};

  /// 取得指定edgeType下的所有edgeId
  Set<String> edgesByTypeOf(String edgeType) => edgeIdsByType[edgeType] ?? {};

  /// copyWith
  EdgeState copyWith({
    Map<String, Map<String, EdgeModel>>? edgesByWorkflow,
    Map<String, Set<String>>? edgeIdsByType,
    int? version,
    Set<String>? selectedEdgeIds,
    String? draggingEdgeId,
    Offset? draggingEnd,
    String? hoveredEdgeId,
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

  /// 替换某 workflow 下的所有边
  EdgeState updateWorkflowEdges(
    String workflowId,
    Map<String, EdgeModel> newEdges,
  ) {
    final updated = Map<String, Map<String, EdgeModel>>.from(edgesByWorkflow);
    updated[workflowId] = newEdges;
    return rebuildIndexes(updated, version: version + 1);
  }

  /// 移除整个 workflow
  EdgeState removeWorkflow(String workflowId) {
    if (!edgesByWorkflow.containsKey(workflowId)) return this;
    final updated = Map<String, Map<String, EdgeModel>>.from(edgesByWorkflow)
      ..remove(workflowId);
    return rebuildIndexes(updated, version: version + 1);
  }

  /// 重建 edgeIdsByType，version可递增
  EdgeState rebuildIndexes(
    Map<String, Map<String, EdgeModel>> updatedEdgesByWorkflow, {
    int? version,
  }) {
    final typeIndex = <String, Set<String>>{};

    updatedEdgesByWorkflow.forEach((_, edgesMap) {
      edgesMap.forEach((edgeId, edge) {
        typeIndex.putIfAbsent(edge.edgeType, () => <String>{}).add(edgeId);
      });
    });

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
