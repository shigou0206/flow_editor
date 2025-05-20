// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'canvas_viewport_state.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$CanvasViewportStateImpl _$$CanvasViewportStateImplFromJson(
        Map<String, dynamic> json) =>
    _$CanvasViewportStateImpl(
      offset: json['offset'] == null
          ? Offset.zero
          : const OffsetConverter()
              .fromJson(json['offset'] as Map<String, dynamic>),
      scale: (json['scale'] as num?)?.toDouble() ?? 1.0,
      viewportSize: _$JsonConverterFromJson<Map<String, dynamic>, Size>(
          json['viewportSize'], const SizeConverter().fromJson),
    );

Map<String, dynamic> _$$CanvasViewportStateImplToJson(
        _$CanvasViewportStateImpl instance) =>
    <String, dynamic>{
      'offset': const OffsetConverter().toJson(instance.offset),
      'scale': instance.scale,
      'viewportSize': _$JsonConverterToJson<Map<String, dynamic>, Size>(
          instance.viewportSize, const SizeConverter().toJson),
    };

Value? _$JsonConverterFromJson<Json, Value>(
  Object? json,
  Value? Function(Json json) fromJson,
) =>
    json == null ? null : fromJson(json as Json);

Json? _$JsonConverterToJson<Json, Value>(
  Value? value,
  Json? Function(Value value) toJson,
) =>
    value == null ? null : toJson(value);
