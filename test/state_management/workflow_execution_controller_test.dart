import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flow_editor/workflow/state_management/workflow_execution_provider.dart';
import 'package:flow_editor/workflow/state_management/workflow_execution_controller.dart';

void main() {
  test('WorkflowExecution Controller 测试', () async {
    final container = ProviderContainer();

    // 关键的地方在这里👇
    final controller = container.read(workflowExecutionControllerProvider);

    await controller.loadExecution('3329094e-262a-4c21-922d-a2cb4e8abc7d');

    final execution = container.read(workflowExecutionProvider);

    expect(execution, isNotNull);
    expect(execution!.runId, '3329094e-262a-4c21-922d-a2cb4e8abc7d');
    expect(execution.status, 'completed');
    expect(execution.states, isNotEmpty);

    print('✅ Controller 整体逻辑测试通过: ${execution.toJson()}');
  });
}
