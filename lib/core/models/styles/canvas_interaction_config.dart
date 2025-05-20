import 'package:freezed_annotation/freezed_annotation.dart';

part 'canvas_interaction_config.freezed.dart';
part 'canvas_interaction_config.g.dart';

@freezed
class CanvasInteractionConfig with _$CanvasInteractionConfig {
  const factory CanvasInteractionConfig({
    @Default(true) bool snapToGrid,
    @Default(true) bool showGuides,
    @Default(0.1) double minScale,
    @Default(10.0) double maxScale,
    @Default(true) bool enablePan,
    @Default(true) bool enableZoom,
    @Default(true) bool enableMarqueeSelect,
    @Default(false) bool dropOnEdgeOnly,
  }) = _CanvasInteractionConfig;

  factory CanvasInteractionConfig.fromJson(Map<String, dynamic> json) =>
      _$CanvasInteractionConfigFromJson(json);
}
