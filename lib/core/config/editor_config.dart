import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flow_editor/core/config/hit_test_tolerance.dart';

part 'editor_config.freezed.dart';
part 'editor_config.g.dart';

@freezed
class EditorConfig with _$EditorConfig {
  const factory EditorConfig({
    @Default(HitTestTolerance()) HitTestTolerance hitTestTolerance,
    @Default(true) bool enableMultiSelect,
    @Default(true) bool enableGroupNode,
    @Default(true) bool enableUndoRedo,
    @Default(true) bool enableClipboard,
    @Default(true) bool enableKeyboardShortcuts,
  }) = _EditorConfig;

  factory EditorConfig.fromJson(Map<String, dynamic> json) =>
      _$EditorConfigFromJson(json);
}
