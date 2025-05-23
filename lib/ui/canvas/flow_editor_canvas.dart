import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flow_editor/core/state_management/providers.dart';
import 'package:flow_editor/core/state_management/canvas_controller_provider.dart';
import 'package:flow_editor/core/input/wrapper/canvas_input_wrapper.dart';
import 'package:flow_editor/core/input/behavior_core/behavior_context.dart';
import 'package:flow_editor/core/hit_test/default_canvas_hit_tester.dart';
import 'package:flow_editor/core/utils/anchor_position_utils.dart';
import 'package:flow_editor/ui/canvas/canvas_renderer.dart';
import 'package:flow_editor/ui/node/factories/node_widget_factory_impl.dart';
import 'package:flow_editor/ui/node/node_widget_registry_initializer.dart';
import 'package:flow_editor/core/models/node_model.dart';

class FlowEditorCanvas extends ConsumerWidget {
  const FlowEditorCanvas({super.key});

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

    return DragTarget<NodeModel>(
        onAcceptWithDetails: (details) {
          final renderBox = context.findRenderObject() as RenderBox;
          final localOffset =
              renderBox.globalToLocal(details.offset); // ✅ 正确转换为局部坐标
          final localPos =
              (localOffset - canvas.offset - panDelta) / canvas.scale;

          final newId = 'node_${DateTime.now().millisecondsSinceEpoch}';

          final newNode = details.data.copyWith(
            id: newId,
            position: localPos,
          );

          ctrl.graph.addNode(newNode);
        },
        builder: (_, __, ___) => CanvasInputWrapper(
              context: behaviorCtx,
              toCanvas: (local) => (local - canvas.offset) / canvas.scale,
              child: SizedBox.expand(
                child: Stack(
                  children: [
                    // 背景层
                    Positioned.fill(
                      child: Container(
                        color: Colors.grey[100], // ✅ 可设置网格背景等
                      ),
                    ),
                    // 主绘制区域
                    Positioned.fill(
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
                  ],
                ),
              ),
            ));
  }
}
