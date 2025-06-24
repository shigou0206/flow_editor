// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'fail_state.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$FailStateImpl _$$FailStateImplFromJson(Map<String, dynamic> json) =>
    _$FailStateImpl(
      error: json['error'] as String?,
      cause: json['cause'] as String?,
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

Map<String, dynamic> _$$FailStateImplToJson(_$FailStateImpl instance) =>
    <String, dynamic>{
      'error': instance.error,
      'cause': instance.cause,
      'comment': instance.comment,
      'inputMapping': instance.inputMapping,
      'outputMapping': instance.outputMapping,
      'retry': instance.retry,
      'catch': instance.catchPolicy,
      'next': instance.next,
      'end': instance.end,
    };
