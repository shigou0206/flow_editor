// lib/core/controller/selection_controller_impl.dart

import 'package:flow_editor/core/command/command_context.dart';
import 'package:flow_editor/core/command/command_manager.dart';
import 'package:flow_editor/core/command/edit/select_nodes_command.dart';
import 'package:flow_editor/core/command/edit/select_edges_command.dart';
import 'package:flow_editor/core/command/edit/clear_selection_command.dart';
import 'package:flow_editor/core/controller/selection_controller_interface.dart';

/// 基于命令模式的选区控制器实现
class SelectionControllerImpl implements ISelectionController {
  final CommandManager _commandManager;
  final CommandContext _ctx;

  SelectionControllerImpl(CommandContext ctx)
      : _ctx = ctx,
        _commandManager = CommandManager(ctx);

  @override
  Future<void> selectNodes(Set<String> nodeIds) {
    return _commandManager.executeCommand(
      SelectNodesCommand(_ctx, nodeIds),
    );
  }

  @override
  Future<void> selectEdges(Set<String> edgeIds) {
    return _commandManager.executeCommand(
      SelectEdgesCommand(_ctx, edgeIds),
    );
  }

  @override
  Future<void> clearSelection() {
    return _commandManager.executeCommand(
      ClearSelectionCommand(_ctx),
    );
  }
}
