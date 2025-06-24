// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pass_state.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$PassStateImpl _$$PassStateImplFromJson(Map<String, dynamic> json) =>
    _$PassStateImpl(
      resultPath: json['resultPath'] as String?,
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

Map<String, dynamic> _$$PassStateImplToJson(_$PassStateImpl instance) =>
    <String, dynamic>{
      'resultPath': instance.resultPath,
      'comment': instance.comment,
      'inputMapping': instance.inputMapping,
      'outputMapping': instance.outputMapping,
      'retry': instance.retry,
      'catch': instance.catchPolicy,
      'next': instance.next,
      'end': instance.end,
    };
