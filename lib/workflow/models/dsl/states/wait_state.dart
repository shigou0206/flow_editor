import 'package:flow_editor/workflow/models/dsl/base/catch_policy.dart';
import 'package:flow_editor/workflow/models/dsl/base/retry_policy.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flow_editor/workflow/models/dsl/mapping/mapping_dsl.dart';

part 'wait_state.freezed.dart';
part 'wait_state.g.dart';

@freezed
class WaitState with _$WaitState {
  const WaitState._(); // 必须的私有构造函数，支持自定义getter或接口实现

  const factory WaitState({
    int? seconds,
    String? timestamp,
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
  }) = _WaitState;

  factory WaitState.fromJson(Map<String, dynamic> json) =>
      _$WaitStateFromJson(json);
}
