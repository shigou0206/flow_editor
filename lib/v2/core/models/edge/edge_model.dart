import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flow_editor/v2/core/models/edge/edge_line_style.dart';
import 'package:flow_editor/v2/core/models/edge/edge_animation_config.dart';
import 'package:flow_editor/v2/core/models/common/converters.dart';
import 'package:flow_editor/v2/core/models/common/point.dart';

part 'edge_model.freezed.dart';
part 'edge_model.g.dart';

@freezed
@JsonSerializable(explicitToJson: true, createFactory: false)
class EdgeModel with _$EdgeModel {
  const EdgeModel._();

  const factory EdgeModel({
    String? id,
    @OffsetConverter() required Offset start,
    @OffsetConverter() required Offset end,
    String? sourceNodeId,
    String? sourceAnchorId,
    String? targetNodeId,
    String? targetAnchorId,
    @Default([]) List<Point> waypoints,
    @Default(true) bool isDirected,
    @Default(false) bool isConnected,
    @Default(1) int version,
    @Default(0) int zIndex,
    @Default("default") String edgeType,
    String? status,
    @Default(false) bool locked,
    String? lockedByUser,
    @Default(EdgeLineStyle()) EdgeLineStyle lineStyle,
    @Default(EdgeAnimationConfig()) EdgeAnimationConfig animConfig,
    String? label,
    Map<String, dynamic>? labelStyle,
    @Default({}) Map<String, dynamic> data,
  }) = _EdgeModel;

  factory EdgeModel.fromJson(Map<String, dynamic> json) =>
      _$EdgeModelFromJson(json);
}

extension EdgeModelUtils on EdgeModel {
  /// 自动生成 id（如果当前为 null）
  EdgeModel withResolvedId() {
    if (id != null) return this;

    final generated = generateEdgeId(
      sourceNodeId,
      targetNodeId,
      sourceAnchorId,
      targetAnchorId,
      label,
      isDirected: isDirected,
    );

    return copyWith(id: generated);
  }

  /// 生成 ID（逻辑一致）
  static String generateEdgeId(
    String? sourceNodeId,
    String? targetNodeId,
    String? sourceAnchorId,
    String? targetAnchorId,
    String? name, {
    bool isDirected = true,
  }) {
    final sourceAnchor = sourceAnchorId ?? '';
    final targetAnchor = targetAnchorId ?? '';
    final source = sourceNodeId ?? '';
    final target = targetNodeId ?? '';

    String? anchorName;
    if (sourceAnchorId != null && targetAnchorId != null) {
      anchorName = sourceAnchorId.compareTo(targetAnchorId) <= 0
          ? "$sourceAnchor\u0001$targetAnchor"
          : "$targetAnchor\u0001$sourceAnchor";
    }

    if (anchorName != null && name != null) {
      name = "$anchorName\u0001$name";
    }

    return createEdgeId(source, target, name, isDirected);
  }

  static String createEdgeId(
    String v,
    String w,
    String? name,
    bool isDirected,
  ) {
    if (isDirected || v.compareTo(w) <= 0) {
      return name != null ? '$v\u0001$w\u0001$name' : '$v\u0001$w\u0001\u0000';
    } else {
      return name != null ? '$w\u0001$v\u0001$name' : '$w\u0001$v\u0001\u0000';
    }
  }
}
