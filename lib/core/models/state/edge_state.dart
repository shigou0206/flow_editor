import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flow_editor/core/models/edge_model.dart';
import 'package:collection/collection.dart';

part 'edge_state.freezed.dart';
part 'edge_state.g.dart';

@freezed
class EdgeState with _$EdgeState {
  const EdgeState._(); // for custom methods

  const factory EdgeState({
    @Default([]) List<EdgeModel> edges,
    @Default({}) Map<String, Set<String>> edgeIdsByType,
    @Default(1) int version,
    @Default({}) Set<String> selectedEdgeIds,
  }) = _EdgeState;

  factory EdgeState.fromJson(Map<String, dynamic> json) =>
      _$EdgeStateFromJson(json);

  EdgeModel? getEdgeById(String edgeId) =>
      edges.firstWhereOrNull((e) => e.id == edgeId);

  Set<String> edgesByTypeOf(String edgeType) => edgeIdsByType[edgeType] ?? {};

  bool isSelected(String edgeId) => selectedEdgeIds.contains(edgeId);

  EdgeState upsertEdge(EdgeModel edge) {
    final updatedList = [
      ...edges.where((e) => e.id != edge.id),
      edge,
    ];
    return rebuildIndexes(updatedList, version: version + 1);
  }

  EdgeState removeEdge(String edgeId) {
    final updatedList = edges.where((e) => e.id != edgeId).toList();
    return rebuildIndexes(updatedList, version: version + 1);
  }

  EdgeState updateEdges(List<EdgeModel> newEdges) {
    if (edges == newEdges) return this;
    return rebuildIndexes(newEdges, version: version + 1);
  }

  EdgeState rebuildIndexes(List<EdgeModel> updatedEdges, {int? version}) {
    final typeIndex = <String, Set<String>>{};
    for (final edge in updatedEdges) {
      typeIndex.putIfAbsent(edge.edgeType, () => {}).add(edge.id);
    }
    return copyWith(
      edges: updatedEdges,
      edgeIdsByType: typeIndex,
      version: version ?? this.version,
    );
  }

  EdgeState selectEdge(String edgeId) =>
      copyWith(selectedEdgeIds: {...selectedEdgeIds, edgeId});

  EdgeState deselectEdge(String edgeId) =>
      copyWith(selectedEdgeIds: {...selectedEdgeIds}..remove(edgeId));

  EdgeState clearSelection() => copyWith(selectedEdgeIds: {});
}
