// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'retry_policy.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$RetryPolicyImpl _$$RetryPolicyImplFromJson(Map<String, dynamic> json) =>
    _$RetryPolicyImpl(
      errorEquals: (json['errorEquals'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      intervalSeconds: (json['intervalSeconds'] as num?)?.toInt(),
      backoffRate: (json['backoffRate'] as num?)?.toDouble(),
      maxAttempts: (json['maxAttempts'] as num?)?.toInt(),
    );

Map<String, dynamic> _$$RetryPolicyImplToJson(_$RetryPolicyImpl instance) =>
    <String, dynamic>{
      'errorEquals': instance.errorEquals,
      'intervalSeconds': instance.intervalSeconds,
      'backoffRate': instance.backoffRate,
      'maxAttempts': instance.maxAttempts,
    };
