import 'package:freezed_annotation/freezed_annotation.dart';

part 'retry_policy.freezed.dart';
part 'retry_policy.g.dart';

@freezed
class RetryPolicy with _$RetryPolicy {
  const factory RetryPolicy({
    required List<String> errorEquals,
    @Default(1) int intervalSeconds,
    @Default(2.0) double backoffRate,
    @Default(3) int maxAttempts,
  }) = _RetryPolicy;

  factory RetryPolicy.fromJson(Map<String, dynamic> json) =>
      _$RetryPolicyFromJson(json);
}
