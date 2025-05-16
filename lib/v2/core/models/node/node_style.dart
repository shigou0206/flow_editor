import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flow_editor/v2/core/models/common/converters.dart';

part 'node_style.freezed.dart';
part 'node_style.g.dart';

@freezed
@JsonSerializable(explicitToJson: true, createFactory: false)
class NodeStyle with _$NodeStyle {
  const NodeStyle._();

  const factory NodeStyle({
    @ColorHexConverter() Color? fillColor,
    @ColorHexConverter() Color? borderColor,
    @Default(1.0) double borderWidth,
    @Default(4.0) double borderRadius,
  }) = _NodeStyle;

  factory NodeStyle.fromJson(Map<String, dynamic> json) =>
      _$NodeStyleFromJson(json);
}
