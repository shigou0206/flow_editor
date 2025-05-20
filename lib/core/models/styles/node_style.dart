import 'package:freezed_annotation/freezed_annotation.dart';

part 'node_style.freezed.dart';
part 'node_style.g.dart';

@freezed
class NodeStyle with _$NodeStyle {
  const factory NodeStyle({
    String? fillColorHex, // 如 "#FF0000"
    String? borderColorHex, // 如 "#000000"
    @Default(1.0) double borderWidth,
    @Default(4.0) double borderRadius,
  }) = _NodeStyle;

  factory NodeStyle.fromJson(Map<String, dynamic> json) =>
      _$NodeStyleFromJson(json);
}
