import 'package:flutter_test/flutter_test.dart';
import 'package:flow_editor/workflow/models/execution/workflow_execution.dart';

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

void main() {
  test('WorkflowExecution serialization', () {
    final json = {
      "runId": "exec_001",
      "status": "RUNNING",
      "workflowTemplate": {
        "comment": null,
        "version": "1.0.0",
        "startAt": "task1",
        "states": {
          "task1": {
            "type": "Task",
            "comment": null,
            "next": "task2",
            "end": false,
            "resource": "doSomething",
            "parameters": null,
            "executionConfig": null,
            "heartbeatSeconds": null,
            "heartbeatExpr": null,
            "retry": null,
            "catchPolicy": null
          },
          "task2": {
            "type": "Succeed",
            "comment": null,
            "next": null,
            "end": true,
            "retry": null,
            "catchPolicy": null
          }
        }
      },
      "states": {},
      "startedAt": "2024-05-27T00:00:00.000Z",
      "finishedAt": null,
      "inputs": null,
      "outputs": null,
    };

    final execution = WorkflowExecution.fromJson(convertJson(json));

    expect(execution.runId, "exec_001");
    expect(execution.status, "RUNNING");
    expect(execution.startedAt, DateTime.parse("2024-05-27T00:00:00Z"));

    // 最终的正确写法在这里👇
    final serializedFixed = execution.toJson();

    serializedFixed['workflowTemplate'] = execution.workflowTemplate.toJson();
    serializedFixed['workflowTemplate']['states'] = execution
        .workflowTemplate.states
        .map((key, state) => MapEntry(key, state.toJson()));

    expect(serializedFixed, json);
  });
}
