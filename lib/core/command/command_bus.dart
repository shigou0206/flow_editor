// lib/flow_editor/core/command/command_bus.dart
import 'command.dart';

class CommandBus {
  CommandBus._internal();
  static final CommandBus _inst = CommandBus._internal();
  factory CommandBus() => _inst;

  // 历史栈
  final List<UndoableCommand> _undoStack = [];
  final List<UndoableCommand> _redoStack = [];

  // ===== Dispatch =====
  void dispatch(Command cmd, {bool record = true}) {
    cmd.execute();

    // 只有支持撤销的才入栈
    if (record && cmd is UndoableCommand) {
      _undoStack.add(cmd);
      _redoStack.clear(); // 新命令使 redo 栈失效
    }
  }

  // ===== Undo / Redo =====
  bool canUndo() => _undoStack.isNotEmpty;
  bool canRedo() => _redoStack.isNotEmpty;

  void undo() {
    if (!canUndo()) return;
    final cmd = _undoStack.removeLast();
    cmd.undo();
    _redoStack.add(cmd);
  }

  void redo() {
    if (!canRedo()) return;
    final cmd = _redoStack.removeLast();
    cmd.redo();
    _undoStack.add(cmd);
  }

  // ===== Helpers =====
  void clearHistory() {
    _undoStack.clear();
    _redoStack.clear();
  }

  int get undoCount => _undoStack.length;
  int get redoCount => _redoStack.length;
}
