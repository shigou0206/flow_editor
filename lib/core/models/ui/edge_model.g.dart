// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'edge_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$EdgeModelImpl _$$EdgeModelImplFromJson(Map<String, dynamic> json) =>
    _$EdgeModelImpl(
      id: json['id'] as String,
      sourcePosition: _$JsonConverterFromJson<Map<String, dynamic>, Offset>(
          json['sourcePosition'], const OffsetConverter().fromJson),
      targetPosition: _$JsonConverterFromJson<Map<String, dynamic>, Offset>(
          json['targetPosition'], const OffsetConverter().fromJson),
      sourceNodeId: json['sourceNodeId'] as String?,
      sourceAnchorId: json['sourceAnchorId'] as String?,
      targetNodeId: json['targetNodeId'] as String? ?? "none",
      targetAnchorId: json['targetAnchorId'] as String? ?? "none",
      isConnected: json['isConnected'] as bool? ?? false,
      isDirected: json['isDirected'] as bool? ?? true,
      edgeType: json['edgeType'] as String? ?? "default",
      status: json['status'] as String?,
      locked: json['locked'] as bool? ?? false,
      lockedByUser: json['lockedByUser'] as String?,
      version: (json['version'] as num?)?.toInt() ?? 1,
      zIndex: (json['zIndex'] as num?)?.toInt() ?? 0,
      waypoints:
          const OffsetListConverter().fromJson(json['waypoints'] as List?),
      lineStyle: json['lineStyle'] == null
          ? const EdgeLineStyle()
          : EdgeLineStyle.fromJson(json['lineStyle'] as Map<String, dynamic>),
      animConfig: json['animConfig'] == null
          ? const EdgeAnimationConfig()
          : EdgeAnimationConfig.fromJson(
              json['animConfig'] as Map<String, dynamic>),
      label: json['label'] as String?,
      labelStyle: json['labelStyle'] as Map<String, dynamic>?,
      overlays: (json['overlays'] as List<dynamic>?)
              ?.map(
                  (e) => EdgeOverlayElement.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      data: json['data'] as Map<String, dynamic>? ?? const {},
      metadata: json['metadata'] as Map<String, dynamic>? ?? const {},
    );

Map<String, dynamic> _$$EdgeModelImplToJson(_$EdgeModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'sourcePosition': _$JsonConverterToJson<Map<String, dynamic>, Offset>(
          instance.sourcePosition, const OffsetConverter().toJson),
      'targetPosition': _$JsonConverterToJson<Map<String, dynamic>, Offset>(
          instance.targetPosition, const OffsetConverter().toJson),
      'sourceNodeId': instance.sourceNodeId,
      'sourceAnchorId': instance.sourceAnchorId,
      'targetNodeId': instance.targetNodeId,
      'targetAnchorId': instance.targetAnchorId,
      'isConnected': instance.isConnected,
      'isDirected': instance.isDirected,
      'edgeType': instance.edgeType,
      'status': instance.status,
      'locked': instance.locked,
      'lockedByUser': instance.lockedByUser,
      'version': instance.version,
      'zIndex': instance.zIndex,
      'waypoints': const OffsetListConverter().toJson(instance.waypoints),
      'lineStyle': instance.lineStyle,
      'animConfig': instance.animConfig,
      'label': instance.label,
      'labelStyle': instance.labelStyle,
      'overlays': instance.overlays,
      'data': instance.data,
      'metadata': instance.metadata,
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
