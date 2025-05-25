import 'package:freezed_annotation/freezed_annotation.dart';
import '../base/base_state.dart';
import '../base/retry_policy.dart';
import '../base/catch_policy.dart';

part 'task_state.freezed.dart';
part 'task_state.g.dart';

@freezed
class TaskState with _$TaskState implements BaseState {
  const factory TaskState({
    @Default('Task') String type,
    String? comment,
    String? next,
    bool? end,
    required String resource,
    Map<String, dynamic>? parameters,
    Map<String, dynamic>? executionConfig,
    int? heartbeatSeconds,
    String? heartbeatExpr,
    List<RetryPolicy>? retry,
    List<CatchPolicy>? catchPolicy,
  }) = _TaskState;

  factory TaskState.fromJson(Map<String, dynamic> json) =>
      _$TaskStateFromJson(json);
}
