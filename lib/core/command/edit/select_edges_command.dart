// lib/core/command/edit/select_edges_command.dart

import 'package:flow_editor/core/command/i_command.dart';
import 'package:flow_editor/core/command/command_context.dart';
import 'package:flow_editor/core/models/ui_state/selection_state.dart';

/// 选中一组边，替换当前的选区为仅包含这些边
class SelectEdgesCommand implements ICommand {
  final CommandContext ctx;
  final Set<String> edgeIds;

  late final SelectionState _before;
  late final SelectionState _after;

  SelectEdgesCommand(this.ctx, this.edgeIds);

  @override
  String get description => 'Select edges $edgeIds';

  @override
  Future<void> execute() async {
    final st = ctx.getState();
    // 保存执行前的选区
    _before = st.selection;
    // 构建新的选区，只包含这次要选的边
    _after = SelectionState(nodeIds: {}, edgeIds: edgeIds);
    // 更新状态
    ctx.updateState(st.copyWith(selection: _after));
  }

  @override
  Future<void> undo() async {
    final st = ctx.getState();
    // 恢复到执行前的选区
    ctx.updateState(st.copyWith(selection: _before));
  }
}
