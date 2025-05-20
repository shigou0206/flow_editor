// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'node_style.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$NodeStyleImpl _$$NodeStyleImplFromJson(Map<String, dynamic> json) =>
    _$NodeStyleImpl(
      fillColorHex: json['fillColorHex'] as String?,
      borderColorHex: json['borderColorHex'] as String?,
      borderWidth: (json['borderWidth'] as num?)?.toDouble() ?? 1.0,
      borderRadius: (json['borderRadius'] as num?)?.toDouble() ?? 4.0,
    );

Map<String, dynamic> _$$NodeStyleImplToJson(_$NodeStyleImpl instance) =>
    <String, dynamic>{
      'fillColorHex': instance.fillColorHex,
      'borderColorHex': instance.borderColorHex,
      'borderWidth': instance.borderWidth,
      'borderRadius': instance.borderRadius,
    };
