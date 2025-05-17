// lib/core/painters/background_painter.dart
import 'package:flutter/material.dart';
import 'package:flow_editor/core/models/style/grid_style.dart';
import 'package:flow_editor/core/models/enums.dart';

class CanvasBackgroundPainter extends CustomPainter {
  const CanvasBackgroundPainter({
    required this.offset,
    required this.scale,
    required this.bgColor,
    required this.grid,
  });

  final Offset offset;
  final double scale;
  final Color bgColor;
  final GridStyle grid;

  // ────────── paint ──────────
  @override
  void paint(Canvas canvas, Size size) {
    // 1. 底色
    canvas.drawRect(Offset.zero & size, Paint()..color = bgColor);

    // 2. 网格
    if (!grid.show || grid.style == BackgroundStyle.clean) return;

    switch (grid.style) {
      case BackgroundStyle.dots:
        _paintDots(canvas, size);
        break;
      case BackgroundStyle.lines:
        _paintLines(canvas, size);
        break;
      case BackgroundStyle.crossLines:
        _paintCross(canvas, size);
        break;
      case BackgroundStyle.clean:
        break;
    }
  }

  // ────────── dots ──────────
  void _paintDots(Canvas c, Size s) {
    if (scale <= 0) return;
    final step = grid.spacing * scale;
    final startX = (-offset.dx % step);
    final startY = (-offset.dy % step);

    final paint = Paint()
      ..color = grid.mainColor
      ..style = PaintingStyle.fill;

    for (double x = startX; x <= s.width; x += step) {
      for (double y = startY; y <= s.height; y += step) {
        c.drawCircle(Offset(x, y), grid.dotRadius, paint);
      }
    }
  }

  // ────────── lines ──────────
  void _paintLines(Canvas c, Size s) {
    if (scale <= 0) return;
    final main = grid.spacing * scale;
    final sub = main / 4;

    final mainPaint = Paint()
      ..color = grid.mainColor
      ..strokeWidth = 1
      ..isAntiAlias = false;
    final subPaint = Paint()
      ..color = grid.subColor
      ..strokeWidth = 1
      ..isAntiAlias = false;

    _drawGrid(c, s, sub, subPaint);
    _drawGrid(c, s, main, mainPaint);
  }

  void _drawGrid(Canvas c, Size s, double step, Paint p) {
    final x0 = (-offset.dx % step);
    final y0 = (-offset.dy % step);
    for (double x = x0; x <= s.width; x += step) {
      c.drawLine(Offset(x + .5, 0), Offset(x + .5, s.height), p);
    }
    for (double y = y0; y <= s.height; y += step) {
      c.drawLine(Offset(0, y + .5), Offset(s.width, y + .5), p);
    }
  }

  // ──────── crossLines ────────
  void _paintCross(Canvas c, Size s) {
    if (scale <= 0) return;
    final step = grid.spacing * scale;
    final startX = (-offset.dx % step);
    final startY = (-offset.dy % step);
    const half = 3.0;

    final paint = Paint()
      ..color = grid.mainColor
      ..strokeWidth = 1;

    for (double x = startX; x <= s.width; x += step) {
      for (double y = startY; y <= s.height; y += step) {
        c.drawLine(
            Offset(x - half, y - half), Offset(x + half, y + half), paint);
        c.drawLine(
            Offset(x - half, y + half), Offset(x + half, y - half), paint);
      }
    }
  }

  // ────────── shouldRepaint ──────────
  @override
  bool shouldRepaint(covariant CanvasBackgroundPainter old) =>
      old.offset != offset ||
      old.scale != scale ||
      old.bgColor != bgColor ||
      old.grid != grid;
}



// // lib/core/painters/background_painter.dart
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';

// import 'package:flow_editor/core/state_management/providers/canvas_state_provider.dart';
// import 'package:flow_editor/core/state_management/providers/theme_provider.dart';
// import 'package:flow_editor/core/state_management/models/canvas_visual.dart';
// import 'package:flow_editor/core/models/enums.dart'; // AppTheme, BackgroundStyle

// class CanvasBackgroundPainter extends CustomPainter {
//   const CanvasBackgroundPainter({
//     required this.offset,
//     required this.scale,
//     required this.workflowId,
//     required this.ref,
//   });

//   final Offset offset;
//   final double scale;
//   final String workflowId;
//   final WidgetRef ref;

//   @override
//   void paint(Canvas canvas, Size size) {
//     // 全局主题 & 画布几何参数
//     final appTheme = ref.read(themeProvider);
//     final visual = ref.read(canvasVisualProvider(workflowId));

//     // —— 背景底色 —— (跟随 appTheme)
//     final bgColor = switch (appTheme) {
//       AppTheme.dark => const Color(0xFF1E1E1E),
//       AppTheme.sepia => const Color(0xFFF3E9D2),
//       AppTheme.ocean => const Color(0xFFE0F7FA),
//       _ => Colors.white,
//     };
//     canvas.drawRect(Offset.zero & size, Paint()..color = bgColor);

//     if (!visual.showGrid || visual.bgStyle == BackgroundStyle.clean) return;

//     switch (visual.bgStyle) {
//       case BackgroundStyle.dots:
//         _paintDots(canvas, size, visual, appTheme);
//         break;
//       case BackgroundStyle.lines:
//         _paintLines(canvas, size, visual, appTheme);
//         break;
//       case BackgroundStyle.crossLines:
//         _paintCross(canvas, size, visual, appTheme);
//         break;
//       case BackgroundStyle.clean:
//         break;
//     }
//   }

//   // ═════════ dots ═════════
//   void _paintDots(Canvas c, Size s, CanvasVisual v, AppTheme t) {
//     if (scale <= 0) return;
//     final step = v.spacing * scale;
//     final startX = (-offset.dx % step);
//     final startY = (-offset.dy % step);

//     final paint = Paint()
//       ..color = (t == AppTheme.dark ? v.gridColorDark : v.gridColorLight)
//           .withOpacity(v.lineOpacityMain)
//       ..style = PaintingStyle.fill;

//     final r = v.dotRadius; // 直接使用配置值

//     for (double x = startX; x <= s.width; x += step) {
//       for (double y = startY; y <= s.height; y += step) {
//         c.drawCircle(Offset(x, y), r, paint);
//       }
//     }
//   }

//   // ═════════ lines ═════════
//   void _paintLines(Canvas c, Size s, CanvasVisual v, AppTheme t) {
//     if (scale <= 0) return;
//     final main = v.spacing * scale; // 主网格
//     final sub = main / 4; // 次网格

//     final baseColor = (t == AppTheme.dark ? v.gridColorDark : v.gridColorLight);

//     final mainPaint = Paint()
//       ..color = baseColor.withOpacity(v.lineOpacityMain)
//       ..strokeWidth = 1
//       ..isAntiAlias = false;

//     final subPaint = Paint()
//       ..color = baseColor.withOpacity(v.lineOpacitySub)
//       ..strokeWidth = 1
//       ..isAntiAlias = false;

//     _drawGrid(c, s, sub, subPaint);
//     _drawGrid(c, s, main, mainPaint);
//   }

//   void _drawGrid(Canvas c, Size s, double step, Paint p) {
//     final x0 = (-offset.dx % step);
//     final y0 = (-offset.dy % step);

//     for (double x = x0; x <= s.width; x += step) {
//       c.drawLine(Offset(x + .5, 0), Offset(x + .5, s.height), p);
//     }
//     for (double y = y0; y <= s.height; y += step) {
//       c.drawLine(Offset(0, y + .5), Offset(s.width, y + .5), p);
//     }
//   }

//   // ═══════ cross lines ═══════
//   void _paintCross(Canvas c, Size s, CanvasVisual v, AppTheme t) {
//     if (scale <= 0) return;
//     final step = v.spacing * scale;
//     final x0 = (-offset.dx % step);
//     final y0 = (-offset.dy % step);
//     const half = 3.0;

//     final baseColor = (t == AppTheme.dark ? v.gridColorDark : v.gridColorLight);

//     final paint = Paint()
//       ..color = baseColor.withOpacity(v.lineOpacityMain)
//       ..strokeWidth = 1;

//     for (double x = x0; x <= s.width; x += step) {
//       for (double y = y0; y <= s.height; y += step) {
//         c.drawLine(
//             Offset(x - half, y - half), Offset(x + half, y + half), paint);
//         c.drawLine(
//             Offset(x - half, y + half), Offset(x + half, y - half), paint);
//       }
//     }
//   }

//   // ═════════ shouldRepaint ═════════
//   @override
//   bool shouldRepaint(covariant CanvasBackgroundPainter old) =>
//       old.offset != offset ||
//       old.scale != scale ||
//       old.ref.read(canvasVisualProvider(old.workflowId)) !=
//           ref.read(canvasVisualProvider(workflowId)) ||
//       old.ref.read(themeProvider) != ref.read(themeProvider);
// }
