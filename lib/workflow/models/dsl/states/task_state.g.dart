// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task_state.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$TaskStateImpl _$$TaskStateImplFromJson(Map<String, dynamic> json) =>
    _$TaskStateImpl(
      resource: json['resource'] as String,
      parameters: json['parameters'] as Map<String, dynamic>?,
      executionConfig: json['executionConfig'] as Map<String, dynamic>?,
      heartbeatSeconds: (json['heartbeatSeconds'] as num?)?.toInt(),
      heartbeatExpr: json['heartbeatExpr'] as String?,
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

Map<String, dynamic> _$$TaskStateImplToJson(_$TaskStateImpl instance) =>
    <String, dynamic>{
      'resource': instance.resource,
      'parameters': instance.parameters,
      'executionConfig': instance.executionConfig,
      'heartbeatSeconds': instance.heartbeatSeconds,
      'heartbeatExpr': instance.heartbeatExpr,
      'comment': instance.comment,
      'inputMapping': instance.inputMapping,
      'outputMapping': instance.outputMapping,
      'retry': instance.retry,
      'catch': instance.catchPolicy,
      'next': instance.next,
      'end': instance.end,
    };
