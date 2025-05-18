// test/behavior_core/behavior_manager_test.dart

import 'package:flutter_test/flutter_test.dart';
import 'dart:ui';

import 'package:flow_editor/core/input/behavior_core/behavior_manager.dart';
import 'package:flow_editor/core/input/behavior_core/canvas_behavior.dart';
import 'package:flow_editor/core/input/behavior_core/behavior_context.dart';
import 'package:flow_editor/core/input/event/input_event.dart';
import 'package:flow_editor/core/input/event/input_event_type.dart';
import 'package:flow_editor/core/models/state/canvas_state.dart';
import 'package:flow_editor/core/models/styles/canvas_interaction_config.dart';
import 'package:flow_editor/core/models/styles/canvas_visual_config.dart';
import 'package:flow_editor/core/models/state/canvas_interaction_state.dart';
import 'package:flow_editor/core/hit_test/canvas_hit_tester.dart';
import 'package:flow_editor/test/_helpers/fake_canvas_controller.dart';

/// 一个简单的假行为，用来测试调度逻辑
class FakeBehavior implements CanvasBehavior {
  @override
  final int priority;
  final bool Function(InputEvent ev, CanvasState state) _canHandle;

  bool handleCalled = false;
  InputEvent? lastEvent;
  BehaviorContext? lastContext;

  FakeBehavior({
    required this.priority,
    required bool Function(InputEvent, CanvasState) canHandle,
  }) : _canHandle = canHandle;

  @override
  bool canHandle(InputEvent ev, CanvasState state) => _canHandle(ev, state);

  @override
  void handle(InputEvent ev, BehaviorContext context) {
    handleCalled = true;
    lastEvent = ev;
    lastContext = context;
  }
}

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
  late CanvasState state;
  late BehaviorContext context;

  setUp(() {
    state = const CanvasState(
      interactionConfig: CanvasInteractionConfig(),
      visualConfig: CanvasVisualConfig(),
      interactionState: CanvasInteractionState(),
    );
    context = BehaviorContext(
      controller: FakeCanvasController(),
      getState: () => state,
      updateState: (s) => state = s,
      hitTester: DummyHitTester(),
    );
  });

  test('BehaviorManager calls first matching behavior and stops', () {
    final b1 = FakeBehavior(
      priority: 10,
      canHandle: (_, __) => false,
    );
    final b2 = FakeBehavior(
      priority: 20,
      canHandle: (_, __) => true,
    );
    final b3 = FakeBehavior(
      priority: 30,
      canHandle: (_, __) => true,
    );

    final manager = BehaviorManager([b1, b2, b3]);
    final ev = InputEvent.pointer(
      type: InputEventType.pointerDown,
      raw: null,
      canvasPos: const Offset(0, 0),
    );
    manager.handle(ev, context);

    expect(b1.handleCalled, isFalse);
    expect(b2.handleCalled, isTrue);
    expect(b3.handleCalled, isFalse);
    expect(b2.lastEvent, ev);
    expect(b2.lastContext, context);
  });

  test('BehaviorManager sorts behaviors by priority', () {
    final order = <int>[];
    final bLow = FakeBehavior(
      priority: 100,
      canHandle: (ev, st) {
        order.add(100);
        return false;
      },
    );
    final bHigh = FakeBehavior(
      priority: 10,
      canHandle: (ev, st) {
        order.add(10);
        return false;
      },
    );
    final manager = BehaviorManager([bLow, bHigh]);
    final ev = InputEvent.pointer(
      type: InputEventType.pointerDown,
      raw: null,
      canvasPos: const Offset(1, 1),
    );
    manager.handle(ev, context);

    expect(order, [10, 100],
        reason: 'Should invoke lower-priority-number first');
  });
}
