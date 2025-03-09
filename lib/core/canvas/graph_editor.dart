// file: graph_editor.dart

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// ======= 你项目中的导入，需根据实际修改 =======
import 'package:flow_editor/core/node/controllers/node_controller.dart';
import 'package:flow_editor/core/edge/controllers/edge_controller.dart';
import 'package:flow_editor/core/node/models/node_model.dart';
import 'package:flow_editor/core/edge/models/edge_model.dart';
import 'package:flow_editor/core/anchor/models/anchor_model.dart';
import 'package:flow_editor/core/anchor/models/anchor_enums.dart';
import 'package:flow_editor/core/types/position_enum.dart';
import 'package:flow_editor/core/canvas/controllers/canvas_controller.dart';
import 'package:flow_editor/core/canvas/models/canvas_visual_config.dart';
import 'package:flow_editor/core/canvas/behaviors/canvas_behavior.dart';
import 'package:flow_editor/core/canvas/interaction/gesture_event_handler.dart';
import 'package:flow_editor/core/canvas/canvas_state/canvas_state_provider.dart';

// ============== 示例：GraphEditor ==============
class GraphEditor extends ConsumerStatefulWidget {
  final String workflowId;

  /// Node 与 Edge 的控制器，用于增删改节点、连线等
  final NodeController nodeController;
  final EdgeController? edgeController; // 可能为 null

  /// 画布外观配置
  final CanvasVisualConfig visualConfig;

  /// 画布行为(如 resetView 等)
  final CanvasBehavior canvasBehavior;

  /// 全局Key (若需要在画布层面做 globalToLocal)
  static final GlobalKey canvasStackKey = GlobalKey();

  const GraphEditor({
    super.key,
    required this.workflowId,
    required this.nodeController,
    this.edgeController,
    required this.visualConfig,
    required this.canvasBehavior,
  });

  @override
  ConsumerState<GraphEditor> createState() => _GraphEditorState();
}

class _GraphEditorState extends ConsumerState<GraphEditor> {
  @override
  void initState() {
    super.initState();

    // 在首帧渲染后，切换到指定 workflow 并初始化示例数据
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // 1. 切换到对应 workflow
      ref
          .read(multiCanvasStateProvider.notifier)
          .switchWorkflow(widget.workflowId);

      // 2. 插入示例节点 & 边
      _initSampleData();

      // 3. 如果遇到首帧节点位置可能不准的问题，可再加一次刷新：
      //    WidgetsBinding.instance.addPostFrameCallback((__) {
      //      setState(() {
      //        // 触发一次重绘，让新插入的节点位置与画布变换完全同步
      //      });
      //    });
    });
  }

  /// 在这里插入“示例节点 + 边”
  void _initSampleData() {
    // 定义两个节点 ID
    const nodeAId = 'nodeA';
    const nodeBId = 'nodeB';

    // 1. 创建节点 A
    final nodeA = NodeModel(
      id: nodeAId,
      x: 100,
      y: 100,
      width: 80,
      height: 40,
      title: 'Node A',
      anchors: [
        AnchorModel(
          id: 'out_$nodeAId',
          nodeId: nodeAId,
          position: Position.right,
          placement: AnchorPlacement.outside,
          offsetDistance: 10,
          ratio: 0.5,
          width: 24,
          height: 24,
        ),
        AnchorModel(
          id: 'in_$nodeAId',
          nodeId: nodeAId,
          position: Position.left,
          placement: AnchorPlacement.outside,
          offsetDistance: 10,
          width: 24,
          height: 24,
        ),
      ],
    );

    // 2. 创建节点 B
    final nodeB = NodeModel(
      id: nodeBId,
      x: 300,
      y: 120,
      width: 80,
      height: 40,
      title: 'Node B',
      anchors: [
        AnchorModel(
          id: 'in_$nodeBId',
          nodeId: nodeBId,
          position: Position.left,
          placement: AnchorPlacement.outside,
          offsetDistance: 10,
          ratio: 0.5,
          width: 24,
          height: 24,
        ),
      ],
    );

    // 3. 通过 nodeController 插入节点
    widget.nodeController.upsertNode(nodeA);
    widget.nodeController.upsertNode(nodeB);

    // 4. 若存在 edgeController，则创建一条边 AB
    if (widget.edgeController != null) {
      const edgeId = 'edgeAB';
      const edge = EdgeModel(
        id: edgeId,
        // 注意 EdgeModel 构造器字段是 sourceNodeId / sourceAnchorId / targetNodeId / targetAnchorId
        sourceNodeId: nodeAId,
        sourceAnchorId: 'out_$nodeAId',
        targetNodeId: nodeBId,
        targetAnchorId: 'in_$nodeBId',
        isConnected: true,
      );
      widget.edgeController!.createEdge(edge);
    }
  }

  @override
  Widget build(BuildContext context) {
    // 监听当前 workflow 对应的 CanvasState
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
      // 在这里使用 CanvasGestureHandler + CanvasController 组合
      body: CanvasGestureHandler(
        child: CanvasController(
          workflowId: widget.workflowId,
          visualConfig: widget.visualConfig,
          canvasGlobalKey: GraphEditor.canvasStackKey,
          offset: canvasState.offset,
          scale: canvasState.scale,
        ),
      ),
      floatingActionButton: _buildFloatingActions(),
    );
  }

  /// 示例：一些简单的 FAB 按钮操作
  Widget _buildFloatingActions() {
    final multiCanvasNotifier = ref.read(multiCanvasStateProvider.notifier);

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

  /// 动态添加一个示例节点
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
          ratio: 0.5,
          width: 24,
          height: 24,
        ),
        AnchorModel(
          id: 'in_$newId',
          nodeId: newId,
          position: Position.left,
          placement: AnchorPlacement.outside,
          offsetDistance: 10,
          ratio: 0.5,
          width: 24,
          height: 24,
        ),
      ],
    );
    widget.nodeController.upsertNode(node);
  }

  /// 动态删除最后一个节点
  void _removeLastNodeExample() {
    final allNodes = widget.nodeController.getAllNodes();
    if (allNodes.isEmpty) return;
    final lastNode = allNodes.last;
    widget.nodeController.removeNode(lastNode.id);
  }
}
