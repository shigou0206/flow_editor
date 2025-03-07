import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../node/controllers/node_controller.dart';
import '../edge/controllers/edge_controller.dart';
import '../node/models/node_model.dart';
import '../anchor/models/anchor_model.dart';
import '../anchor/models/anchor_enums.dart';
import '../types/position_enum.dart';
import '../canvas/controllers/canvas_controller.dart';
import '../canvas/models/canvas_visual_config.dart';
import '../canvas/behaviors/canvas_behavior.dart';
import '../canvas/interaction/gesture_event_handler.dart';
import '../state_management/canvas_state/canvas_state_provider.dart';
import '../canvas/models/canvas_interaction_mode.dart';

class GraphEditor extends ConsumerStatefulWidget {
  final String workflowId;
  final NodeController nodeController;
  final EdgeController? edgeController;
  final CanvasVisualConfig visualConfig;
  final CanvasBehavior canvasBehavior;

  const GraphEditor({
    Key? key,
    required this.workflowId,
    required this.nodeController,
    this.edgeController,
    required this.visualConfig,
    required this.canvasBehavior,
  }) : super(key: key);

  @override
  ConsumerState<GraphEditor> createState() => _GraphEditorState();
}

class _GraphEditorState extends ConsumerState<GraphEditor> {
  @override
  void initState() {
    super.initState();
    // 在挂载完成后，再异步调用 switchWorkflow
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref
          .read(multiCanvasStateProvider.notifier)
          .switchWorkflow(widget.workflowId);
    });
  }

  @override
  Widget build(BuildContext context) {
    // 下面就不会在build时同步更改 provider
    // 先 watch 当前 workflow 状态
    final canvasState = ref.watch(multiCanvasStateProvider).activeState;

    return Scaffold(
      appBar: AppBar(
        title: Text('GraphEditor (workflow = ${widget.workflowId})'),
        actions: [
          IconButton(
            onPressed: widget.canvasBehavior.resetView,
            icon: const Icon(Icons.fit_screen),
          ),
        ],
      ),
      body: CanvasController(
        workflowId: widget.workflowId,
        visualConfig: widget.visualConfig,
        offset: canvasState.offset,
        scale: canvasState.scale,
      ),
      floatingActionButton: _buildFloatingActions(),
    );
  }

  Widget _buildFloatingActions() {
    final multiCanvasNotifier = ref.read(multiCanvasStateProvider.notifier);
    final currentMode = ref.watch(multiCanvasStateProvider).activeState.mode;

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        FloatingActionButton(
          onPressed: _addNodeExample,
          heroTag: 'addNode',
          child: const Icon(Icons.add),
        ),
        const SizedBox(height: 8),

        FloatingActionButton(
          onPressed: _removeLastNodeExample,
          heroTag: 'removeNode',
          child: const Icon(Icons.remove),
        ),
        const SizedBox(height: 8),

        // 切换到 editNode
        FloatingActionButton(
          onPressed: () {
            multiCanvasNotifier
                .setInteractionMode(CanvasInteractionMode.editNode);
          },
          heroTag: 'forceEditNode',
          backgroundColor: Colors.orange,
          child: const Icon(Icons.edit),
        ),
        const SizedBox(height: 8),

        // 在 editNode / panCanvas 之间来回切换
        FloatingActionButton(
          onPressed: () {
            if (currentMode == CanvasInteractionMode.editNode) {
              multiCanvasNotifier
                  .setInteractionMode(CanvasInteractionMode.panCanvas);
            } else {
              multiCanvasNotifier
                  .setInteractionMode(CanvasInteractionMode.editNode);
            }
          },
          heroTag: 'toggleMode',
          child: const Icon(Icons.swap_horiz),
        ),
        const SizedBox(height: 8),

        // 平移画布
        FloatingActionButton(
          onPressed: () => multiCanvasNotifier.panBy(10, 0),
          heroTag: 'panRight',
          child: const Icon(Icons.arrow_right),
        ),
        const SizedBox(height: 8),

        FloatingActionButton(
          onPressed: () => multiCanvasNotifier.zoomAtPoint(1.1, Offset.zero),
          heroTag: 'zoomIn',
          child: const Icon(Icons.zoom_in),
        ),
        const SizedBox(height: 8),

        FloatingActionButton(
          onPressed: () => multiCanvasNotifier.zoomAtPoint(0.9, Offset.zero),
          heroTag: 'zoomOut',
          child: const Icon(Icons.zoom_out),
        ),
        const SizedBox(height: 8),

        FloatingActionButton(
          onPressed: () => multiCanvasNotifier.resetCanvas(),
          heroTag: 'resetCanvas',
          child: const Icon(Icons.refresh),
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
            placement: AnchorPlacement.outside,
            offsetDistance: 10,
            ratio: 0.5),
        AnchorModel(
            id: 'in_$newId',
            nodeId: newId,
            position: Position.left,
            placement: AnchorPlacement.outside,
            offsetDistance: 10,
            ratio: 0.5),
      ],
    );
    widget.nodeController.upsertNode(node);
  }

  void _removeLastNodeExample() {
    final allNodes = widget.nodeController.getAllNodes();
    if (allNodes.isEmpty) return;
    final lastNode = allNodes.last;
    widget.nodeController.removeNode(lastNode.id);
  }
}
