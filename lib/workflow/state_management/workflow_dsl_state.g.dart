// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'workflow_dsl_state.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$WorkflowDslStateImpl _$$WorkflowDslStateImplFromJson(
        Map<String, dynamic> json) =>
    _$WorkflowDslStateImpl(
      workflow: WorkflowDSL.fromJson(json['workflow'] as Map<String, dynamic>),
      isLoading: json['isLoading'] as bool? ?? false,
      errorMessage: json['errorMessage'] as String?,
    );

Map<String, dynamic> _$$WorkflowDslStateImplToJson(
        _$WorkflowDslStateImpl instance) =>
    <String, dynamic>{
      'workflow': instance.workflow,
      'isLoading': instance.isLoading,
      'errorMessage': instance.errorMessage,
    };
