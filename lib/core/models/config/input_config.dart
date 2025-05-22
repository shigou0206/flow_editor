import 'package:freezed_annotation/freezed_annotation.dart';

part 'input_config.freezed.dart';
part 'input_config.g.dart';

@freezed
class InputConfig with _$InputConfig {
  const factory InputConfig({
    @Default(true) bool enablePan,
    @Default(true) bool enableZoom,
    @Default(true) bool enableNodeDrag,
    @Default(true) bool enableEdgeDraw,
    @Default(false) bool enableMarqueeSelect,
    @Default(true) bool enableKeyDelete,
    @Default(true) bool enableKeyCopyPaste,
    @Default(true) bool enableKeyUndoRedo,
  }) = _InputConfig;

  factory InputConfig.fromJson(Map<String, dynamic> json) =>
      _$InputConfigFromJson(json);
}
