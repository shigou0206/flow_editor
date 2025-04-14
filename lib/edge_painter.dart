import 'package:flutter/material.dart';
import 'dart:math' show pi, cos, sin;

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
