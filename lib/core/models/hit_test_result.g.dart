// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hit_test_result.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ResizeHitResultImpl _$$ResizeHitResultImplFromJson(
        Map<String, dynamic> json) =>
    _$ResizeHitResultImpl(
      nodeId: json['nodeId'] as String,
      handle: $enumDecode(_$ResizeHandlePositionEnumMap, json['handle']),
    );

Map<String, dynamic> _$$ResizeHitResultImplToJson(
        _$ResizeHitResultImpl instance) =>
    <String, dynamic>{
      'nodeId': instance.nodeId,
      'handle': _$ResizeHandlePositionEnumMap[instance.handle]!,
    };

const _$ResizeHandlePositionEnumMap = {
  ResizeHandlePosition.topLeft: 'topLeft',
  ResizeHandlePosition.topRight: 'topRight',
  ResizeHandlePosition.bottomLeft: 'bottomLeft',
  ResizeHandlePosition.bottomRight: 'bottomRight',
  ResizeHandlePosition.left: 'left',
  ResizeHandlePosition.right: 'right',
  ResizeHandlePosition.top: 'top',
  ResizeHandlePosition.bottom: 'bottom',
};

_$EdgeUiHitResultImpl _$$EdgeUiHitResultImplFromJson(
        Map<String, dynamic> json) =>
    _$EdgeUiHitResultImpl(
      edgeId: json['edgeId'] as String,
      type: json['type'] as String,
      bounds: const RectConverter()
          .fromJson(json['bounds'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$EdgeUiHitResultImplToJson(
        _$EdgeUiHitResultImpl instance) =>
    <String, dynamic>{
      'edgeId': instance.edgeId,
      'type': instance.type,
      'bounds': const RectConverter().toJson(instance.bounds),
    };

_$EdgeWaypointHitResultImpl _$$EdgeWaypointHitResultImplFromJson(
        Map<String, dynamic> json) =>
    _$EdgeWaypointHitResultImpl(
      edgeId: json['edgeId'] as String,
      index: (json['index'] as num).toInt(),
      center: const OffsetConverter()
          .fromJson(json['center'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$EdgeWaypointHitResultImplToJson(
        _$EdgeWaypointHitResultImpl instance) =>
    <String, dynamic>{
      'edgeId': instance.edgeId,
      'index': instance.index,
      'center': const OffsetConverter().toJson(instance.center),
    };

_$FloatingAnchorHitResultImpl _$$FloatingAnchorHitResultImplFromJson(
        Map<String, dynamic> json) =>
    _$FloatingAnchorHitResultImpl(
      nodeId: json['nodeId'] as String,
      center: const OffsetConverter()
          .fromJson(json['center'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$FloatingAnchorHitResultImplToJson(
        _$FloatingAnchorHitResultImpl instance) =>
    <String, dynamic>{
      'nodeId': instance.nodeId,
      'center': const OffsetConverter().toJson(instance.center),
    };

_$InsertTargetHitResultImpl _$$InsertTargetHitResultImplFromJson(
        Map<String, dynamic> json) =>
    _$InsertTargetHitResultImpl(
      targetType: json['targetType'] as String,
      targetId: json['targetId'] as String,
      position: const OffsetConverter()
          .fromJson(json['position'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$InsertTargetHitResultImplToJson(
        _$InsertTargetHitResultImpl instance) =>
    <String, dynamic>{
      'targetType': instance.targetType,
      'targetId': instance.targetId,
      'position': const OffsetConverter().toJson(instance.position),
    };
