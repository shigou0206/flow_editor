import 'package:flutter_test/flutter_test.dart';
import 'package:flow_editor/core/command/i_command.dart';

/// 一个最简单的 ICommand 实现，用来测试接口契约
class NoOpCommand implements ICommand {
  bool executed = false;
  bool undone = false;

  @override
  Future<void> execute() async {
    executed = true;
  }

  @override
  Future<void> undo() async {
    if (!executed) {
      throw StateError('cannot undo before execute');
    }
    undone = true;
  }

  @override
  String get description => 'no-op';
}

void main() {
  group('ICommand interface', () {
    test('execute flips executed flag', () async {
      final cmd = NoOpCommand();
      expect(cmd.executed, isFalse);
      await cmd.execute();
      expect(cmd.executed, isTrue);
    });

    test('undo flips undone flag after execute', () async {
      final cmd = NoOpCommand();
      await cmd.execute();
      expect(cmd.undone, isFalse);
      await cmd.undo();
      expect(cmd.undone, isTrue);
    });

    test('undo before execute throws', () async {
      final cmd = NoOpCommand();
      expect(() => cmd.undo(), throwsA(isA<StateError>()));
    });

    test('description is non-empty', () {
      final cmd = NoOpCommand();
      expect(cmd.description, isNotEmpty);
    });
  });
}
