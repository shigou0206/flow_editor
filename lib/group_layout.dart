import 'package:flutter/material.dart';
import 'package:flow_layout/graph/graph.dart';
import 'package:flow_layout/layout/layout.dart';
import 'package:flow_editor/v1/core/edge/models/edge_model.dart';
import 'package:flow_editor/v1/core/node/models/node_model.dart';
import 'package:collection/collection.dart';
import 'dart:math' show pi, cos, sin;

void main() => runApp(
      const MaterialApp(home: Scaffold(body: CanvasWidget())),
    );

/// 扩展方法：递归计算节点的绝对坐标，传入整个节点列表用于查找父节点
extension AbsolutePositionExtension on NodeModel {
  Offset absolutePosition(List<NodeModel> allNodes) {
    if (parentId == null) {
      return position;
    } else {
      final parent =
          allNodes.firstWhere((n) => n.id == parentId, orElse: () => this);
      final parentPosition = parent.absolutePosition(allNodes);
      final absolutePosition = parentPosition + position;
      return absolutePosition;
    }
  }
}

List<Offset> mapEdgeWaypointsToAbsolute(
    EdgeModel edge, List<NodeModel> allNodes) {
  final NodeModel? source =
      allNodes.firstWhereOrNull((n) => n.id == edge.sourceNodeId);
  if (source == null) return [];

  // 如果源节点没有父组件，则认为其路由点已经是绝对坐标
  if (source.parentId == null) {
    return edge.waypoints!.map((pt) => Offset(pt[0], pt[1])).toList();
  }

  // 查找源节点的父组件
  final NodeModel? group =
      allNodes.firstWhereOrNull((n) => n.id == source.parentId);
  if (group == null) {
    return edge.waypoints!.map((pt) => Offset(pt[0], pt[1])).toList();
  }

  // 计算该 group 的绝对位置
  final Offset groupAbs = group.absolutePosition(allNodes);
  // 将边的每个相对路由点映射到绝对坐标
  return edge.waypoints!
      .map((pt) => Offset(pt[0] + groupAbs.dx, pt[1] + groupAbs.dy))
      .toList();
}

/// CustomPainter 用于绘制边的路由线
class EdgePainter extends CustomPainter {
  final Map<String, List<Offset>> edgeRoutes;
  final Color color;
  final double strokeWidth;

  EdgePainter({
    required this.edgeRoutes,
    this.color = Colors.black,
    this.strokeWidth = 2.0,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke;

    for (final points in edgeRoutes.values) {
      if (points.length < 2) continue;

      final path = Path()..moveTo(points.first.dx, points.first.dy);

      for (int i = 0; i < points.length - 1; i++) {
        final current = points[i];
        final next = points[i + 1];

        if (i < points.length - 2) {
          // 取中点用于控制曲线
          final midPoint = Offset(
            (current.dx + next.dx) / 2,
            (current.dy + next.dy) / 2,
          );
          path.quadraticBezierTo(
            current.dx,
            current.dy,
            midPoint.dx,
            midPoint.dy,
          );
        } else {
          // 最后一个线段直接连接到终点
          path.quadraticBezierTo(
            current.dx,
            current.dy,
            next.dx,
            next.dy,
          );
        }
      }

      canvas.drawPath(path, paint);

      // 绘制箭头，基于路径的最后两个点
      _drawArrow(canvas, paint, points[points.length - 2], points.last);
    }
  }

  void _drawArrow(Canvas canvas, Paint paint, Offset from, Offset to) {
    const double arrowLength = 10;
    const double arrowAngle = 25 * (pi / 180); // 箭头角度（25度）

    final angle = (to - from).direction;
    final path = Path();

    final Offset arrowPoint1 = to -
        Offset(
          arrowLength * cos(angle - arrowAngle),
          arrowLength * sin(angle - arrowAngle),
        );
    final Offset arrowPoint2 = to -
        Offset(
          arrowLength * cos(angle + arrowAngle),
          arrowLength * sin(angle + arrowAngle),
        );

    path.moveTo(to.dx, to.dy);
    path.lineTo(arrowPoint1.dx, arrowPoint1.dy);
    path.moveTo(to.dx, to.dy);
    path.lineTo(arrowPoint2.dx, arrowPoint2.dy);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant EdgePainter oldDelegate) =>
      oldDelegate.edgeRoutes != edgeRoutes;
}

/// CanvasWidget 用于展示树形节点结构
/// 分为三大阶段：
/// 1. 内部布局阶段：包含调用外部布局算法对 group 内部进行重新布局，并更新 group 尺寸
/// 2. 边路由阶段：对所有边使用 flow_layout 计算路由点
/// 3. 渲染阶段：通过扩展方法计算每个节点的最终绝对坐标，再渲染节点和边
class CanvasWidget extends StatefulWidget {
  const CanvasWidget({super.key});
  @override
  State<CanvasWidget> createState() => _CanvasWidgetState();
}

class _CanvasWidgetState extends State<CanvasWidget> {
  final List<NodeModel> nodes = [];
  final List<EdgeModel> edges = [];
  // 存储每条边的路由点
  final Map<String, List<Offset>> edgeRoutes = {};

  // group 内部边距和节点间间距
  final EdgeInsets groupPadding = const EdgeInsets.all(16);
  final double nodeSpacing = 12;

  @override
  void initState() {
    super.initState();
    // 示例数据：顶层 group1 的 position 为绝对坐标 (100,100)，内部子节点存局部坐标
    nodes.addAll([
      // 顶层 Group1
      NodeModel(
        id: 'group1',
        title: 'Group 1',
        position: const Offset(100, 100),
        size: Size.zero, // 待内部布局计算
        isGroup: true,
      ),
      // group1 内的 Root 节点，局部坐标 (16,16)
      NodeModel(
        id: 'root1',
        title: 'Root 1',
        parentId: 'group1',
        position: const Offset(16, 16),
        size: const Size(100, 40),
        isGroupRoot: true,
      ),
      // group1 内的普通节点 Node 1.1，局部坐标 (16,68)
      NodeModel(
        id: 'node11',
        title: 'Node 1.1',
        parentId: 'group1',
        position: const Offset(16, 68),
        size: const Size(100, 40),
      ),

      // group1 内的普通节点 Node 1.2，局部坐标 (16,120)
      NodeModel(
        id: 'node12',
        title: 'Node 1.2',
        parentId: 'group1',
        position: const Offset(16, 68),
        size: const Size(100, 40),
      ),

      // group1 内的子组 Group2，局部坐标 (16,120)
      NodeModel(
        id: 'group2',
        title: 'Group 2',
        parentId: 'group1',
        position: const Offset(16, 120),
        size: const Size(150, 100), // 假设 group2 内部局部尺寸计算结果
        isGroup: true,
      ),
      // group2 内的普通节点 Node 2.1，局部坐标 (16,16)
      NodeModel(
        id: 'node21',
        title: 'Node 2.1',
        parentId: 'group2',
        position: const Offset(16, 16),
        size: const Size(100, 40),
      ),
      // group2 内的普通节点 Node 2.2，局部坐标 (16,68)
      NodeModel(
        id: 'node22',
        title: 'Node 2.2',
        parentId: 'group2',
        position: const Offset(16, 68),
        size: const Size(100, 40),
      ),

      NodeModel(
        id: 'node23',
        title: 'Node 2.3',
        parentId: 'group2',
        position: const Offset(16, 68),
        size: const Size(100, 40),
      ),

      NodeModel(
        id: 'node24',
        title: 'Node 2.4',
        parentId: 'group2',
        position: const Offset(16, 68),
        size: const Size(100, 40),
      ),

      NodeModel(
        id: 'nodeend',
        title: 'Node End',
        parentId: 'group1',
        position: const Offset(16, 180),
        size: const Size(100, 40),
      ),
    ]);
    // 示例边：
    // 边1：从 root1 到 node11
    edges.add(EdgeModel(sourceNodeId: 'root1', targetNodeId: 'node11'));

    // 边2：从 node11 到 node12
    edges.add(EdgeModel(sourceNodeId: 'node11', targetNodeId: 'node12'));

    // 边2：从 node11 到 group2（形成 chain： root1 -> node11 -> group2）
    edges.add(EdgeModel(sourceNodeId: 'node11', targetNodeId: 'group2'));

    // 边3：从 node21 到 node22
    edges.add(EdgeModel(sourceNodeId: 'node21', targetNodeId: 'node22'));
    // 边4：从 node22 到 node23
    edges.add(EdgeModel(sourceNodeId: 'node21', targetNodeId: 'node23'));

    // 边5：从 node23 到 node24
    edges.add(EdgeModel(sourceNodeId: 'node24', targetNodeId: 'node23'));

    // 边4：从 group2 到 nodeend
    edges.add(EdgeModel(sourceNodeId: 'group2', targetNodeId: 'nodeend'));
    // 边5：从 node22 到 nodeend
    edges.add(EdgeModel(sourceNodeId: 'node12', targetNodeId: 'nodeend'));
    edges.add(EdgeModel(sourceNodeId: 'node11', targetNodeId: 'nodeend'));

    // 执行内部布局：调用 performLayout() 递归调整 group 内部子节点
    performLayout();
  }

  /// performLayout：递归方式为所有 group 执行内部布局（从最内层开始）
  void performLayout() {
    void layoutGroup(String? parentId) {
      for (final group
          in nodes.where((n) => n.parentId == parentId && n.isGroup)) {
        layoutGroup(group.id);
        performGraphLayoutForGroup(group);
      }
    }

    layoutGroup(null);
  }

  /// 使用 flow_layout 算法对 group 内部子节点重新布局，
  /// 并归一化子节点坐标，使之相对于 group 内部区域左上角
  void performGraphLayoutForGroup(NodeModel group) {
    final children = nodes.where((n) => n.parentId == group.id).toList();
    if (children.isEmpty) return;

    final groupEdges = edges.where((edge) {
      final src =
          nodes.firstWhereOrNull((node) => node.id == edge.sourceNodeId);
      final tgt =
          nodes.firstWhereOrNull((node) => node.id == edge.targetNodeId);
      return src != null &&
          tgt != null &&
          src.parentId == group.id &&
          tgt.parentId == group.id;
    }).toList();

    final graph = Graph();
    // 添加子节点到 graph，局部坐标视为左上角坐标
    for (final node in children) {
      graph.setNode(node.id, {
        'width': node.size.width,
        'height': node.size.height,
        'x': node.position.dx,
        'y': node.position.dy,
      });
    }
    // 可选：添加顺序边到 graph 中
    for (final edge in edges) {
      final src = nodes.firstWhereOrNull((n) => n.id == edge.sourceNodeId);
      final tgt = nodes.firstWhereOrNull((n) => n.id == edge.targetNodeId);
      if (src != null &&
          tgt != null &&
          src.parentId == group.id &&
          tgt.parentId == group.id) {
        graph.setEdge(edge.sourceNodeId, edge.targetNodeId, {'id': edge.id});
      }
    }
    graph.setGraph({
      'rankdir': 'TB',
      'marginx': 20,
      'marginy': 20,
      'ranker': 'network-simplex',
    });
    layout(graph); // 调用 flow_layout 的布局算法

    // 更新子节点局部坐标归一化
    for (final node in children) {
      final nd = graph.node(node.id);
      if (nd != null && nd['x'] != null && nd['y'] != null) {
        final newX = (nd['x'] as num).toDouble() - node.size.width / 2;
        final newY = (nd['y'] as num).toDouble() - node.size.height / 2;
        node.position = Offset(newX, newY);
      }
    }
    // 使用 graph.label 来获取整个子图的计算宽高
    final labelData = graph.label;
    group.size = Size(labelData['width'], labelData['height']);

    for (final e in groupEdges) {
      final edgeData = graph.edge(e.sourceNodeId, e.targetNodeId);
      debugPrint('处理边 ${e.id} 的路由点');
      if (edgeData != null && edgeData['points'] != null) {
        final points = edgeData['points'] as List;
        final offsetPoints = <Offset>[];
        debugPrint('  边 ${e.id} 有 ${points.length} 个路由点');

        // 添加中间路由点
        for (final p in points) {
          final px = (p['x'] as num).toDouble();
          final py = (p['y'] as num).toDouble();
          offsetPoints.add(Offset(px, py));
          debugPrint('    点: ($px, $py)');
        }
        e.waypoints = offsetPoints.map((p) => [p.dx, p.dy]).toList();
      }
    }
  }

  void performGlobalEdgeRouteUpdate() {
    edgeRoutes.clear();
    for (final edge in edges) {
      if (edge.waypoints != null) {
        final absPoints = mapEdgeWaypointsToAbsolute(edge, nodes);
        edgeRoutes[edge.id] = absPoints;
      }
    }
  }

  /// 渲染阶段：使用扩展方法计算节点绝对坐标，并绘制边和节点
  @override
  Widget build(BuildContext context) {
    // 渲染阶段：先计算边路由，然后进行节点渲染
    performGlobalEdgeRouteUpdate();
    final sorted = _getSortedByDepthFirst();
    return Container(
      color: Colors.grey.shade200,
      child: Stack(
        children: [
          // 边先绘制
          CustomPaint(
            painter: EdgePainter(edgeRoutes: edgeRoutes),
            size: Size.infinite,
          ),
          // 节点之后，使用扩展方法计算绝对坐标
          ...sorted.map((node) {
            final absPos = node.absolutePosition(nodes);
            return Positioned(
              left: absPos.dx,
              top: absPos.dy,
              child: node.isGroup ? _renderGroup(node) : _renderNode(node),
            );
          }),
        ],
      ),
    );
  }

  /// 深度优先遍历排序，确保 group 先渲染（背景），内部节点后渲染
  List<NodeModel> _getSortedByDepthFirst() {
    List<NodeModel> result = [];
    void visit(String? parentId) {
      for (final node in nodes.where((n) => n.parentId == parentId)) {
        if (node.isGroup) result.add(node);
        visit(node.id);
        if (!node.isGroup) result.add(node);
      }
    }

    visit(null);
    return result;
  }

  Widget _renderGroup(NodeModel group) {
    return Container(
      width: group.size.width,
      height: group.size.height,
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: Colors.blue.withOpacity(0.1),
        border: Border.all(color: Colors.blue, width: 2),
      ),
      child: Text(
        group.title ?? '',
        style: const TextStyle(fontSize: 12),
      ),
    );
  }

  Widget _renderNode(NodeModel node) {
    return Container(
      width: node.size.width,
      height: node.size.height,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: node.isGroupRoot ? Colors.redAccent : Colors.orangeAccent,
        border: Border.all(color: Colors.black),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(node.title ?? '', style: const TextStyle(fontSize: 12)),
    );
  }
}
