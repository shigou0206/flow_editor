// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'canvas_insert_element.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$NodeInsertElementImpl _$$NodeInsertElementImplFromJson(
        Map<String, dynamic> json) =>
    _$NodeInsertElementImpl(
      position: const OffsetConverter()
          .fromJson(json['position'] as Map<String, dynamic>),
      size:
          const SizeConverter().fromJson(json['size'] as Map<String, dynamic>),
      node: NodeModel.fromJson(json['node'] as Map<String, dynamic>),
      $type: json['type'] as String?,
    );

Map<String, dynamic> _$$NodeInsertElementImplToJson(
        _$NodeInsertElementImpl instance) =>
    <String, dynamic>{
      'position': const OffsetConverter().toJson(instance.position),
      'size': const SizeConverter().toJson(instance.size),
      'node': instance.node,
      'type': instance.$type,
    };

_$GroupInsertElementImpl _$$GroupInsertElementImplFromJson(
        Map<String, dynamic> json) =>
    _$GroupInsertElementImpl(
      position: const OffsetConverter()
          .fromJson(json['position'] as Map<String, dynamic>),
      size:
          const SizeConverter().fromJson(json['size'] as Map<String, dynamic>),
      groupNode: NodeModel.fromJson(json['groupNode'] as Map<String, dynamic>),
      children: (json['children'] as List<dynamic>)
          .map((e) => NodeModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      edges: (json['edges'] as List<dynamic>)
          .map((e) => EdgeModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      $type: json['type'] as String?,
    );

Map<String, dynamic> _$$GroupInsertElementImplToJson(
        _$GroupInsertElementImpl instance) =>
    <String, dynamic>{
      'position': const OffsetConverter().toJson(instance.position),
      'size': const SizeConverter().toJson(instance.size),
      'groupNode': instance.groupNode,
      'children': instance.children,
      'edges': instance.edges,
      'type': instance.$type,
    };
