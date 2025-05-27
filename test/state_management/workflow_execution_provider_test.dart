import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flow_editor/workflow/state_management/workflow_execution_provider.dart';
import 'package:flow_editor/workflow/services/workflow_execution_service.dart';

void main() {
  test('WorkflowExecution 状态管理测试', () async {
    final container = ProviderContainer();

    // 调用你已经成功通过的Dio请求
    final execution = await WorkflowExecutionService.getExecution(
        '3329094e-262a-4c21-922d-a2cb4e8abc7d');

    // 更新状态
    container.read(workflowExecutionProvider.notifier).state = execution;

    // 获取状态
    final state = container.read(workflowExecutionProvider);

    // 验证状态正确
    expect(state, isNotNull);
    expect(state!.runId, '3329094e-262a-4c21-922d-a2cb4e8abc7d');
    expect(state.status, 'completed');
    expect(state.workflowTemplate.startAt, 'EvaluateUserType');

    print('✅ Riverpod 状态更新与读取正常: ${state.toJson()}');
  });
}
