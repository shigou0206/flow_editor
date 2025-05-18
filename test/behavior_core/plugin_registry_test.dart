// test/behavior_core/plugin_registry_test.dart

import 'package:flutter_test/flutter_test.dart';
import 'package:flow_editor/core/input/behavior_core/plugin_registry.dart';
import 'package:flow_editor/core/input/behavior_core/behavior_context.dart';
import 'package:flow_editor/core/input/behavior_plugins/canvas_pan_behavior.dart';
import 'package:flow_editor/core/input/behavior_plugins/canvas_zoom_behavior.dart';
import 'package:flow_editor/core/input/behavior_plugins/node_drag_behavior.dart';
import 'package:flow_editor/core/input/behavior_plugins/edge_draw_behavior.dart';
import 'package:flow_editor/core/input/behavior_plugins/marquee_select_behavior.dart';
import 'package:flow_editor/core/input/behavior_plugins/delete_key_behavior.dart';
import 'package:flow_editor/core/input/behavior_plugins/copy_paste_behavior.dart';
import 'package:flow_editor/core/input/behavior_plugins/undo_redo_behavior.dart';
import 'package:flow_editor/core/hit_test/canvas_hit_tester.dart';
import 'package:flow_editor/core/models/state/canvas_state.dart';
import 'package:flow_editor/core/models/state/canvas_interaction_state.dart';
import 'package:flow_editor/core/models/styles/canvas_interaction_config.dart';
import 'package:flow_editor/core/models/styles/canvas_visual_config.dart';
import 'package:flow_editor/test/_helpers/fake_canvas_controller.dart';

/// A no-op hit tester just to satisfy BehaviorContext
class _DummyHitTester implements CanvasHitTester {
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
  late BehaviorContext context;

  setUp(() {
    // Construct a minimal-but-valid BehaviorContext
    context = BehaviorContext(
      controller: FakeCanvasController(),
      getState: () => const CanvasState(
        interactionConfig: CanvasInteractionConfig(),
        visualConfig: CanvasVisualConfig(),
        interactionState: CanvasInteractionState(),
      ),
      updateState: (_) {},
      hitTester: _DummyHitTester(),
    );
  });

  test('registerDefaultBehaviors returns exactly 8 behaviors', () {
    final list = registerDefaultBehaviors(context);
    expect(list, hasLength(8));
  });

  test('behaviors are sorted by priority ascending', () {
    final list = registerDefaultBehaviors(context);
    final priorities = list.map((b) => b.priority).toList();
    expect(priorities, [10, 20, 30, 50, 60, 80, 90, 100]);
  });

  test('behaviors are of the correct types', () {
    final list = registerDefaultBehaviors(context);
    expect(
      list,
      [
        isA<NodeDragBehavior>(), // priority 10
        isA<EdgeDrawBehavior>(), //      20
        isA<MarqueeSelectBehavior>(), //      30
        isA<CanvasPanBehavior>(), //      50
        isA<CanvasZoomBehavior>(), //      60
        isA<DeleteKeyBehavior>(), //      80
        isA<CopyPasteBehavior>(), //      90
        isA<UndoRedoBehavior>(), //     100
      ],
    );
  });
}
