import 'package:dio/dio.dart';
import 'dart:convert';
import 'package:flow_editor/workflow/models/execution/workflow_execution.dart';
import 'package:flow_editor/workflow/models/execution/workflow_execution_state.dart';
import 'package:flow_editor/workflow/models/dsl/flow/workflow_dsl.dart';

class WorkflowExecutionService {
  static final Dio client = Dio(BaseOptions(baseUrl: 'http://localhost:8000'));

  static Future<WorkflowExecution> getExecution(String runId) async {
    final resp = await client.get('/workflow_executions/$runId');

    final data = resp.data['data'] as Map<String, dynamic>;

    final workflowTemplate = await getTemplate(data['template_id'] as String);

    final execution = WorkflowExecution(
      runId: data['run_id'] as String,
      status: data['status'] as String,
      workflowTemplate: workflowTemplate,
      states: {},
      startedAt: data['start_time'] != null
          ? DateTime.parse(data['start_time'])
          : null,
      finishedAt: data['close_time'] != null
          ? DateTime.parse(data['close_time'])
          : null,
      inputs: null,
      outputs: null,
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
    final data = resp.data['data'] as Map<String, dynamic>;

    final dslDefinitionStr = data['dsl_definition'] as String;
    final dslDefinition = jsonDecode(dslDefinitionStr);

    final formattedDsl = {
      'startAt': dslDefinition['StartAt'],
      'states': dslDefinition['States'],
      'comment': null,
      'version': '1.0.0',
      'globalConfig': null,
      'errorHandling': null,
    };

    final template = WorkflowDSL.fromJson(normalizeJson(formattedDsl));
    return template;
  }

  static Future<void> cancelExecution(String runId) async {
    await client.delete('/workflow_executions/$runId');
  }
}

dynamic convertJson(dynamic item) {
  if (item is Map) {
    return item
        .map((key, value) => MapEntry(key as String, convertJson(value)));
  } else if (item is List) {
    return item.map(convertJson).toList();
  } else {
    return item;
  }
}

dynamic normalizeJson(dynamic item) {
  if (item is Map) {
    final map =
        item.map((key, value) => MapEntry(key as String, normalizeJson(value)));

    const mappings = {
      'Type': 'type',
      'Next': 'next',
      'End': 'end',
      'Resource': 'resource',
      'Parameters': 'parameters',
      'Choices': 'choices',
      'Seconds': 'seconds',
      'Condition': 'condition',
      'Variable': 'variable',
      'Operator': 'operator',
      'Value': 'value',
      'Default': 'defaultNext',
      'Result': 'result',
      'ResultPath': 'resultPath',
      'ResultExpr': 'resultExpr',
      'Error': 'error',
      'Cause': 'cause',
    };

    mappings.forEach((original, newKey) {
      if (map.containsKey(original)) {
        map[newKey] = map.remove(original);
      }
    });

    return map;
  } else if (item is List) {
    return item.map(normalizeJson).toList();
  } else {
    return item;
  }
}
