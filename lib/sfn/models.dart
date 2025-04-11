enum NodeType { normal, choice }

/// 节点模型
class NodeModel {
  final String id;
  final String title;
  final NodeType type;
  final double x;
  final double y;
  final double width;
  final double height;

  NodeModel({
    required this.id,
    required this.title,
    required this.type,
    this.x = 0,
    this.y = 0,
    this.width = 100,
    this.height = 60,
  });

  NodeModel copyWith({
    double? x,
    double? y,
  }) {
    return NodeModel(
      id: id,
      title: title,
      type: type,
      x: x ?? this.x,
      y: y ?? this.y,
      width: width,
      height: height,
    );
  }
}

/// 边模型
class EdgeModel {
  final String id;
  final String sourceId;
  final String targetId;

  EdgeModel({
    required this.id,
    required this.sourceId,
    required this.targetId,
  });
}
