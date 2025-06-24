// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mapping_dsl.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$MappingDSLImpl _$$MappingDSLImplFromJson(Map<String, dynamic> json) =>
    _$MappingDSLImpl(
      namespace: json['namespace'] as String?,
      version: json['version'] as String?,
      description: json['description'] as String?,
      preserve: json['preserve'] == null
          ? const PreserveFields.none()
          : PreserveFields.fromJson(json['preserve'] as Map<String, dynamic>),
      debug: json['debug'] as bool? ?? false,
      mappings: (json['mappings'] as List<dynamic>)
          .map((e) => MappingRule.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$MappingDSLImplToJson(_$MappingDSLImpl instance) =>
    <String, dynamic>{
      'namespace': instance.namespace,
      'version': instance.version,
      'description': instance.description,
      'preserve': instance.preserve,
      'debug': instance.debug,
      'mappings': instance.mappings,
    };
