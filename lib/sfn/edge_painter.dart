import 'package:flutter/material.dart';
import 'models.dart';

class EdgePainter extends CustomPainter {
  final List<NodeModel> nodes;
  final List<EdgeModel> edges;
  final Map<String, List<Offset>> edgeRoutes; // 路由点列表
  final bool debug; // 是否开启调试信息
  final Offset offset; // 画布整体偏移

  EdgePainter(this.nodes, this.edges, this.edgeRoutes,
      {this.debug = false, this.offset = Offset.zero});

  @override
  void paint(Canvas canvas, Size size) {
    if (debug) {
      debugPrint(
          'EdgePainter: 绘制 ${edges.length} 条边, ${edgeRoutes.length} 条路由信息');
    }

    final paint = Paint()
      ..color = Colors.black
      ..strokeWidth = 2;

    final nodeMap = {for (var n in nodes) n.id: n};

    for (final e in edges) {
      if (debug) debugPrint('绘制边 ${e.id}: ${e.sourceId} -> ${e.targetId}');
      final src = nodeMap[e.sourceId];
      final dst = nodeMap[e.targetId];
      if (src == null || dst == null) continue;

      final routePoints = edgeRoutes[e.id];
      if (routePoints != null && routePoints.isNotEmpty) {
        if (debug) {
          debugPrint('  使用路由点绘制: ${routePoints.length} 个点');
          for (int i = 0; i < routePoints.length; i++) {
            debugPrint(
                '    点 $i: (${routePoints[i].dx}, ${routePoints[i].dy})');
          }
        }

        final pathPaint = Paint()
          ..color = debug ? Colors.blue.shade700 : Colors.black
          ..strokeWidth = 1.5
          ..style = PaintingStyle.stroke;

        final path = Path()
          ..moveTo(
              routePoints[0].dx + offset.dx, routePoints[0].dy + offset.dy);
        for (int i = 1; i < routePoints.length; i++) {
          path.lineTo(
              routePoints[i].dx + offset.dx, routePoints[i].dy + offset.dy);
        }
        canvas.drawPath(path, pathPaint);

        // 绘制调试用的小圆点
        if (debug) {
          final dotPaint = Paint()
            ..color = Colors.red
            ..strokeWidth = 1
            ..style = PaintingStyle.fill;
          for (final point in routePoints) {
            canvas.drawCircle(
                Offset(point.dx + offset.dx, point.dy + offset.dy),
                2,
                dotPaint);
          }
        }

        // 绘制箭头：使用最后两个点确定方向
        if (routePoints.length >= 2) {
          final lastPoint = routePoints.last + offset;
          final secondLastPoint = routePoints[routePoints.length - 2] + offset;
          _drawArrow(canvas, secondLastPoint, lastPoint, paint);
        }
      } else {
        if (debug) debugPrint('  没有路由点，使用直线绘制');

        // fallback 使用节点中心直线绘制
        final srcPos = Offset(src.x, src.y) + offset;
        final dstPos = Offset(dst.x, dst.y) + offset;
        if (debug) {
          debugPrint(
              '  直线: (${srcPos.dx}, ${srcPos.dy}) -> (${dstPos.dx}, ${dstPos.dy})');
        }
        canvas.drawLine(srcPos, dstPos, paint);
        _drawArrow(canvas, srcPos, dstPos, paint);
      }
    }
  }

  // 绘制箭头函数
  void _drawArrow(Canvas canvas, Offset start, Offset end, Paint paint) {
    final arrowSize = 6.0;
    final direction = (end - start);
    final length = direction.distance;
    if (length == 0) return;
    final normalized = direction / length;
    // 避免箭头与节点重叠，稍微缩回一点
    final arrowEnd = end - normalized * 2.0;
    final perpendicular = Offset(-normalized.dy, normalized.dx);
    final arrowPoint1 =
        arrowEnd - normalized * arrowSize + perpendicular * (arrowSize / 2);
    final arrowPoint2 =
        arrowEnd - normalized * arrowSize - perpendicular * (arrowSize / 2);
    final arrowPaint = Paint()
      ..color = paint.color
      ..strokeWidth = 1.5
      ..style = PaintingStyle.stroke;
    final path = Path()
      ..moveTo(arrowEnd.dx, arrowEnd.dy)
      ..lineTo(arrowPoint1.dx, arrowPoint1.dy)
      ..lineTo(arrowPoint2.dx, arrowPoint2.dy)
      ..close();
    canvas.drawPath(path, arrowPaint);

    if (debug) {
      debugPrint(
          '  绘制箭头: 从 (${start.dx}, ${start.dy}) 到 (${end.dx}, ${end.dy})');
      debugPrint('    箭头尖端: (${arrowEnd.dx}, ${arrowEnd.dy})');
      debugPrint('    箭头点1: (${arrowPoint1.dx}, ${arrowPoint1.dy})');
      debugPrint('    箭头点2: (${arrowPoint2.dx}, ${arrowPoint2.dy})');
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
