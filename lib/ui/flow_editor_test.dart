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
    final editor = ref.watch(activeEditorStateProvider);
    final store = ref.read(activeEditorNotifierProvider);
    final ctrl = ref.read(activeCanvasControllerProvider);

    final canvas = editor.canvasState;

    late final BehaviorContext behaviorCtx;
    behaviorCtx = BehaviorContext(
      controller: ctrl,
      getState: () => ref.read(activeEditorStateProvider),
      updateState: (s) => store.replaceState(s),
      hitTester: DefaultCanvasHitTester(
        // 🔑 从 behaviorCtx.getState() 拿最新 state
        getNodes: () => behaviorCtx.getState().nodeState.nodes,
        getEdges: () => behaviorCtx.getState().edgeState.edges,
        computeAnchorWorldPosition: computeAnchorWorldPosition,
      ),
    );

    final panDelta = editor.interaction.maybeMap(
      panCanvas: (s) => s.lastGlobal - s.startGlobal,
      orElse: () => Offset.zero,
    );

    final registry = initNodeWidgetRegistry();
    final nodeFactory = NodeWidgetFactoryImpl(registry: registry);

    final availableNodes = [
      const NodeModel(
        id: 'start_template',
        type: 'start',
        position: Offset.zero,
        size: Size(100, 80),
        title: 'Start',
        anchors: [],
      ),
      const NodeModel(
        id: 'end_template',
        type: 'end',
        position: Offset.zero,
        size: Size(100, 80),
        title: 'End',
        anchors: [],
      ),
      const NodeModel(
        id: 'placeholder_template',
        type: 'placeholder',
        position: Offset.zero,
        size: Size(100, 80),
        title: 'Placeholder',
        anchors: [],
      ),
      const NodeModel(
        id: 'middle_template',
        type: 'middle',
        position: Offset.zero,
        size: Size(100, 80),
        title: 'Middle',
        anchors: [],
      ),
    ];

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: Row(
        children: [
          // 左侧节点列表
          SizedBox(
            width: 120,
            child: ListView(
              children: availableNodes
                  .map((nodeTemplate) => Draggable<NodeModel>(
                        data: nodeTemplate,
                        feedback: Opacity(
                          opacity: 0.7,
                          child: SizedBox(
                            width: nodeTemplate.size.width,
                            height: nodeTemplate.size.height,
                            child: nodeFactory.createNodeWidget(nodeTemplate),
                          ),
                        ),
                        childWhenDragging: Opacity(
                          opacity: 0.3,
                          child: nodeFactory.createNodeWidget(nodeTemplate),
                        ),
                        child: nodeFactory.createNodeWidget(nodeTemplate),
                      ))
                  .toList(),
            ),
          ),

          // 主画布 (拖拽目标区域)
          Expanded(
            child: DragTarget<NodeModel>(
              onAcceptWithDetails: (details) {
                final localPos =
                    (details.offset - canvas.offset - panDelta) / canvas.scale;

                final newId = 'node_${DateTime.now().millisecondsSinceEpoch}';

                final newNode = details.data.copyWith(
                  id: newId,
                  position: localPos,
                  anchors: [
                    AnchorModel(
                      id: 'anchor_$newId',
                      position: Position.right,
                      size: const Size(5, 5),
                    ),
                  ],
                );

                ctrl.graph.addNode(newNode);
              },
              builder: (_, candidateData, rejectedData) => CanvasInputWrapper(
                context: behaviorCtx,
                toCanvas: (local) => (local - canvas.offset) / canvas.scale,
                child: SizedBox.expand(
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
            ),
          ),
        ],
      ),
    );
  }
}
