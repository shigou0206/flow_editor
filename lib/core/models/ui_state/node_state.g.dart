// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'node_state.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$NodeStateImpl _$$NodeStateImplFromJson(Map<String, dynamic> json) =>
    _$NodeStateImpl(
      nodes: (json['nodes'] as List<dynamic>?)
              ?.map((e) => NodeModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      version: (json['version'] as num?)?.toInt() ?? 1,
    );

Map<String, dynamic> _$$NodeStateImplToJson(_$NodeStateImpl instance) =>
    <String, dynamic>{
      'nodes': instance.nodes,
      'version': instance.version,
    };
