class HoverState {
  const HoverState({this.edgeId, this.nodeId});

  final String? edgeId;
  final String? nodeId;

  HoverState copyWith({
    String? edgeId,
    String? nodeId,
    bool clearEdge = false,
    bool clearNode = false,
  }) =>
      HoverState(
        edgeId: clearEdge ? null : (edgeId ?? this.edgeId),
        nodeId: clearNode ? null : (nodeId ?? this.nodeId),
      );
}
