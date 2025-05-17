class SelectionState {
  const SelectionState({
    this.edgeIds = const {},
    this.nodeIds = const {},
  });

  final Set<String> edgeIds;
  final Set<String> nodeIds;

  SelectionState copyWith({
    Set<String>? edgeIds,
    Set<String>? nodeIds,
  }) =>
      SelectionState(
        edgeIds: edgeIds ?? this.edgeIds,
        nodeIds: nodeIds ?? this.nodeIds,
      );

  bool get isEmpty => edgeIds.isEmpty && nodeIds.isEmpty;
}
