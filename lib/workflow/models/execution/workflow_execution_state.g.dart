// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'workflow_execution_state.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$WorkflowExecutionStateImpl _$$WorkflowExecutionStateImplFromJson(
        Map<String, dynamic> json) =>
    _$WorkflowExecutionStateImpl(
      stateId: json['stateId'] as String,
      activityType: json['activityType'] as String,
      status: json['status'] as String,
      input: json['input'] as Map<String, dynamic>?,
      result: json['result'] as Map<String, dynamic>?,
      scheduledAt: json['scheduledAt'] == null
          ? null
          : DateTime.parse(json['scheduledAt'] as String),
      startedAt: json['startedAt'] == null
          ? null
          : DateTime.parse(json['startedAt'] as String),
      completedAt: json['completedAt'] == null
          ? null
          : DateTime.parse(json['completedAt'] as String),
    );

Map<String, dynamic> _$$WorkflowExecutionStateImplToJson(
        _$WorkflowExecutionStateImpl instance) =>
    <String, dynamic>{
      'stateId': instance.stateId,
      'activityType': instance.activityType,
      'status': instance.status,
      'input': instance.input,
      'result': instance.result,
      'scheduledAt': instance.scheduledAt?.toIso8601String(),
      'startedAt': instance.startedAt?.toIso8601String(),
      'completedAt': instance.completedAt?.toIso8601String(),
    };
