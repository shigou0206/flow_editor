import 'package:flow_editor/core/models/ui_state/editor_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flow_editor/core/state_management/providers.dart';
import 'package:flow_editor/core/input/wrapper/canvas_input_wrapper.dart';
import 'package:flow_editor/core/input/behavior_core/behavior_context.dart';
import 'package:flow_editor/core/hit_test/default_canvas_hit_tester.dart';
import 'package:flow_editor/core/utils/anchor_position_utils.dart';
import 'package:flow_editor/ui/canvas/sfn_canvas_render.dart';
import 'package:flow_editor/ui/node/factories/node_widget_factory_impl.dart';
import 'package:flow_editor/ui/node/node_widget_registry_initializer.dart';
import 'package:flow_editor/core/models/ui/canvas_insert_element.dart';
import 'package:flow_editor/core/models/ui_state/interaction_transient_state.dart';

class SfnEditorCanvas extends ConsumerWidget {
  const SfnEditorCanvas({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final editor = ref.watch(activeEditorStateProvider);
    final store = ref.read(activeEditorNotifierProvider);
    final ctrl = ref.read(activeCanvasControllerProvider);
    final canvas = editor.canvasState;

    final behaviorCtx = BehaviorContext(
      buildContext: context,
      controller: ctrl,
      getState: () => ref.read(activeEditorStateProvider),
      updateState: (s) => store.replaceState(s),
      hitTester: DefaultCanvasHitTester(
        getNodes: () => ref.read(activeEditorStateProvider).nodeState.nodes,
        getEdges: () => ref.read(activeEditorStateProvider).edgeState.edges,
        computeAnchorWorldPosition: computeAnchorWorldPosition,
      ),
    );

    final panDelta = editor.interaction.maybeMap(
      panCanvas: (s) => s.lastGlobal - s.startGlobal,
      orElse: () => Offset.zero,
    );

    final registry = initNodeWidgetRegistry();
    final nodeFactory = NodeWidgetFactoryImpl(registry: registry);

    return DragTarget<CanvasInsertElement>(
      onWillAcceptWithDetails: (details) {
        final renderBox = context.findRenderObject() as RenderBox;
        final localOffset = renderBox.globalToLocal(details.offset);
        final elementSize = details.data.size;

        final centerLocalOffset =
            localOffset + Offset(elementSize.width / 2, elementSize.height / 2);
        final localPos =
            (centerLocalOffset - canvas.offset - panDelta) / canvas.scale;

        final highlightedEdgeId = behaviorCtx.hitTester.hitTestEdgeWithRect(
          Rect.fromCenter(
            center: localPos,
            width: elementSize.width / canvas.scale,
            height: elementSize.height / canvas.scale,
          ),
        );

        if (details.data.isNode) {
          ctrl.interaction
              .startInsertingNodePreview(details.data.singleNode!, localPos);
          ctrl.interaction
              .updateInsertingNodePreview(localPos, highlightedEdgeId);
        } else if (details.data.isGroup) {
          ctrl.interaction.startInsertingGroupPreview(
            details.data.rootGroupNode!,
            details.data.allNodes,
            details.data.allEdges,
            localPos,
          );
          ctrl.interaction
              .updateInsertingGroupPreview(localPos, highlightedEdgeId);
        }
        return true;
      },
      onMove: (details) {
        final renderBox = context.findRenderObject() as RenderBox;
        final localOffset = renderBox.globalToLocal(details.offset);
        final elementSize = details.data.size;

        final centerLocalOffset =
            localOffset + Offset(elementSize.width / 2, elementSize.height / 2);
        final localPos =
            (centerLocalOffset - canvas.offset - panDelta) / canvas.scale;

        final highlightedEdgeId = behaviorCtx.hitTester.hitTestEdgeWithRect(
          Rect.fromCenter(
            center: localPos,
            width: elementSize.width / canvas.scale,
            height: elementSize.height / canvas.scale,
          ),
        );

        if (details.data.isNode) {
          ctrl.interaction
              .updateInsertingNodePreview(localPos, highlightedEdgeId);
        } else if (details.data.isGroup) {
          ctrl.interaction
              .updateInsertingGroupPreview(localPos, highlightedEdgeId);
        }
      },
      onLeave: (_) {
        ctrl.interaction.endInsertingNodePreview();
        ctrl.interaction.endInsertingGroupPreview();
      },
      onAcceptWithDetails: (details) {
        final renderBox = context.findRenderObject() as RenderBox;
        final localOffset = renderBox.globalToLocal(details.offset);
        final elementSize = details.data.size;

        final centerLocalOffset =
            localOffset + Offset(elementSize.width / 2, elementSize.height / 2);
        final localPos =
            (centerLocalOffset - canvas.offset - panDelta) / canvas.scale;

        final interaction = behaviorCtx.interaction;

        if (details.data.isNode) {
          final node = details.data.singleNode!.copyWith(
            id: 'node_${DateTime.now().millisecondsSinceEpoch}',
            position: localPos,
          );

          if (interaction.currentHighlightedEdgeId != null) {
            ctrl.graph.insertNodeIntoEdge(
                node, interaction.currentHighlightedEdgeId!);
          }
        } else if (details.data.isGroup) {
          if (interaction.currentHighlightedEdgeId != null) {
            ctrl.graph.insertNodeGroupIntoEdge(
              details.data.rootGroupNode!,
              details.data.allNodes,
              details.data.allEdges,
              interaction.currentHighlightedEdgeId!,
            );
          }
        }

        ctrl.interaction.endInsertingNodePreview();
        ctrl.interaction.endInsertingGroupPreview();
      },
      builder: (_, __, ___) => CanvasInputWrapper(
        context: behaviorCtx,
        toCanvas: (local) => (local - canvas.offset) / canvas.scale,
        child: SizedBox.expand(
          child: Stack(
            children: [
              Positioned.fill(child: Container(color: Colors.grey[100])),
              Positioned.fill(
                child: RepaintBoundary(
                  child: SfnCanvasRenderer(
                    offset: canvas.offset + panDelta,
                    scale: canvas.scale,
                    visualConfig: canvas.visualConfig,
                    nodeState: editor.nodeState,
                    edgeState: editor.edgeState,
                    interaction: editor.interaction,
                    nodeWidgetFactory: nodeFactory,
                    renderedNodes: editor.renderedNodes,
                    renderedEdges: editor.renderedEdges,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
