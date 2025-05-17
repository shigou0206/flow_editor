import 'package:flutter/material.dart';
import 'package:flow_editor/core/models/styles/canvas_visual_config.dart';
import 'package:flow_editor/core/models/enums/canvas_enum.dart';

class DottedGridPainter extends CustomPainter {
  final Offset offset; // Canvas translation offset
  final double scale; // Scale factor
  final CanvasVisualConfig config;
  final BackgroundStyle style;
  final ThemeMode themeMode;

  DottedGridPainter({
    required this.offset,
    required this.scale,
    required this.config,
    required this.style,
    required this.themeMode,
  });

  @override
  void paint(Canvas canvas, Size size) {
    // 首先绘制背景色
    canvas.drawRect(
      Offset.zero & size,
      Paint()
        ..color = themeMode == ThemeMode.dark
            ? const Color(0xFF1E1E1E)
            : Colors.white,
    );

    // 根据主题调整网格颜色
    final gridColor = themeMode == ThemeMode.dark ? Colors.white : Colors.black;

    switch (style) {
      case BackgroundStyle.dots:
        _paintDots(canvas, size, gridColor);
      case BackgroundStyle.lines:
        _paintLines(canvas, size, gridColor);
      case BackgroundStyle.crossLines:
        _paintCrossLines(canvas, size, gridColor);
      case BackgroundStyle.clean:
        // 纯白色背景，不需要绘制
        break;
    }
  }

  void _paintDots(Canvas canvas, Size size, Color color) {
    final paint = Paint()
      ..color = color.withOpacity(0.2)
      ..strokeWidth = 1;

    final logicalTopLeft = (Offset.zero - offset) / scale;
    final logicalBottomRight = (size.bottomRight(Offset.zero) - offset) / scale;
    const spacing = 20.0;

    final startX = (logicalTopLeft.dx / spacing).floor() * spacing;
    final startY = (logicalTopLeft.dy / spacing).floor() * spacing;

    for (double x = startX; x <= logicalBottomRight.dx; x += spacing) {
      for (double y = startY; y <= logicalBottomRight.dy; y += spacing) {
        final point = (Offset(x, y) * scale) + offset;
        canvas.drawCircle(point, 1, paint);
      }
    }
  }

  void _paintLines(Canvas canvas, Size size, Color color) {
    final mainPaint = Paint()
      ..color = color.withOpacity(0.1)
      ..strokeWidth = 1;
    final subPaint = Paint()
      ..color = color.withOpacity(0.05)
      ..strokeWidth = 0.5;

    final logicalTopLeft = (Offset.zero - offset) / scale;
    final logicalBottomRight = (size.bottomRight(Offset.zero) - offset) / scale;

    const mainSpacing = 100.0;
    const subSpacing = 20.0;

    // 绘制次网格线
    for (double x = logicalTopLeft.dx;
        x <= logicalBottomRight.dx;
        x += subSpacing) {
      final startPoint = (Offset(x, logicalTopLeft.dy) * scale) + offset;
      final endPoint = (Offset(x, logicalBottomRight.dy) * scale) + offset;
      canvas.drawLine(startPoint, endPoint, subPaint);
    }

    for (double y = logicalTopLeft.dy;
        y <= logicalBottomRight.dy;
        y += subSpacing) {
      final startPoint = (Offset(logicalTopLeft.dx, y) * scale) + offset;
      final endPoint = (Offset(logicalBottomRight.dx, y) * scale) + offset;
      canvas.drawLine(startPoint, endPoint, subPaint);
    }

    // 绘制主网格线
    for (double x = logicalTopLeft.dx;
        x <= logicalBottomRight.dx;
        x += mainSpacing) {
      final startPoint = (Offset(x, logicalTopLeft.dy) * scale) + offset;
      final endPoint = (Offset(x, logicalBottomRight.dy) * scale) + offset;
      canvas.drawLine(startPoint, endPoint, mainPaint);
    }

    for (double y = logicalTopLeft.dy;
        y <= logicalBottomRight.dy;
        y += mainSpacing) {
      final startPoint = (Offset(logicalTopLeft.dx, y) * scale) + offset;
      final endPoint = (Offset(logicalBottomRight.dx, y) * scale) + offset;
      canvas.drawLine(startPoint, endPoint, mainPaint);
    }
  }

  void _paintCrossLines(Canvas canvas, Size size, Color color) {
    final paint = Paint()
      ..color = color.withOpacity(0.1)
      ..strokeWidth = 0.5;

    const spacing = 20.0;

    // 绘制交叉线
    for (double x = 0; x <= size.width; x += spacing) {
      for (double y = 0; y <= size.height; y += spacing) {
        // 绘制 "X" 形
        canvas.drawLine(
          Offset(x - 5, y - 5),
          Offset(x + 5, y + 5),
          paint,
        );
        canvas.drawLine(
          Offset(x - 5, y + 5),
          Offset(x + 5, y - 5),
          paint,
        );
      }
    }
  }

  @override
  bool shouldRepaint(covariant DottedGridPainter oldDelegate) {
    return oldDelegate.offset != offset ||
        oldDelegate.scale != scale ||
        oldDelegate.style != style ||
        oldDelegate.themeMode != themeMode;
  }
}
