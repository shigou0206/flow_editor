// test/behavior_plugins/copy_paste_behavior_test.dart
// ignore_for_file: deprecated_member_use

import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flow_editor/core/input/behavior_plugins/copy_paste_behavior.dart';
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
  // ⚠️ 必须先初始化绑定，才能正常使用 hardware_keyboard 的 isControlPressed()
  TestWidgetsFlutterBinding.ensureInitialized();

  late FakeCanvasController controller;
  late BehaviorContext context;
  late CanvasState dummyState;
  late CopyPasteBehavior behavior;

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
    behavior = CopyPasteBehavior(context);
  });

  group('canHandle', () {
    test('handles Ctrl+C', () {
      const raw = RawKeyDownEvent(
        data: RawKeyEventDataMacOs(
          modifiers: RawKeyEventDataMacOs.modifierControl,
          characters: 'c',
          charactersIgnoringModifiers: 'c',
          keyCode: 0,
        ),
        character: 'c',
      );
      final ev = InputEvent.key(
        type: InputEventType.keyDown,
        raw: raw,
        key: LogicalKeyboardKey.keyC,
      );
      expect(behavior.canHandle(ev, dummyState), isTrue);
    });

    test('handles Ctrl+V', () {
      const raw = RawKeyDownEvent(
        data: RawKeyEventDataMacOs(
          modifiers: RawKeyEventDataMacOs.modifierControl,
          characters: 'v',
          charactersIgnoringModifiers: 'v',
          keyCode: 0,
        ),
        character: 'v',
      );
      final ev = InputEvent.key(
        type: InputEventType.keyDown,
        raw: raw,
        key: LogicalKeyboardKey.keyV,
      );
      expect(behavior.canHandle(ev, dummyState), isTrue);
    });

    test('rejects without Control', () {
      const raw = RawKeyDownEvent(
        data: RawKeyEventDataMacOs(
          modifiers: 0,
          characters: 'c',
          charactersIgnoringModifiers: 'c',
          keyCode: 0,
        ),
        character: 'c',
      );
      final ev = InputEvent.key(
        type: InputEventType.keyDown,
        raw: raw,
        key: LogicalKeyboardKey.keyC,
      );
      expect(behavior.canHandle(ev, dummyState), isFalse);
    });
  });

  test('handle(copy) and handle(paste) invoke controller', () {
    // copy
    var raw = const RawKeyDownEvent(
      data: RawKeyEventDataMacOs(
        modifiers: RawKeyEventDataMacOs.modifierControl,
        characters: 'c',
        charactersIgnoringModifiers: 'c',
        keyCode: 0,
      ),
      character: 'c',
    );
    var ev = InputEvent.key(
      type: InputEventType.keyDown,
      raw: raw,
      key: LogicalKeyboardKey.keyC,
    );
    behavior.handle(ev, context);
    expect(controller.didCopy, isTrue);

    // paste
    controller.didCopy = false;
    raw = const RawKeyDownEvent(
      data: RawKeyEventDataMacOs(
        modifiers: RawKeyEventDataMacOs.modifierControl,
        characters: 'v',
        charactersIgnoringModifiers: 'v',
        keyCode: 0,
      ),
      character: 'v',
    );
    ev = InputEvent.key(
      type: InputEventType.keyDown,
      raw: raw,
      key: LogicalKeyboardKey.keyV,
    );
    behavior.handle(ev, context);
    expect(controller.didPaste, isTrue);
  });
}
