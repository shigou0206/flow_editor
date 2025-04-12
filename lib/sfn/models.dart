import 'dart:math' as math;

enum NodeType { task, source, destination, parallel, choice, subgraph, normal }

/// 节点模型
class NodeModel {
  final String id;
  final String title;
  final NodeType type;
  final double x;
  final double y;
  final double width;
  final double height;
  final bool expanded; // 子图是否展开
  final String? parentId; // 父节点ID，如果是子图内部节点
  final String? rootNodeId; // 子图根节点ID
  final List<String> childrenIds; // 子图中的子节点ID列表
  final bool isVisible; // 节点是否可见

  const NodeModel({
    required this.id,
    required this.title,
    required this.type,
    required this.x,
    required this.y,
    this.width = 100.0,
    this.height = 60.0,
    this.expanded = false,
    this.parentId,
    this.rootNodeId,
    this.childrenIds = const [],
    this.isVisible = true,
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
      expanded: expanded,
      parentId: parentId,
      rootNodeId: rootNodeId,
      childrenIds: childrenIds,
      isVisible: isVisible,
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
