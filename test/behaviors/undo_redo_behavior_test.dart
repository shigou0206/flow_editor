// test/behavior_plugins/undo_redo_behavior_test.dart

import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flow_editor/core/input/behavior_plugins/undo_redo_behavior.dart';
import 'package:flow_editor/core/input/behavior_core/behavior_context.dart';
import 'package:flow_editor/core/input/event/input_event.dart';
import 'package:flow_editor/core/input/event/input_event_type.dart';
import 'package:flow_editor/core/models/state/canvas_state.dart';
import 'package:flow_editor/core/models/state/canvas_interaction_state.dart';
import 'package:flow_editor/core/models/styles/canvas_interaction_config.dart';
import 'package:flow_editor/core/models/styles/canvas_visual_config.dart';
import 'package:flow_editor/core/hit_test/canvas_hit_tester.dart';
import 'package:flow_editor/test/_helpers/fake_canvas_controller.dart';

class DummyHitTester implements CanvasHitTester {
  @override
  String? hitTestAnchor(Offset pos) => null;
  @override
  String? hitTestEdge(Offset pos) => null;
  @override
  String? hitTestNode(Offset pos) => null;
  @override
  String? hitTestElement(Offset pos) => null;
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late FakeCanvasController controller;
  late BehaviorContext context;
  late CanvasState dummyState;
  late UndoRedoBehavior behavior;

  setUp(() {
    controller = FakeCanvasController();
    dummyState = const CanvasState(
      interactionConfig: CanvasInteractionConfig(),
      visualConfig: CanvasVisualConfig(),
      interactionState: CanvasInteractionState(),
    );
    context = BehaviorContext(
      controller: controller,
      getState: () => dummyState,
      updateState: (_) {},
      hitTester: DummyHitTester(),
    );
    behavior = UndoRedoBehavior(context);
  });

  group('canHandle', () {
    testWidgets('Ctrl+Z for undo', (tester) async {
      // 1) 按下 Ctrl
      await tester.sendKeyDownEvent(LogicalKeyboardKey.controlLeft);
      // 2) 发送 Z down
      final ev = InputEvent.key(
        type: InputEventType.keyDown,
        raw: const KeyDownEvent(
          physicalKey: PhysicalKeyboardKey.keyZ,
          logicalKey: LogicalKeyboardKey.keyZ,
          character: 'z',
          timeStamp: Duration.zero,
        ),
        key: LogicalKeyboardKey.keyZ,
      );
      expect(behavior.canHandle(ev, dummyState), isTrue);
    });

    testWidgets('Ctrl+Y for redo', (tester) async {
      await tester.sendKeyDownEvent(LogicalKeyboardKey.controlLeft);
      final ev = InputEvent.key(
        type: InputEventType.keyDown,
        raw: const KeyDownEvent(
          physicalKey: PhysicalKeyboardKey.keyY,
          logicalKey: LogicalKeyboardKey.keyY,
          character: 'y',
          timeStamp: Duration.zero,
        ),
        key: LogicalKeyboardKey.keyY,
      );
      expect(behavior.canHandle(ev, dummyState), isTrue);
    });

    testWidgets('other keys or no Ctrl not handled', (tester) async {
      // 不按 Ctrl，只按 Z
      final ev = InputEvent.key(
        type: InputEventType.keyDown,
        raw: const KeyDownEvent(
          physicalKey: PhysicalKeyboardKey.keyZ,
          logicalKey: LogicalKeyboardKey.keyZ,
          character: 'z',
          timeStamp: Duration.zero,
        ),
        key: LogicalKeyboardKey.keyZ,
      );
      expect(behavior.canHandle(ev, dummyState), isFalse);
    });
  });

  testWidgets('handle undo & redo correctly', (tester) async {
    // undo
    await tester.sendKeyDownEvent(LogicalKeyboardKey.controlLeft);
    var ev = InputEvent.key(
      type: InputEventType.keyDown,
      raw: const KeyDownEvent(
        physicalKey: PhysicalKeyboardKey.keyZ,
        logicalKey: LogicalKeyboardKey.keyZ,
        character: 'z',
        timeStamp: Duration.zero,
      ),
      key: LogicalKeyboardKey.keyZ,
    );
    behavior.handle(ev, context);
    expect(controller.didUndo, isTrue);

    // redo
    controller.didUndo = false;
    ev = InputEvent.key(
      type: InputEventType.keyDown,
      raw: const KeyDownEvent(
        physicalKey: PhysicalKeyboardKey.keyY,
        logicalKey: LogicalKeyboardKey.keyY,
        character: 'y',
        timeStamp: Duration.zero,
      ),
      key: LogicalKeyboardKey.keyY,
    );
    behavior.handle(ev, context);
    expect(controller.didRedo, isTrue);
  });
}
