import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// 你的现有 Controller/State
import '../node/controllers/node_controller.dart'; // 你已有的 NodeController
import '../edge/controllers/edge_controller.dart'; // 假设也有个 EdgeController                 // NodeEventCallback, etc. if needed
import '../node/models/node_model.dart';
import '../anchor/models/anchor_model.dart';
import '../types/position_enum.dart';

// 画布
import '../canvas/controllers/canvas_controller.dart';
import '../canvas/models/canvas_visual_config.dart';

// 你可以再导入 nodeBehavior, anchorBehavior, edgeBehavior 等

class GraphEditor extends ConsumerStatefulWidget {
  /// 唯一工作流 ID
  final String workflowId;

  /// Node/Edge 控制器
  final NodeController nodeController;
  final EdgeController? edgeController; // 如果需要

  /// 可视化配置
  final CanvasVisualConfig visualConfig;

  /// 初始平移/缩放
  final Offset initialOffset;
  final double initialScale;

  const GraphEditor({
    Key? key,
    required this.workflowId,
    required this.nodeController,
    this.edgeController,
    required this.visualConfig,
    this.initialOffset = Offset.zero,
    this.initialScale = 1.0,
  }) : super(key: key);

  @override
  ConsumerState<GraphEditor> createState() => _GraphEditorState();
}

class _GraphEditorState extends ConsumerState<GraphEditor> {
  /// 画布全局Key (给 CanvasController / CanvasRenderer 用)
  final _canvasGlobalKey = GlobalKey();

  // 画布的平移/缩放
  Offset _canvasOffset = Offset.zero;
  double _canvasScale = 1.0;

  // 拖拽节点中间状态
  String? _draggingNodeId;
  Offset? _lastPointerPos;

  @override
  void initState() {
    super.initState();

    // 用外部传进来的初始值
    _canvasOffset = widget.initialOffset;
    _canvasScale = widget.initialScale;

    // 如果你给 NodeController 传了 onNodeAdded / onNodeRemoved，也会在此生效
    // widget.nodeController.onNodeAdded = (node) => ...
  }

  @override
  Widget build(BuildContext context) {
    // 1) 读 Node/Edge State: watch => 当节点/边变化时重绘
    // final nodeState = ref.watch(nodeStateProvider(widget.workflowId));
    // final edgeState = ref.watch(edgeStateProvider(widget.workflowId));

    return Scaffold(
      appBar: AppBar(
        title: Text("GraphEditor (workflow = ${widget.workflowId})"),
        actions: [
          IconButton(onPressed: _fitView, icon: const Icon(Icons.fit_screen)),
        ],
      ),
      body: Stack(
        children: [
          // ----- 拖拽/指针事件
          Listener(
            onPointerDown: _onPointerDown,
            onPointerMove: _onPointerMove,
            onPointerUp: _onPointerUp,
            child: ClipRect(
              child: Transform(
                transform: Matrix4.identity()
                  ..translate(-_canvasOffset.dx * _canvasScale,
                      -_canvasOffset.dy * _canvasScale)
                  ..scale(_canvasScale),
                alignment: Alignment.topLeft,
                child: Stack(
                  children: [
                    // 2) CanvasController 绘制节点/边 (可选看你架构)
                    CanvasController(
                      workflowId: widget.workflowId,
                      visualConfig: widget.visualConfig,
                      canvasGlobalKey: _canvasGlobalKey,
                      offset: Offset.zero, // transform已经在外面处理
                      scale: 1.0,
                    ),
                    // ... 也可以加别的 Widget, selectionBox, overlay, etc.
                  ],
                ),
              ),
            ),
          ),
          // ----- 左下角的操作面板
          Positioned(
            left: 10,
            bottom: 10,
            child: Column(
              children: [
                ElevatedButton(
                  onPressed: _addNodeExample,
                  child: const Text("Add Node"),
                ),
                const SizedBox(height: 8),
                ElevatedButton(
                  onPressed: _removeLastNodeExample,
                  child: const Text("Remove Last Node"),
                ),
                const SizedBox(height: 8),
                ElevatedButton(
                  onPressed: _panRight,
                  child: const Text("Pan Right"),
                ),
                const SizedBox(height: 8),
                ElevatedButton(
                  onPressed: _zoomIn,
                  child: const Text("Zoom In"),
                ),
                const SizedBox(height: 8),
                ElevatedButton(
                  onPressed: _zoomOut,
                  child: const Text("Zoom Out"),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ========== 拖拽节点逻辑: 改成用 NodeController? ==========

  Offset screenToWorld(Offset screenPos) {
    return screenPos / _canvasScale + _canvasOffset;
  }

  void _onPointerDown(PointerDownEvent event) {
    final worldPos = screenToWorld(event.localPosition);
    // 根据 NodeController or nodeStateProvider hitTest
    final node = _hitTestNode(worldPos);
    if (node != null) {
      _draggingNodeId = node.id;
    } else {
      _draggingNodeId = null;
    }
    _lastPointerPos = event.localPosition;
  }

  void _onPointerMove(PointerMoveEvent event) {
    if (_draggingNodeId != null && _lastPointerPos != null) {
      final deltaScreen = event.localPosition - _lastPointerPos!;
      final deltaWorld = deltaScreen / _canvasScale;
      // 用 NodeController 移动节点
      final node = widget.nodeController.getNode(_draggingNodeId!);
      if (node != null) {
        final updated = node.copyWith(
          x: node.x + deltaWorld.dx,
          y: node.y + deltaWorld.dy,
        );
        widget.nodeController.upsertNode(updated);
      }
    }
    _lastPointerPos = event.localPosition;
  }

  void _onPointerUp(PointerUpEvent event) {
    _draggingNodeId = null;
    _lastPointerPos = null;
  }

  NodeModel? _hitTestNode(Offset worldPos) {
    // 你可以直接从 NodeController 里获取所有节点, 做碰撞检测
    final nodes = widget.nodeController.getAllNodes();
    for (final node in nodes) {
      final rect = Rect.fromLTWH(node.x, node.y, node.width, node.height);
      if (rect.contains(worldPos)) {
        return node;
      }
    }
    return null;
  }

  // ========== 示例: 使用 NodeController 新增/删除节点 ==========

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
    widget.nodeController.upsertNode(node);
  }

  void _removeLastNodeExample() {
    final allNodes = widget.nodeController.getAllNodes();
    if (allNodes.isEmpty) return;
    final lastNode = allNodes.last;
    widget.nodeController.removeNode(lastNode.id);
  }

  // ========== 平移/缩放 ==========

  void _panRight() {
    setState(() {
      _canvasOffset += const Offset(10, 0);
    });
  }

  void _zoomIn() {
    setState(() {
      _canvasScale *= 1.1;
    });
  }

  void _zoomOut() {
    setState(() {
      _canvasScale /= 1.1;
    });
  }

  void _fitView() {
    final allNodes = widget.nodeController.getAllNodes();
    if (allNodes.isEmpty) return;

    double minX = double.infinity, minY = double.infinity;
    double maxX = -double.infinity, maxY = -double.infinity;
    for (final node in allNodes) {
      minX = min(minX, node.x);
      minY = min(minY, node.y);
      maxX = max(maxX, node.x + node.width);
      maxY = max(maxY, node.y + node.height);
    }
    final nodesWidth = maxX - minX;
    final nodesHeight = maxY - minY;
    if (nodesWidth <= 0 || nodesHeight <= 0) return;

    final size = MediaQuery.of(context).size;
    const margin = 20.0;
    final scaleX = (size.width - margin * 2) / nodesWidth;
    final scaleY = (size.height - margin * 2) / nodesHeight;
    final newScale = min(scaleX, scaleY);
    final centerX = (minX + maxX) / 2;
    final centerY = (minY + maxY) / 2;
    final offsetX = (size.width / newScale) / 2 - centerX;
    final offsetY = (size.height / newScale) / 2 - centerY;

    setState(() {
      _canvasScale = newScale;
      _canvasOffset = Offset(offsetX, offsetY);
    });
  }
}
