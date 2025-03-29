// file: graph_editor_test.dart

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:flow_editor/core/node/behaviors/node_behavior.dart';
import 'package:flow_editor/core/node/models/node_enums.dart';
import 'package:flow_editor/core/edge/behaviors/edge_behavior.dart';
import 'package:flow_editor/core/anchor/behaviors/anchor_behavior.dart';
import 'package:flow_editor/core/node/models/node_model.dart';
import 'package:flow_editor/core/anchor/models/anchor_model.dart';
import 'package:flow_editor/core/anchor/models/anchor_enums.dart';
import 'package:flow_editor/core/types/position_enum.dart';
import 'package:flow_editor/core/canvas/behaviors/canvas_behavior.dart';
import 'package:flow_editor/core/canvas/models/canvas_visual_config.dart';
import 'package:flow_editor/core/canvas/interaction/gesture_event_handler.dart';
import 'package:flow_editor/core/canvas/interaction/mouse_event_handler.dart';
import 'package:flow_editor/core/canvas/canvas_state/canvas_state_provider.dart';
import 'package:flow_editor/core/canvas/canvas_state/canvas_state.dart';
import 'package:flow_editor/core/canvas/widgets/canvas_widget.dart';

// =========== NodeWidget / NodeWidgetRegistry / NodeWidgetFactory ===========
import 'package:flow_editor/core/node/widgets/workflows/base/node_widget.dart';
import 'package:flow_editor/core/node/node_widget_registry.dart';
import 'package:flow_editor/core/node/factories/node_widget_factory.dart';
import 'package:flow_editor/core/node/factories/node_widget_factory_impl.dart';
import 'package:flow_editor/core/logic/strategy/workflow_mode.dart';
import 'package:flow_editor/core/graph_editor/node_list_widget.dart';

/// GraphEditor：左侧节点列表 + 右侧画布区域
class GraphEditor extends ConsumerStatefulWidget {
  final String workflowId;
  final NodeBehavior nodeBehavior;
  final EdgeBehavior edgeBehavior;
  final AnchorBehavior anchorBehavior;
  final CanvasVisualConfig visualConfig;
  final CanvasBehavior canvasBehavior;

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
  late final NodeWidgetFactory nodeFactory;
  late final List<NodeModel> availableNodes;

  @override
  void initState() {
    super.initState();

    // 1. 创建并注册默认节点类型
    final registry = NodeWidgetRegistry();
    registry.register<NodeModel>(
      type: 'default',
      builder: (node) => NodeWidget(
        node: node,
        behavior: widget.nodeBehavior,
        anchorBehavior: widget.anchorBehavior,
      ),
      useDefaultContainer: false,
    );

    nodeFactory = NodeWidgetFactoryImpl(
      registry: registry,
      nodeBehavior: widget.nodeBehavior,
      anchorBehavior: widget.anchorBehavior,
    );

    // 2. 初始化可用节点（示例，不包含 start/end）
    availableNodes = [
      NodeModel(
        id: 'task_template',
        role: NodeRole.middle,
        x: 0,
        y: 0,
        width: 100,
        height: 80,
        title: 'Task',
        anchors: [],
      ),
      NodeModel(
        id: 'choice_template',
        role: NodeRole.custom,
        x: 0,
        y: 0,
        width: 120,
        height: 80,
        title: 'Choice',
        anchors: [],
      ),
      NodeModel(
        id: 'placeholder_template',
        role: NodeRole.placeholder,
        x: 0,
        y: 0,
        width: 100,
        height: 80,
        title: 'Placeholder',
        anchors: [],
      ),
    ];

    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref
          .read(multiCanvasStateProvider.notifier)
          .switchWorkflow(widget.workflowId);
      ref.read(multiCanvasStateProvider.notifier).setWorkflowMode(
            widget.workflowId,
            WorkflowMode.stateMachine,
          );
    });
  }

  @override
  Widget build(BuildContext context) {
    final canvasState = ref.watch(multiCanvasStateProvider).activeState;

    return Scaffold(
      appBar: AppBar(
        title: Text('GraphEditor (workflow = ${widget.workflowId})'),
      ),
      body: Row(
        children: [
          // 左侧节点列表
          NodeListWidget(
            availableNodes: availableNodes,
            onDragCompleted: (nodeTemplate) {},
          ),
          // 右侧画布区域
          Expanded(
            child: _buildCanvasArea(canvasState),
          ),
        ],
      ),
      floatingActionButton: _buildFloatingActions(),
    );
  }

  Widget _buildCanvasArea(CanvasState canvasState) {
    return Center(
      child: Container(
        width: 1200,
        height: 800,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.blueAccent, width: 2),
        ),
        child: ClipRect(
          child: DragTarget<NodeModel>(
            onWillAcceptWithDetails: (details) => true,
            onAcceptWithDetails: (details) {
              final renderBox = GraphEditor.canvasStackKey.currentContext
                  ?.findRenderObject() as RenderBox?;
              if (renderBox == null) {
                return;
              }
              final localPos = renderBox.globalToLocal(details.offset);
              final canvasX =
                  (localPos.dx - canvasState.offset.dx) / canvasState.scale;
              final canvasY =
                  (localPos.dy - canvasState.offset.dy) / canvasState.scale;

              final newId = 'node_${DateTime.now().millisecondsSinceEpoch}';
              final newNode = NodeModel(
                id: newId,
                type: 'default', // keep consistent with registry
                x: canvasX,
                y: canvasY,
                width: 100,
                height: 80,
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
              widget.nodeBehavior.nodeController.upsertNode(newNode);
            },
            builder: (context, candidateData, rejectedData) {
              return CanvasMouseHandler(
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
                    nodeWidgetFactory: nodeFactory,
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

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
          onPressed: () {
            multiCanvasNotifier.panBy(10, 0);
            debugPrint('>>> Pan by (10, 0)');
          },
          heroTag: 'panRight',
          child: const Icon(Icons.arrow_right),
        ),
        const SizedBox(height: 8),
        FloatingActionButton(
          onPressed: () {
            multiCanvasNotifier.zoomAtPoint(1.1, Offset.zero);
            debugPrint('>>> Zoom in (1.1) at Offset.zero');
          },
          heroTag: 'zoomIn',
          child: const Icon(Icons.zoom_in),
        ),
        const SizedBox(height: 8),
        FloatingActionButton(
          onPressed: () {
            multiCanvasNotifier.zoomAtPoint(0.9, Offset.zero);
            debugPrint('>>> Zoom out (0.9) at Offset.zero');
          },
          heroTag: 'zoomOut',
          child: const Icon(Icons.zoom_out),
        ),
        const SizedBox(height: 8),
        FloatingActionButton(
          onPressed: () {
            multiCanvasNotifier.resetCanvas();
            debugPrint('>>> ResetCanvas');
          },
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
      type: 'default',
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
    debugPrint('>>> Manually addNodeExample: $newId');
    widget.nodeBehavior.nodeController.upsertNode(node);
  }

  void _removeLastNodeExample() {
    final allNodes = widget.nodeBehavior.nodeController.getAllNodes();
    if (allNodes.isEmpty) return;
    final lastNode = allNodes.last;
    debugPrint('>>> removeLastNodeExample: removing ${lastNode.id}');
    widget.nodeBehavior.nodeController.removeNode(lastNode.id);
  }
}
