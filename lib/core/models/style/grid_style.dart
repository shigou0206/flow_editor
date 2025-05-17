// lib/core/painters/grid_style.dart
import 'package:flutter/material.dart';
import 'package:flow_editor/core/models/enums.dart';

class GridStyle {
  const GridStyle({
    required this.show,
    required this.style,
    required this.spacing,
    required this.dotRadius,
    required this.mainColor,
    required this.subColor,
  });

  final bool show;
  final BackgroundStyle style;
  final double spacing;
  final double dotRadius;
  final Color mainColor;
  final Color subColor;

  @override
  bool operator ==(Object other) =>
      other is GridStyle &&
      show == other.show &&
      style == other.style &&
      spacing == other.spacing &&
      dotRadius == other.dotRadius &&
      mainColor == other.mainColor &&
      subColor == other.subColor;

  @override
  int get hashCode =>
      Object.hash(show, style, spacing, dotRadius, mainColor, subColor);
}
