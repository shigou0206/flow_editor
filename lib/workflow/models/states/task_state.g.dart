// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task_state.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$TaskStateImpl _$$TaskStateImplFromJson(Map<String, dynamic> json) =>
    _$TaskStateImpl(
      type: json['type'] as String? ?? 'Task',
      comment: json['comment'] as String?,
      next: json['next'] as String?,
      end: json['end'] as bool?,
      resource: json['resource'] as String,
      parameters: json['parameters'] as Map<String, dynamic>?,
      executionConfig: json['executionConfig'] as Map<String, dynamic>?,
      heartbeatSeconds: (json['heartbeatSeconds'] as num?)?.toInt(),
      heartbeatExpr: json['heartbeatExpr'] as String?,
      retry: (json['retry'] as List<dynamic>?)
          ?.map((e) => RetryPolicy.fromJson(e as Map<String, dynamic>))
          .toList(),
      catchPolicy: (json['catchPolicy'] as List<dynamic>?)
          ?.map((e) => CatchPolicy.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$TaskStateImplToJson(_$TaskStateImpl instance) =>
    <String, dynamic>{
      'type': instance.type,
      'comment': instance.comment,
      'next': instance.next,
      'end': instance.end,
      'resource': instance.resource,
      'parameters': instance.parameters,
      'executionConfig': instance.executionConfig,
      'heartbeatSeconds': instance.heartbeatSeconds,
      'heartbeatExpr': instance.heartbeatExpr,
      'retry': instance.retry,
      'catchPolicy': instance.catchPolicy,
    };
