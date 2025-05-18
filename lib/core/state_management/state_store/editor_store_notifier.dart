// lib/core/state_management/state_store/editor_store_notifier.dart

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flow_editor/core/command/command_context.dart';
import 'package:flow_editor/core/command/command_manager.dart';
import 'package:flow_editor/core/command/i_command.dart';
import 'package:flow_editor/core/controller/impl/canvas_controller_impl.dart';
import 'package:flow_editor/core/models/state/selection_state.dart';
import 'package:flow_editor/core/state_management/state_store/editor_state.dart';
import 'package:flow_editor/core/controller/canvas_controller_interface.dart';

/// StateNotifier for EditorState, integrating undo/redo via CommandManager.
class EditorStoreNotifier extends StateNotifier<EditorState> {
  late final CommandContext _commandContext;
  late final CommandManager _commandManager;

  /// 构造时，传入一个包含所有必需字段的 [initialState]（尤其要带上 selection）
  EditorStoreNotifier(super.initialState) {
    _commandContext = CommandContext(
      controller: CanvasController(_commandContext), // 只要一个 ctx
      getState: () => state,
      updateState: (newState) => state = newState,
    );
    _commandManager = CommandManager(_commandContext);
  }

  /// 如果你需要更底层的能力，可以拿到整个 CommandContext
  CommandContext get commandContext => _commandContext;

  /// 最常用的入口：直接拿到聚合后的 CanvasController
  ICanvasController get controller => _commandContext.controller;

  // ———— 选区 相关 ————

  /// 当前活跃工作流的选区
  SelectionState get selection => state.selection;

  /// 设置新的选区（节点/边），会触发界面刷新
  void setSelection(SelectionState newSelection) {
    state = state.copyWith(selection: newSelection);
  }

  /// 切换至另一个 workflow，示例中同时重置选区
  void switchWorkflow(String newWorkflowId) {
    state = state.copyWith(
      activeWorkflowId: newWorkflowId,
      selection: const SelectionState(),
    );
  }

  // ———— 撤销/重做/清空 ————

  /// 执行一个命令，并将其纳入 undo 历史
  Future<void> executeCommand(ICommand cmd) =>
      _commandManager.executeCommand(cmd);

  /// 撤销上一个命令
  Future<void> undo() => _commandManager.undo();

  /// 重做上一次被撤销的命令
  Future<void> redo() => _commandManager.redo();

  /// 清空 undo/redo 历史
  void clearHistory() => _commandManager.clearHistory();

  bool get canUndo => _commandManager.canUndo;
  bool get canRedo => _commandManager.canRedo;
}
