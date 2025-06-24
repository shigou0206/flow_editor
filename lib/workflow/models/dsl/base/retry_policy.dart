import 'package:freezed_annotation/freezed_annotation.dart';

part 'retry_policy.freezed.dart';
part 'retry_policy.g.dart';

@freezed
class RetryPolicy with _$RetryPolicy {
  const factory RetryPolicy({
    required List<String> errorEquals,

    // ignore: invalid_annotation_target
    @JsonKey(defaultValue: null) int? intervalSeconds,

    // ignore: invalid_annotation_target
    @JsonKey(defaultValue: null) double? backoffRate,

    // ignore: invalid_annotation_target
    @JsonKey(defaultValue: null) int? maxAttempts,
  }) = _RetryPolicy;

  factory RetryPolicy.fromJson(Map<String, dynamic> json) =>
      _$RetryPolicyFromJson(json);
}
