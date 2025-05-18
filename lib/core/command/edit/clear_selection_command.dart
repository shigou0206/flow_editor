// lib/core/command/edit/clear_selection_command.dart

import 'package:flow_editor/core/command/i_command.dart';
import 'package:flow_editor/core/command/command_context.dart';
import 'package:flow_editor/core/models/state/selection_state.dart';

/// 清空当前工作流下所有节点和边的选中状态
class ClearSelectionCommand implements ICommand {
  final CommandContext ctx;

  /// 执行前的 selection，仅在第一次执行时初始化
  late final SelectionState _before;
  bool _hasRecorded = false;

  ClearSelectionCommand(this.ctx);

  @override
  String get description => 'Clear selection';

  @override
  Future<void> execute() async {
    // 取当前 EditorState
    final st = ctx.getState();

    // 仅在第一次执行（不论是 execute 还是 redo）时记录 _before
    if (!_hasRecorded) {
      _before = st.selection;
      _hasRecorded = true;
    }

    // 清空当前 selection
    ctx.updateState(
      st.copyWith(selection: const SelectionState()),
    );
  }

  @override
  Future<void> undo() async {
    // 恢复执行前的 selection
    final st = ctx.getState();
    ctx.updateState(
      st.copyWith(selection: _before),
    );
  }
}
