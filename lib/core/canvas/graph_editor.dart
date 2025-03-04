import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// 你项目的引用，略...
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
import '../canvas/models/canvas_interaction_mode.dart';

class GraphEditor extends ConsumerWidget {
  final String workflowId;
  final NodeController nodeController;
  final EdgeController? edgeController;
  final CanvasVisualConfig visualConfig;
  final CanvasBehavior canvasBehavior;

  // 1) 在这定义一个 key（全局或静态都行，这里用静态示例）
  static final GlobalKey canvasStackKey = GlobalKey();

  const GraphEditor({
    Key? key,
    required this.workflowId,
    required this.nodeController,
    this.edgeController,
    required this.visualConfig,
    required this.canvasBehavior,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // 拿到当前画布状态
    final canvasState = ref.watch(multiCanvasStateProvider).activeState;
    // 拿到 Notifier
    final multiCanvasNotifier = ref.read(multiCanvasStateProvider.notifier);

    // 2) 把 key 注入给 Notifier，让它能用 stackKey 做 globalToLocal
    multiCanvasNotifier.stackKey = canvasStackKey;

    return Scaffold(
      appBar: AppBar(
        title: Text('GraphEditor (workflow = $workflowId)'),
        actions: [
          IconButton(
            onPressed: canvasBehavior.resetView, // 如果你在 canvasBehavior 里有自定义逻辑
            icon: const Icon(Icons.fit_screen),
          ),
        ],
      ),
      body: CanvasGestureHandler(
        // CanvasGestureHandler 中捕获指针事件，调用 startDrag / updateDrag / endDrag
        child: CanvasController(
          workflowId: workflowId,
          visualConfig: visualConfig,
          // 3) 用同一个 key
          canvasGlobalKey: canvasStackKey,

          // offset 和 scale 来自全局状态
          offset: canvasState.offset,
          scale: canvasState.scale,
        ),
      ),
      floatingActionButton: _buildFloatingActions(ref),
    );
  }

  Widget _buildFloatingActions(WidgetRef ref) {
    final multiCanvasNotifier = ref.read(multiCanvasStateProvider.notifier);
    final currentMode = ref.watch(multiCanvasStateProvider).activeState.mode;

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        // 新增一个节点
        FloatingActionButton(
          onPressed: _addNodeExample,
          heroTag: 'addNode',
          child: const Icon(Icons.add),
        ),
        const SizedBox(height: 8),

        // 删除最后一个节点
        FloatingActionButton(
          onPressed: _removeLastNodeExample,
          heroTag: 'removeNode',
          child: const Icon(Icons.remove),
        ),
        const SizedBox(height: 8),

        // 切换到 "editNode" 模式
        FloatingActionButton(
          onPressed: () {
            multiCanvasNotifier.setInteractionMode(CanvasInteractionMode.editNode);
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
              multiCanvasNotifier.setInteractionMode(CanvasInteractionMode.panCanvas);
            } else {
              multiCanvasNotifier.setInteractionMode(CanvasInteractionMode.editNode);
            }
          },
          heroTag: 'toggleMode',
          child: const Icon(Icons.swap_horiz),
        ),
        const SizedBox(height: 8),

        // 平移画布 (向右移动10px)
        FloatingActionButton(
          onPressed: () => multiCanvasNotifier.panBy(10, 0),
          heroTag: 'panRight',
          child: const Icon(Icons.arrow_right),
        ),
        const SizedBox(height: 8),

        // 放大
        FloatingActionButton(
          onPressed: () => multiCanvasNotifier.zoomAtPoint(1.1, Offset.zero),
          heroTag: 'zoomIn',
          child: const Icon(Icons.zoom_in),
        ),
        const SizedBox(height: 8),

        // 缩小
        FloatingActionButton(
          onPressed: () => multiCanvasNotifier.zoomAtPoint(0.9, Offset.zero),
          heroTag: 'zoomOut',
          child: const Icon(Icons.zoom_out),
        ),
        const SizedBox(height: 8),

        // 重置画布
        FloatingActionButton(
          onPressed: () => multiCanvasNotifier.resetCanvas(),
          heroTag: 'resetCanvas',
          child: const Icon(Icons.refresh),
        ),
      ],
    );
  }

  /// 示例: 添加一个新的节点
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

  /// 示例: 移除最后一个节点
  void _removeLastNodeExample() {
    final allNodes = nodeController.getAllNodes();
    if (allNodes.isEmpty) return;
    final lastNode = allNodes.last;
    nodeController.removeNode(lastNode.id);
  }
}