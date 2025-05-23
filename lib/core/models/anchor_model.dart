import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/material.dart';

import 'package:flow_editor/core/models/enums/anchor_enums.dart';
import 'package:flow_editor/core/models/enums/position_enum.dart';
import 'package:flow_editor/core/models/converters/offset_size_converter.dart';

part 'anchor_model.freezed.dart';
part 'anchor_model.g.dart';

@freezed
class AnchorModel with _$AnchorModel {
  const AnchorModel._(); // for custom logic

  const factory AnchorModel({
    required String id,
    @SizeConverter() @Default(Size(24, 24)) Size size,
    @Default(Position.left) Position position,

    // 0.0 <= ratio <= 1.0
    @Default(0.5) double ratio,
    @Default(AnchorDirection.inout) AnchorDirection direction,
    int? maxConnections,
    List<String>? acceptedEdgeTypes,
    @Default(AnchorShape.circle) AnchorShape shape,
    @Default(ArrowDirection.none) ArrowDirection arrowDirection,
    @Default(false) bool locked,
    @Default(1) int version,
    String? lockedByUser,
    String? plusButtonColorHex,
    double? plusButtonSize,
    String? iconName,
    @Default({}) Map<String, dynamic> data,
    @Default(AnchorPlacement.border) AnchorPlacement placement,
    @Default(0.0) double offsetDistance,
    @Default(0.0) double angle,
  }) = _AnchorModel;

  factory AnchorModel.fromJson(Map<String, dynamic> json) =>
      _$AnchorModelFromJson(json);

  /// 保证合法范围（如 ratio 约束 0-1，offsetDistance >= 0）
  AnchorModel validated() => copyWith(
        ratio: ratio.clamp(0.0, 1.0),
        offsetDistance: offsetDistance < 0 ? 0.0 : offsetDistance,
      );
}
