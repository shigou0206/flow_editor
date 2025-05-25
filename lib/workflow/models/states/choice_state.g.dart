// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'choice_state.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ChoiceStateImpl _$$ChoiceStateImplFromJson(Map<String, dynamic> json) =>
    _$ChoiceStateImpl(
      type: json['type'] as String? ?? 'Choice',
      comment: json['comment'] as String?,
      choices: (json['choices'] as List<dynamic>)
          .map((e) => ChoiceRule.fromJson(e as Map<String, dynamic>))
          .toList(),
      defaultNext: json['defaultNext'] as String?,
      next: json['next'] as String?,
      end: json['end'] as bool?,
      retry: (json['retry'] as List<dynamic>?)
          ?.map((e) => RetryPolicy.fromJson(e as Map<String, dynamic>))
          .toList(),
      catchPolicy: (json['catchPolicy'] as List<dynamic>?)
          ?.map((e) => CatchPolicy.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$ChoiceStateImplToJson(_$ChoiceStateImpl instance) =>
    <String, dynamic>{
      'type': instance.type,
      'comment': instance.comment,
      'choices': instance.choices,
      'defaultNext': instance.defaultNext,
      'next': instance.next,
      'end': instance.end,
      'retry': instance.retry,
      'catchPolicy': instance.catchPolicy,
    };
