// test/command/composite_command_test.dart

import 'package:flutter_test/flutter_test.dart';
import 'package:flow_editor/core/command/i_command.dart';

class FakeCommand implements ICommand {
  final List<String> log;
  final String name;
  FakeCommand(this.log, this.name);

  @override
  String get description => name;

  @override
  Future<void> execute() async {
    log.add('$name:execute');
  }

  @override
  Future<void> undo() async {
    log.add('$name:undo');
  }
}

void main() {
  test('CompositeCommand executes and undoes in correct order', () async {
    final log = <String>[];

    final c1 = FakeCommand(log, 'c1');
    final c2 = FakeCommand(log, 'c2');
    final composite = CompositeCommand('macro', [c1, c2]);

    await composite.execute();
    expect(log, ['c1:execute', 'c2:execute']);

    log.clear();
    await composite.undo();
    expect(log, ['c2:undo', 'c1:undo']);
  });
}
