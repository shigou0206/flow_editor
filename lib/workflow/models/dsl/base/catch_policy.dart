import 'package:freezed_annotation/freezed_annotation.dart';

part 'catch_policy.freezed.dart';
part 'catch_policy.g.dart';

@freezed
class CatchPolicy with _$CatchPolicy {
  const factory CatchPolicy({
    required List<String> errorEquals,
    required String next,

    // ignore: invalid_annotation_target
    @JsonKey(defaultValue: null) String? resultPath,
  }) = _CatchPolicy;

  factory CatchPolicy.fromJson(Map<String, dynamic> json) =>
      _$CatchPolicyFromJson(json);
}
