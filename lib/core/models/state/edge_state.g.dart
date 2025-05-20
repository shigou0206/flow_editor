// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'edge_state.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$EdgeStateImpl _$$EdgeStateImplFromJson(Map<String, dynamic> json) =>
    _$EdgeStateImpl(
      edgesByWorkflow: (json['edgesByWorkflow'] as Map<String, dynamic>?)?.map(
            (k, e) => MapEntry(
                k,
                (e as List<dynamic>)
                    .map((e) => EdgeModel.fromJson(e as Map<String, dynamic>))
                    .toList()),
          ) ??
          const {},
      edgeIdsByType: (json['edgeIdsByType'] as Map<String, dynamic>?)?.map(
            (k, e) => MapEntry(
                k, (e as List<dynamic>).map((e) => e as String).toSet()),
          ) ??
          const {},
      version: (json['version'] as num?)?.toInt() ?? 1,
      selectedEdgeIds: (json['selectedEdgeIds'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toSet() ??
          const {},
    );

Map<String, dynamic> _$$EdgeStateImplToJson(_$EdgeStateImpl instance) =>
    <String, dynamic>{
      'edgesByWorkflow': instance.edgesByWorkflow,
      'edgeIdsByType':
          instance.edgeIdsByType.map((k, e) => MapEntry(k, e.toList())),
      'version': instance.version,
      'selectedEdgeIds': instance.selectedEdgeIds.toList(),
    };
