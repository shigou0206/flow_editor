import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flow_editor/workflow/models/dsl/states/task_state.dart';
import 'package:flow_editor/workflow/models/dsl/states/pass_state.dart';
import 'package:flow_editor/workflow/models/dsl/states/choice_state.dart';
import 'package:flow_editor/workflow/models/dsl/states/succeed_state.dart';
import 'package:flow_editor/workflow/models/dsl/states/fail_state.dart';
import 'package:flow_editor/workflow/models/dsl/states/wait_state.dart';

part 'workflow_state.freezed.dart';

@Freezed(
  unionKey: 'type',
  unionValueCase: FreezedUnionCase.none, // ✅ 保持原样
  fromJson: false,
  toJson: false,
)
class WorkflowState with _$WorkflowState {
  const factory WorkflowState.task(TaskState task) = TaskWorkflowState;
  const factory WorkflowState.pass(PassState pass) = PassWorkflowState;
  const factory WorkflowState.choice(ChoiceState choice) = ChoiceWorkflowState;
  const factory WorkflowState.succeed(SucceedState succeed) =
      SucceedWorkflowState;
  const factory WorkflowState.fail(FailState fail) = FailWorkflowState;
  const factory WorkflowState.wait(WaitState wait) = WaitWorkflowState;

  factory WorkflowState.fromJson(Map<String, dynamic> json) {
    final type = json['type'] as String;
    final content = Map<String, dynamic>.from(json)..remove('type');

    switch (type) {
      case 'task':
        return WorkflowState.task(TaskState.fromJson(content));
      case 'pass':
        return WorkflowState.pass(PassState.fromJson(content));
      case 'choice':
        return WorkflowState.choice(ChoiceState.fromJson(content));
      case 'succeed':
        return WorkflowState.succeed(SucceedState.fromJson(content));
      case 'fail':
        return WorkflowState.fail(FailState.fromJson(content));
      case 'wait':
        return WorkflowState.wait(WaitState.fromJson(content));
      default:
        throw UnsupportedError('Unsupported type: $type');
    }
  }

  const WorkflowState._();

  Map<String, dynamic> toJson() {
    return map(
      task: (task) => {'type': 'task', ...task.task.toJson()},
      pass: (pass) => {'type': 'pass', ...pass.pass.toJson()},
      choice: (choice) => {'type': 'choice', ...choice.choice.toJson()},
      succeed: (succeed) => {'type': 'succeed', ...succeed.succeed.toJson()},
      fail: (fail) => {'type': 'fail', ...fail.fail.toJson()},
      wait: (wait) => {'type': 'wait', ...wait.wait.toJson()},
    );
  }
}

// ✅ 扩展类型标识访问器（保持小写）
extension WorkflowStateX on WorkflowState {
  String get type => map(
        task: (_) => 'task',
        pass: (_) => 'pass',
        choice: (_) => 'choice',
        succeed: (_) => 'succeed',
        fail: (_) => 'fail',
        wait: (_) => 'wait',
      );
}

extension WorkflowStateCastX on WorkflowState {
  TaskState? asTask() => maybeMap(task: (t) => t.task, orElse: () => null);
  PassState? asPass() => maybeMap(pass: (p) => p.pass, orElse: () => null);
  ChoiceState? asChoice() =>
      maybeMap(choice: (c) => c.choice, orElse: () => null);
  SucceedState? asSucceed() =>
      maybeMap(succeed: (s) => s.succeed, orElse: () => null);
  FailState? asFail() => maybeMap(fail: (f) => f.fail, orElse: () => null);
  WaitState? asWait() => maybeMap(wait: (w) => w.wait, orElse: () => null);
}

extension WorkflowStateCast<T> on WorkflowState {
  T? asTyped<T>() {
    return map(
      task: (t) => T == TaskState ? t.task as T : null,
      pass: (p) => T == PassState ? p.pass as T : null,
      choice: (c) => T == ChoiceState ? c.choice as T : null,
      succeed: (s) => T == SucceedState ? s.succeed as T : null,
      fail: (f) => T == FailState ? f.fail as T : null,
      wait: (w) => T == WaitState ? w.wait as T : null,
    );
  }
}
