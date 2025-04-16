// lib/flow_editor/core/graph_editor/graph_editor_actions.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
// 引入多画布状态提供者
import 'package:flow_editor/core/canvas/canvas_state/canvas_state_provider.dart';
import 'package:flow_editor/core/node/models/node_model.dart';
import 'package:flow_editor/core/node/models/node_enums.dart';
import 'package:flow_editor/core/anchor/models/anchor_model.dart';
import 'package:flow_editor/core/anchor/models/anchor_enums.dart';
import 'package:flow_editor/core/types/position_enum.dart';

class GraphEditorActions extends ConsumerWidget {
  final dynamic nodeBehavior;
  final dynamic canvasState; // CanvasState 类型

  const GraphEditorActions({
    Key? key,
    required this.nodeBehavior,
    required this.canvasState,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final multiCanvasNotifier = ref.read(multiCanvasStateProvider.notifier);

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        FloatingActionButton(
          onPressed: () => _addNodeExample(context),
          heroTag: 'addNode',
          child: const Icon(Icons.add),
        ),
        const SizedBox(height: 8),
        FloatingActionButton(
          onPressed: () => _removeLastNodeExample(),
          heroTag: 'removeNode',
          child: const Icon(Icons.remove),
        ),
        const SizedBox(height: 8),
        FloatingActionButton(
          onPressed: () {
            multiCanvasNotifier.panBy(10, 0);
          },
          heroTag: 'panRight',
          child: const Icon(Icons.arrow_right),
        ),
        const SizedBox(height: 8),
        FloatingActionButton(
          onPressed: () {
            multiCanvasNotifier.zoomAtPoint(1.1, Offset.zero);
          },
          heroTag: 'zoomIn',
          child: const Icon(Icons.zoom_in),
        ),
        const SizedBox(height: 8),
        FloatingActionButton(
          onPressed: () {
            multiCanvasNotifier.zoomAtPoint(0.9, Offset.zero);
          },
          heroTag: 'zoomOut',
          child: const Icon(Icons.zoom_out),
        ),
        const SizedBox(height: 8),
        FloatingActionButton(
          onPressed: () {
            multiCanvasNotifier.resetCanvas();
          },
          heroTag: 'resetCanvas',
          child: const Icon(Icons.refresh),
        ),
      ],
    );
  }

  void _addNodeExample(BuildContext context) {
    final newId = 'new_${DateTime.now().millisecondsSinceEpoch}';
    final node = NodeModel(
      id: newId,
      type: 'middle',
      role: NodeRole.middle,
      position: const Offset(200, 200),
      size: const Size(100, 80),
      title: newId,
      anchors: [
        AnchorModel(
          id: 'out_$newId',
          nodeId: newId,
          position: Position.right,
          placement: AnchorPlacement.border,
          offsetDistance: 0,
          ratio: 0.65,
          width: 24,
          height: 24,
          shape: AnchorShape.diamond,
        ),
        AnchorModel(
          id: 'in_$newId',
          nodeId: newId,
          position: Position.left,
          placement: AnchorPlacement.border,
          offsetDistance: 0,
          ratio: 0.65,
          width: 24,
          height: 24,
          shape: AnchorShape.square,
        ),
      ],
    );
    nodeBehavior.nodeController.upsertNode(node);
  }

  void _removeLastNodeExample() {
    final allNodes = nodeBehavior.nodeController.getAllNodes();
    if (allNodes.isEmpty) return;
    final lastNode = allNodes.last;
    nodeBehavior.nodeController.removeNode(lastNode.id);
  }
}
