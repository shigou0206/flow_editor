import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flow_editor/workflow/models/dsl/base/retry_policy.dart';
import 'package:flow_editor/workflow/models/dsl/base/catch_policy.dart';
import 'package:flow_editor/workflow/models/dsl/mapping/mapping_dsl.dart';

part 'fail_state.freezed.dart';
part 'fail_state.g.dart';

@freezed
class FailState with _$FailState {
  const FailState._(); // 必须的私有构造函数

  const factory FailState({
    String? error,
    String? cause,
    @Default(null) String? comment,

    // ignore: invalid_annotation_target
    @JsonKey(defaultValue: null) MappingDSL? inputMapping,

    // ignore: invalid_annotation_target
    @JsonKey(defaultValue: null) MappingDSL? outputMapping,

    // ignore: invalid_annotation_target
    @JsonKey(defaultValue: null) List<RetryPolicy>? retry,

    // ignore: invalid_annotation_target
    @JsonKey(name: 'catch', defaultValue: null) List<CatchPolicy>? catchPolicy,
    @Default(null) String? next,
    @Default(null) bool? end,
  }) = _FailState;

  factory FailState.fromJson(Map<String, dynamic> json) =>
      _$FailStateFromJson(json);
}
