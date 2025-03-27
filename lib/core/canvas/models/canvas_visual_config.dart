import 'package:flutter/material.dart';
import 'package:flow_editor/core/canvas/models/canvas_enum.dart';

class CanvasVisualConfig {
  final Color backgroundColor;
  final bool showGrid;
  final Color gridColor;
  final double gridSpacing;
  final double width;
  final double height;
  final BackgroundStyle backgroundStyle;

  const CanvasVisualConfig({
    this.backgroundColor = Colors.white,
    this.showGrid = false,
    this.gridColor = const Color(0xffe0e0e0),
    this.gridSpacing = 20.0,
    this.width = 1e6,
    this.height = 1e6,
    this.backgroundStyle = BackgroundStyle.dots,
  });

  /// 不可变更新
  CanvasVisualConfig copyWith({
    bool? showGrid,
    double? gridSpacing,
    Color? backgroundColor,
    Color? gridColor,
    double? width,
    double? height,
    BackgroundStyle? backgroundStyle,
  }) {
    return CanvasVisualConfig(
      showGrid: showGrid ?? this.showGrid,
      gridSpacing: gridSpacing ?? this.gridSpacing,
      backgroundColor: backgroundColor ?? this.backgroundColor,
      gridColor: gridColor ?? this.gridColor,
      width: width ?? this.width,
      height: height ?? this.height,
      backgroundStyle: backgroundStyle ?? this.backgroundStyle,
    );
  }

  // 序列化/反序列化 (如需要)
  Map<String, dynamic> toJson() => {
        'showGrid': showGrid,
        'gridSpacing': gridSpacing,
        'backgroundColor':
            '#${backgroundColor.value.toRadixString(16).padLeft(8, '0')}',
        'gridColor': '#${gridColor.value.toRadixString(16).padLeft(8, '0')}',
        'width': width,
        'height': height,
        'backgroundStyle': backgroundStyle.name,
      };

  factory CanvasVisualConfig.fromJson(Map<String, dynamic> json) {
    return CanvasVisualConfig(
      showGrid: json['showGrid'] as bool? ?? true,
      gridSpacing: (json['gridSpacing'] as num?)?.toDouble() ?? 20.0,
      backgroundColor: _parseColor(json['backgroundColor'], Colors.white),
      gridColor: _parseColor(json['gridColor'], const Color(0xffe0e0e0)),
      width: (json['width'] as num?)?.toDouble() ?? 1000,
      height: (json['height'] as num?)?.toDouble() ?? 1000,
      backgroundStyle: BackgroundStyle.values.byName(json['backgroundStyle']),
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
