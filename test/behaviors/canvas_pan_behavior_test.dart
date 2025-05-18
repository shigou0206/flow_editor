// test/behaviors/canvas_pan_behavior_test.dart

import 'package:flutter_test/flutter_test.dart';
import 'dart:ui';

import 'package:flow_editor/core/input/behavior_core/behavior_context.dart';
import 'package:flow_editor/core/input/behavior_plugins/canvas_pan_behavior.dart';
import 'package:flow_editor/core/input/controller/canvas_controller.dart';
import 'package:flow_editor/core/input/event/input_event.dart';
import 'package:flow_editor/core/input/event/input_event_type.dart';
import 'package:flow_editor/core/models/state/canvas_state.dart';
import 'package:flow_editor/core/models/state/canvas_interaction_state.dart';
import 'package:flow_editor/core/models/styles/canvas_interaction_config.dart';
import 'package:flow_editor/core/models/styles/canvas_visual_config.dart';
import 'package:flow_editor/core/hit_test/canvas_hit_tester.dart';

// 1. Fake CanvasController：记录 panBy 调用
class FakeController extends CanvasController {
  Offset? lastPanDelta;
  @override
  void panBy(Offset delta) {
    lastPanDelta = delta;
  }
}

// 2. Dummy HitTester：始终不命中任何元素，以便测试纯 pan 逻辑
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

// 3. 创建 BehaviorContext 工厂
BehaviorContext makeContext({
  required CanvasController controller,
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
  late FakeController ctrl;
  late CanvasState state;
  late CanvasState Function() getState;
  late void Function(CanvasState) setState;
  late BehaviorContext context;
  late CanvasPanBehavior behavior;

  setUp(() {
    ctrl = FakeController();
    state = const CanvasState(
      interactionConfig: CanvasInteractionConfig(enablePan: true),
      visualConfig: CanvasVisualConfig(),
      interactionState: CanvasInteractionState(isPanning: false),
    );
    getState = () => state;
    setState = (s) => state = s;
    context = makeContext(
      controller: ctrl,
      getState: getState,
      updateState: setState,
    );
    behavior = CanvasPanBehavior(context);
  });

  test('can start panning on pointerDown when empty canvas', () {
    final ev = InputEvent.pointer(
      type: InputEventType.pointerDown,
      raw: null,
      canvasPos: const Offset(50, 50),
    );
    expect(behavior.canHandle(ev, state), isTrue);
    behavior.handle(ev, context);
    expect(state.interactionState.isPanning, isTrue);
    expect(state.interactionState.panStartPos, const Offset(50, 50));
  });

  test('panBy is called on pointerMove when panning', () {
    // Simulate already panning
    state = state.copyWith(
      interactionState: state.interactionState.copyWith(
        isPanning: true,
        panStartPos: const Offset(10, 10),
      ),
    );
    final evMove = InputEvent.pointer(
      type: InputEventType.pointerMove,
      raw: null,
      canvasPos: const Offset(20, 20),
      canvasPosDelta: const Offset(10, 10),
    );
    expect(behavior.canHandle(evMove, state), isTrue);
    behavior.handle(evMove, context);
    expect(ctrl.lastPanDelta, const Offset(10, 10));
  });

  test('stops panning on pointerUp', () {
    state = state.copyWith(
      interactionState: state.interactionState.copyWith(isPanning: true),
    );
    final evUp = InputEvent.pointer(
      type: InputEventType.pointerUp,
      raw: null,
      canvasPos: const Offset(20, 20),
    );
    expect(behavior.canHandle(evUp, state), isTrue);
    behavior.handle(evUp, context);
    expect(state.interactionState.isPanning, isFalse);
    expect(state.interactionState.panStartPos, isNull);
  });

  test('does not handle pointerDown when pan disabled', () {
    state = state.copyWith(
      interactionConfig: const CanvasInteractionConfig(enablePan: false),
    );
    final evDown = InputEvent.pointer(
      type: InputEventType.pointerDown,
      raw: null,
      canvasPos: const Offset(10, 10),
    );
    expect(behavior.canHandle(evDown, state), isFalse);
  });
}
