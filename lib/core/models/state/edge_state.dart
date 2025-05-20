import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flow_editor/core/models/edge_model.dart';

part 'edge_state.freezed.dart';
part 'edge_state.g.dart';

@freezed
class EdgeState with _$EdgeState {
  const EdgeState._(); // for custom methods

  const factory EdgeState({
    @Default({}) Map<String, List<EdgeModel>> edgesByWorkflow,
    @Default({}) Map<String, Set<String>> edgeIdsByType,
    @Default(1) int version,
    @Default({}) Set<String> selectedEdgeIds,
  }) = _EdgeState;

  /// JSON 支持
  factory EdgeState.fromJson(Map<String, dynamic> json) =>
      _$EdgeStateFromJson(json);

  /// 获取 workflow 下的边
  List<EdgeModel> edgesOf(String workflowId) =>
      edgesByWorkflow[workflowId] ?? [];

  /// 获取某类型的所有 edgeId
  Set<String> edgesByTypeOf(String edgeType) => edgeIdsByType[edgeType] ?? {};

  /// 获取指定边
  EdgeModel? getEdgeById(String workflowId, String edgeId) {
    final edges = edgesOf(workflowId);
    for (final edge in edges) {
      if (edge.id == edgeId) return edge;
    }
    return null;
  }

  /// 是否选中边
  bool isSelected(String edgeId) => selectedEdgeIds.contains(edgeId);

  /// 插入或更新边
  EdgeState upsertEdge(String workflowId, EdgeModel edge) {
    final oldList = edgesOf(workflowId);
    final updatedList = [
      ...oldList.where((e) => e.id != edge.id),
      edge,
    ];
    return updateWorkflowEdges(workflowId, updatedList);
  }

  /// 删除某条边
  EdgeState removeEdge(String workflowId, String edgeId) {
    final updatedList =
        edgesOf(workflowId).where((e) => e.id != edgeId).toList();
    return updateWorkflowEdges(workflowId, updatedList);
  }

  /// 替换 workflow 的边列表
  EdgeState updateWorkflowEdges(String workflowId, List<EdgeModel> newEdges) {
    if (edgesOf(workflowId) == newEdges) return this;
    final updated = Map<String, List<EdgeModel>>.from(edgesByWorkflow)
      ..[workflowId] = newEdges;
    return rebuildIndexes(updated, version: version + 1);
  }

  /// 移除 workflow
  EdgeState removeWorkflow(String workflowId) {
    if (!edgesByWorkflow.containsKey(workflowId)) return this;
    final updated = Map<String, List<EdgeModel>>.from(edgesByWorkflow)
      ..remove(workflowId);
    return rebuildIndexes(updated, version: version + 1);
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

  /// 选中某条边
  EdgeState selectEdge(String edgeId) =>
      copyWith(selectedEdgeIds: {...selectedEdgeIds, edgeId});

  /// 取消选中边
  EdgeState deselectEdge(String edgeId) =>
      copyWith(selectedEdgeIds: {...selectedEdgeIds}..remove(edgeId));

  /// 清空选中边
  EdgeState clearSelection() => copyWith(selectedEdgeIds: {});
}
