import 'i_command.dart';
import 'command_context.dart';

class CommandManager {
  final CommandContext context;

  final List<ICommand> _undoStack = [];

  final List<ICommand> _redoStack = [];

  CommandManager(this.context);

  Future<void> executeCommand(ICommand cmd) async {
    try {
      await cmd.execute();
      _undoStack.add(cmd);
      _redoStack.clear();
    } catch (e) {
      try {
        await cmd.undo();
      } catch (_) {}
      rethrow;
    }
  }

  /// 是否可以撤销
  bool get canUndo => _undoStack.isNotEmpty;

  /// 是否可以重做
  bool get canRedo => _redoStack.isNotEmpty;

  /// 撤销最近一次执行的命令
  Future<void> undo() async {
    if (!canUndo) return;
    final cmd = _undoStack.removeLast();
    await cmd.undo();
    _redoStack.add(cmd);
  }

  /// 重做最近一次被撤销的命令
  Future<void> redo() async {
    if (!canRedo) return;
    final cmd = _redoStack.removeLast();
    await cmd.execute();
    _undoStack.add(cmd);
  }

  /// 清空所有历史
  void clearHistory() {
    _undoStack.clear();
    _redoStack.clear();
  }
}
