import 'package:flutter_test/flutter_test.dart';
import 'package:flow_editor/workflow/services/workflow_execution_service.dart';

void main() {
  test('测试Dio网络调用', () async {
    final execution = await WorkflowExecutionService.getExecution(
        '3329094e-262a-4c21-922d-a2cb4e8abc7d');

    expect(execution.runId, '3329094e-262a-4c21-922d-a2cb4e8abc7d');
    expect(execution.status, isNotNull);
    expect(execution.workflowTemplate, isNotNull);

    print('✅ Dio 网络请求返回结果正确：${execution.toJson()}');
  });
}
