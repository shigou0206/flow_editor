import 'package:freezed_annotation/freezed_annotation.dart';

part 'input_config.freezed.dart';
part 'input_config.g.dart';

@freezed
class InputConfig with _$InputConfig {
  const factory InputConfig({
    // Canvas interactions
    @Default(true) bool enablePan,
    @Default(true) bool enableZoom,

    // Node interactions
    @Default(true) bool enableNodeDrag,
    @Default(true) bool enableNodeResize,
    @Default(true) bool enableNodeHover,
    @Default(true) bool enableNodeTap,

    // Edge interactions
    @Default(true) bool enableEdgeDraw,
    @Default(true) bool enableEdgeHover,
    @Default(true) bool enableEdgeWaypointDrag,
    @Default(true) bool enableEdgeWaypointHover,

    // Anchor interactions
    @Default(true) bool enableAnchorHover,
    @Default(true) bool enableAnchorDrag,

    // Marquee selection
    @Default(false) bool enableMarqueeSelect,

    // Insertion interactions
    @Default(true) bool enableInsertNodeToEdge,

    // Keyboard interactions
    @Default(true) bool enableKeyDelete,
    @Default(true) bool enableKeyCopyPaste,
    @Default(true) bool enableKeyUndoRedo,
  }) = _InputConfig;

  factory InputConfig.fromJson(Map<String, dynamic> json) =>
      _$InputConfigFromJson(json);
}
