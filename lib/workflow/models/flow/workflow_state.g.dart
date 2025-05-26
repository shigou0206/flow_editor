// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'workflow_state.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$TaskWorkflowStateImpl _$$TaskWorkflowStateImplFromJson(
        Map<String, dynamic> json) =>
    _$TaskWorkflowStateImpl(
      TaskState.fromJson(json['task'] as Map<String, dynamic>),
      $type: json['type'] as String?,
    );

Map<String, dynamic> _$$TaskWorkflowStateImplToJson(
        _$TaskWorkflowStateImpl instance) =>
    <String, dynamic>{
      'task': instance.task,
      'type': instance.$type,
    };

_$PassWorkflowStateImpl _$$PassWorkflowStateImplFromJson(
        Map<String, dynamic> json) =>
    _$PassWorkflowStateImpl(
      PassState.fromJson(json['pass'] as Map<String, dynamic>),
      $type: json['type'] as String?,
    );

Map<String, dynamic> _$$PassWorkflowStateImplToJson(
        _$PassWorkflowStateImpl instance) =>
    <String, dynamic>{
      'pass': instance.pass,
      'type': instance.$type,
    };

_$ChoiceWorkflowStateImpl _$$ChoiceWorkflowStateImplFromJson(
        Map<String, dynamic> json) =>
    _$ChoiceWorkflowStateImpl(
      ChoiceState.fromJson(json['choice'] as Map<String, dynamic>),
      $type: json['type'] as String?,
    );

Map<String, dynamic> _$$ChoiceWorkflowStateImplToJson(
        _$ChoiceWorkflowStateImpl instance) =>
    <String, dynamic>{
      'choice': instance.choice,
      'type': instance.$type,
    };

_$SucceedWorkflowStateImpl _$$SucceedWorkflowStateImplFromJson(
        Map<String, dynamic> json) =>
    _$SucceedWorkflowStateImpl(
      SucceedState.fromJson(json['succeed'] as Map<String, dynamic>),
      $type: json['type'] as String?,
    );

Map<String, dynamic> _$$SucceedWorkflowStateImplToJson(
        _$SucceedWorkflowStateImpl instance) =>
    <String, dynamic>{
      'succeed': instance.succeed,
      'type': instance.$type,
    };

_$FailWorkflowStateImpl _$$FailWorkflowStateImplFromJson(
        Map<String, dynamic> json) =>
    _$FailWorkflowStateImpl(
      FailState.fromJson(json['fail'] as Map<String, dynamic>),
      $type: json['type'] as String?,
    );

Map<String, dynamic> _$$FailWorkflowStateImplToJson(
        _$FailWorkflowStateImpl instance) =>
    <String, dynamic>{
      'fail': instance.fail,
      'type': instance.$type,
    };

_$WaitWorkflowStateImpl _$$WaitWorkflowStateImplFromJson(
        Map<String, dynamic> json) =>
    _$WaitWorkflowStateImpl(
      WaitState.fromJson(json['wait'] as Map<String, dynamic>),
      $type: json['type'] as String?,
    );

Map<String, dynamic> _$$WaitWorkflowStateImplToJson(
        _$WaitWorkflowStateImpl instance) =>
    <String, dynamic>{
      'wait': instance.wait,
      'type': instance.$type,
    };
