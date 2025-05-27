import 'package:freezed_annotation/freezed_annotation.dart';

part 'workflow_execution_state.freezed.dart';
part 'workflow_execution_state.g.dart';

@freezed
class WorkflowExecutionState with _$WorkflowExecutionState {
  const factory WorkflowExecutionState({
    required String stateId,
    required String activityType,
    required String status,
    Map<String, dynamic>? input,
    Map<String, dynamic>? result,
    DateTime? scheduledAt,
    DateTime? startedAt,
    DateTime? completedAt,
  }) = _WorkflowExecutionState;

  factory WorkflowExecutionState.fromJson(Map<String, dynamic> json) =>
      _$WorkflowExecutionStateFromJson(json);
}
