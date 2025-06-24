import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flow_editor/workflow/models/dsl/base/retry_policy.dart';
import 'package:flow_editor/workflow/models/dsl/base/catch_policy.dart';
import 'package:flow_editor/workflow/models/dsl/mapping/mapping_dsl.dart';

part 'task_state.freezed.dart';
part 'task_state.g.dart';

@freezed
class TaskState with _$TaskState {
  const factory TaskState({
    required String resource,
    Map<String, dynamic>? parameters,
    Map<String, dynamic>? executionConfig,
    int? heartbeatSeconds,
    String? heartbeatExpr,
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
  }) = _TaskState;

  factory TaskState.fromJson(Map<String, dynamic> json) =>
      _$TaskStateFromJson(json);
}
