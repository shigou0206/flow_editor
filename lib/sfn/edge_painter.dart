// edge_painter.dart

import 'package:flutter/material.dart';
import 'models.dart';

class EdgePainter extends CustomPainter {
  final List<NodeModel> nodes;
  final List<EdgeModel> edges;
  final Map<String, List<Offset>> edgeRoutes; // 关键：路由点

  EdgePainter(this.nodes, this.edges, this.edgeRoutes);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.black
      ..strokeWidth = 2;

    final nodeMap = {for (var n in nodes) n.id: n};

    for (final e in edges) {
      final routePoints = edgeRoutes[e.id];
      if (routePoints != null && routePoints.isNotEmpty) {
        // 如果存在多段折线路径，则逐点连接
        final path = Path()..moveTo(routePoints[0].dx, routePoints[0].dy);
        for (int i = 1; i < routePoints.length; i++) {
          path.lineTo(routePoints[i].dx, routePoints[i].dy);
        }
        canvas.drawPath(path, paint);

        // 你也可在此加“箭头”计算，取 path 最后两点做方向
      } else {
        // fallback: 画一条直线(节点中心->节点中心)
        final src = nodeMap[e.sourceId];
        final dst = nodeMap[e.targetId];
        if (src == null || dst == null) continue;

        final srcPos = Offset(src.x, src.y);
        final dstPos = Offset(dst.x, dst.y);
        canvas.drawLine(srcPos, dstPos, paint);
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
