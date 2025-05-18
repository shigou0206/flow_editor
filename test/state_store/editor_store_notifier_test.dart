import 'package:flutter_test/flutter_test.dart';
import 'package:flow_editor/core/command/i_command.dart';
import 'package:flow_editor/core/state_management/state_store/editor_store_notifier.dart';
import 'package:flow_editor/core/state_management/state_store/editor_state.dart';
import 'package:flow_editor/core/models/state/canvas_viewport_state.dart';
import 'package:flow_editor/core/models/state/canvas_state.dart';
import 'package:flow_editor/core/models/state/node_state.dart';
import 'package:flow_editor/core/models/state/edge_state.dart';

/// 一个简单的测试命令：把 viewport.offset.dx +1
class IncrementOffsetXCommand implements ICommand {
  final EditorStoreNotifier _notifier;
  double _before = 0.0;

  IncrementOffsetXCommand(this._notifier);

  @override
  String get description => 'increment offsetX';

  @override
  Future<void> execute() async {
    final oldX = _notifier.state.viewport.offset.dx;
    _before = oldX;
    // 更新 notifier.state
    _notifier.state = _notifier.state.copyWith(
      viewport: _notifier.state.viewport.copyWith(offset: Offset(oldX + 1, 0)),
    );
  }

  @override
  Future<void> undo() async {
    _notifier.state = _notifier.state.copyWith(
      viewport: _notifier.state.viewport.copyWith(offset: Offset(_before, 0)),
    );
  }
}

class BadCommand implements ICommand {
  @override
  String get description => 'bad';
  @override
  Future<void> execute() => throw Exception('fail');
  @override
  Future<void> undo() async => fail('undo should not be called');
}

void main() {
  late EditorStoreNotifier notifier;

  setUp(() {
    // 直接用构造函数，不通过 ProviderContainer
    const initial = EditorState(
      canvases: {'w': CanvasState()},
      activeWorkflowId: 'w',
      nodes: NodeState(),
      edges: EdgeState(),
      viewport: CanvasViewportState(offset: Offset(0, 0)),
    );
    notifier = EditorStoreNotifier(initial);
  });

  test('initial canUndo/canRedo are false', () {
    expect(notifier.canUndo, isFalse);
    expect(notifier.canRedo, isFalse);
  });

  test('executeCommand updates state and enables undo', () async {
    final cmd = IncrementOffsetXCommand(notifier);
    await notifier.executeCommand(cmd);
    expect(notifier.state.viewport.offset.dx, equals(1.0));
    expect(notifier.canUndo, isTrue);
    expect(notifier.canRedo, isFalse);
  });

  test('undo reverts state and enables redo', () async {
    final cmd = IncrementOffsetXCommand(notifier);
    await notifier.executeCommand(cmd);
    await notifier.undo();
    expect(notifier.state.viewport.offset.dx, equals(0.0));
    expect(notifier.canUndo, isFalse);
    expect(notifier.canRedo, isTrue);
  });

  test('redo reapplies and disables redo', () async {
    final cmd = IncrementOffsetXCommand(notifier);
    await notifier.executeCommand(cmd);
    await notifier.undo();
    await notifier.redo();
    expect(notifier.state.viewport.offset.dx, equals(1.0));
    expect(notifier.canUndo, isTrue);
    expect(notifier.canRedo, isFalse);
  });

  test('clearHistory resets undo/redo', () async {
    final cmd1 = IncrementOffsetXCommand(notifier);
    await notifier.executeCommand(cmd1);
    notifier.clearHistory();
    expect(notifier.canUndo, isFalse);
    expect(notifier.canRedo, isFalse);
  });

  test('failed execute does not push to history', () async {
    await expectLater(
      () => notifier.executeCommand(BadCommand()),
      throwsException,
    );
    expect(notifier.canUndo, isFalse);
    expect(notifier.canRedo, isFalse);
  });
}
