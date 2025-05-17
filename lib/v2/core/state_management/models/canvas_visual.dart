import 'package:flutter/material.dart';
import 'package:flow_editor/v2/core/models/enums.dart';

class CanvasVisual {
  const CanvasVisual({
    this.showGrid = true,
    this.bgStyle = BackgroundStyle.dots, // ←★ 新增
    this.spacing = 16,
    this.dotRadius = 1.0,
    this.gridColorLight = const Color(0xFF4A4A4A),
    this.gridColorDark = const Color(0xFF9CA3AF),
    this.lineOpacityMain = .60,
    this.lineOpacitySub = .25,
  });

  // —— Config fields ——
  final bool showGrid;
  final BackgroundStyle bgStyle; // ←★
  final double spacing;
  final double dotRadius;
  final Color gridColorLight;
  final Color gridColorDark;
  final double lineOpacityMain;
  final double lineOpacitySub;

  // —— copyWith ——
  CanvasVisual copyWith({
    bool? showGrid,
    BackgroundStyle? bgStyle, // ←★
    double? spacing,
    double? dotRadius,
    Color? gridColorLight,
    Color? gridColorDark,
    double? lineOpacityMain,
    double? lineOpacitySub,
  }) =>
      CanvasVisual(
        showGrid: showGrid ?? this.showGrid,
        bgStyle: bgStyle ?? this.bgStyle, // ←★
        spacing: spacing ?? this.spacing,
        dotRadius: dotRadius ?? this.dotRadius,
        gridColorLight: gridColorLight ?? this.gridColorLight,
        gridColorDark: gridColorDark ?? this.gridColorDark,
        lineOpacityMain: lineOpacityMain ?? this.lineOpacityMain,
        lineOpacitySub: lineOpacitySub ?? this.lineOpacitySub,
      );
}
