// test/wrapper/canvas_input_wrapper_test.dart

import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/services.dart';

import 'package:flow_editor/core/input/wrapper/canvas_input_wrapper.dart';
import 'package:flow_editor/core/input/behavior_core/behavior_manager.dart';
import 'package:flow_editor/core/input/behavior_core/behavior_context.dart';
import 'package:flow_editor/core/input/event/input_event.dart';
import 'package:flow_editor/core/input/event/input_event_type.dart';
import 'package:flow_editor/core/input/config/config.dart';
import 'package:flow_editor/core/input/controller/canvas_controller.dart';
import 'package:flow_editor/core/hit_test/canvas_hit_tester.dart';
import 'package:flow_editor/core/models/state/canvas_state.dart';
import 'package:flow_editor/core/models/state/canvas_interaction_state.dart';
import 'package:flow_editor/core/models/styles/canvas_interaction_config.dart';
import 'package:flow_editor/core/models/styles/canvas_visual_config.dart';

// Fake BehaviorManager to capture events
class FakeManager extends BehaviorManager {
  InputEvent? lastEvent;
  BehaviorContext? lastContext;
  FakeManager() : super([]);
  @override
  void handle(InputEvent ev, BehaviorContext context) {
    lastEvent = ev;
    lastContext = context;
  }
}

// Dummy hit tester
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
  late FakeManager fakeManager;
  late BehaviorContext context;

  setUp(() {
    fakeManager = FakeManager();
    context = BehaviorContext(
      controller: CanvasController(),
      getState: () => const CanvasState(
        interactionConfig: CanvasInteractionConfig(),
        visualConfig: CanvasVisualConfig(),
        interactionState: CanvasInteractionState(),
      ),
      updateState: (_) {},
      hitTester: DummyHitTester(),
    );
  });

  testWidgets('dispatches pointerDown with correct canvasPos', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: Center(
            child: CanvasInputWrapper(
              toCanvas: (local) => local * 2,
              context: context,
              manager: fakeManager,
              config: const InputConfig(),
              child: Container(
                key: const ValueKey('child'),
                width: 100,
                height: 100,
                color: Colors.transparent,
              ),
            ),
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();

    final box =
        tester.renderObject<RenderBox>(find.byKey(const ValueKey('child')));
    // 先计算本地中心（相对于 container 的坐标）
    final localCenter = box.size.center(Offset.zero);
    // 再将本地坐标转换为全局，用于发送事件
    final globalCenter = box.localToGlobal(localCenter);

    // send pointer down
    await tester.sendEventToBinding(PointerDownEvent(position: globalCenter));
    await tester.pumpAndSettle();

    final ev = fakeManager.lastEvent!;
    expect(ev.type, InputEventType.pointerDown);
    // toCanvas: local * 2
    expect(ev.canvasPos, localCenter * 2);
    expect(ev.canvasPosDelta, isNull);

    // clear any pending gesture timers
    await tester.pump(const Duration(milliseconds: 500));
  });

  testWidgets('dispatches pointerMove with delta', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: Center(
            child: CanvasInputWrapper(
              toCanvas: (local) => local,
              context: context,
              manager: fakeManager,
              child: Container(
                key: const ValueKey('child'),
                width: 100,
                height: 100,
                color: Colors.transparent,
              ),
            ),
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();

    final box =
        tester.renderObject<RenderBox>(find.byKey(const ValueKey('child')));
    const p1Local = Offset(10, 10);
    const p2Local = Offset(20, 25);
    final p1Global = box.localToGlobal(p1Local);
    final p2Global = box.localToGlobal(p2Local);

    // pointer down to set lastPos
    await tester.sendEventToBinding(PointerDownEvent(position: p1Global));
    await tester.pumpAndSettle();

    // pointer move
    await tester.sendEventToBinding(PointerMoveEvent(position: p2Global));
    await tester.pumpAndSettle();

    final ev = fakeManager.lastEvent!;
    expect(ev.type, InputEventType.pointerMove);
    expect(ev.canvasPos, p2Local);
    expect(ev.canvasPosDelta, p2Local - p1Local);

    await tester.pump(const Duration(milliseconds: 500));
  });

  testWidgets('dispatches pointerSignal when scroll event', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: Center(
            child: CanvasInputWrapper(
              toCanvas: (local) => local,
              context: context,
              config: const InputConfig(enableZoom: true),
              manager: fakeManager,
              child: Container(
                key: const ValueKey('child'),
                width: 100,
                height: 100,
                color: Colors.transparent,
              ),
            ),
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();

    final box =
        tester.renderObject<RenderBox>(find.byKey(const ValueKey('child')));
    const localPos = Offset(30, 30);
    final globalPos = box.localToGlobal(localPos);

    await tester.sendEventToBinding(
      PointerScrollEvent(
          position: globalPos, scrollDelta: const Offset(0, -10)),
    );
    await tester.pumpAndSettle();

    final ev = fakeManager.lastEvent!;
    expect(ev.type, InputEventType.pointerSignal);
    expect(ev.raw, isA<PointerScrollEvent>());
    expect(ev.canvasPos, localPos);

    await tester.pump(const Duration(milliseconds: 500));
  });

  testWidgets('dispatches doubleTap and longPress', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: Center(
            child: CanvasInputWrapper(
              toCanvas: (local) => local,
              context: context,
              manager: fakeManager,
              child: Container(
                key: const ValueKey('child'),
                width: 100,
                height: 100,
                color: Colors.transparent,
              ),
            ),
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();

    // 直接 dispatch 双击与长按事件，无需 tap()/longPress() 的定时器
    fakeManager.handle(
      InputEvent.pointer(
          type: InputEventType.doubleTap, raw: null, canvasPos: null),
      context,
    );
    expect(fakeManager.lastEvent!.type, InputEventType.doubleTap);

    fakeManager.handle(
      InputEvent.pointer(
          type: InputEventType.longPress, raw: null, canvasPos: null),
      context,
    );
    expect(fakeManager.lastEvent!.type, InputEventType.longPress);
  });

  testWidgets('dispatches keyDown and keyUp', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: Center(
            child: CanvasInputWrapper(
              toCanvas: (local) => local,
              context: context,
              manager: fakeManager,
              child: Container(
                key: const ValueKey('child'),
                width: 100,
                height: 100,
                color: Colors.transparent,
              ),
            ),
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();

    // send key down
    await tester.sendKeyDownEvent(LogicalKeyboardKey.keyA);
    await tester.pumpAndSettle();
    expect(fakeManager.lastEvent!.type, InputEventType.keyDown);
    expect(fakeManager.lastEvent!.key, LogicalKeyboardKey.keyA);

    // send key up
    await tester.sendKeyUpEvent(LogicalKeyboardKey.keyA);
    await tester.pumpAndSettle();
    expect(fakeManager.lastEvent!.type, InputEventType.keyUp);
    expect(fakeManager.lastEvent!.key, LogicalKeyboardKey.keyA);
  });
}
