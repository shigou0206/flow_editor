// lib/ui/pages/flow_editor_page.dart
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:flow_editor/core/state_management/providers.dart';
import 'package:flow_editor/core/state_management/canvas_controller_provider.dart';

import 'package:flow_editor/core/input/wrapper/canvas_input_wrapper.dart';
import 'package:flow_editor/core/input/behavior_core/behavior_context.dart';

import 'package:flow_editor/core/hit_test/default_canvas_hit_tester.dart';
import 'package:flow_editor/core/utils/anchor_position_utils.dart';

import 'package:flow_editor/ui/canvas/canvas_renderer.dart';
import 'package:flow_editor/ui/node/factories/default_node_factory.dart';

import 'package:flow_editor/core/models/node_model.dart';

class FlowEditorPage extends ConsumerWidget {
  const FlowEditorPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // ─────────────── 数据源 ────────────────────────────────────
    final editor = ref.watch(activeEditorStateProvider); // 当前 EditorState
    final store = ref.read(activeEditorNotifierProvider); // Store（写入口）
    final ctrl = ref.read(activeCanvasControllerProvider); // ICanvasController

    final canvas = editor.canvasState; // CanvasState
    final nodes = editor.nodeState.nodes; // List<NodeModel>
    final edges = editor.edgeState.edges; // List<EdgeModel>

    // ─────────────── Hit-tester & BehaviorContext ─────────────
    final hitTester = DefaultCanvasHitTester(
      getNodes: () => nodes,
      getEdges: () => edges,
      getAnchors: () => nodes.expand((n) => n.anchors).toList(),
      computeAnchorWorldPosition: computeAnchorWorldPosition,
    );
    final behaviorCtx = BehaviorContext(
      controller: ctrl,
      getState: () => ref.read(activeEditorStateProvider),
      updateState: (s) => store.replaceState(s),
      hitTester: hitTester,
    );

    // ─────────────── UI ───────────────────────────────────────
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,

      // “+” 按钮：随机位置添加一个节点
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          final id = 'node_${DateTime.now().millisecondsSinceEpoch}';
          final rnd = Random();
          final x = 200.0 + 50;
          final y = 200.0 + 50;

          final newNode = NodeModel(
            id: id,
            position: Offset(x, y),
            size: const Size(120, 60),
            title: 'Node $id',
          );
          ctrl.addNode(newNode);
        },
      ),

      // 主画布
      body: CanvasInputWrapper(
        context: behaviorCtx,
        toCanvas: (local) => (local - canvas.offset) / canvas.scale,
        child: SizedBox.expand(
          // ← 确保填满整屏，这样才能接收全域事件
          child: RepaintBoundary(
            child: CanvasRenderer(
              offset: canvas.offset,
              scale: canvas.scale,
              visualConfig: canvas.visualConfig,
              nodeState: editor.nodeState,
              edgeState: editor.edgeState,
              interaction: editor.interaction,
              nodeWidgetFactory: const DefaultNodeFactory(),
            ),
          ),
        ),
      ),
    );
  }
}
