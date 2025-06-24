// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'succeed_state.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$SucceedStateImpl _$$SucceedStateImplFromJson(Map<String, dynamic> json) =>
    _$SucceedStateImpl(
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

Map<String, dynamic> _$$SucceedStateImplToJson(_$SucceedStateImpl instance) =>
    <String, dynamic>{
      'comment': instance.comment,
      'inputMapping': instance.inputMapping,
      'outputMapping': instance.outputMapping,
      'retry': instance.retry,
      'catch': instance.catchPolicy,
      'next': instance.next,
      'end': instance.end,
    };
