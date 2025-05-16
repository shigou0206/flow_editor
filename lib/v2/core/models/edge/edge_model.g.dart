// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'edge_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Map<String, dynamic> _$EdgeModelToJson(EdgeModel instance) => <String, dynamic>{
      'id': instance.id,
      'start': const OffsetConverter().toJson(instance.start),
      'end': const OffsetConverter().toJson(instance.end),
      'sourceNodeId': instance.sourceNodeId,
      'sourceAnchorId': instance.sourceAnchorId,
      'targetNodeId': instance.targetNodeId,
      'targetAnchorId': instance.targetAnchorId,
      'waypoints': instance.waypoints.map((e) => e.toJson()).toList(),
      'isDirected': instance.isDirected,
      'isConnected': instance.isConnected,
      'version': instance.version,
      'zIndex': instance.zIndex,
      'edgeType': instance.edgeType,
      'status': instance.status,
      'locked': instance.locked,
      'lockedByUser': instance.lockedByUser,
      'lineStyle': instance.lineStyle.toJson(),
      'animConfig': instance.animConfig.toJson(),
      'label': instance.label,
      'labelStyle': instance.labelStyle,
      'data': instance.data,
    };

_$EdgeModelImpl _$$EdgeModelImplFromJson(Map<String, dynamic> json) =>
    _$EdgeModelImpl(
      id: json['id'] as String?,
      start: const OffsetConverter()
          .fromJson(json['start'] as Map<String, dynamic>),
      end:
          const OffsetConverter().fromJson(json['end'] as Map<String, dynamic>),
      sourceNodeId: json['sourceNodeId'] as String?,
      sourceAnchorId: json['sourceAnchorId'] as String?,
      targetNodeId: json['targetNodeId'] as String?,
      targetAnchorId: json['targetAnchorId'] as String?,
      waypoints: (json['waypoints'] as List<dynamic>?)
              ?.map((e) => Point.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      isDirected: json['isDirected'] as bool? ?? true,
      isConnected: json['isConnected'] as bool? ?? false,
      version: (json['version'] as num?)?.toInt() ?? 1,
      zIndex: (json['zIndex'] as num?)?.toInt() ?? 0,
      edgeType: json['edgeType'] as String? ?? "default",
      status: json['status'] as String?,
      locked: json['locked'] as bool? ?? false,
      lockedByUser: json['lockedByUser'] as String?,
      lineStyle: json['lineStyle'] == null
          ? const EdgeLineStyle()
          : EdgeLineStyle.fromJson(json['lineStyle'] as Map<String, dynamic>),
      animConfig: json['animConfig'] == null
          ? const EdgeAnimationConfig()
          : EdgeAnimationConfig.fromJson(
              json['animConfig'] as Map<String, dynamic>),
      label: json['label'] as String?,
      labelStyle: json['labelStyle'] as Map<String, dynamic>?,
      data: json['data'] as Map<String, dynamic>? ?? const {},
    );

Map<String, dynamic> _$$EdgeModelImplToJson(_$EdgeModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'start': const OffsetConverter().toJson(instance.start),
      'end': const OffsetConverter().toJson(instance.end),
      'sourceNodeId': instance.sourceNodeId,
      'sourceAnchorId': instance.sourceAnchorId,
      'targetNodeId': instance.targetNodeId,
      'targetAnchorId': instance.targetAnchorId,
      'waypoints': instance.waypoints,
      'isDirected': instance.isDirected,
      'isConnected': instance.isConnected,
      'version': instance.version,
      'zIndex': instance.zIndex,
      'edgeType': instance.edgeType,
      'status': instance.status,
      'locked': instance.locked,
      'lockedByUser': instance.lockedByUser,
      'lineStyle': instance.lineStyle,
      'animConfig': instance.animConfig,
      'label': instance.label,
      'labelStyle': instance.labelStyle,
      'data': instance.data,
    };
