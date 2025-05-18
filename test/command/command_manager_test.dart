// test/command/command_manager_test.dart

import 'dart:ui';

import 'package:flutter_test/flutter_test.dart';
import 'package:flow_editor/core/command/command_context.dart';
import 'package:flow_editor/core/command/command_manager.dart';
import 'package:flow_editor/core/command/i_command.dart';
import 'package:flow_editor/core/models/state/canvas_state.dart';
import 'package:flow_editor/core/models/state/canvas_interaction_state.dart';
import 'package:flow_editor/core/models/styles/canvas_interaction_config.dart';
import 'package:flow_editor/core/models/styles/canvas_visual_config.dart';
import 'package:flow_editor/test/_helpers/fake_canvas_controller.dart';
import 'package:flow_editor/core/state_management/state_store/editor_state.dart';
import 'package:flow_editor/core/models/state/node_state.dart';
import 'package:flow_editor/core/models/state/edge_state.dart';
import 'package:flow_editor/core/models/state/canvas_viewport_state.dart';
import 'package:flow_editor/core/models/state/selection_state.dart';

/// 一个"+"命令，把 interactionState.marqueeRect.width +1
class IncrementCommand implements ICommand {
  final CommandContext ctx;
  late int before;
  IncrementCommand(this.ctx);

  @override
  String get description => 'increment';
  @override
  Future<void> execute() async {
    final st = ctx.getState();
    final wfId = st.activeWorkflowId;
    final canvas = st.canvases[wfId]!;
    final w = canvas.interactionState.marqueeRect?.width.toInt() ?? 0;
    before = w;
    final newRect = Rect.fromLTWH(0, 0, (w + 1).toDouble(), 0);

    ctx.updateState(
      st.copyWith(
        canvases: {
          ...st.canvases,
          wfId: canvas.copyWith(
              interactionState:
                  canvas.interactionState.copyWith(marqueeRect: newRect))
        },
      ),
    );
  }

  @override
  Future<void> undo() async {
    final st = ctx.getState();
    final wfId = st.activeWorkflowId;
    final canvas = st.canvases[wfId]!;
    final rect = Rect.fromLTWH(0, 0, before.toDouble(), 0);

    ctx.updateState(
      st.copyWith(
        canvases: {
          ...st.canvases,
          wfId: canvas.copyWith(
              interactionState:
                  canvas.interactionState.copyWith(marqueeRect: rect))
        },
      ),
    );
  }
}

/// 一个永远抛错的命令
class BadCommand implements ICommand {
  @override
  String get description => 'bad';
  @override
  Future<void> execute() async {
    throw Exception('fail');
  }

  @override
  Future<void> undo() async {
    fail('undo() should not be called for failed commands');
  }
}

void main() {
  late EditorState state;
  late CommandContext ctx;
  late CommandManager mgr;

  setUp(() {
    const canvasState = CanvasState(
      interactionConfig: CanvasInteractionConfig(),
      visualConfig: CanvasVisualConfig(),
      interactionState: CanvasInteractionState(),
    );

    state = const EditorState(
      activeWorkflowId: 'default',
      canvases: {'default': canvasState},
      nodes: NodeState(),
      edges: EdgeState(),
      viewport: CanvasViewportState(),
      selection: SelectionState(),
    );

    ctx = CommandContext(
      controller: FakeCanvasController(),
      getState: () => state,
      updateState: (s) => state = s,
    );
    mgr = CommandManager(ctx);
  });

  test('initially cannot undo/redo', () {
    expect(mgr.canUndo, isFalse);
    expect(mgr.canRedo, isFalse);
  });

  test('executeCommand updates state and enables undo', () async {
    await mgr.executeCommand(IncrementCommand(ctx));
    expect(state.canvases['default']!.interactionState.marqueeRect!.width, 1.0);
    expect(mgr.canUndo, isTrue);
    expect(mgr.canRedo, isFalse);
  });

  test('undo reverts and enables redo', () async {
    await mgr.executeCommand(IncrementCommand(ctx));
    await mgr.undo();
    expect(state.canvases['default']!.interactionState.marqueeRect!.width, 0.0);
    expect(mgr.canUndo, isFalse);
    expect(mgr.canRedo, isTrue);
  });

  test('redo re‐applies and restores undo', () async {
    await mgr.executeCommand(IncrementCommand(ctx));
    await mgr.undo();
    await mgr.redo();
    expect(state.canvases['default']!.interactionState.marqueeRect!.width, 1.0);
    expect(mgr.canUndo, isTrue);
    expect(mgr.canRedo, isFalse);
  });

  test('clearHistory resets both stacks', () async {
    await mgr.executeCommand(IncrementCommand(ctx));
    await mgr.executeCommand(IncrementCommand(ctx));
    mgr.clearHistory();
    expect(mgr.canUndo, isFalse);
    expect(mgr.canRedo, isFalse);
  });

  test('failed execute does not push to history', () async {
    await expectLater(
      mgr.executeCommand(BadCommand()),
      throwsException,
    );
    expect(mgr.canUndo, isFalse);
    expect(mgr.canRedo, isFalse);
  });
}
