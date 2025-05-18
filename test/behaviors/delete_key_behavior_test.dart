// test/behavior_plugins/delete_key_behavior_test.dart

import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flow_editor/core/input/behavior_plugins/delete_key_behavior.dart';
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
  late FakeCanvasController controller;
  late BehaviorContext context;
  late CanvasState dummyState;
  late DeleteKeyBehavior behavior;

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
    behavior = DeleteKeyBehavior(context);
  });

  test('canHandle only on Delete key down', () {
    // other key
    var ev = InputEvent.key(
      type: InputEventType.keyDown,
      raw: const KeyDownEvent(
        physicalKey: PhysicalKeyboardKey.keyA,
        logicalKey: LogicalKeyboardKey.keyA,
        character: 'a',
        timeStamp: Duration.zero,
      ),
      key: LogicalKeyboardKey.keyA,
    );
    expect(behavior.canHandle(ev, dummyState), isFalse);

    // delete key up
    ev = InputEvent.key(
      type: InputEventType.keyUp,
      raw: const KeyUpEvent(
        physicalKey: PhysicalKeyboardKey.delete,
        logicalKey: LogicalKeyboardKey.delete,
        timeStamp: Duration.zero,
      ),
      key: LogicalKeyboardKey.delete,
    );
    expect(behavior.canHandle(ev, dummyState), isFalse);

    // delete key down
    ev = InputEvent.key(
      type: InputEventType.keyDown,
      raw: const KeyDownEvent(
        physicalKey: PhysicalKeyboardKey.delete,
        logicalKey: LogicalKeyboardKey.delete,
        timeStamp: Duration.zero,
      ),
      key: LogicalKeyboardKey.delete,
    );
    expect(behavior.canHandle(ev, dummyState), isTrue);
  });

  test('handle calls deleteSelection', () {
    final ev = InputEvent.key(
      type: InputEventType.keyDown,
      raw: const KeyDownEvent(
        physicalKey: PhysicalKeyboardKey.delete,
        logicalKey: LogicalKeyboardKey.delete,
        timeStamp: Duration.zero,
      ),
      key: LogicalKeyboardKey.delete,
    );
    behavior.handle(ev, context);
    expect(controller.didDelete, isTrue);
  });
}
