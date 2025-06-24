// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'choice_state.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ChoiceStateImpl _$$ChoiceStateImplFromJson(Map<String, dynamic> json) =>
    _$ChoiceStateImpl(
      choices: (json['choices'] as List<dynamic>)
          .map((e) => ChoiceRule.fromJson(e as Map<String, dynamic>))
          .toList(),
      defaultNext: json['defaultNext'] as String?,
      comment: json['comment'] as String? ?? null,
      inputMapping: json['inputMapping'] == null
          ? null
          : MappingDSL.fromJson(json['inputMapping'] as Map<String, dynamic>),
      outputMapping: json['outputMapping'] == null
          ? null
          : MappingDSL.fromJson(json['outputMapping'] as Map<String, dynamic>),
      retry: (json['retry'] as List<dynamic>?)
          ?.map((e) => RetryPolicy.fromJson(e as Map<String, dynamic>))
          .toList(),
      catchPolicy: (json['catch'] as List<dynamic>?)
          ?.map((e) => CatchPolicy.fromJson(e as Map<String, dynamic>))
          .toList(),
      next: json['next'] as String? ?? null,
      end: json['end'] as bool? ?? null,
    );

Map<String, dynamic> _$$ChoiceStateImplToJson(_$ChoiceStateImpl instance) =>
    <String, dynamic>{
      'choices': instance.choices,
      'defaultNext': instance.defaultNext,
      'comment': instance.comment,
      'inputMapping': instance.inputMapping,
      'outputMapping': instance.outputMapping,
      'retry': instance.retry,
      'catch': instance.catchPolicy,
      'next': instance.next,
      'end': instance.end,
    };
