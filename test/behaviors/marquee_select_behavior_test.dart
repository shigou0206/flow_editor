// test/behaviors/marquee_select_behavior_test.dart

import 'package:flutter_test/flutter_test.dart';
import 'dart:ui';

import 'package:flow_editor/core/input/behavior_core/behavior_context.dart';
import 'package:flow_editor/core/input/behavior_plugins/marquee_select_behavior.dart';
import 'package:flow_editor/core/input/event/input_event.dart';
import 'package:flow_editor/core/input/event/input_event_type.dart';
import 'package:flow_editor/core/models/state/canvas_state.dart';
import 'package:flow_editor/core/models/state/canvas_interaction_state.dart';
import 'package:flow_editor/core/hit_test/canvas_hit_tester.dart';
import 'package:flow_editor/core/models/styles/canvas_visual_config.dart';
import 'package:flow_editor/core/models/styles/canvas_interaction_config.dart';
import 'package:flow_editor/test/_helpers/fake_canvas_controller.dart';
import 'package:flow_editor/core/controller/canvas_controller_interface.dart';

// Dummy hit tester returning null always (blank canvas)
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

BehaviorContext makeContext({
  required ICanvasController controller,
  required CanvasState Function() getState,
  required void Function(CanvasState) updateState,
}) {
  return BehaviorContext(
    controller: controller,
    getState: getState,
    updateState: updateState,
    hitTester: DummyHitTester(),
  );
}

void main() {
  late FakeCanvasController ctrl;
  late CanvasState state;
  late CanvasState Function() getState;
  late void Function(CanvasState) setState;
  late BehaviorContext context;
  late MarqueeSelectBehavior behavior;

  setUp(() {
    ctrl = FakeCanvasController();
    state = const CanvasState(
      interactionConfig: CanvasInteractionConfig(enableMarqueeSelect: true),
      visualConfig: CanvasVisualConfig(),
      interactionState: CanvasInteractionState(marqueeRect: null),
    );
    getState = () => state;
    setState = (s) => state = s;
    context = makeContext(
      controller: ctrl,
      getState: getState,
      updateState: setState,
    );
    behavior = MarqueeSelectBehavior(context);
  });

  test('canHandle pointerDown when blank canvas', () {
    final ev = InputEvent.pointer(
      type: InputEventType.pointerDown,
      raw: null,
      canvasPos: const Offset(5, 5),
    );
    expect(behavior.canHandle(ev, state), isTrue);
  });

  test('handle pointerDown sets marqueeRect start', () {
    final ev = InputEvent.pointer(
      type: InputEventType.pointerDown,
      raw: null,
      canvasPos: const Offset(5, 5),
    );
    behavior.handle(ev, context);
    expect(state.interactionState.marqueeRect?.topLeft, const Offset(5, 5));
    expect(state.interactionState.marqueeRect?.bottomRight, const Offset(5, 5));
  });

  test('canHandle pointerMove when marquee active', () {
    state = state.copyWith(
      interactionState: const CanvasInteractionState(
        marqueeRect: Rect.fromLTWH(5, 5, 0, 0),
      ),
    );
    final evMove = InputEvent.pointer(
      type: InputEventType.pointerMove,
      raw: null,
      canvasPos: const Offset(15, 20),
    );
    expect(behavior.canHandle(evMove, state), isTrue);
  });

  test('handle pointerMove updates marquee and calls controller', () {
    // simulate started marquee
    state = state.copyWith(
      interactionState: const CanvasInteractionState(
        marqueeRect: Rect.fromLTWH(5, 5, 0, 0),
      ),
    );
    final evMove = InputEvent.pointer(
      type: InputEventType.pointerMove,
      raw: null,
      canvasPos: const Offset(15, 20),
    );
    behavior.handle(evMove, context);
    // controller should be called with new rect
    expect(ctrl.lastRect,
        Rect.fromPoints(const Offset(5, 5), const Offset(15, 20)));
    // state updated
    expect(state.interactionState.marqueeRect,
        Rect.fromPoints(const Offset(5, 5), const Offset(15, 20)));
  });

  test('handle pointerUp clears marqueeRect and calls controller clear', () {
    state = state.copyWith(
      interactionState: const CanvasInteractionState(
        marqueeRect: Rect.fromLTWH(5, 5, 0, 0),
      ),
    );
    final evUp = InputEvent.pointer(
      type: InputEventType.pointerUp,
      raw: null,
      canvasPos: const Offset(15, 20),
    );
    behavior.handle(evUp, context);
    // state cleared
    expect(state.interactionState.marqueeRect, isNull);
    // controller called with zero rect
    expect(ctrl.lastRect, Rect.zero);
  });
}
