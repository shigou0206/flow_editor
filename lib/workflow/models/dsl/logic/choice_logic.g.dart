// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'choice_logic.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ChoiceLogicImpl _$$ChoiceLogicImplFromJson(Map<String, dynamic> json) =>
    _$ChoiceLogicImpl(
      and: _choiceLogicListFromJson(json['And'] as List?),
      or: _choiceLogicListFromJson(json['Or'] as List?),
      not: _choiceLogicFromJson(json['Not'] as Map<String, dynamic>?),
      variable: json['variable'] as String?,
      operator: json['operator'] as String?,
      value: json['value'],
    );

Map<String, dynamic> _$$ChoiceLogicImplToJson(_$ChoiceLogicImpl instance) =>
    <String, dynamic>{
      'And': _choiceLogicListToJson(instance.and),
      'Or': _choiceLogicListToJson(instance.or),
      'Not': _choiceLogicToJson(instance.not),
      'variable': instance.variable,
      'operator': instance.operator,
      'value': instance.value,
    };
