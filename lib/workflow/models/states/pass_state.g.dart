// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pass_state.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$PassStateImpl _$$PassStateImplFromJson(Map<String, dynamic> json) =>
    _$PassStateImpl(
      type: json['type'] as String? ?? 'Pass',
      comment: json['comment'] as String?,
      next: json['next'] as String?,
      end: json['end'] as bool?,
      result: json['result'],
      resultPath: json['resultPath'] as String?,
      retry: (json['retry'] as List<dynamic>?)
          ?.map((e) => RetryPolicy.fromJson(e as Map<String, dynamic>))
          .toList(),
      catchPolicy: (json['catchPolicy'] as List<dynamic>?)
          ?.map((e) => CatchPolicy.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$PassStateImplToJson(_$PassStateImpl instance) =>
    <String, dynamic>{
      'type': instance.type,
      'comment': instance.comment,
      'next': instance.next,
      'end': instance.end,
      'result': instance.result,
      'resultPath': instance.resultPath,
      'retry': instance.retry,
      'catchPolicy': instance.catchPolicy,
    };
