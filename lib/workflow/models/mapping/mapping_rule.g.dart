// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mapping_rule.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$MappingRuleImpl _$$MappingRuleImplFromJson(Map<String, dynamic> json) =>
    _$MappingRuleImpl(
      key: json['key'] as String,
      mappingType: $enumDecode(_$MappingTypeEnumMap, json['type']),
      source: json['source'] as String?,
      transform: json['transform'] as String?,
      template: json['template'] as String?,
      value: json['value'],
      subMappings: (json['subMappings'] as List<dynamic>?)
          ?.map((e) => MappingRule.fromJson(e as Map<String, dynamic>))
          .toList(),
      mergeStrategy:
          $enumDecodeNullable(_$MergeStrategyEnumMap, json['mergeStrategy']) ??
              MergeStrategy.overwrite,
      condition: json['condition'] as String?,
      dependsOn: (json['dependsOn'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      comment: json['comment'] as String?,
      lang: json['lang'] as String?,
      expectedType: json['expectedType'] as String?,
      schema: json['schema'],
    );

Map<String, dynamic> _$$MappingRuleImplToJson(_$MappingRuleImpl instance) =>
    <String, dynamic>{
      'key': instance.key,
      'type': _$MappingTypeEnumMap[instance.mappingType]!,
      'source': instance.source,
      'transform': instance.transform,
      'template': instance.template,
      'value': instance.value,
      'subMappings': instance.subMappings,
      'mergeStrategy': _$MergeStrategyEnumMap[instance.mergeStrategy]!,
      'condition': instance.condition,
      'dependsOn': instance.dependsOn,
      'comment': instance.comment,
      'lang': instance.lang,
      'expectedType': instance.expectedType,
      'schema': instance.schema,
    };

const _$MappingTypeEnumMap = {
  MappingType.constant: 'Constant',
  MappingType.jsonPath: 'JsonPath',
  MappingType.expr: 'Expr',
  MappingType.template: 'Template',
  MappingType.subMapping: 'SubMapping',
};

const _$MergeStrategyEnumMap = {
  MergeStrategy.overwrite: 'overwrite',
  MergeStrategy.ignore: 'ignore',
  MergeStrategy.append: 'append',
  MergeStrategy.merge: 'merge',
};
