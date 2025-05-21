import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flow_editor/core/command/command_context.dart';
import 'package:flow_editor/core/command/command_manager.dart';
import 'package:flow_editor/core/command/i_command.dart';
import 'package:flow_editor/core/models/state/selection_state.dart';
import 'package:flow_editor/core/models/state/editor_state.dart';

/// EditorState 的单 workflow 管理器，支持命令/撤销/选区等
class EditorStoreNotifier extends StateNotifier<EditorState> {
  late final CommandContext _commandContext;
  late final CommandManager _commandManager;

  EditorStoreNotifier(super.initialState) {
    _commandContext = CommandContext(
      getState: () => state,
      updateState: (newState) => state = newState,
    );
    _commandManager = CommandManager(_commandContext);
  }

  CommandContext get commandContext => _commandContext;

  // ———— 选区相关 ————

  SelectionState get selection => state.selection;

  void setSelection(SelectionState newSelection) {
    state = state.copyWith(selection: newSelection);
  }

  // ———— 撤销/重做 ————

  Future<void> executeCommand(ICommand cmd) =>
      _commandManager.executeCommand(cmd);

  Future<void> undo() => _commandManager.undo();

  Future<void> redo() => _commandManager.redo();

  void clearHistory() => _commandManager.clearHistory();

  bool get canUndo => _commandManager.canUndo;
  bool get canRedo => _commandManager.canRedo;

  void replaceState(EditorState newState) {
    state = newState;
  }
}
