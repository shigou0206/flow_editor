// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'choice_logic.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ChoiceLogicImpl _$$ChoiceLogicImplFromJson(Map<String, dynamic> json) =>
    _$ChoiceLogicImpl(
      and: (json['And'] as List<dynamic>?)
          ?.map((e) => ChoiceLogic.fromJson(e as Map<String, dynamic>))
          .toList(),
      or: (json['Or'] as List<dynamic>?)
          ?.map((e) => ChoiceLogic.fromJson(e as Map<String, dynamic>))
          .toList(),
      not: json['Not'] == null
          ? null
          : ChoiceLogic.fromJson(json['Not'] as Map<String, dynamic>),
      variable: json['variable'] as String?,
      operator: json['operator'] as String?,
      value: json['value'],
    );

Map<String, dynamic> _$$ChoiceLogicImplToJson(_$ChoiceLogicImpl instance) =>
    <String, dynamic>{
      'And': instance.and,
      'Or': instance.or,
      'Not': instance.not,
      'variable': instance.variable,
      'operator': instance.operator,
      'value': instance.value,
    };
