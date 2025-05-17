import 'package:flutter/material.dart';

enum Position { left, right, top, bottom }

Position revisePosition(Position? position) {
  return switch (position) {
    Position.left => Position.right,
    Position.right => Position.left,
    Position.top => Position.bottom,
    Position.bottom => Position.top,
    null => Position.right,
  };
}

enum AnchorPlacement { inside, border, outside }

enum AnchorDirection { inOnly, outOnly, inout }

enum AnchorShape { circle, diamond, square, custom }

enum ArrowDirection { inward, outward, none }

enum EdgeLineCap { butt, round, square }

enum EdgeLineJoin { miter, round, bevel }

enum ArrowType { none, triangle, diamond, arrow, normal }

enum EdgeMode { line, orthogonal3, orthogonal5, bezier, hvBezier }

enum DragMode { full, handle }

enum NodeRole { placeholder, start, middle, end, custom }

enum NodeStatus { none, running, completed, error, orphaned, unlinked, normal }

enum EdgeAttachmentKind { handle, label, action }

enum BackgroundStyle { dots, lines, crossLines, clean }

enum AppTheme { light, dark, ocean, sepia }

extension AppThemeX on AppTheme {
  ThemeData data(bool useMaterial3) => switch (this) {
        AppTheme.light => ThemeData(
            colorScheme: ColorScheme.fromSeed(
                seedColor: Colors.blue, brightness: Brightness.light),
            useMaterial3: useMaterial3,
          ),
        AppTheme.dark => ThemeData(
            colorScheme: ColorScheme.fromSeed(
                seedColor: Colors.blue, brightness: Brightness.dark),
            useMaterial3: useMaterial3,
          ),
        AppTheme.ocean => ThemeData(
            primarySwatch: Colors.teal,
            scaffoldBackgroundColor: const Color(0xFFE0F7FA),
            useMaterial3: useMaterial3,
          ),
        AppTheme.sepia => ThemeData(
            scaffoldBackgroundColor: const Color(0xFFF3E9D2),
            colorScheme: const ColorScheme.light(primary: Color(0xFF7C6A4F)),
            useMaterial3: useMaterial3,
          ),
      };
}
