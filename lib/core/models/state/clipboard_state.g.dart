// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'clipboard_state.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ClipboardStateImpl _$$ClipboardStateImplFromJson(Map<String, dynamic> json) =>
    _$ClipboardStateImpl(
      nodes: (json['nodes'] as List<dynamic>?)
              ?.map((e) => NodeModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      edges: (json['edges'] as List<dynamic>?)
              ?.map((e) => EdgeModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$$ClipboardStateImplToJson(
        _$ClipboardStateImpl instance) =>
    <String, dynamic>{
      'nodes': instance.nodes,
      'edges': instance.edges,
    };
