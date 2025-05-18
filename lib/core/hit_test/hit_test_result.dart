enum HitType { anchor, node, edge }

class HitTestResult {
  final HitType type;
  final String id;

  HitTestResult(this.type, this.id);

  @override
  String toString() => 'HitTestResult(type: $type, id: $id)';
}
