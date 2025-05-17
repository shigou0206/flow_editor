import 'package:flutter/material.dart';
import 'package:flow_editor/v1/core/canvas/models/canvas_visual_config.dart';

class BackgroundRenderer extends CustomPainter {
  final CanvasVisualConfig config;

  /// 画布/视图的平移量(offset) 和 缩放(scale)：
  /// 外层通常是 Transform(...translate(offset.dx, offset.dy)..scale(scale))
  /// 这里要在paint里做逆变换。
  final Offset offset;
  final double scale;

  BackgroundRenderer({
    required this.config,
    this.offset = Offset.zero,
    this.scale = 1.0,
  });

  @override
  void paint(Canvas canvas, Size size) {
    // 1) 绘制底色
    canvas.drawRect(
      Offset.zero & size,
      Paint()..color = config.backgroundColor,
    );

    // 2) 如果网格开启，则画网格
    if (config.showGrid) {
      _drawInfiniteGrid(canvas, size);
    }
  }

  /// “方法B” 实现：每次paint时根据“可视区域”动态画网格。
  /// 步骤：
  ///  - 在此处先做 "逆变换" (跟外层 transform相反)，
  ///  - 再用 0..size + margin 的范围画线 => 等价于“只画当前屏幕可见区”在逻辑坐标下的部分。
  void _drawInfiniteGrid(Canvas canvas, Size size) {
    // 先保存状态
    canvas.save();

    // 外层 transform: translate(offset) => scale(scale)
    // => 逆变换： scale(1/scale) => translate(-offset)
    //
    // 注意：若你的外层transform顺序是先scale再translate，就要反着来。
    // 这里假设顺序: translate(offset) -> scale(scale).
    // 如果实际顺序不同，请对应调整。
    canvas.scale(1 / scale);
    canvas.translate(-offset.dx, -offset.dy);

    // 现在 “屏幕坐标(0..size.width x 0..size.height)”
    //      => “逻辑坐标( )”
    // 我们只需要在 0..size 这块区域(加些margin)画网格，即可保证可视区覆盖到。

    const double margin = 1000; // 额外绘制一点边缘，避免拖动时看到空白
    const double left = -margin;
    const double top = -margin;
    final double right = size.width + margin;
    final double bottom = size.height + margin;

    final Paint gridPaint = Paint()
      ..color = config.gridColor
      ..strokeWidth = 0.5;

    // 这里的 “逻辑步长”：
    // 若希望网格随缩放一起变，就不要再乘以scale。(外层transform已被逆变换了)
    // => 这样 1个step在逻辑空间固定 => 放大时网格看起来变稀疏, 缩小时变密
    final double step = config.gridSpacing;

    // 垂直线
    for (double x = left; x <= right; x += step) {
      canvas.drawLine(Offset(x, top), Offset(x, bottom), gridPaint);
    }

    // 水平线
    for (double y = top; y <= bottom; y += step) {
      canvas.drawLine(Offset(left, y), Offset(right, y), gridPaint);
    }

    // 恢复
    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
