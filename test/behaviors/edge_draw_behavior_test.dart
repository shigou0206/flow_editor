// test/behaviors/edge_draw_behavior_test.dart

import 'package:flutter_test/flutter_test.dart';

import 'package:flow_editor/core/input/behavior_core/behavior_context.dart';
import 'package:flow_editor/core/input/behavior_plugins/edge_draw_behavior.dart';
import 'package:flow_editor/core/input/controller/canvas_controller.dart';
import 'package:flow_editor/core/input/event/input_event.dart';
import 'package:flow_editor/core/input/event/input_event_type.dart';
import 'package:flow_editor/core/models/state/canvas_state.dart';
import 'package:flow_editor/core/models/state/canvas_interaction_state.dart';
import 'package:flow_editor/core/models/styles/canvas_interaction_config.dart';
import 'package:flow_editor/core/models/styles/canvas_visual_config.dart';
import 'package:flow_editor/core/hit_test/canvas_hit_tester.dart';

// Fake controller to capture edge drag calls
class FakeController extends CanvasController {
  String? startedAnchorId;
  Offset? lastPos;
  bool endCalled = false;

  @override
  void startEdgeDrag(String anchorId) {
    startedAnchorId = anchorId;
  }

  @override
  void updateEdgeDrag(Offset pos) {
    lastPos = pos;
  }

  @override
  void endEdgeDrag({String? targetNodeId, String? targetAnchorId}) {
    endCalled = true;
  }
}

// Dummy hit tester returning an anchor id on hitTestAnchor
class DummyHitTester implements CanvasHitTester {
  final String anchorId;

  DummyHitTester(this.anchorId);

  @override
  String? hitTestAnchor(Offset pos) => anchorId;
  @override
  String? hitTestNode(Offset pos) => null;
  @override
  String? hitTestEdge(Offset pos) => null;
  @override
  String? hitTestElement(Offset pos) => anchorId;
}

BehaviorContext makeContext({
  required CanvasController controller,
  required CanvasState Function() getState,
  required void Function(CanvasState) updateState,
  required CanvasHitTester hitTester,
}) {
  return BehaviorContext(
    controller: controller,
    getState: getState,
    updateState: updateState,
    hitTester: hitTester,
  );
}

void main() {
  late FakeController ctrl;
  late CanvasState state;
  late CanvasState Function() getState;
  late void Function(CanvasState) setState;
  late BehaviorContext context;
  late EdgeDrawBehavior behavior;
  const testAnchorId = 'anchorA';

  setUp(() {
    ctrl = FakeController();
    state = const CanvasState(
      interactionConfig: CanvasInteractionConfig(),
      visualConfig: CanvasVisualConfig(),
      interactionState: CanvasInteractionState(isDraggingEdge: false),
    );
    getState = () => state;
    setState = (s) => state = s;
    context = makeContext(
      controller: ctrl,
      getState: getState,
      updateState: setState,
      hitTester: DummyHitTester(testAnchorId),
    );
    behavior = EdgeDrawBehavior(context);
  });

  test('canHandle pointerDown when anchor hit', () {
    final ev = InputEvent.pointer(
      type: InputEventType.pointerDown,
      raw: null,
      canvasPos: const Offset(0, 0),
    );
    expect(behavior.canHandle(ev, state), isTrue);
  });

  test('handle pointerDown starts edge drag and updates interaction', () {
    final ev = InputEvent.pointer(
      type: InputEventType.pointerDown,
      raw: null,
      canvasPos: const Offset(5, 5),
    );
    behavior.handle(ev, context);
    expect(ctrl.startedAnchorId, testAnchorId);
    expect(state.interactionState.isDraggingEdge, isTrue);
    expect(state.interactionState.drawingFromAnchorId, testAnchorId);
  });

  test('canHandle move and up when dragging edge', () {
    state = state.copyWith(
      interactionState: state.interactionState.copyWith(
        isDraggingEdge: true,
        drawingFromAnchorId: testAnchorId,
      ),
    );
    final evMove = InputEvent.pointer(
      type: InputEventType.pointerMove,
      raw: null,
      canvasPos: const Offset(10, 10),
    );
    expect(behavior.canHandle(evMove, state), isTrue);

    final evUp = InputEvent.pointer(
      type: InputEventType.pointerUp,
      raw: null,
      canvasPos: const Offset(10, 10),
    );
    expect(behavior.canHandle(evUp, state), isTrue);
  });

  test('handle pointerMove updates edge drag', () {
    state = state.copyWith(
      interactionState: state.interactionState.copyWith(isDraggingEdge: true),
    );
    final evMove = InputEvent.pointer(
      type: InputEventType.pointerMove,
      raw: null,
      canvasPos: const Offset(20, 20),
    );
    behavior.handle(evMove, context);
    expect(ctrl.lastPos, const Offset(20, 20));
  });

  test('handle pointerUp ends edge drag', () {
    state = state.copyWith(
      interactionState: state.interactionState.copyWith(isDraggingEdge: true),
    );
    final evUp = InputEvent.pointer(
      type: InputEventType.pointerUp,
      raw: null,
      canvasPos: const Offset(20, 20),
    );
    behavior.handle(evUp, context);
    expect(ctrl.endCalled, isTrue);
    expect(state.interactionState.isDraggingEdge, isFalse);
    expect(state.interactionState.drawingFromAnchorId, isNull);
  });
}
