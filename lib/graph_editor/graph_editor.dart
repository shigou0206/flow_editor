import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// ------------------- Core & FlowEditor Imports -------------------
import 'package:flow_editor/del/behaviors/node_behavior.dart';
import 'package:flow_editor/del/behaviors/edge_behavior.dart';
import 'package:flow_editor/del/behaviors/anchor_behavior.dart';
import 'package:flow_editor/del/behaviors/canvas_behavior.dart';
import 'package:flow_editor/core/models/styles/canvas_visual_config.dart';
import 'package:flow_editor/core/widgets/gesture_event_handler.dart';
import 'package:flow_editor/core/widgets/mouse_event_handler.dart';
import 'package:flow_editor/core/widgets/canvas_widget.dart';
import 'package:flow_editor/core/state_management/providers/canvas_state_provider.dart';
import 'package:flow_editor/core/models/state/canvas_state.dart';
import 'package:flow_editor/core/node/plugins/node_action_callbacks.dart';

// ------------------- Node-Related Imports -------------------
import 'package:flow_editor/core/models/node_model.dart';
import 'package:flow_editor/core/models/anchor_model.dart';
import 'package:flow_editor/core/widgets/factories/node_widget_factory.dart';
import 'package:flow_editor/core/widgets/factories/node_widget_factory_impl.dart';

// ------------------- Logic -------------------
import 'package:flow_editor/core/logic/strategy/workflow_mode.dart';
import 'package:flow_editor/core/models/enums/node_enums.dart';
import 'package:flow_editor/core/models/enums/anchor_enums.dart';
import 'package:flow_editor/core/models/enums/position_enum.dart';

// ------------------- UI Widgets -------------------
import 'node_list_widget.dart';
import 'node_widget_registry_initializer.dart';

// ------------------- Plugins -------------------
import 'package:flow_editor/core/plugins/tools_plugin.dart';
import 'package:flow_editor/core/plugins/minimap_plugin.dart';

/// GraphEditor：当侧边栏收起时，不能拖拽节点；展开时才可拖拽
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
    // 默认的回调
    final defaultCallbacks = NodeActionCallbacks(
      onRun: _runNode,
      onStop: _stopNode,
      onDelete: _deleteNode,
      onMenu: _showMenu,
    );

    nodeFactory = NodeWidgetFactoryImpl(
      registry: registry,
      nodeBehavior: widget.nodeBehavior,
      anchorBehavior: widget.anchorBehavior,
      callbacks: defaultCallbacks,
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
          title: Text('GraphEditor (workflowId=${widget.workflowId})'),
        ),
        body: Row(
          children: [
            _buildSidebarNoAnimation(),
            Expanded(
              child: _buildCanvasArea(canvasState),
            ),
          ],
        ));
  }

  /// 去除动画，固定宽度，但区分展开/收起逻辑
  Widget _buildSidebarNoAnimation() {
    debugPrint(
        '_buildSidebarNoAnimation: isSidebarCollapsed=$isSidebarCollapsed');

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
          Expanded(
            // 如果折叠，就显示一个静态的占位；展开则显示带 Draggable 的节点列表
            child: isSidebarCollapsed
                ? _buildCollapsedPlaceholder()
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

  /// 收起时只显示一个简单占位，完全不能拖拽
  Widget _buildCollapsedPlaceholder() {
    debugPrint('_buildCollapsedPlaceholder: no drag allowed when collapsed');
    return Center(
      child: Container(
        padding: const EdgeInsets.all(8),
        child: const Text(
          'Sidebar Collapsed',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
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
                    ratio: 0.5,
                    size: const Size(24, 24),
                    shape: AnchorShape.diamond,
                  ),
                  AnchorModel(
                    id: 'in_$newId',
                    nodeId: newId,
                    position: Position.left,
                    placement: AnchorPlacement.border,
                    offsetDistance: 0,
                    ratio: 0.5,
                    size: const Size(24, 24),
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
                    plugins: [
                      Positioned(
                        left: 16,
                        bottom: 16,
                        child: ToolsPlugin(
                          nodeBehavior: widget.nodeBehavior,
                          viewportWidth: 1200,
                          viewportHeight: 800,
                        ),
                      ),
                      Positioned(
                        right: 16,
                        bottom: 16,
                        child: MinimapPlugin(
                          workflowId: widget.workflowId,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  void _runNode(NodeModel node) {
    debugPrint('Run Node => ${node.id}');
  }

  void _stopNode(NodeModel node) {
    debugPrint('Stop Node => ${node.id}');
  }

  void _deleteNode(NodeModel node) {
    debugPrint('Delete Node => ${node.id}');
    widget.nodeBehavior.nodeController.removeNode(node.id);
  }

  void _showMenu(NodeModel node) {
    debugPrint('Show menu for ${node.id}');
  }
}
