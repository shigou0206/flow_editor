import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'canvas_command.dart';

/// 管理命令历史，实现 dispatch/undo/redo
class CommandDispatcher {
  final List<CanvasCommand> _history = [];
  int _index = -1;

  void dispatch(WidgetRef ref, CanvasCommand cmd) {
    // 丢弃“未来”命令
    if (_index < _history.length - 1) {
      _history.removeRange(_index + 1, _history.length);
    }
    cmd.execute(ref);
    _history.add(cmd);
    _index++;
  }

  void undo(WidgetRef ref) {
    if (_index >= 0) {
      _history[_index].undo(ref);
      _index--;
    }
  }

  void redo(WidgetRef ref) {
    if (_index + 1 < _history.length) {
      _index++;
      _history[_index].execute(ref);
    }
  }

  bool get canUndo => _index >= 0;
  bool get canRedo => _index < _history.length - 1;
}
