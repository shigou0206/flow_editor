import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/material.dart';
import 'package:flow_editor/core/models/ui/anchor_model.dart';
import 'package:flow_editor/core/models/converters/offset_size_converter.dart';
import 'package:flow_editor/core/models/converters/rect_converter.dart';

part 'hit_test_result.freezed.dart';
part 'hit_test_result.g.dart';

@freezed
class ResizeHitResult with _$ResizeHitResult {
  const factory ResizeHitResult({
    required String nodeId,
    required ResizeHandlePosition handle,
  }) = _ResizeHitResult;

  factory ResizeHitResult.fromJson(Map<String, dynamic> json) =>
      _$ResizeHitResultFromJson(json);
}

@JsonEnum()
enum ResizeHandlePosition {
  topLeft,
  topRight,
  bottomLeft,
  bottomRight,
  left,
  right,
  top,
  bottom,
}

@freezed
class EdgeUiHitResult with _$EdgeUiHitResult {
  const factory EdgeUiHitResult({
    required String edgeId,
    required String type,
    @RectConverter() required Rect bounds,
  }) = _EdgeUiHitResult;

  factory EdgeUiHitResult.fromJson(Map<String, dynamic> json) =>
      _$EdgeUiHitResultFromJson(json);
}

@freezed
class EdgeWaypointHitResult with _$EdgeWaypointHitResult {
  const factory EdgeWaypointHitResult({
    required String edgeId,
    required int index,
    @OffsetConverter() required Offset center,
  }) = _EdgeWaypointHitResult;

  factory EdgeWaypointHitResult.fromJson(Map<String, dynamic> json) =>
      _$EdgeWaypointHitResultFromJson(json);
}

@freezed
class FloatingAnchorHitResult with _$FloatingAnchorHitResult {
  const factory FloatingAnchorHitResult({
    required String nodeId,
    @OffsetConverter() required Offset center,
  }) = _FloatingAnchorHitResult;

  factory FloatingAnchorHitResult.fromJson(Map<String, dynamic> json) =>
      _$FloatingAnchorHitResultFromJson(json);
}

@freezed
class InsertTargetHitResult with _$InsertTargetHitResult {
  const factory InsertTargetHitResult({
    required String targetType, // 'node' | 'edge'
    required String targetId,
    @OffsetConverter() required Offset position,
  }) = _InsertTargetHitResult;

  factory InsertTargetHitResult.fromJson(Map<String, dynamic> json) =>
      _$InsertTargetHitResultFromJson(json);
}

/// 命中 anchor 时的返回结构，包含 anchor 和其归属节点 ID
@freezed
class AnchorHitResult with _$AnchorHitResult {
  const factory AnchorHitResult({
    required String nodeId,
    required AnchorModel anchor,
  }) = _AnchorHitResult;

  factory AnchorHitResult.fromJson(Map<String, dynamic> json) =>
      _$AnchorHitResultFromJson(json);
}

/// 命中基于 Waypoints 边时的返回结构
@freezed
class EdgeWaypointPathHitResult with _$EdgeWaypointPathHitResult {
  const factory EdgeWaypointPathHitResult({
    required String edgeId,
    @OffsetConverter() required Offset nearestPoint, // 命中线段上离鼠标最近的点
    required double distance, // 鼠标与命中点之间的距离（用于排序）
  }) = _EdgeWaypointPathHitResult;

  factory EdgeWaypointPathHitResult.fromJson(Map<String, dynamic> json) =>
      _$EdgeWaypointPathHitResultFromJson(json);
}
