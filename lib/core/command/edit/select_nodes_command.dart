// lib/core/command/edit/select_nodes_command.dart

import 'package:flow_editor/core/command/i_command.dart';
import 'package:flow_editor/core/command/command_context.dart';
import 'package:flow_editor/core/models/ui_state/selection_state.dart';

/// A command that selects the given [nodeIds] in the active workflow.
class SelectNodesCommand implements ICommand {
  final CommandContext ctx;
  final Set<String> nodeIds;

  /// Holds the selection state *before* each execute, so we can undo.
  SelectionState? _before;

  SelectNodesCommand(this.ctx, this.nodeIds);

  @override
  String get description => 'Select nodes: ${nodeIds.join(',')}';

  @override
  Future<void> execute() async {
    final st = ctx.getState();

    // snapshot the prior selection
    _before = st.selection;

    // apply new selection for active workflow
    final newSelection = st.selection.copyWith(nodeIds: nodeIds);
    ctx.updateState(st.copyWith(selection: newSelection));
  }

  @override
  Future<void> undo() async {
    final st = ctx.getState();
    if (_before == null) return; // nothing to undo

    // restore previous selection
    ctx.updateState(st.copyWith(selection: _before!));
  }
}
