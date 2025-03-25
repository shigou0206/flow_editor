// file: graph_editor.dart

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:flow_editor/core/node/behaviors/node_behavior.dart';
import 'package:flow_editor/core/edge/behaviors/edge_behavior.dart';
import 'package:flow_editor/core/anchor/behaviors/anchor_behavior.dart';
import 'package:flow_editor/core/node/models/node_model.dart';
import 'package:flow_editor/core/edge/models/edge_model.dart';
import 'package:flow_editor/core/anchor/models/anchor_model.dart';
import 'package:flow_editor/core/anchor/models/anchor_enums.dart';
import 'package:flow_editor/core/types/position_enum.dart';
import 'package:flow_editor/core/canvas/behaviors/canvas_behavior.dart';
import 'package:flow_editor/core/canvas/models/canvas_visual_config.dart';
import 'package:flow_editor/core/canvas/interaction/gesture_event_handler.dart';
import 'package:flow_editor/core/canvas/interaction/mouse_event_handler.dart';
import 'package:flow_editor/core/canvas/canvas_state/canvas_state_provider.dart';
import 'package:flow_editor/core/canvas/widgets/canvas_widget.dart';

// =========== 新增：导入 NodeWidget / NodeWidgetRegistry / NodeWidgetFactory ===========
import 'package:flow_editor/core/node/widgets/workflows/base/node_widget.dart';
import 'package:flow_editor/core/node/node_widget_registry.dart';
import 'package:flow_editor/core/node/factories/node_widget_factory.dart';
import 'package:flow_editor/core/node/factories/node_widget_factory_impl.dart';

/// GraphEditor(改造版):
/// - 保留原有逻辑：插入示例节点、示例边
/// - 使用 CanvasGestureHandler + CanvasWidget
/// - 新增 NodeWidgetRegistry + NodeWidgetFactory，用来渲染默认节点
class GraphEditor extends ConsumerStatefulWidget {
  final String workflowId; // 唯一标识某个工作流

  /// Node 与 Edge 的控制器，用于增删改节点、连线等
  final NodeBehavior nodeBehavior;
  final EdgeBehavior edgeBehavior;
  final AnchorBehavior anchorBehavior;

  /// 画布外观配置
  final CanvasVisualConfig visualConfig;

  /// 画布行为(如 resetView 等)
  final CanvasBehavior canvasBehavior;

  /// 全局Key (若需要在画布层面做 globalToLocal)
  static final GlobalKey canvasStackKey = GlobalKey();

  const GraphEditor({
    super.key,
    required this.workflowId,
    required this.nodeBehavior,
    required this.edgeBehavior,
    required this.anchorBehavior,
    required this.visualConfig,
    required this.canvasBehavior,
  });

  @override
  ConsumerState<GraphEditor> createState() => _GraphEditorState();
}

class _GraphEditorState extends ConsumerState<GraphEditor> {
  /// 我们在这里持有一个 nodeWidgetFactory，
  /// 用于给 CanvasWidget / CanvasRenderer 渲染节点
  late final NodeWidgetFactory nodeFactory;

  @override
  void initState() {
    super.initState();

    // 1. 创建并注册一个"默认"节点类型，让它使用 NodeWidget 渲染
    final registry = NodeWidgetRegistry();
    registry.register<NodeModel>(
      type: 'default',
      // 此处可任意写法，比如把 node.title 作为 body
      builder: (node) => NodeWidget(
        node: node,
        behavior: widget.nodeBehavior,
        anchorBehavior: widget.anchorBehavior,
      ),
      useDefaultContainer: false,
    );

    // 2. 用这个 registry 构建工厂，并注入 behavior（可选）
    nodeFactory = NodeWidgetFactoryImpl(
      registry: registry,
      nodeBehavior: widget.nodeBehavior,
      anchorBehavior: widget.anchorBehavior,
    );

    // 3. 首帧渲染后，切换到对应 workflow 并插入示例数据
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // 切换 workflow
      ref
          .read(multiCanvasStateProvider.notifier)
          .switchWorkflow(widget.workflowId);

      // 插入示例节点 & 边
      _initSampleData();
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
      type: 'default', // 关键：指定type为"default"
      x: 100,
      y: 100,
      width: 100,
      height: 100,
      title: 'Node A',
      anchors: [
        AnchorModel(
          id: 'out_$nodeAId',
          nodeId: nodeAId,
          position: Position.right,
          placement: AnchorPlacement.border,
          offsetDistance: 0,
          ratio: 0.65,
          width: 12,
          height: 12,
          shape: AnchorShape.diamond,
        ),
        AnchorModel(
          id: 'in_$nodeAId',
          nodeId: nodeAId,
          position: Position.left,
          placement: AnchorPlacement.border,
          offsetDistance: 0,
          ratio: 0.65,
          width: 12,
          height: 12,
          shape: AnchorShape.square,
        ),
      ],
    );

    // 2. 创建节点 B
    final nodeB = NodeModel(
      id: nodeBId,
      type: 'default', // 同样设为"default"
      x: 300,
      y: 120,
      width: 100,
      height: 100,
      title: 'Node B',
      anchors: [
        AnchorModel(
          id: 'in_$nodeBId',
          nodeId: nodeBId,
          position: Position.left,
          placement: AnchorPlacement.border,
          offsetDistance: 0,
          ratio: 0.65,
          width: 24,
          height: 24,
        ),
      ],
    );

    // 3. 通过 nodeController 插入节点
    widget.nodeBehavior.nodeController.upsertNode(nodeA);
    widget.nodeBehavior.nodeController.upsertNode(nodeB);

    // 4. 创建一条边 A->B
    const edgeId = 'edgeAB';
    const edge = EdgeModel(
      id: edgeId,
      sourceNodeId: nodeAId,
      sourceAnchorId: 'out_$nodeAId',
      targetNodeId: nodeBId,
      targetAnchorId: 'in_$nodeBId',
      isConnected: true,
    );
    widget.edgeBehavior.edgeController.createEdge(edge);
  }

  @override
  Widget build(BuildContext context) {
    // 监听当前 workflow 对应的 CanvasState
    final canvasState = ref.watch(multiCanvasStateProvider).activeState;

    return Scaffold(
      appBar: AppBar(
        title: Text('GraphEditor (workflow = ${widget.workflowId})'),
        actions: [
          // 你之前注释掉的按钮 (Fit Screen 等)，保持原样
          // IconButton(
          //   onPressed: () => widget.canvasBehavior.resetCanvas(),
          //   icon: const Icon(Icons.fit_screen),
          // ),
        ],
      ),
      // 保持之前的手势处理 & CanvasWidget
      body: CanvasMouseHandler(
        child: CanvasGestureHandler(
          behavior: widget.canvasBehavior,
          child: CanvasWidget(
            workflowId: widget.workflowId,
            visualConfig: widget.visualConfig,
            canvasGlobalKey: GraphEditor.canvasStackKey,
            offset: canvasState.offset,
            scale: canvasState.scale,
            nodeBehavior: widget.nodeBehavior,
            edgeBehavior: widget.edgeBehavior,
            anchorBehavior: widget.anchorBehavior,

            // 重点：把我们在 initState 里构造的 factory 传给 CanvasWidget
            nodeWidgetFactory: nodeFactory,
          ),
        ),
      ),
      floatingActionButton: _buildFloatingActions(),
    );
  }

  /// 保留你之前的一些简单FAB操作
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

  /// 动态添加一个节点
  void _addNodeExample() {
    final newId = 'new_${DateTime.now().millisecondsSinceEpoch}';
    final node = NodeModel(
      id: newId,
      type: 'default', // 同样指定为"default"
      x: 200,
      y: 200,
      width: 100,
      height: 100,
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
    widget.nodeBehavior.nodeController.upsertNode(node);
  }

  /// 动态删除最后一个节点
  void _removeLastNodeExample() {
    final allNodes = widget.nodeBehavior.nodeController.getAllNodes();
    if (allNodes.isEmpty) return;
    final lastNode = allNodes.last;
    widget.nodeBehavior.nodeController.removeNode(lastNode.id);
  }
}
