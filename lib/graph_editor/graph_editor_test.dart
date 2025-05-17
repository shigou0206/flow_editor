import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// ------------------- Core & FlowEditor Imports -------------------
import 'package:flow_editor/v1/core/node/behaviors/node_behavior.dart';
import 'package:flow_editor/v1/core/edge/behaviors/edge_behavior.dart';
import 'package:flow_editor/v1/core/anchor/behaviors/anchor_behavior.dart';
import 'package:flow_editor/v1/core/canvas/behaviors/canvas_behavior.dart';
import 'package:flow_editor/v1/core/canvas/models/canvas_visual_config.dart';
import 'package:flow_editor/v1/core/canvas/interaction/gesture_event_handler.dart';
import 'package:flow_editor/v1/core/canvas/interaction/mouse_event_handler.dart';
import 'package:flow_editor/v1/core/canvas/widgets/canvas_widget.dart';
import 'package:flow_editor/v1/core/canvas/canvas_state/canvas_state_provider.dart';
import 'package:flow_editor/v1/core/canvas/canvas_state/canvas_state.dart';

// ------------------- Node-Related Imports -------------------
import 'package:flow_editor/v1/core/node/models/node_model.dart';
import 'package:flow_editor/v1/core/node/factories/node_widget_factory.dart';
import 'package:flow_editor/v1/core/node/factories/node_widget_factory_impl.dart';

// ------------------- Logic -------------------
import 'package:flow_editor/v1/core/logic/strategy/workflow_mode.dart';
import 'package:flow_editor/v1/core/node/models/node_enums.dart';
import 'package:flow_editor/v1/core/anchor/models/anchor_model.dart';
import 'package:flow_editor/v1/core/anchor/models/anchor_enums.dart';
import 'package:flow_editor/v1/core/types/position_enum.dart';

// ------------------- UI Widgets -------------------
import 'node_list_widget.dart';
import 'node_widget_registry_initializer.dart';

/// GraphEditor：去除 AnimatedContainer，直接使用固定宽度的 Container 来验证折叠/展开逻辑
class GraphEditor extends ConsumerStatefulWidget {
  final String workflowId;
  final NodeBehavior nodeBehavior;
  final EdgeBehavior edgeBehavior;
  final AnchorBehavior anchorBehavior;
  final CanvasVisualConfig visualConfig;
  final CanvasBehavior canvasBehavior;

  /// 用于在画布上做坐标转换
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

  // 控制侧边栏是否折叠
  bool isSidebarCollapsed = false;

  @override
  void initState() {
    super.initState();
    debugPrint('=== GraphEditor _initState ===');

    // 1. 注册节点类型
    final registry = initNodeWidgetRegistry();
    debugPrint('=== initNodeWidgetRegistry done ===');

    // 2. 工厂
    nodeFactory = NodeWidgetFactoryImpl(
      registry: registry,
      nodeBehavior: widget.nodeBehavior,
      anchorBehavior: widget.anchorBehavior,
    );
    debugPrint('=== NodeWidgetFactoryImpl created ===');

    // 3. 左侧可拖拽节点列表
    availableNodes = [
      NodeModel(
        id: 'start_template',
        type: 'start',
        role: NodeRole.start,
        position: const Offset(0, 0),
        size: const Size(100, 80),
        title: 'Start',
        anchors: [],
      ),
      NodeModel(
        id: 'end_template',
        type: 'end',
        role: NodeRole.end,
        position: const Offset(0, 0),
        size: const Size(100, 80),
        title: 'End',
        anchors: [],
      ),
      NodeModel(
        id: 'placeholder_template',
        type: 'placeholder',
        role: NodeRole.placeholder,
        position: const Offset(0, 0),
        size: const Size(100, 80),
        title: 'Placeholder',
        anchors: [],
      ),
      NodeModel(
        id: 'middle_template',
        type: 'middle',
        role: NodeRole.middle,
        position: const Offset(0, 0),
        size: const Size(100, 80),
        title: 'Middle',
        anchors: [],
      ),
    ];
    debugPrint(
        '=== availableNodes initialized, length=${availableNodes.length} ===');

    // 4. 切换 workflow & mode
    WidgetsBinding.instance.addPostFrameCallback((_) {
      debugPrint(
          '=== addPostFrameCallback => switchWorkflow + setWorkflowMode ===');
      ref
          .read(multiCanvasStateProvider.notifier)
          .switchWorkflow(widget.workflowId);
      ref
          .read(multiCanvasStateProvider.notifier)
          .setWorkflowMode(widget.workflowId, WorkflowMode.stateMachine);
    });
  }

  @override
  Widget build(BuildContext context) {
    debugPrint(
        '=== GraphEditor build ===, isSidebarCollapsed=$isSidebarCollapsed');

    final canvasState = ref.watch(multiCanvasStateProvider).activeState;

    return Scaffold(
      appBar: AppBar(
        title: const Text('GraphEditor (No Animation)'),
      ),
      body: Row(
        children: [
          // 左侧固定宽度面板（非动画）
          _buildSidebarNoAnimation(),
          // 右侧画布
          Expanded(
            child: _buildCanvasArea(canvasState),
          ),
        ],
      ),
      floatingActionButton: _buildFloatingActions(),
    );
  }

  /// 使用普通 Container，去掉动画
  Widget _buildSidebarNoAnimation() {
    debugPrint(
        '_buildSidebarNoAnimation: isSidebarCollapsed=$isSidebarCollapsed');

    // 折叠时宽度 60，展开时宽度 240
    final sidebarWidth = isSidebarCollapsed ? 60.0 : 240.0;

    return Container(
      width: sidebarWidth,
      color: Colors.grey.shade100,
      child: Column(
        children: [
          // 折叠/展开按钮
          Align(
            alignment: Alignment.topRight,
            child: IconButton(
              icon: Icon(
                isSidebarCollapsed
                    ? Icons.arrow_forward_ios
                    : Icons.arrow_back_ios,
              ),
              onPressed: () {
                debugPrint('>>> onPressed => toggle isSidebarCollapsed');
                setState(() {
                  debugPrint('>>> setState before: $isSidebarCollapsed');
                  isSidebarCollapsed = !isSidebarCollapsed;
                  debugPrint('>>> setState after: $isSidebarCollapsed');
                });
              },
            ),
          ),
          // 如果折叠，就只显示图标；展开则显示完整NodeList
          Expanded(
            child: isSidebarCollapsed
                ? _buildCollapsedNodeList()
                : NodeListWidget(
                    availableNodes: availableNodes,
                    onDragCompleted: (nodeTemplate) {
                      debugPrint('Drag completed: ${nodeTemplate.type}');
                    },
                  ),
          ),
        ],
      ),
    );
  }

  /// 折叠状态下，简单展示可拖拽的几个图标（不显示文字）
  Widget _buildCollapsedNodeList() {
    debugPrint('_buildCollapsedNodeList');
    return ListView.builder(
      itemCount: availableNodes.length,
      itemBuilder: (context, index) {
        final template = availableNodes[index];
        // 用 Draggable 包裹一个简化的小方块或图标
        return Draggable<NodeModel>(
          data: template,
          feedback: Material(
            color: Colors.transparent,
            child: Container(
              padding: const EdgeInsets.all(6),
              color: Colors.blue.withOpacity(0.8),
              child: const Icon(Icons.add, color: Colors.white, size: 16),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Center(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.blue.shade200,
                  borderRadius: BorderRadius.circular(4),
                ),
                padding: const EdgeInsets.all(4),
                child: const Icon(Icons.add, size: 16, color: Colors.white),
              ),
            ),
          ),
        );
      },
    );
  }

  /// 画布区域
  Widget _buildCanvasArea(CanvasState canvasState) {
    debugPrint(
        '_buildCanvasArea: offset=${canvasState.offset}, scale=${canvasState.scale}');
    return Center(
      child: Container(
        width: 1200,
        height: 800,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.blueAccent, width: 2),
        ),
        child: ClipRect(
          child: DragTarget<NodeModel>(
            onWillAcceptWithDetails: (details) {
              debugPrint('onWillAcceptWithDetails: node=${details.data.title}');
              return true;
            },
            onAcceptWithDetails: (details) {
              debugPrint('onAcceptWithDetails: node=${details.data.title}');
              final renderBox = GraphEditor.canvasStackKey.currentContext
                  ?.findRenderObject() as RenderBox?;
              if (renderBox == null) {
                debugPrint('!!! RenderBox is null, cannot compute position');
                return;
              }

              final localPos = renderBox.globalToLocal(details.offset);
              final canvasX =
                  (localPos.dx - canvasState.offset.dx) / canvasState.scale;
              final canvasY =
                  (localPos.dy - canvasState.offset.dy) / canvasState.scale;

              final nodeTemplate = details.data;
              final newId = 'node_${DateTime.now().millisecondsSinceEpoch}';

              final newNode = NodeModel(
                id: newId,
                type: nodeTemplate.type,
                role: nodeTemplate.role,
                position: Offset(canvasX, canvasY),
                size: Size(nodeTemplate.size.width, nodeTemplate.size.height),
                title: nodeTemplate.title,
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
              debugPrint('+++ newNode => ${newNode.type}');
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

  /// 浮动按钮区域：平移 / 缩放 / 添加 / 删除 等操作
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
            debugPrint('>>> Pan by (10, 0)');
            multiCanvasNotifier.panBy(10, 0);
          },
          heroTag: 'panRight',
          child: const Icon(Icons.arrow_right),
        ),
        const SizedBox(height: 8),
        FloatingActionButton(
          onPressed: () {
            debugPrint('>>> Zoom in (1.1) at Offset.zero');
            multiCanvasNotifier.zoomAtPoint(1.1, Offset.zero);
          },
          heroTag: 'zoomIn',
          child: const Icon(Icons.zoom_in),
        ),
        const SizedBox(height: 8),
        FloatingActionButton(
          onPressed: () {
            debugPrint('>>> Zoom out (0.9) at Offset.zero');
            multiCanvasNotifier.zoomAtPoint(0.9, Offset.zero);
          },
          heroTag: 'zoomOut',
          child: const Icon(Icons.zoom_out),
        ),
        const SizedBox(height: 8),
        FloatingActionButton(
          onPressed: () {
            debugPrint('>>> ResetCanvas');
            multiCanvasNotifier.resetCanvas();
          },
          heroTag: 'resetCanvas',
          child: const Icon(Icons.refresh),
        ),
      ],
    );
  }

  /// 手动添加一个"middle"节点，仅供示例
  void _addNodeExample() {
    debugPrint('>>> _addNodeExample triggered');
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
    debugPrint('>>> Manually addNodeExample: $newId');
    widget.nodeBehavior.nodeController.upsertNode(node);
  }

  /// 删除最后一个节点
  void _removeLastNodeExample() {
    debugPrint('>>> _removeLastNodeExample triggered');
    final allNodes = widget.nodeBehavior.nodeController.getAllNodes();
    if (allNodes.isEmpty) {
      debugPrint('>>> No node to remove');
      return;
    }
    final lastNode = allNodes.last;
    debugPrint('>>> removeLastNodeExample: removing ${lastNode.id}');
    widget.nodeBehavior.nodeController.removeNode(lastNode.id);
  }
}
