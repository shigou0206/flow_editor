// lib/flow_editor/core/command/command.dart
/// 所有命令都需要执行一次 mutate。
abstract class Command {
  void execute();
}

/// 如果命令支持撤销/重做，则实现此接口。
abstract class UndoableCommand implements Command {
  /// 回滚 execute 的变更
  void undo();

  /// 默认调用 execute 重做；如逻辑不同可重写
  void redo() => execute();
}

/// 可选：命令类型标签，方便日志 / 调试
enum CommandType {
  moveAttachment,
  removeAttachment,
  // … 其它命令类型
}
