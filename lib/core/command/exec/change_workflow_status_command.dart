import 'package:flow_editor/core/command/i_command.dart';
import 'package:flow_editor/core/command/command_context.dart';
import 'package:flow_editor/core/models/enums/execution_status.dart';
import 'package:flow_editor/core/models/state/canvas_state.dart';

/// 修改当前活跃 Workflow 的执行状态，并可选地更新 data 字段。
class ChangeWorkflowStatusCommand implements ICommand {
  final CommandContext ctx;
  final WorkflowStatus newStatus;
  final Map<String, dynamic>? newData;

  late final WorkflowStatus _oldStatus;
  late final Map<String, dynamic>? _oldData;

  ChangeWorkflowStatusCommand(
    this.ctx,
    this.newStatus, {
    this.newData,
  });

  @override
  String get description =>
      'Change workflow status to $newStatus${newData != null ? ' and update data' : ''}';

  @override
  Future<void> execute() async {
    // 从 EditorState 中获取 CanvasState（多工作流时取 activeWorkflowId 对应那份）
    final st = ctx.getState();
    final wfId = st.activeWorkflowId;
    final canvasState = st.canvases[wfId]!;

    // 保存旧状态和旧 data
    _oldStatus = canvasState.workflowStatus;
    _oldData = canvasState.data == null ? null : Map.of(canvasState.data!);

    // 构造新的 CanvasState
    var updated = canvasState.copyWith(
      workflowStatus: newStatus,
    );
    if (newData != null) {
      updated = updated.copyWith(data: newData);
    }

    // 将这一份 CanvasState 放回 map
    final newCanvases = Map<String, CanvasState>.from(st.canvases)
      ..[wfId] = updated;
    ctx.updateState(st.copyWith(canvases: newCanvases));
  }

  @override
  Future<void> undo() async {
    final st = ctx.getState();
    final wfId = st.activeWorkflowId;
    final canvasState = st.canvases[wfId]!;

    // 恢复旧状态与旧 data
    var restored = canvasState.copyWith(workflowStatus: _oldStatus);
    if (_oldData != null) {
      restored = restored.copyWith(data: _oldData);
    }

    final newCanvases = Map<String, CanvasState>.from(st.canvases)
      ..[wfId] = restored;
    ctx.updateState(st.copyWith(canvases: newCanvases));
  }
}
