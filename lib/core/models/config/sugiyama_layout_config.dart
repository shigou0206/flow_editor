import 'package:flutter/widgets.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flow_editor/core/models/converters/offset_size_converter.dart';

part 'sugiyama_layout_config.freezed.dart';
part 'sugiyama_layout_config.g.dart';

@freezed
class SugiyamaLayoutConfig with _$SugiyamaLayoutConfig {
  const SugiyamaLayoutConfig._();

  const factory SugiyamaLayoutConfig({
    @Default(0.0) double groupHorizontalPadding,
    @Default(0.0) double groupVerticalPadding,
    @Default(20.0) double nodeMarginX,
    @Default(20.0) double nodeMarginY,
    @Default('TB') String rankDir,
    @Default('network-simplex') String ranker,
    @Default(Size(80, 60)) @SizeConverter() Size emptyGroupSize,
    @Default(true) bool compactTop,
    @Default(false) bool compactBottom,
    @Default(false) bool compactLeft,
    @Default(false) bool compactRight,
  }) = _SugiyamaLayoutConfig;

  factory SugiyamaLayoutConfig.fromJson(Map<String, dynamic> json) =>
      _$SugiyamaLayoutConfigFromJson(json);

  /// 支持单独控制Group padding
  EdgeInsets getGroupPadding(Map<String, dynamic>? metadata) {
    final padding = metadata?['padding'] as Map<String, dynamic>?;

    if (padding != null) {
      return EdgeInsets.only(
        left: (padding['left'] ?? groupHorizontalPadding).toDouble(),
        right: (padding['right'] ?? groupHorizontalPadding).toDouble(),
        top: (padding['top'] ?? groupVerticalPadding).toDouble(),
        bottom: (padding['bottom'] ?? groupVerticalPadding).toDouble(),
      );
    }

    return EdgeInsets.symmetric(
      horizontal: groupHorizontalPadding,
      vertical: groupVerticalPadding,
    );
  }
}
