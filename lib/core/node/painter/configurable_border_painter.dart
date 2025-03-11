// file: configurable_border_painter.dart
import 'dart:math' as math;
import 'package:flutter/material.dart';

/// 边框绘制模式
enum BorderDrawMode {
  staticColor,
  animatedSweep,
  staticWithSpinningArc,
  animatedMarqueeEdges,
}

/// 边框形状
enum BorderShape {
  roundRect,
  rect,
  ellipse,
}

/// 通用配置
class BorderPainterConfig {
  final BorderDrawMode mode;
  final BorderShape shape;

  /// 动画进度[0..1], 用于旋转
  final double animationValue;

  /// 边框线宽
  final double strokeWidth;

  /// 圆角大小 (仅对roundRect)
  final double cornerRadius;

  /// 静态颜色 (如非运行时灰色)
  final Color staticColor;

  /// animatedSweep 模式的颜色等
  final List<Color> gradientColors;

  /// ============== 新增：marqueeEdges相关 ==============
  /// 用于控制该跑马灯的“波段宽度”、颜色等
  /// 我们用 stops/颜色搭配, 或让你自定义
  final List<Color> marqueeColors;
  final List<double> marqueeStops;

  const BorderPainterConfig({
    this.mode = BorderDrawMode.staticColor,
    this.shape = BorderShape.roundRect,
    this.animationValue = 0.0,
    this.strokeWidth = 4.0,
    this.cornerRadius = 8.0,
    this.staticColor = Colors.grey,
    this.gradientColors = const [
      Colors.red,
      Colors.orange,
      Colors.yellow,
      Colors.green,
      Colors.blue,
      Colors.purple,
      Colors.red,
    ],
    // marqueeEdges默认值：前后透明，中间一小段有色
    this.marqueeColors = const [
      Colors.transparent,
      Colors.transparent,
      Colors.cyan,
      Colors.cyan,
      Colors.transparent,
      Colors.transparent,
    ],
    this.marqueeStops = const [0.0, 0.4, 0.45, 0.55, 0.60, 1.0],
  });
}

class ConfigurableBorderPainter extends CustomPainter {
  final BorderPainterConfig config;

  const ConfigurableBorderPainter({required this.config});

  @override
  void paint(Canvas canvas, Size size) {
    // 基础Rect
    final rect = Rect.fromLTWH(0, 0, size.width, size.height)
        .deflate(config.strokeWidth / 2);

    switch (config.mode) {
      case BorderDrawMode.staticColor:
        _paintStatic(canvas, rect);
        break;
      case BorderDrawMode.animatedSweep:
        _paintAnimatedSweep(canvas, rect);
        break;
      case BorderDrawMode.staticWithSpinningArc:
        _paintStatic(canvas, rect);
        _paintSpinningArc(canvas, rect);
        break;
      case BorderDrawMode.animatedMarqueeEdges:
        _paintMarqueeEdges(canvas, rect);
        break;
    }
  }

  /// 1) 纯色静态边
  void _paintStatic(Canvas canvas, Rect rect) {
    final paint = Paint()
      ..color = config.staticColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = config.strokeWidth;
    _drawShape(canvas, rect, paint);
  }

  /// 2) 整圈SweepGradient (已示例过)
  void _paintAnimatedSweep(Canvas canvas, Rect rect) {
    final startAngle = 2 * math.pi * config.animationValue;
    final gradient = SweepGradient(
      startAngle: startAngle,
      endAngle: startAngle + 2 * math.pi,
      colors: config.gradientColors,
    );
    final paint = Paint()
      ..shader = gradient.createShader(rect)
      ..style = PaintingStyle.stroke
      ..strokeWidth = config.strokeWidth;
    _drawShape(canvas, rect, paint);
  }

  /// 3) 灰+外沿弧 (也见之前示例)
  void _paintSpinningArc(Canvas canvas, Rect rect) {
    // ...
  }

  /// 4) 新增：MarqueeEdges => 用 SweepGradient + 只在部分区段有颜色
  void _paintMarqueeEdges(Canvas canvas, Rect rect) {
    // 先可选地画一个静态灰色边做底
    // 如果你想node默认就是黑或灰, 你可以在外层Widget写mode=staticColor
    // 这里演示"直接"在MarqueeEdges里, 先绘制灰色
    _paintStatic(canvas, rect);

    // SweepGradient: 前后是透明, 中间一小段是彩色 => 形成一个"波段"
    final startAngle = 2 * math.pi * config.animationValue;

    final gradient = SweepGradient(
      startAngle: startAngle,
      endAngle: startAngle + 2 * math.pi,
      colors: config
          .marqueeColors, // e.g. [transparent, transparent, color, color, transparent...]
      stops: config.marqueeStops, // 定义波段宽度
      tileMode: TileMode.clamp,
    );

    final paint = Paint()
      ..shader = gradient.createShader(rect)
      ..style = PaintingStyle.stroke
      ..strokeWidth = config.strokeWidth;

    _drawShape(canvas, rect, paint);
  }

  void _drawShape(Canvas canvas, Rect rect, Paint paint) {
    switch (config.shape) {
      case BorderShape.roundRect:
        final rrect = RRect.fromRectAndRadius(
          rect,
          Radius.circular(config.cornerRadius),
        );
        canvas.drawRRect(rrect, paint);
        break;
      case BorderShape.rect:
        canvas.drawRect(rect, paint);
        break;
      case BorderShape.ellipse:
        canvas.drawOval(rect, paint);
        break;
    }
  }

  @override
  bool shouldRepaint(ConfigurableBorderPainter oldDelegate) {
    return oldDelegate.config != config;
  }
}
