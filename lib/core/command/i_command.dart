abstract class ICommand {
  Future<void> execute();

  Future<void> undo();

  String get description;
}

class CompositeCommand implements ICommand {
  @override
  final String description;
  final List<ICommand> _commands;

  CompositeCommand(this.description, this._commands);

  @override
  Future<void> execute() async {
    for (final cmd in _commands) {
      await cmd.execute();
    }
  }

  @override
  Future<void> undo() async {
    // 反向撤销
    for (final cmd in _commands.reversed) {
      await cmd.undo();
    }
  }
}
