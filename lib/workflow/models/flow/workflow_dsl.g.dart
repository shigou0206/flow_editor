// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'workflow_dsl.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$WorkflowDSLImpl _$$WorkflowDSLImplFromJson(Map<String, dynamic> json) =>
    _$WorkflowDSLImpl(
      comment: json['comment'] as String?,
      version: json['version'] as String? ?? '1.0.0',
      startAt: json['startAt'] as String,
      globalConfig: json['globalConfig'] as Map<String, dynamic>?,
      errorHandling: json['errorHandling'] as Map<String, dynamic>?,
      states: json['states'] as Map<String, dynamic>,
    );

Map<String, dynamic> _$$WorkflowDSLImplToJson(_$WorkflowDSLImpl instance) =>
    <String, dynamic>{
      'comment': instance.comment,
      'version': instance.version,
      'startAt': instance.startAt,
      'globalConfig': instance.globalConfig,
      'errorHandling': instance.errorHandling,
      'states': instance.states,
    };
