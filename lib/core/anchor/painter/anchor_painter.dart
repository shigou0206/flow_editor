import 'package:flutter/material.dart';
import 'package:flow_editor/core/anchor/models/anchor_model.dart';
import 'package:flow_editor/core/anchor/models/anchor_enums.dart';

/// 用于绘制 Anchor 的 CustomPainter
/// 根据 anchor.shape / locked / hover 等状态绘制不同外观
/// 你可在外部传递 isHover / isSelected，或存储在 anchor.data 里
/// 这里只示例最基本的绘制
class AnchorPainter extends CustomPainter {
  final AnchorModel anchor;
  final bool isHover; // 可选: 用于悬停高亮
  final bool isSelected; // 可选: 用于选中时的高亮

  AnchorPainter({
    required this.anchor,
    this.isHover = false,
    this.isSelected = false,
  });

  @override
  void paint(Canvas canvas, Size size) {
    // 1) 确定锚点中心点(这里以整个widget的中心为锚点)
    final center = Offset(size.width / 2, size.height / 2);

    // 2) 大小(半径/边长)
    // 根据 anchor.data 或 shape 设定，暂时用固定大小
    const double radius = 8;

    // 3) 颜色(如果 locked => 灰色，否则 from anchor.plusButtonColorHex / default)
    Color color;
    if (anchor.locked) {
      color = Colors.grey;
    } else {
      color = _parseColorHex(anchor.plusButtonColorHex) ?? Colors.blue;
    }

    // 如果 hover/selected => 稍微加重
    if (isSelected || isHover) {
      color = color.withOpacity(0.8);
    }

    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    // 4) 根据 shape 画不同图形
    switch (anchor.shape) {
      case AnchorShape.circle:
        canvas.drawCircle(center, radius, paint);
        break;
      case AnchorShape.square:
        final rect = Rect.fromCenter(
          center: center,
          width: radius * 2,
          height: radius * 2,
        );
        canvas.drawRect(rect, paint);
        break;
      case AnchorShape.diamond:
        final path = Path();
        path.moveTo(center.dx, center.dy - radius); // top
        path.lineTo(center.dx + radius, center.dy); // right
        path.lineTo(center.dx, center.dy + radius); // bottom
        path.lineTo(center.dx - radius, center.dy); // left
        path.close();
        canvas.drawPath(path, paint);
        break;
      case AnchorShape.custom:
        // 这里可从 anchor.data 里获取自定义路径或 svg
        // 简单示例 => 画三角
        final path2 = Path();
        path2.moveTo(center.dx, center.dy - radius);
        path2.lineTo(center.dx + radius, center.dy + radius);
        path2.lineTo(center.dx - radius, center.dy + radius);
        path2.close();
        canvas.drawPath(path2, paint);
        break;
    }

    // 5) 若 anchor.plusButtonSize != null => 也可在内部加一个 + 号
    // ... 视需求自由发挥
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true; // 简单处理
  }
}

Color? _parseColorHex(String? hexStr) {
  if (hexStr == null || hexStr.isEmpty) return null;
  var hex = hexStr.replaceAll('#', '');
  if (hex.length == 6) {
    hex = 'FF$hex';
  }
  if (hex.length == 8) {
    final val = int.parse(hex, radix: 16);
    return Color(val);
  }
  return null;
}
