// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'choice_rule.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ChoiceRuleImpl _$$ChoiceRuleImplFromJson(Map<String, dynamic> json) =>
    _$ChoiceRuleImpl(
      condition:
          ChoiceLogic.fromJson(json['condition'] as Map<String, dynamic>),
      next: json['next'] as String,
    );

Map<String, dynamic> _$$ChoiceRuleImplToJson(_$ChoiceRuleImpl instance) =>
    <String, dynamic>{
      'condition': instance.condition,
      'next': instance.next,
    };
