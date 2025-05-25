// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'succeed_state.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$SucceedStateImpl _$$SucceedStateImplFromJson(Map<String, dynamic> json) =>
    _$SucceedStateImpl(
      type: json['type'] as String? ?? 'Succeed',
      comment: json['comment'] as String?,
      next: json['next'] as String? ?? null,
      end: json['end'] as bool? ?? true,
      retry: (json['retry'] as List<dynamic>?)
              ?.map((e) => RetryPolicy.fromJson(e as Map<String, dynamic>))
              .toList() ??
          null,
      catchPolicy: (json['catchPolicy'] as List<dynamic>?)
              ?.map((e) => CatchPolicy.fromJson(e as Map<String, dynamic>))
              .toList() ??
          null,
    );

Map<String, dynamic> _$$SucceedStateImplToJson(_$SucceedStateImpl instance) =>
    <String, dynamic>{
      'type': instance.type,
      'comment': instance.comment,
      'next': instance.next,
      'end': instance.end,
      'retry': instance.retry,
      'catchPolicy': instance.catchPolicy,
    };
