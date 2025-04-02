class Edge {
  final int sourceId;
  final int targetId;

  Edge({required this.sourceId, required this.targetId});

  @override
  String toString() => 'Edge($sourceId -> $targetId)';
}
