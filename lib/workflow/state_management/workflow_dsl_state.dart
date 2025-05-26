import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flow_editor/workflow/models/flow/workflow_dsl.dart';

part 'workflow_dsl_state.freezed.dart';
part 'workflow_dsl_state.g.dart';

@freezed
class WorkflowDslState with _$WorkflowDslState {
  const factory WorkflowDslState({
    required WorkflowDSL workflow,
    @Default(false) bool isLoading,
    String? errorMessage,
  }) = _WorkflowDslState;

  factory WorkflowDslState.fromJson(Map<String, dynamic> json) =>
      _$WorkflowDslStateFromJson(json);
}
