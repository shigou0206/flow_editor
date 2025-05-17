import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flow_editor/v2/core/models/enums.dart';

class CanvasModel extends Equatable {
  /// 平移偏移量 (pan)
  final Offset offset;

  /// 缩放倍数 (zoom)
  final double scale;

  /// 视口大小（可选，用于布局或约束）
  final Size? viewportSize;

  /// 背景颜色
  final Color backgroundColor;

  /// 背景样式
  final BackgroundStyle backgroundStyle;

  const CanvasModel({
    this.offset = Offset.zero,
    this.scale = 1.0,
    this.viewportSize,
    this.backgroundColor = Colors.white,
    this.backgroundStyle = BackgroundStyle.clean,
  });

  @override
  List<Object?> get props =>
      [offset, scale, viewportSize, backgroundColor, backgroundStyle];

  /// 生成修改后的副本
  CanvasModel copyWith({
    Offset? offset,
    double? scale,
    Size? viewportSize,
    Color? backgroundColor,
    BackgroundStyle? backgroundStyle,
  }) {
    return CanvasModel(
      offset: offset ?? this.offset,
      scale: scale ?? this.scale,
      viewportSize: viewportSize ?? this.viewportSize,
      backgroundColor: backgroundColor ?? this.backgroundColor,
      backgroundStyle: backgroundStyle ?? this.backgroundStyle,
    );
  }

  /// 序列化为 JSON
  Map<String, dynamic> toJson() => {
        'offsetX': offset.dx,
        'offsetY': offset.dy,
        'scale': scale,
        'viewportWidth': viewportSize?.width,
        'viewportHeight': viewportSize?.height,
        'backgroundColor': backgroundColor.value,
        'backgroundStyle': backgroundStyle.toString().split('.').last,
      };

  /// 从 JSON 构造
  factory CanvasModel.fromJson(Map<String, dynamic> json) {
    final dx = (json['offsetX'] as num?)?.toDouble() ?? 0.0;
    final dy = (json['offsetY'] as num?)?.toDouble() ?? 0.0;
    final scale = (json['scale'] as num?)?.toDouble() ?? 1.0;
    final width = (json['viewportWidth'] as num?)?.toDouble();
    final height = (json['viewportHeight'] as num?)?.toDouble();
    final bgColorValue = json['backgroundColor'] as int?;
    final styleStr = (json['backgroundStyle'] as String?) ?? 'clean';
    final style = BackgroundStyle.values.firstWhere(
      (e) => e.toString().split('.').last == styleStr,
      orElse: () => BackgroundStyle.clean,
    );

    return CanvasModel(
      offset: Offset(dx, dy),
      scale: scale,
      viewportSize:
          (width != null && height != null) ? Size(width, height) : null,
      backgroundColor:
          bgColorValue != null ? Color(bgColorValue) : Colors.white,
      backgroundStyle: style,
    );
  }
}
