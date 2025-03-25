import 'package:flutter/material.dart';
import 'package:flow_editor/core/anchor/models/anchor_model.dart';
import 'package:flow_editor/core/anchor/models/anchor_enums.dart';

class AnchorPainter extends CustomPainter {
  final AnchorModel anchor;
  final bool isHover;
  final bool isSelected;

  AnchorPainter({
    required this.anchor,
    this.isHover = false,
    this.isSelected = false,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    const double radius = 8;

    // 动态颜色计算
    final baseColor =
        _parseColorHex(anchor.plusButtonColorHex) ?? const Color(0xFF252525);
    final fillColor = anchor.locked
        ? Colors.grey
        : baseColor.withOpacity(isHover || isSelected ? 0.9 : 0.7);

    final borderColor = isSelected
        ? Colors.blueAccent
        : isHover
            ? Colors.orange
            : Colors.black12;

    final borderWidth = isSelected ? 2.5 : 1.0;

    final fillPaint = Paint()
      ..color = fillColor
      ..style = PaintingStyle.fill;

    final borderPaint = Paint()
      ..color = borderColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = borderWidth;

    switch (anchor.shape) {
      case AnchorShape.circle:
        canvas.drawCircle(center, radius, fillPaint);
        canvas.drawCircle(center, radius, borderPaint);
        break;
      case AnchorShape.square:
        final rect = Rect.fromCenter(
          center: center,
          width: radius * 2,
          height: radius * 2,
        );
        canvas.drawRect(rect, fillPaint);
        canvas.drawRect(rect, borderPaint);
        break;
      case AnchorShape.diamond:
        final path = Path()
          ..moveTo(center.dx, center.dy - radius)
          ..lineTo(center.dx + radius, center.dy)
          ..lineTo(center.dx, center.dy + radius)
          ..lineTo(center.dx - radius, center.dy)
          ..close();
        canvas.drawPath(path, fillPaint);
        canvas.drawPath(path, borderPaint);
        break;
      case AnchorShape.custom:
        final path2 = Path()
          ..moveTo(center.dx, center.dy - radius)
          ..lineTo(center.dx + radius, center.dy + radius)
          ..lineTo(center.dx - radius, center.dy + radius)
          ..close();
        canvas.drawPath(path2, fillPaint);
        canvas.drawPath(path2, borderPaint);
        break;
    }

    // 发光效果（可选）
    if (isHover || isSelected) {
      final glowPaint = Paint()
        ..color = borderColor.withOpacity(0.3)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 6.0
        ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 4.0);

      canvas.drawCircle(center, radius + 2, glowPaint);
    }
  }

  @override
  bool shouldRepaint(covariant AnchorPainter oldDelegate) {
    return anchor != oldDelegate.anchor ||
        isHover != oldDelegate.isHover ||
        isSelected != oldDelegate.isSelected;
  }
}

Color? _parseColorHex(String? hexStr) {
  if (hexStr == null || hexStr.isEmpty) return null;
  var hex = hexStr.replaceAll('#', '');
  if (hex.length == 6) hex = 'FF$hex';
  if (hex.length == 8) {
    final val = int.parse(hex, radix: 16);
    return Color(val);
  }
  return null;
}
