import 'package:flutter/material.dart';
import 'package:flow_editor/core/node/models/node_model.dart';
import 'package:flow_editor/core/edge/models/edge_model.dart';
import 'package:flow_editor/core/layout/sugiyama_layout.dart';
import 'package:flow_editor/core/canvas/utils.dart';
import 'dart:math' show pi, cos, sin;

void main() {
  runApp(const MaterialApp(home: LayoutDemoPage()));
}

class LayoutDemoPage extends StatefulWidget {
  const LayoutDemoPage({super.key});

  @override
  State<LayoutDemoPage> createState() => _LayoutDemoPageState();
}

class _LayoutDemoPageState extends State<LayoutDemoPage> {
  final List<NodeModel> nodes = [];
  final List<EdgeModel> edges = [];

  @override
  void initState() {
    super.initState();
    _initGraph();
    _performLayout();
  }

  void _initGraph() {
    nodes.addAll([
      NodeModel(
          id: 'group1',
          title: 'Group 1',
          position: const Offset(100, 100),
          size: Size.zero,
          isGroup: true),
      NodeModel(
          id: 'root1',
          title: 'Root 1',
          parentId: 'group1',
          position: const Offset(16, 16),
          size: const Size(100, 40),
          isGroupRoot: true),
      NodeModel(
          id: 'node11',
          title: 'Node 1.1',
          parentId: 'group1',
          position: const Offset(16, 68),
          size: const Size(100, 40)),
      NodeModel(
          id: 'node12',
          title: 'Node 1.2',
          parentId: 'group1',
          position: const Offset(16, 68),
          size: const Size(100, 40)),
      NodeModel(
          id: 'group2',
          title: 'Group 2',
          parentId: 'group1',
          position: const Offset(16, 120),
          size: const Size(150, 100),
          isGroup: true),
      NodeModel(
          id: 'node21',
          title: 'Node 2.1',
          parentId: 'group2',
          position: const Offset(16, 16),
          size: const Size(100, 40)),
      NodeModel(
          id: 'node22',
          title: 'Node 2.2',
          parentId: 'group2',
          position: const Offset(16, 68),
          size: const Size(100, 40)),
      NodeModel(
          id: 'node23',
          title: 'Node 2.3',
          parentId: 'group2',
          position: const Offset(16, 68),
          size: const Size(100, 40)),
      NodeModel(
          id: 'node24',
          title: 'Node 2.4',
          parentId: 'group2',
          position: const Offset(16, 68),
          size: const Size(100, 40)),
      NodeModel(
          id: 'nodeend',
          title: 'Node End',
          parentId: 'group1',
          position: const Offset(16, 180),
          size: const Size(100, 40)),
    ]);

    edges.addAll([
      EdgeModel(sourceNodeId: 'root1', targetNodeId: 'node11'),
      EdgeModel(sourceNodeId: 'node11', targetNodeId: 'node12'),
      EdgeModel(sourceNodeId: 'node11', targetNodeId: 'group2'),
      EdgeModel(sourceNodeId: 'node21', targetNodeId: 'node22'),
      EdgeModel(sourceNodeId: 'node21', targetNodeId: 'node23'),
      EdgeModel(sourceNodeId: 'node24', targetNodeId: 'node23'),
      EdgeModel(sourceNodeId: 'group2', targetNodeId: 'nodeend'),
      EdgeModel(sourceNodeId: 'node12', targetNodeId: 'nodeend'),
      EdgeModel(sourceNodeId: 'node11', targetNodeId: 'nodeend'),
    ]);
  }

  void _performLayout() {
    final layout = SugiyamaLayoutStrategy();
    layout.performLayout(nodes, edges);
  }

  Map<String, List<Offset>> performGlobalEdgeRouteUpdate(List<EdgeModel> edges) {
    final edgeRoutes = <String, List<Offset>>{};
    for (final edge in edges) {
      if (edge.waypoints != null) {
        final absPoints = mapEdgeWaypointsToAbsolute(edge, nodes);
        edgeRoutes[edge.id] = absPoints;
      }
    }
    return edgeRoutes;
  }

  @override
  Widget build(BuildContext context) {
    // 渲染阶段：先计算边路由，然后进行节点渲染
    final edgeRoutes = performGlobalEdgeRouteUpdate(edges);
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
        style: const TextStyle(fontSize: 12, color: Colors.black),
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
      child: Text(
        node.title ?? '',
        style: const TextStyle(fontSize: 12, color: Colors.black),
      ),
    );
  }
}

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
