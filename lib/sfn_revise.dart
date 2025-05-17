import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flow_editor/v1/core/node/models/node_model.dart';
import 'package:flow_editor/v1/core/edge/models/edge_model.dart';
import 'package:flow_editor/v1/core/layout/sugiyama_layout.dart';
import 'package:flow_editor/v1/core/canvas/utils.dart';
import 'dart:math' show pi, cos, sin;

void main() {
  runApp(const ProviderScope(child: MaterialApp(home: LayoutDemoPage())));
}

class LayoutState {
  final List<NodeModel> nodes;
  final List<EdgeModel> edges;
  final Map<String, List<Offset>> edgeRoutes;
  final List<NodeModel> sortedNodes;

  LayoutState({
    required this.nodes,
    required this.edges,
    required this.edgeRoutes,
    required this.sortedNodes,
  });
}

final layoutStateProvider = StateProvider<LayoutState>((ref) => LayoutState(
      nodes: [],
      edges: [],
      edgeRoutes: {},
      sortedNodes: [],
    ));

class LayoutDemoPage extends ConsumerStatefulWidget {
  const LayoutDemoPage({super.key});

  @override
  ConsumerState<LayoutDemoPage> createState() => _LayoutDemoPageState();
}

class _LayoutDemoPageState extends ConsumerState<LayoutDemoPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final nodes = _initGraph();
      final edges = _initEdges();

      _performLayout(nodes, edges);

      ref.read(layoutStateProvider.notifier).state = LayoutState(
        nodes: nodes,
        edges: edges,
        edgeRoutes: _computeGlobalEdgeRoutes(nodes, edges),
        sortedNodes: _getSortedByDepthFirst(nodes),
      );
    });
  }

  List<NodeModel> _initGraph() => [
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
            parentId: 'group1',
            position: const Offset(16, 68),
            size: const Size(100, 40)),
        NodeModel(
            id: 'nodeend',
            title: 'Node End',
            parentId: 'group1',
            position: const Offset(16, 180),
            size: const Size(100, 40)),
      ];

  List<EdgeModel> _initEdges() => [
        EdgeModel(sourceNodeId: 'root1', targetNodeId: 'node11'),
        EdgeModel(sourceNodeId: 'node11', targetNodeId: 'node12'),
        EdgeModel(sourceNodeId: 'node11', targetNodeId: 'group2'),
        EdgeModel(sourceNodeId: 'node21', targetNodeId: 'node22'),
        EdgeModel(sourceNodeId: 'node21', targetNodeId: 'node23'),
        // EdgeModel(sourceNodeId: 'node24', targetNodeId: 'node23'),
        EdgeModel(sourceNodeId: 'group2', targetNodeId: 'node24'),
        EdgeModel(sourceNodeId: 'node12', targetNodeId: 'nodeend'),
        EdgeModel(sourceNodeId: 'node24', targetNodeId: 'nodeend'),
      ];

  void _performLayout(List<NodeModel> nodes, List<EdgeModel> edges) {
    final layout = SugiyamaLayoutStrategy();
    layout.performLayout(nodes, edges);
  }

  Map<String, List<Offset>> _computeGlobalEdgeRoutes(
          List<NodeModel> nodes, List<EdgeModel> edges) =>
      {
        for (final edge in edges)
          if (edge.waypoints != null)
            edge.id: mapEdgeWaypointsToAbsolute(edge, nodes)
      };

  List<NodeModel> _getSortedByDepthFirst(List<NodeModel> nodes) {
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

  @override
  Widget build(BuildContext context) {
    final layoutState = ref.watch(layoutStateProvider);

    return Scaffold(
      body: Container(
        color: Colors.grey.shade200,
        child: Stack(
          children: [
            CustomPaint(
              painter: EdgePainter(edgeRoutes: layoutState.edgeRoutes),
              size: Size.infinite,
            ),
            for (final node in layoutState.sortedNodes)
              Positioned(
                left: node.absolutePosition(layoutState.nodes).dx,
                top: node.absolutePosition(layoutState.nodes).dy,
                child: node.isGroup ? _renderGroup(node) : _renderNode(node),
              ),
          ],
        ),
      ),
    );
  }

  Widget _renderGroup(NodeModel group) => Container(
        width: group.size.width,
        height: group.size.height,
        padding: const EdgeInsets.all(4),
        decoration: BoxDecoration(
          color: Colors.blue.withOpacity(0.1),
          border: Border.all(color: Colors.blue, width: 2),
        ),
        child: Text(group.title ?? '', style: const TextStyle(fontSize: 12)),
      );

  Widget _renderNode(NodeModel node) => Container(
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
