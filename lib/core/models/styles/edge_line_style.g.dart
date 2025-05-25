// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'edge_line_style.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$EdgeLineStyleImpl _$$EdgeLineStyleImplFromJson(Map<String, dynamic> json) =>
    _$EdgeLineStyleImpl(
      edgeMode: $enumDecodeNullable(_$EdgeModeEnumMap, json['edgeMode']) ??
          EdgeMode.hvBezier,
      colorHex: json['colorHex'] as String? ?? '#000000',
      strokeWidth: (json['strokeWidth'] as num?)?.toDouble() ?? 2.0,
      dashPattern: (json['dashPattern'] as List<dynamic>?)
              ?.map((e) => (e as num).toDouble())
              .toList() ??
          const [],
      lineCap: $enumDecodeNullable(_$EdgeLineCapEnumMap, json['lineCap']) ??
          EdgeLineCap.butt,
      lineJoin: $enumDecodeNullable(_$EdgeLineJoinEnumMap, json['lineJoin']) ??
          EdgeLineJoin.miter,
      arrowStart: $enumDecodeNullable(_$ArrowTypeEnumMap, json['arrowStart']) ??
          ArrowType.none,
      arrowEnd: $enumDecodeNullable(_$ArrowTypeEnumMap, json['arrowEnd']) ??
          ArrowType.arrow,
      arrowSize: (json['arrowSize'] as num?)?.toDouble() ?? 10.0,
      arrowAngleDeg: (json['arrowAngleDeg'] as num?)?.toDouble() ?? 30.0,
    );

Map<String, dynamic> _$$EdgeLineStyleImplToJson(_$EdgeLineStyleImpl instance) =>
    <String, dynamic>{
      'edgeMode': _$EdgeModeEnumMap[instance.edgeMode]!,
      'colorHex': instance.colorHex,
      'strokeWidth': instance.strokeWidth,
      'dashPattern': instance.dashPattern,
      'lineCap': _$EdgeLineCapEnumMap[instance.lineCap]!,
      'lineJoin': _$EdgeLineJoinEnumMap[instance.lineJoin]!,
      'arrowStart': _$ArrowTypeEnumMap[instance.arrowStart]!,
      'arrowEnd': _$ArrowTypeEnumMap[instance.arrowEnd]!,
      'arrowSize': instance.arrowSize,
      'arrowAngleDeg': instance.arrowAngleDeg,
    };

const _$EdgeModeEnumMap = {
  EdgeMode.line: 'line',
  EdgeMode.orthogonal3: 'orthogonal3',
  EdgeMode.orthogonal5: 'orthogonal5',
  EdgeMode.bezier: 'bezier',
  EdgeMode.hvBezier: 'hvBezier',
};

const _$EdgeLineCapEnumMap = {
  EdgeLineCap.butt: 'butt',
  EdgeLineCap.round: 'round',
  EdgeLineCap.square: 'square',
};

const _$EdgeLineJoinEnumMap = {
  EdgeLineJoin.miter: 'miter',
  EdgeLineJoin.round: 'round',
  EdgeLineJoin.bevel: 'bevel',
};

const _$ArrowTypeEnumMap = {
  ArrowType.none: 'none',
  ArrowType.triangle: 'triangle',
  ArrowType.diamond: 'diamond',
  ArrowType.arrow: 'arrow',
  ArrowType.normal: 'normal',
};
