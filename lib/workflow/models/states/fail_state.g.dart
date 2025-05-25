// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'fail_state.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$FailStateImpl _$$FailStateImplFromJson(Map<String, dynamic> json) =>
    _$FailStateImpl(
      type: json['type'] as String? ?? 'Fail',
      comment: json['comment'] as String?,
      error: json['error'] as String?,
      cause: json['cause'] as String?,
      next: json['next'] as String? ?? null,
      end: json['end'] as bool? ?? true,
      retry: (json['retry'] as List<dynamic>?)
          ?.map((e) => RetryPolicy.fromJson(e as Map<String, dynamic>))
          .toList(),
      catchPolicy: (json['catchPolicy'] as List<dynamic>?)
          ?.map((e) => CatchPolicy.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$FailStateImplToJson(_$FailStateImpl instance) =>
    <String, dynamic>{
      'type': instance.type,
      'comment': instance.comment,
      'error': instance.error,
      'cause': instance.cause,
      'next': instance.next,
      'end': instance.end,
      'retry': instance.retry,
      'catchPolicy': instance.catchPolicy,
    };
