// test/behaviors/node_drag_behavior_test.dart

import 'package:flutter_test/flutter_test.dart';
import 'package:flow_editor/core/input/behavior_core/behavior_context.dart';
import 'package:flow_editor/core/input/behavior_plugins/node_drag_behavior.dart';
import 'package:flow_editor/core/input/controller/canvas_controller.dart';
import 'package:flow_editor/core/input/event/input_event.dart';
import 'package:flow_editor/core/input/event/input_event_type.dart';
import 'package:flow_editor/core/models/state/canvas_state.dart';
import 'package:flow_editor/core/models/state/canvas_interaction_state.dart';
import 'package:flow_editor/core/models/styles/canvas_interaction_config.dart';
import 'package:flow_editor/core/models/styles/canvas_visual_config.dart';
import 'package:flow_editor/core/hit_test/canvas_hit_tester.dart';

// Fake controller to capture drag calls
class FakeController extends CanvasController {
  String? startedNodeId;
  Offset? lastDelta;
  bool endCalled = false;

  @override
  void startNodeDrag(String nodeId) {
    startedNodeId = nodeId;
  }

  @override
  void updateNodeDrag(Offset delta) {
    lastDelta = delta;
  }

  @override
  void endNodeDrag() {
    endCalled = true;
  }
}

// Dummy hit tester returning a node id on hitTestNode
class DummyHitTester implements CanvasHitTester {
  final String hitId;

  DummyHitTester(this.hitId);

  @override
  String? hitTestAnchor(Offset pos) => null;
  @override
  String? hitTestEdge(Offset pos) => null;
  @override
  String? hitTestNode(Offset pos) => hitId;
  @override
  String? hitTestElement(Offset pos) => null;
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
  late NodeDragBehavior behavior;
  const testNodeId = 'node123';

  setUp(() {
    ctrl = FakeController();
    state = const CanvasState(
      interactionConfig: CanvasInteractionConfig(),
      visualConfig: CanvasVisualConfig(),
      interactionState: CanvasInteractionState(isDraggingNode: false),
    );
    getState = () => state;
    setState = (s) => state = s;
    context = makeContext(
      controller: ctrl,
      getState: getState,
      updateState: setState,
      hitTester: DummyHitTester(testNodeId),
    );
    behavior = NodeDragBehavior(context);
  });

  test('canHandle pointerDown when node hit', () {
    final ev = InputEvent.pointer(
      type: InputEventType.pointerDown,
      raw: null,
      canvasPos: const Offset(10, 10),
    );
    expect(behavior.canHandle(ev, state), isTrue);
  });

  test('handle pointerDown starts node drag and updates interaction', () {
    final ev = InputEvent.pointer(
      type: InputEventType.pointerDown,
      raw: null,
      canvasPos: const Offset(10, 10),
    );
    behavior.handle(ev, context);
    expect(ctrl.startedNodeId, testNodeId);
    expect(state.interactionState.isDraggingNode, isTrue);
    expect(state.interactionState.draggingNodeId, testNodeId);
  });

  test('canHandle move and up when dragging', () {
    // simulate dragging
    state = state.copyWith(
      interactionState: const CanvasInteractionState(
        isDraggingNode: true,
        draggingNodeId: testNodeId,
      ),
    );
    final evMove = InputEvent.pointer(
      type: InputEventType.pointerMove,
      raw: null,
      canvasPos: const Offset(20, 20),
      canvasPosDelta: const Offset(10, 10),
    );
    expect(behavior.canHandle(evMove, state), isTrue);

    final evUp = InputEvent.pointer(
      type: InputEventType.pointerUp,
      raw: null,
      canvasPos: const Offset(20, 20),
    );
    expect(behavior.canHandle(evUp, state), isTrue);
  });

  test('handle pointerMove updates node drag', () {
    state = state.copyWith(
      interactionState: const CanvasInteractionState(isDraggingNode: true),
    );
    final evMove = InputEvent.pointer(
      type: InputEventType.pointerMove,
      raw: null,
      canvasPos: const Offset(30, 30),
      canvasPosDelta: const Offset(5, 5),
    );
    behavior.handle(evMove, context);
    expect(ctrl.lastDelta, const Offset(5, 5));
  });

  test('handle pointerUp ends node drag', () {
    state = state.copyWith(
      interactionState: const CanvasInteractionState(isDraggingNode: true),
    );
    final evUp = InputEvent.pointer(
      type: InputEventType.pointerUp,
      raw: null,
      canvasPos: const Offset(30, 30),
    );
    behavior.handle(evUp, context);
    expect(ctrl.endCalled, isTrue);
    expect(state.interactionState.isDraggingNode, isFalse);
    expect(state.interactionState.draggingNodeId, isNull);
  });
}
