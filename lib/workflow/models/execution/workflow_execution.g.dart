// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'workflow_execution.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$WorkflowExecutionImpl _$$WorkflowExecutionImplFromJson(
        Map<String, dynamic> json) =>
    _$WorkflowExecutionImpl(
      runId: json['runId'] as String,
      status: json['status'] as String,
      workflowTemplate: WorkflowDSL.fromJson(
          json['workflowTemplate'] as Map<String, dynamic>),
      states: (json['states'] as Map<String, dynamic>).map(
        (k, e) => MapEntry(
            k, WorkflowExecutionState.fromJson(e as Map<String, dynamic>)),
      ),
      startedAt: json['startedAt'] == null
          ? null
          : DateTime.parse(json['startedAt'] as String),
      finishedAt: json['finishedAt'] == null
          ? null
          : DateTime.parse(json['finishedAt'] as String),
      inputs: json['inputs'] as Map<String, dynamic>?,
      outputs: json['outputs'] as Map<String, dynamic>?,
    );

Map<String, dynamic> _$$WorkflowExecutionImplToJson(
        _$WorkflowExecutionImpl instance) =>
    <String, dynamic>{
      'runId': instance.runId,
      'status': instance.status,
      'workflowTemplate': instance.workflowTemplate,
      'states': instance.states,
      'startedAt': instance.startedAt?.toIso8601String(),
      'finishedAt': instance.finishedAt?.toIso8601String(),
      'inputs': instance.inputs,
      'outputs': instance.outputs,
    };
