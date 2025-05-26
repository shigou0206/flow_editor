import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'workflow_dsl_state.dart';
import 'package:flow_editor/workflow/models/flow/workflow_dsl.dart';

final workflowDslStateProvider =
    StateNotifierProvider<WorkflowDslStateNotifier, WorkflowDslState>(
        (ref) => WorkflowDslStateNotifier());

class WorkflowDslStateNotifier extends StateNotifier<WorkflowDslState> {
  WorkflowDslStateNotifier()
      : super(const WorkflowDslState(
          workflow: WorkflowDSL(startAt: '', states: {}),
        ));

  void updateWorkflow(WorkflowDSL workflow) {
    state = state.copyWith(workflow: workflow);
  }

  void setLoading(bool loading) {
    state = state.copyWith(isLoading: loading);
  }

  void setError(String error) {
    state = state.copyWith(errorMessage: error);
  }

  void clearError() {
    state = state.copyWith(errorMessage: null);
  }
}
