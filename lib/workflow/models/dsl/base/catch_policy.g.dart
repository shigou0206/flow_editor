// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'catch_policy.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$CatchPolicyImpl _$$CatchPolicyImplFromJson(Map<String, dynamic> json) =>
    _$CatchPolicyImpl(
      errorEquals: (json['errorEquals'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      next: json['next'] as String,
      resultPath: json['resultPath'] as String?,
    );

Map<String, dynamic> _$$CatchPolicyImplToJson(_$CatchPolicyImpl instance) =>
    <String, dynamic>{
      'errorEquals': instance.errorEquals,
      'next': instance.next,
      'resultPath': instance.resultPath,
    };
