// import 'package:flow_editor/core/models/state/editor_state.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:flow_editor/core/state_management/providers.dart';
// import 'package:flow_editor/core/state_management/canvas_controller_provider.dart';
// import 'package:flow_editor/core/input/wrapper/canvas_input_wrapper.dart';
// import 'package:flow_editor/core/input/behavior_core/behavior_context.dart';
// import 'package:flow_editor/core/hit_test/default_canvas_hit_tester.dart';
// import 'package:flow_editor/core/utils/anchor_position_utils.dart';
// import 'package:flow_editor/ui/canvas/sfn_canvas_render.dart';
// import 'package:flow_editor/ui/node/factories/node_widget_factory_impl.dart';
// import 'package:flow_editor/ui/node/node_widget_registry_initializer.dart';
// import 'package:flow_editor/core/models/node_model.dart';
// import 'package:flow_editor/core/models/state/interaction_transient_state.dart';

// class SfnEditorCanvas extends ConsumerWidget {
//   const SfnEditorCanvas({super.key});

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final editor = ref.watch(activeEditorStateProvider);
//     final store = ref.read(activeEditorNotifierProvider);
//     final ctrl = ref.read(activeCanvasControllerProvider);
//     final canvas = editor.canvasState;

//     late final BehaviorContext behaviorCtx;
//     behaviorCtx = BehaviorContext(
//       controller: ctrl,
//       getState: () => ref.read(activeEditorStateProvider),
//       updateState: (s) => store.replaceState(s),
//       hitTester: DefaultCanvasHitTester(
//         getNodes: () => behaviorCtx.getState().nodeState.nodes,
//         getEdges: () => behaviorCtx.getState().edgeState.edges,
//         computeAnchorWorldPosition: computeAnchorWorldPosition,
//       ),
//     );

//     final panDelta = editor.interaction.maybeMap(
//       panCanvas: (s) => s.lastGlobal - s.startGlobal,
//       orElse: () => Offset.zero,
//     );

//     final registry = initNodeWidgetRegistry();
//     final nodeFactory = NodeWidgetFactoryImpl(registry: registry);

//     return DragTarget<NodeModel>(
//       onWillAcceptWithDetails: (details) {
//         debugPrint('[DragTarget] onWillAcceptWithDetails triggered');
//         final renderBox = context.findRenderObject() as RenderBox;
//         final localOffset = renderBox.globalToLocal(details.offset);

//         final localPos =
//             (localOffset - canvas.offset - panDelta) / canvas.scale;
//         debugPrint('[DragTarget] Local position: $localPos');

//         final highlightedEdgeId = behaviorCtx.hitTester.hitTestEdge(localPos);
//         debugPrint('[DragTarget] Highlighted Edge: $highlightedEdgeId');

//         ctrl.interaction.startInsertingNodePreview(details.data, localPos);
//         ctrl.interaction
//             .updateInsertingNodePreview(localPos, highlightedEdgeId);
//         return true;
//       },
//       onMove: (details) {
//         final renderBox = context.findRenderObject() as RenderBox;
//         final localOffset = renderBox.globalToLocal(details.offset);
//         final localPos =
//             (localOffset - canvas.offset - panDelta) / canvas.scale;
//         debugPrint('[DragTarget] onMove: Local position: $localPos');

//         final highlightedEdgeId = behaviorCtx.hitTester.hitTestEdge(localPos);
//         debugPrint('[DragTarget] onMove: Highlighted Edge: $highlightedEdgeId');

//         ctrl.interaction
//             .updateInsertingNodePreview(localPos, highlightedEdgeId);
//       },
//       onLeave: (_) {
//         debugPrint('[DragTarget] onLeave triggered');
//         ctrl.interaction.endInsertingNodePreview();
//       },
//       onAcceptWithDetails: (details) {
//         debugPrint('[DragTarget] onAcceptWithDetails triggered');
//         final renderBox = context.findRenderObject() as RenderBox;
//         final localOffset = renderBox.globalToLocal(details.offset);
//         final localPos =
//             (localOffset - canvas.offset - panDelta) / canvas.scale;
//         debugPrint('[DragTarget] onAccept: Local position: $localPos');

//         final interaction = behaviorCtx.interaction;

//         if (interaction is InsertingNodePreview &&
//             interaction.highlightedEdgeId != null) {
//           debugPrint(
//               '[DragTarget] Inserting node into edge ${interaction.highlightedEdgeId}');
//           final newNode = details.data.copyWith(
//             id: 'node_${DateTime.now().millisecondsSinceEpoch}',
//             position: localPos,
//           );

//           ctrl.graph
//               .insertNodeIntoEdge(newNode, interaction.highlightedEdgeId!);
//         } else {
//           debugPrint('[DragTarget] Inserting node at canvas');
//           final newNode = details.data.copyWith(
//             id: 'node_${DateTime.now().millisecondsSinceEpoch}',
//             position: localPos,
//           );

//           ctrl.graph.addNode(newNode);
//         }

//         ctrl.interaction.endInsertingNodePreview();
//       },
//       builder: (_, __, ___) => CanvasInputWrapper(
//         context: behaviorCtx,
//         toCanvas: (local) => (local - canvas.offset) / canvas.scale,
//         child: SizedBox.expand(
//           child: Stack(
//             children: [
//               Positioned.fill(
//                 child: Container(color: Colors.grey[100]),
//               ),
//               Positioned.fill(
//                 child: RepaintBoundary(
//                   child: SfnCanvasRenderer(
//                     offset: canvas.offset + panDelta,
//                     scale: canvas.scale,
//                     visualConfig: canvas.visualConfig,
//                     nodeState: editor.nodeState,
//                     edgeState: editor.edgeState,
//                     interaction: editor.interaction,
//                     nodeWidgetFactory: nodeFactory,
//                     renderedNodes: editor.renderedNodes,
//                     renderedEdges: editor.renderedEdges,
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'package:flow_editor/core/models/state/editor_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flow_editor/core/state_management/providers.dart';
import 'package:flow_editor/core/state_management/canvas_controller_provider.dart';
import 'package:flow_editor/core/input/wrapper/canvas_input_wrapper.dart';
import 'package:flow_editor/core/input/behavior_core/behavior_context.dart';
import 'package:flow_editor/core/hit_test/default_canvas_hit_tester.dart';
import 'package:flow_editor/core/utils/anchor_position_utils.dart';
import 'package:flow_editor/ui/canvas/sfn_canvas_render.dart';
import 'package:flow_editor/ui/node/factories/node_widget_factory_impl.dart';
import 'package:flow_editor/ui/node/node_widget_registry_initializer.dart';
import 'package:flow_editor/core/models/node_model.dart';
import 'package:flow_editor/core/models/state/interaction_transient_state.dart';

class SfnEditorCanvas extends ConsumerWidget {
  const SfnEditorCanvas({super.key});

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
      onWillAcceptWithDetails: (details) {
        final renderBox = context.findRenderObject() as RenderBox;
        final localOffset = renderBox.globalToLocal(details.offset);

        // ✅ 修正位置：计算中心点，而非左上角
        final nodeSize = details.data.size;
        final centerLocalOffset =
            localOffset + Offset(nodeSize.width / 2, nodeSize.height / 2);
        final localPos =
            (centerLocalOffset - canvas.offset - panDelta) / canvas.scale;

        final highlightedEdgeId = behaviorCtx.hitTester.hitTestEdge(localPos);

        ctrl.interaction.startInsertingNodePreview(details.data, localPos);
        ctrl.interaction
            .updateInsertingNodePreview(localPos, highlightedEdgeId);
        return true;
      },
      onMove: (details) {
        final renderBox = context.findRenderObject() as RenderBox;
        final localOffset = renderBox.globalToLocal(details.offset);

        // ✅ 修正位置：计算中心点，而非左上角
        final nodeSize = details.data.size;
        final centerLocalOffset =
            localOffset + Offset(nodeSize.width / 2, nodeSize.height / 2);
        final localPos =
            (centerLocalOffset - canvas.offset - panDelta) / canvas.scale;

        // final highlightedEdgeId = behaviorCtx.hitTester.hitTestEdge(localPos);
        final highlightedEdgeId = behaviorCtx.hitTester.hitTestEdgeWithRect(
            Rect.fromCenter(
                center: localPos,
                width: nodeSize.width,
                height: nodeSize.height));

        ctrl.interaction
            .updateInsertingNodePreview(localPos, highlightedEdgeId);
      },
      onLeave: (_) {
        ctrl.interaction.endInsertingNodePreview();
      },
      onAcceptWithDetails: (details) {
        final renderBox = context.findRenderObject() as RenderBox;
        final localOffset = renderBox.globalToLocal(details.offset);

        // ✅ 修正位置：计算中心点，而非左上角
        final nodeSize = details.data.size;
        final centerLocalOffset =
            localOffset + Offset(nodeSize.width / 2, nodeSize.height / 2);
        final localPos =
            (centerLocalOffset - canvas.offset - panDelta) / canvas.scale;

        final interaction = behaviorCtx.interaction;

        if (interaction is InsertingNodePreview &&
            interaction.highlightedEdgeId != null) {
          final newNode = details.data.copyWith(
            id: 'node_${DateTime.now().millisecondsSinceEpoch}',
            position: localPos,
          );

          ctrl.graph
              .insertNodeIntoEdge(newNode, interaction.highlightedEdgeId!);
        } else {
          final newNode = details.data.copyWith(
            id: 'node_${DateTime.now().millisecondsSinceEpoch}',
            position: localPos,
          );

          ctrl.graph.addNode(newNode);
        }

        ctrl.interaction.endInsertingNodePreview();
      },
      builder: (_, __, ___) => CanvasInputWrapper(
        context: behaviorCtx,
        toCanvas: (local) => (local - canvas.offset) / canvas.scale,
        child: SizedBox.expand(
          child: Stack(
            children: [
              Positioned.fill(
                child: Container(color: Colors.grey[100]),
              ),
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
