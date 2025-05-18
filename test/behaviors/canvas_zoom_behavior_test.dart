// test/behaviors/canvas_zoom_behavior_test.dart

import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/gestures.dart';

import 'package:flow_editor/core/input/behavior_core/behavior_context.dart';
import 'package:flow_editor/core/input/behavior_plugins/canvas_zoom_behavior.dart';
import 'package:flow_editor/core/controller/canvas_controller_interface.dart';
import 'package:flow_editor/core/input/event/input_event.dart';
import 'package:flow_editor/core/input/event/input_event_type.dart';
import 'package:flow_editor/core/models/state/canvas_state.dart';
import 'package:flow_editor/core/models/styles/canvas_interaction_config.dart';
import 'package:flow_editor/core/models/styles/canvas_visual_config.dart';
import 'package:flow_editor/core/hit_test/canvas_hit_tester.dart';
import 'package:flow_editor/test/_helpers/fake_canvas_controller.dart';

// Dummy hit tester not used in zoom
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
  late CanvasZoomBehavior behavior;

  setUp(() {
    ctrl = FakeCanvasController();
    state = const CanvasState(
      interactionConfig: CanvasInteractionConfig(enableZoom: true),
      visualConfig: CanvasVisualConfig(),
    );
    getState = () => state;
    setState = (s) => state = s;
    context = makeContext(
      controller: ctrl,
      getState: getState,
      updateState: setState,
    );
    behavior = CanvasZoomBehavior(context);
  });

  test('canHandle returns true for pointerSignal when zoom enabled', () {
    const scrollEvent = PointerScrollEvent(
      position: Offset(30, 40),
      scrollDelta: Offset(0, 20),
    );
    final ev = InputEvent.pointer(
      type: InputEventType.pointerSignal,
      raw: scrollEvent,
      canvasPos: const Offset(15, 25),
    );
    expect(behavior.canHandle(ev, state), isTrue);
  });

  test('canHandle returns false for pointerSignal when zoom disabled', () {
    state = state.copyWith(
      interactionConfig: const CanvasInteractionConfig(enableZoom: false),
    );
    const scrollEvent = PointerScrollEvent(
      position: Offset(0, 0),
      scrollDelta: Offset(0, -10),
    );
    final ev = InputEvent.pointer(
      type: InputEventType.pointerSignal,
      raw: scrollEvent,
      canvasPos: const Offset(0, 0),
    );
    expect(behavior.canHandle(ev, state), isFalse);
  });

  test('handle applies zoomAt with correct delta and focal', () {
    const scrollEvent = PointerScrollEvent(
      position: Offset(50, 60),
      scrollDelta: Offset(0, 50),
    );
    const canvasPos = Offset(25, 35);
    final ev = InputEvent.pointer(
      type: InputEventType.pointerSignal,
      raw: scrollEvent,
      canvasPos: canvasPos,
    );

    behavior.handle(ev, context);

    // Delta is -scrollDelta.dy * 0.001 -> -50 * 0.001 = -0.05
    expect(ctrl.lastFocal, canvasPos);
    expect(ctrl.lastDelta, closeTo(-0.05, 1e-6));
  });

  test('handle does nothing for non-pointerSignal events', () {
    final ev = InputEvent.pointer(
      type: InputEventType.pointerDown,
      raw: null,
      canvasPos: const Offset(10, 10),
    );
    behavior.handle(ev, context);
    expect(ctrl.lastFocal, isNull);
    expect(ctrl.lastDelta, isNull);
  });
}
