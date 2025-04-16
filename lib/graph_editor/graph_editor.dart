// lib/flow_editor/core/graph_editor/graph_editor.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Core & FlowEditor Imports
import 'package:flow_editor/core/node/behaviors/node_behavior.dart';
import 'package:flow_editor/core/edge/behaviors/edge_behavior.dart';
import 'package:flow_editor/core/anchor/behaviors/anchor_behavior.dart';
import 'package:flow_editor/core/canvas/behaviors/canvas_behavior.dart';
import 'package:flow_editor/core/canvas/models/canvas_visual_config.dart';
import 'package:flow_editor/core/canvas/canvas_state/canvas_state_provider.dart';

// Node-Related Imports
import 'package:flow_editor/core/node/models/node_model.dart';
import 'package:flow_editor/core/node/factories/node_widget_factory.dart';
import 'package:flow_editor/core/node/factories/node_widget_factory_impl.dart';

// Logic & Types
import 'package:flow_editor/core/logic/strategy/workflow_mode.dart';
import 'package:flow_editor/core/node/models/node_enums.dart';

// UI Imports：侧边栏、画布与浮动操作
import 'graph_editor_sidebar.dart';
import 'graph_editor_canvas.dart';
import 'graph_editor_actions.dart';
import 'node_widget_registry_initializer.dart';
import 'node_list_widget.dart';

/// GraphEditor：主要负责组合各个子模块，管理侧边栏与画布状态
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
  late List<NodeModel> availableNodes;

  // 控制侧边栏是否折叠
  bool isSidebarCollapsed = false;

  @override
  void initState() {
    super.initState();
    debugPrint('=== GraphEditor initState ===');

    // 1. 注册节点类型与构建节点工厂
    final registry = initNodeWidgetRegistry();
    nodeFactory = NodeWidgetFactoryImpl(
      registry: registry,
      nodeBehavior: widget.nodeBehavior,
      anchorBehavior: widget.anchorBehavior,
    );
    debugPrint('=== NodeWidgetFactoryImpl created ===');

    // 2. 初始化左侧节点模板数据
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
        '=== availableNodes initialized, count=${availableNodes.length} ===');

    // 3. 后续切换 workflow 与模式
    WidgetsBinding.instance.addPostFrameCallback((_) {
      debugPrint('=== PostFrame: switchWorkflow & setWorkflowMode ===');
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
    final canvasState = ref.watch(multiCanvasStateProvider).activeState;

    return Scaffold(
      appBar: AppBar(title: const Text('GraphEditor (No Animation)')),
      body: Row(
        children: [
          // 使用侧边栏模块，并传递折叠状态、模板数据与完整列表组件（NodeListWidget）
          _buildSidebar(),
          // 画布区域采用 canvas 模块
          Expanded(
              child: GraphEditorCanvas(
            canvasState: canvasState,
            workflowId: widget.workflowId,
            nodeBehavior: widget.nodeBehavior,
            edgeBehavior: widget.edgeBehavior,
            anchorBehavior: widget.anchorBehavior,
            visualConfig: widget.visualConfig,
            canvasBehavior: widget.canvasBehavior,
            nodeFactory: nodeFactory,
          )),
        ],
      ),
      // 浮动操作使用独立模块
      floatingActionButton: GraphEditorActions(
        nodeBehavior: widget.nodeBehavior,
        canvasState: canvasState,
      ),
    );
  }

  Widget _buildSidebar() {
    final sidebarWidth = isSidebarCollapsed ? 60.0 : 240.0;
    return Container(
      width: sidebarWidth,
      color: Colors.grey.shade100,
      child: Column(
        children: [
          // 展开/折叠按钮
          Align(
            alignment: Alignment.topRight,
            child: IconButton(
              icon: Icon(isSidebarCollapsed
                  ? Icons.arrow_forward_ios
                  : Icons.arrow_back_ios),
              onPressed: () {
                setState(() {
                  isSidebarCollapsed = !isSidebarCollapsed;
                });
              },
            ),
          ),
          // 根据折叠状态展示不同内容
          Expanded(
            child: isSidebarCollapsed
                ? GraphEditorSidebar.collapsed(availableNodes: availableNodes)
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
}
