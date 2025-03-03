import 'package:flutter/material.dart';
import '../models/canvas_visual_config.dart';

class BackgroundRenderer extends CustomPainter {
  final CanvasVisualConfig config;
  final Offset offset; // 当前视口的偏移
  final double scale; // 当前缩放比例

  BackgroundRenderer({
    required this.config,
    this.offset = Offset.zero,
    this.scale = 1.0,
  });

  @override
  void paint(Canvas canvas, Size size) {
    // 绘制背景色
    canvas.drawRect(
      Offset.zero & size,
      Paint()..color = config.backgroundColor,
    );

    // 绘制网格线（如果开启）
    if (config.showGrid) {
      _drawGrid(canvas, size);
    }
  }

  void _drawGrid(Canvas canvas, Size size) {
    final Paint gridPaint = Paint()
      ..color = config.gridColor
      ..strokeWidth = 0.5;

    final double step = config.gridSpacing * scale;

    // 水平网格线
    double startY = offset.dy % step;
    for (double y = startY; y < size.height; y += step) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), gridPaint);
    }

    // 垂直网格线
    double startX = offset.dx % step;
    for (double x = startX; x < size.width; x += step) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), gridPaint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
