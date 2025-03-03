import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../node/controllers/node_controller.dart';
import '../edge/controllers/edge_controller.dart';
import '../node/models/node_model.dart';
import '../anchor/models/anchor_model.dart';
import '../types/position_enum.dart';
import '../canvas/controllers/canvas_controller.dart';
import '../canvas/models/canvas_visual_config.dart';
import '../canvas/behaviors/canvas_behavior.dart';
import '../canvas/interaction/gesture_event_handler.dart';
import '../state_management/canvas_state/canvas_state_provider.dart';

class GraphEditor extends ConsumerWidget {
  final String workflowId;
  final NodeController nodeController;
  final EdgeController? edgeController;
  final CanvasVisualConfig visualConfig;
  final CanvasBehavior canvasBehavior;

  const GraphEditor({
    super.key,
    required this.workflowId,
    required this.nodeController,
    this.edgeController,
    required this.visualConfig,
    required this.canvasBehavior,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final canvasState = ref.watch(multiCanvasStateProvider).activeState;

    return Scaffold(
      appBar: AppBar(
        title: Text("GraphEditor (workflow = $workflowId)"),
        actions: [
          IconButton(
            onPressed: canvasBehavior.resetView,
            icon: const Icon(Icons.fit_screen),
          ),
        ],
      ),
      body: CanvasGestureHandler(
        canvasBehavior: canvasBehavior,
        child: CanvasController(
          workflowId: workflowId,
          visualConfig: visualConfig,
          canvasGlobalKey: GlobalKey(),
          offset: canvasState.offset, // ← 全局状态
          scale: canvasState.scale, // 直接使用全局状态
        ),
      ),
      floatingActionButton: _buildFloatingActions(),
    );
  }

  Widget _buildFloatingActions() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        FloatingActionButton(
          onPressed: _addNodeExample,
          child: const Icon(Icons.add),
        ),
        const SizedBox(height: 8),
        FloatingActionButton(
          onPressed: _removeLastNodeExample,
          child: const Icon(Icons.remove),
        ),
        const SizedBox(height: 8),
        FloatingActionButton(
          onPressed: () => canvasBehavior.panBy(10, 0),
          child: const Icon(Icons.arrow_right),
        ),
        const SizedBox(height: 8),
        FloatingActionButton(
          onPressed: () => canvasBehavior.zoom(1.1, Offset.zero),
          child: const Icon(Icons.zoom_in),
        ),
        const SizedBox(height: 8),
        FloatingActionButton(
          onPressed: () => canvasBehavior.zoom(0.9, Offset.zero),
          child: const Icon(Icons.zoom_out),
        ),
      ],
    );
  }

  void _addNodeExample() {
    final newId = 'new_${DateTime.now().millisecondsSinceEpoch}';
    final node = NodeModel(
      id: newId,
      x: 200,
      y: 200,
      width: 80,
      height: 40,
      title: newId,
      anchors: [
        AnchorModel(
          id: 'out_$newId',
          nodeId: newId,
          position: Position.right,
          offsetDistance: 10,
          ratio: 0.5,
        ),
        AnchorModel(
          id: 'in_$newId',
          nodeId: newId,
          position: Position.left,
          offsetDistance: 10,
          ratio: 0.5,
        ),
      ],
    );
    nodeController.upsertNode(node);
  }

  void _removeLastNodeExample() {
    final allNodes = nodeController.getAllNodes();
    if (allNodes.isEmpty) return;
    final lastNode = allNodes.last;
    nodeController.removeNode(lastNode.id);
  }
}
