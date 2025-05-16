// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'node_style.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Map<String, dynamic> _$NodeStyleToJson(NodeStyle instance) => <String, dynamic>{
      'fillColor': const ColorHexConverter().toJson(instance.fillColor),
      'borderColor': const ColorHexConverter().toJson(instance.borderColor),
      'borderWidth': instance.borderWidth,
      'borderRadius': instance.borderRadius,
    };

_$NodeStyleImpl _$$NodeStyleImplFromJson(Map<String, dynamic> json) =>
    _$NodeStyleImpl(
      fillColor:
          const ColorHexConverter().fromJson(json['fillColor'] as String?),
      borderColor:
          const ColorHexConverter().fromJson(json['borderColor'] as String?),
      borderWidth: (json['borderWidth'] as num?)?.toDouble() ?? 1.0,
      borderRadius: (json['borderRadius'] as num?)?.toDouble() ?? 4.0,
    );

Map<String, dynamic> _$$NodeStyleImplToJson(_$NodeStyleImpl instance) =>
    <String, dynamic>{
      'fillColor': const ColorHexConverter().toJson(instance.fillColor),
      'borderColor': const ColorHexConverter().toJson(instance.borderColor),
      'borderWidth': instance.borderWidth,
      'borderRadius': instance.borderRadius,
    };
