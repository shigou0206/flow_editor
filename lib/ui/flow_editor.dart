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
import 'package:flow_editor/core/models/node_model.dart';
import 'package:flow_editor/core/models/anchor_model.dart';
import 'package:flow_editor/ui/node/node_widget_registry_initializer.dart';
import 'package:flow_editor/ui/node/factories/node_widget_factory_impl.dart';
import 'package:flow_editor/core/models/enums/position_enum.dart';

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
    debugPrint('nodes length: ${nodes.length}');

    late final BehaviorContext behaviorCtx;
    behaviorCtx = BehaviorContext(
      controller: ctrl,
      getState: () => ref.read(activeEditorStateProvider),
      updateState: (s) => store.replaceState(s),
      hitTester: DefaultCanvasHitTester(
        // 🔑 从 behaviorCtx.getState() 拿最新 state
        getNodes: () => behaviorCtx.getState().nodeState.nodes,
        getEdges: () => behaviorCtx.getState().edgeState.edges,
        getAnchors: () => behaviorCtx
            .getState()
            .nodeState
            .nodes
            .expand((n) => n.anchors)
            .toList(),
        computeAnchorWorldPosition: computeAnchorWorldPosition,
      ),
    );

    final panDelta = editor.interaction.maybeMap(
      panCanvas: (s) => s.lastGlobal - s.startGlobal,
      orElse: () => Offset.zero,
    );

    final registry = initNodeWidgetRegistry();
    final nodeFactory = NodeWidgetFactoryImpl(
      registry: registry,
    );

    late final availableNodes = [
      const NodeModel(
        id: 'start_template',
        type: 'start',
        position: Offset(0, 0),
        size: Size(100, 80),
        title: 'Start',
        anchors: [],
      ),
      const NodeModel(
        id: 'end_template',
        type: 'end',
        position: Offset(0, 0),
        size: Size(100, 80),
        title: 'End',
        anchors: [],
      ),
      const NodeModel(
        id: 'placeholder_template',
        type: 'placeholder',
        position: Offset(0, 0),
        size: Size(100, 80),
        title: 'Placeholder',
        anchors: [],
      ),
      const NodeModel(
        id: 'middle_template',
        type: 'middle',
        position: Offset(0, 0),
        size: Size(100, 80),
        title: 'Middle',
        anchors: [],
      ),
    ];

    // ─────────────── UI ───────────────────────────────────────
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,

      // "+" 按钮：随机位置添加一个节点
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          final id = 'node_${DateTime.now().millisecondsSinceEpoch}';

          final rnd = Random();
          final x = rnd.nextDouble() * 200.0 + 50;
          final y = rnd.nextDouble() * 200.0 + 50;

          final newNode = NodeModel(
            type: 'start',
            id: id,
            position: Offset(x, y),
            size: const Size(120, 60),
            title: 'Node $id',
            anchors: [
              AnchorModel(
                id: 'anchor_${DateTime.now().millisecondsSinceEpoch}',
                position: Position.right,
                size: const Size(5, 5),
                nodeId: id,
              ),
            ],
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
              offset: canvas.offset + panDelta,
              scale: canvas.scale,
              visualConfig: canvas.visualConfig,
              nodeState: editor.nodeState,
              edgeState: editor.edgeState,
              interaction: editor.interaction,
              nodeWidgetFactory: nodeFactory,
            ),
          ),
        ),
      ),
    );
  }
}
