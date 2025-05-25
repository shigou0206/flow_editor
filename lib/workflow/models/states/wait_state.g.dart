// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'wait_state.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$WaitStateImpl _$$WaitStateImplFromJson(Map<String, dynamic> json) =>
    _$WaitStateImpl(
      type: json['type'] as String? ?? 'Wait',
      comment: json['comment'] as String?,
      next: json['next'] as String?,
      end: json['end'] as bool?,
      seconds: (json['seconds'] as num?)?.toInt(),
      timestamp: json['timestamp'] as String?,
      retry: (json['retry'] as List<dynamic>?)
          ?.map((e) => RetryPolicy.fromJson(e as Map<String, dynamic>))
          .toList(),
      catchPolicy: (json['catchPolicy'] as List<dynamic>?)
          ?.map((e) => CatchPolicy.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$WaitStateImplToJson(_$WaitStateImpl instance) =>
    <String, dynamic>{
      'type': instance.type,
      'comment': instance.comment,
      'next': instance.next,
      'end': instance.end,
      'seconds': instance.seconds,
      'timestamp': instance.timestamp,
      'retry': instance.retry,
      'catchPolicy': instance.catchPolicy,
    };
