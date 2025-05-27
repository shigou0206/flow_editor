import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../services/workflow_execution_service.dart';
import 'workflow_execution_provider.dart';

final workflowExecutionControllerProvider = Provider((ref) {
  return WorkflowExecutionController(ref);
});

class WorkflowExecutionController {
  final Ref ref;

  WorkflowExecutionController(this.ref);

  Future<void> loadExecution(String runId) async {
    final execution = await WorkflowExecutionService.getExecution(runId);
    final tasks = await WorkflowExecutionService.getTasks(runId);

    final states = {
      for (final task in tasks) task.stateId: task,
    };

    ref.read(workflowExecutionProvider.notifier).state =
        execution.copyWith(states: states);
  }

  Future<void> refreshExecutionState(String runId) async {
    final tasks = await WorkflowExecutionService.getTasks(runId);
    final states = {
      for (final task in tasks) task.stateId: task,
    };

    final currentExecution = ref.read(workflowExecutionProvider);
    if (currentExecution != null) {
      ref.read(workflowExecutionProvider.notifier).state =
          currentExecution.copyWith(states: states);
    }
  }

  Future<void> cancelExecution(String runId) async {
    await WorkflowExecutionService.cancelExecution(runId);
    final currentExecution = ref.read(workflowExecutionProvider);
    if (currentExecution != null) {
      ref.read(workflowExecutionProvider.notifier).state =
          currentExecution.copyWith(status: 'CANCELED');
    }
  }
}
