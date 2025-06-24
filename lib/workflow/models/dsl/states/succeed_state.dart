import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flow_editor/workflow/models/dsl/base/retry_policy.dart';
import 'package:flow_editor/workflow/models/dsl/base/catch_policy.dart';
import 'package:flow_editor/workflow/models/dsl/mapping/mapping_dsl.dart';

part 'succeed_state.freezed.dart';
part 'succeed_state.g.dart';

@freezed
class SucceedState with _$SucceedState {
  const SucceedState._(); // 必要的私有构造函数

  const factory SucceedState({
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
  }) = _SucceedState;

  factory SucceedState.fromJson(Map<String, dynamic> json) =>
      _$SucceedStateFromJson(json);
}
