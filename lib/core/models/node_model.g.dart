// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'node_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$NodeModelImpl _$$NodeModelImplFromJson(Map<String, dynamic> json) =>
    _$NodeModelImpl(
      id: json['id'] as String,
      position: json['position'] == null
          ? Offset.zero
          : const OffsetConverter()
              .fromJson(json['position'] as Map<String, dynamic>),
      size: json['size'] == null
          ? const Size(200, 40)
          : const SizeConverter()
              .fromJson(json['size'] as Map<String, dynamic>),
      dragMode: $enumDecodeNullable(_$DragModeEnumMap, json['dragMode']) ??
          DragMode.full,
      type: json['type'] as String? ?? '',
      role: $enumDecodeNullable(_$NodeRoleEnumMap, json['role']) ??
          NodeRole.middle,
      title: json['title'] as String?,
      anchors: (json['anchors'] as List<dynamic>?)
              ?.map((e) => AnchorModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      isGroup: json['isGroup'] as bool? ?? false,
      isGroupRoot: json['isGroupRoot'] as bool? ?? false,
      children: (json['children'] as List<dynamic>?)
              ?.map((e) => NodeModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      outgoingEdgeIds: (json['outgoingEdgeIds'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      incomingEdgeIds: (json['incomingEdgeIds'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
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
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
      inputs: json['inputs'] as Map<String, dynamic>? ?? const {},
      outputs: json['outputs'] as Map<String, dynamic>? ?? const {},
      config: json['config'] as Map<String, dynamic>? ?? const {},
      data: json['data'] as Map<String, dynamic>? ?? const {},
      metadata: json['metadata'] as Map<String, dynamic>? ?? const {},
    );

Map<String, dynamic> _$$NodeModelImplToJson(_$NodeModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'position': const OffsetConverter().toJson(instance.position),
      'size': const SizeConverter().toJson(instance.size),
      'dragMode': _$DragModeEnumMap[instance.dragMode]!,
      'type': instance.type,
      'role': _$NodeRoleEnumMap[instance.role]!,
      'title': instance.title,
      'anchors': instance.anchors,
      'isGroup': instance.isGroup,
      'isGroupRoot': instance.isGroupRoot,
      'children': instance.children,
      'outgoingEdgeIds': instance.outgoingEdgeIds,
      'incomingEdgeIds': instance.incomingEdgeIds,
      'status': _$NodeStatusEnumMap[instance.status]!,
      'parentId': instance.parentId,
      'zIndex': instance.zIndex,
      'enabled': instance.enabled,
      'locked': instance.locked,
      'description': instance.description,
      'style': instance.style,
      'version': instance.version,
      'createdAt': instance.createdAt?.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
      'inputs': instance.inputs,
      'outputs': instance.outputs,
      'config': instance.config,
      'data': instance.data,
      'metadata': instance.metadata,
    };

const _$DragModeEnumMap = {
  DragMode.full: 'full',
  DragMode.handle: 'handle',
};

const _$NodeRoleEnumMap = {
  NodeRole.placeholder: 'placeholder',
  NodeRole.start: 'start',
  NodeRole.middle: 'middle',
  NodeRole.end: 'end',
  NodeRole.custom: 'custom',
};

const _$NodeStatusEnumMap = {
  NodeStatus.none: 'none',
  NodeStatus.running: 'running',
  NodeStatus.completed: 'completed',
  NodeStatus.cancelled: 'cancelled',
  NodeStatus.failed: 'failed',
  NodeStatus.pending: 'pending',
  NodeStatus.orphaned: 'orphaned',
  NodeStatus.unlinked: 'unlinked',
  NodeStatus.normal: 'normal',
};
