// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'edge_overlay_element.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$EdgeOverlayElementImpl _$$EdgeOverlayElementImplFromJson(
        Map<String, dynamic> json) =>
    _$EdgeOverlayElementImpl(
      id: json['id'] as String,
      type: json['type'] as String,
      positionRatio: (json['positionRatio'] as num?)?.toDouble() ?? 0.5,
      direction:
          $enumDecodeNullable(_$OverlayDirectionEnumMap, json['direction']) ??
              OverlayDirection.above,
      offset: json['offset'] == null
          ? Offset.zero
          : const OffsetConverter()
              .fromJson(json['offset'] as Map<String, dynamic>),
      size: _$JsonConverterFromJson<Map<String, dynamic>, Size>(
          json['size'], const SizeConverter().fromJson),
      data: json['data'] as Map<String, dynamic>?,
    );

Map<String, dynamic> _$$EdgeOverlayElementImplToJson(
        _$EdgeOverlayElementImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'type': instance.type,
      'positionRatio': instance.positionRatio,
      'direction': _$OverlayDirectionEnumMap[instance.direction]!,
      'offset': const OffsetConverter().toJson(instance.offset),
      'size': _$JsonConverterToJson<Map<String, dynamic>, Size>(
          instance.size, const SizeConverter().toJson),
      'data': instance.data,
    };

const _$OverlayDirectionEnumMap = {
  OverlayDirection.above: 'above',
  OverlayDirection.below: 'below',
  OverlayDirection.left: 'left',
  OverlayDirection.right: 'right',
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
