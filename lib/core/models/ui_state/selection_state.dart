class SelectionState {
  final Set<String> nodeIds;
  final Set<String> edgeIds;

  const SelectionState({
    this.nodeIds = const {},
    this.edgeIds = const {},
  });

  SelectionState copyWith({
    Set<String>? nodeIds,
    Set<String>? edgeIds,
  }) {
    return SelectionState(
      nodeIds: nodeIds ?? this.nodeIds,
      edgeIds: edgeIds ?? this.edgeIds,
    );
  }

  bool get isEmpty => nodeIds.isEmpty && edgeIds.isEmpty;

  Map<String, dynamic> toJson() => {
        'nodeIds': nodeIds.toList(),
        'edgeIds': edgeIds.toList(),
      };

  factory SelectionState.fromJson(Map<String, dynamic> json) {
    return SelectionState(
      nodeIds: Set<String>.from(json['nodeIds'] as List<dynamic>),
      edgeIds: Set<String>.from(json['edgeIds'] as List<dynamic>),
    );
  }
}
