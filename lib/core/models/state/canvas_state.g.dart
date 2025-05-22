// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'canvas_state.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$CanvasStateImpl _$$CanvasStateImplFromJson(Map<String, dynamic> json) =>
    _$CanvasStateImpl(
      offset: json['offset'] == null
          ? Offset.zero
          : const OffsetConverter()
              .fromJson(json['offset'] as Map<String, dynamic>),
      scale: (json['scale'] as num?)?.toDouble() ?? 1.0,
      viewportSize: _$JsonConverterFromJson<Map<String, dynamic>, Size>(
          json['viewportSize'], const SizeConverter().fromJson),
      interactionMode: $enumDecodeNullable(
              _$CanvasInteractionModeEnumMap, json['interactionMode']) ??
          CanvasInteractionMode.panCanvas,
      visualConfig: json['visualConfig'] == null
          ? const CanvasVisualConfig()
          : CanvasVisualConfig.fromJson(
              json['visualConfig'] as Map<String, dynamic>),
      interactionConfig: json['interactionConfig'] == null
          ? const CanvasInteractionConfig()
          : CanvasInteractionConfig.fromJson(
              json['interactionConfig'] as Map<String, dynamic>),
      version: (json['version'] as num?)?.toInt() ?? 1,
      focusItemId: json['focusItemId'] as String?,
      workflowStatus: $enumDecodeNullable(
              _$WorkflowStatusEnumMap, json['workflowStatus']) ??
          WorkflowStatus.pending,
      data: json['data'] as Map<String, dynamic>?,
    );

Map<String, dynamic> _$$CanvasStateImplToJson(_$CanvasStateImpl instance) =>
    <String, dynamic>{
      'offset': const OffsetConverter().toJson(instance.offset),
      'scale': instance.scale,
      'viewportSize': _$JsonConverterToJson<Map<String, dynamic>, Size>(
          instance.viewportSize, const SizeConverter().toJson),
      'interactionMode':
          _$CanvasInteractionModeEnumMap[instance.interactionMode]!,
      'visualConfig': instance.visualConfig,
      'interactionConfig': instance.interactionConfig,
      'version': instance.version,
      'focusItemId': instance.focusItemId,
      'workflowStatus': _$WorkflowStatusEnumMap[instance.workflowStatus]!,
      'data': instance.data,
    };

Value? _$JsonConverterFromJson<Json, Value>(
  Object? json,
  Value? Function(Json json) fromJson,
) =>
    json == null ? null : fromJson(json as Json);

const _$CanvasInteractionModeEnumMap = {
  CanvasInteractionMode.none: 'none',
  CanvasInteractionMode.panCanvas: 'panCanvas',
  CanvasInteractionMode.multiSelect: 'multiSelect',
  CanvasInteractionMode.createEdge: 'createEdge',
  CanvasInteractionMode.editNode: 'editNode',
};

const _$WorkflowStatusEnumMap = {
  WorkflowStatus.pending: 'pending',
  WorkflowStatus.running: 'running',
  WorkflowStatus.completed: 'completed',
  WorkflowStatus.failed: 'failed',
  WorkflowStatus.cancelled: 'cancelled',
  WorkflowStatus.normal: 'normal',
};

Json? _$JsonConverterToJson<Json, Value>(
  Value? value,
  Json? Function(Value value) toJson,
) =>
    value == null ? null : toJson(value);
