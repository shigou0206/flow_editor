import 'package:dio/dio.dart';
import '../models/execution/workflow_execution.dart';
import '../models/execution/workflow_execution_state.dart';
import '../models/flow/workflow_dsl.dart';

class WorkflowExecutionService {
  static final Dio client = Dio(BaseOptions(baseUrl: 'http://localhost:8000'));

  static Future<WorkflowExecution> getExecution(String runId) async {
    final resp = await client.get('/workflow_executions/$runId');
    final workflowId = resp.data['workflow_id'] as String;
    final workflowTemplate = await getTemplate(workflowId);

    final execution = WorkflowExecution(
      runId: resp.data['run_id'],
      status: resp.data['status'],
      workflowTemplate: workflowTemplate,
      states: {}, // initially empty, filled by getTasks
      startedAt: DateTime.parse(resp.data['started_at']),
      finishedAt: resp.data['finished_at'] != null
          ? DateTime.parse(resp.data['finished_at'])
          : null,
      inputs: resp.data['input'],
      outputs: resp.data['output'],
    );
    return execution;
  }

  static Future<List<WorkflowExecutionState>> getTasks(String runId) async {
    final resp = await client.get('/workflow_executions/$runId/tasks');
    return (resp.data as List)
        .map((taskJson) => WorkflowExecutionState.fromJson(taskJson))
        .toList();
  }

  static Future<WorkflowDSL> getTemplate(String templateId) async {
    final resp = await client.get('/workflow_templates/$templateId');
    return WorkflowDSL.fromJson(resp.data);
  }

  static Future<void> cancelExecution(String runId) async {
    await client.delete('/workflow_executions/$runId');
  }
}
