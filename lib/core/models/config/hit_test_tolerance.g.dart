// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hit_test_tolerance.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$HitTestToleranceImpl _$$HitTestToleranceImplFromJson(
        Map<String, dynamic> json) =>
    _$HitTestToleranceImpl(
      anchor: (json['anchor'] as num?)?.toDouble() ?? 20.0,
      edge: (json['edge'] as num?)?.toDouble() ?? 6.0,
      waypoint: (json['waypoint'] as num?)?.toDouble() ?? 8.0,
      resizeHandle: (json['resizeHandle'] as num?)?.toDouble() ?? 10.0,
    );

Map<String, dynamic> _$$HitTestToleranceImplToJson(
        _$HitTestToleranceImpl instance) =>
    <String, dynamic>{
      'anchor': instance.anchor,
      'edge': instance.edge,
      'waypoint': instance.waypoint,
      'resizeHandle': instance.resizeHandle,
    };
