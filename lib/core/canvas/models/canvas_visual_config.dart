import 'package:flutter/material.dart';

class CanvasVisualConfig {
  final Color backgroundColor;
  final bool showGrid;
  final Color gridColor;
  final double gridSpacing;

  const CanvasVisualConfig({
    this.backgroundColor = Colors.white,
    this.showGrid = false,
    this.gridColor = const Color(0xffe0e0e0),
    this.gridSpacing = 20.0,
  });

  /// 不可变更新
  CanvasVisualConfig copyWith({
    bool? showGrid,
    double? gridSpacing,
    Color? backgroundColor,
    Color? gridColor,
  }) {
    return CanvasVisualConfig(
      showGrid: showGrid ?? this.showGrid,
      gridSpacing: gridSpacing ?? this.gridSpacing,
      backgroundColor: backgroundColor ?? this.backgroundColor,
      gridColor: gridColor ?? this.gridColor,
    );
  }

  // 序列化/反序列化 (如需要)
  Map<String, dynamic> toJson() => {
        'showGrid': showGrid,
        'gridSpacing': gridSpacing,
        'backgroundColor':
            '#${backgroundColor.value.toRadixString(16).padLeft(8, '0')}',
        'gridColor': '#${gridColor.value.toRadixString(16).padLeft(8, '0')}',
      };

  factory CanvasVisualConfig.fromJson(Map<String, dynamic> json) {
    return CanvasVisualConfig(
      showGrid: json['showGrid'] as bool? ?? true,
      gridSpacing: (json['gridSpacing'] as num?)?.toDouble() ?? 20.0,
      backgroundColor: _parseColor(json['backgroundColor'], Colors.white),
      gridColor: _parseColor(json['gridColor'], const Color(0xffe0e0e0)),
    );
  }
}

// 添加辅助方法解析颜色
Color _parseColor(dynamic value, Color defaultColor) {
  if (value is Color) return value;
  if (value is String && value.startsWith('#')) {
    final hex = value.substring(1);
    final intValue = int.tryParse(hex, radix: 16);
    if (intValue != null) return Color(intValue);
  }
  return defaultColor;
}
