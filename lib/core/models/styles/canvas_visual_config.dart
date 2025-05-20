import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flow_editor/core/models/enums/canvas_enum.dart';
import 'package:flow_editor/core/models/converters/color_converter.dart';

part 'canvas_visual_config.freezed.dart';
part 'canvas_visual_config.g.dart';

@freezed
class CanvasVisualConfig with _$CanvasVisualConfig {
  const factory CanvasVisualConfig({
    @ColorConverter() @Default(Colors.white) Color backgroundColor,
    @Default(false) bool showGrid,
    @ColorConverter() @Default(Color(0xffe0e0e0)) Color gridColor,
    @Default(20.0) double gridSpacing,
    @Default(1000000.0) double width,
    @Default(1000000.0) double height,
    @Default(BackgroundStyle.dots) BackgroundStyle backgroundStyle,
  }) = _CanvasVisualConfig;

  factory CanvasVisualConfig.fromJson(Map<String, dynamic> json) =>
      _$CanvasVisualConfigFromJson(json);
}
