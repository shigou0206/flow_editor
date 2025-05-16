// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'node_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Map<String, dynamic> _$NodeModelToJson(NodeModel instance) => <String, dynamic>{
      'id': instance.id,
      'position': const OffsetConverter().toJson(instance.position),
      'size': const SizeConverter().toJson(instance.size),
      'type': instance.type,
      'title': instance.title,
      'anchors': instance.anchors.map((e) => e.toJson()).toList(),
      'isGroup': instance.isGroup,
      'isGroupRoot': instance.isGroupRoot,
      'status': _$NodeStatusEnumMap[instance.status]!,
      'parentId': instance.parentId,
      'zIndex': instance.zIndex,
      'enabled': instance.enabled,
      'locked': instance.locked,
      'description': instance.description,
      'style': instance.style?.toJson(),
      'version': instance.version,
      'createdAt': const DateTimeEpochConverter().toJson(instance.createdAt),
      'updatedAt': const DateTimeEpochConverter().toJson(instance.updatedAt),
      'data': instance.data,
    };

const _$NodeStatusEnumMap = {
  NodeStatus.none: 'none',
  NodeStatus.running: 'running',
  NodeStatus.completed: 'completed',
  NodeStatus.error: 'error',
  NodeStatus.orphaned: 'orphaned',
  NodeStatus.unlinked: 'unlinked',
  NodeStatus.normal: 'normal',
};

_$NodeModelImpl _$$NodeModelImplFromJson(Map<String, dynamic> json) =>
    _$NodeModelImpl(
      id: json['id'] as String,
      position: const OffsetConverter()
          .fromJson(json['position'] as Map<String, dynamic>),
      size:
          const SizeConverter().fromJson(json['size'] as Map<String, dynamic>),
      type: json['type'] as String? ?? '',
      title: json['title'] as String?,
      anchors: (json['anchors'] as List<dynamic>?)
              ?.map((e) => AnchorModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      isGroup: json['isGroup'] as bool? ?? false,
      isGroupRoot: json['isGroupRoot'] as bool? ?? false,
      status: $enumDecodeNullable(_$NodeStatusEnumMap, json['status']) ??
          NodeStatus.none,
      parentId: json['parentId'] as String?,
      zIndex: (json['zIndex'] as num?)?.toInt() ?? 0,
      enabled: json['enabled'] as bool? ?? true,
      locked: json['locked'] as bool? ?? false,
      description: json['description'] as String?,
      style: json['style'] == null
          ? null
          : NodeStyle.fromJson(json['style'] as Map<String, dynamic>),
      version: (json['version'] as num?)?.toInt() ?? 1,
      createdAt: const DateTimeEpochConverter()
          .fromJson((json['createdAt'] as num?)?.toInt()),
      updatedAt: const DateTimeEpochConverter()
          .fromJson((json['updatedAt'] as num?)?.toInt()),
      data: json['data'] as Map<String, dynamic>? ?? const <String, dynamic>{},
    );

Map<String, dynamic> _$$NodeModelImplToJson(_$NodeModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'position': const OffsetConverter().toJson(instance.position),
      'size': const SizeConverter().toJson(instance.size),
      'type': instance.type,
      'title': instance.title,
      'anchors': instance.anchors,
      'isGroup': instance.isGroup,
      'isGroupRoot': instance.isGroupRoot,
      'status': _$NodeStatusEnumMap[instance.status]!,
      'parentId': instance.parentId,
      'zIndex': instance.zIndex,
      'enabled': instance.enabled,
      'locked': instance.locked,
      'description': instance.description,
      'style': instance.style,
      'version': instance.version,
      'createdAt': const DateTimeEpochConverter().toJson(instance.createdAt),
      'updatedAt': const DateTimeEpochConverter().toJson(instance.updatedAt),
      'data': instance.data,
    };
