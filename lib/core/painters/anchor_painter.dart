import 'package:flutter/material.dart';
import 'package:flow_editor/core/models/anchor_model.dart';
import 'package:flow_editor/core/models/enums/anchor_enums.dart';

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
    const double radius = 12;

    // 1) 决定填充颜色
    final Color fillColor = _resolveFillColor();

    // 2) 决定边框颜色
    final Color strokeColor = _resolveBorderColor();

    // 3) 决定边框宽度
    final double strokeWidth = isSelected ? 2.5 : 1.0;

    final fillPaint = Paint()
      ..color = fillColor
      ..style = PaintingStyle.fill;

    final strokePaint = Paint()
      ..color = strokeColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth;

    switch (anchor.shape) {
      case AnchorShape.circle:
        // 画圆
        canvas.drawCircle(center, radius, fillPaint);
        canvas.drawCircle(center, radius, strokePaint);
        break;
      case AnchorShape.square:
        final rect = Rect.fromCenter(
          center: center,
          width: radius,
          height: radius * 2,
        );
        canvas.drawRect(rect, fillPaint);
        canvas.drawRect(rect, strokePaint);
        break;
      case AnchorShape.diamond:
        final path = Path()
          ..moveTo(center.dx, center.dy - radius)
          ..lineTo(center.dx + radius, center.dy)
          ..lineTo(center.dx, center.dy + radius)
          ..lineTo(center.dx - radius, center.dy)
          ..close();
        canvas.drawPath(path, fillPaint);
        canvas.drawPath(path, strokePaint);
        break;
      case AnchorShape.custom:
        final path2 = Path()
          ..moveTo(center.dx, center.dy - radius)
          ..lineTo(center.dx + radius, center.dy + radius)
          ..lineTo(center.dx - radius, center.dy + radius)
          ..close();
        canvas.drawPath(path2, fillPaint);
        canvas.drawPath(path2, strokePaint);
        break;
    }

    // 如果想在 hover 或 selected 时做发光效果:
    if (isHover || isSelected) {
      final glowPaint = Paint()
        ..color = strokeColor.withOpacity(0.3)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 6.0
        ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 4.0);
      canvas.drawCircle(center, radius + 2, glowPaint);
    }
  }

  Color _resolveFillColor() {
    // 优先使用 anchor.fillColorHex
    if (anchor.plusButtonColorHex != null &&
        anchor.plusButtonColorHex!.isNotEmpty) {
      return _parseColorHex(anchor.plusButtonColorHex) ?? Colors.white;
    }

    // 否则回到原先 plusButtonColorHex / locked / isHover
    final baseColor =
        _parseColorHex(anchor.plusButtonColorHex) ?? const Color(0xFF252525);
    if (anchor.locked) {
      return Colors.grey;
    } else {
      return baseColor.withOpacity(isHover || isSelected ? 0.9 : 0.7);
    }
  }

  Color _resolveBorderColor() {
    // 优先使用 anchor.borderColorHex
    if (anchor.plusButtonColorHex != null &&
        anchor.plusButtonColorHex!.isNotEmpty) {
      return _parseColorHex(anchor.plusButtonColorHex) ?? Colors.blue;
    }

    // 否则回到原先 hover / selected
    if (isSelected) {
      return Colors.blueAccent;
    } else if (isHover) {
      return Colors.orange;
    } else {
      return Colors.black12;
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
