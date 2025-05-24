import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flow_editor/core/models/node_model.dart';
import 'package:flow_editor/core/models/edge_model.dart';
import 'package:flow_editor/core/state_management/providers.dart';
import 'package:flow_editor/ui/canvas/sfn_editor_canvas.dart';
import 'package:flow_editor/ui/sidebar/nodes_sidebar.dart';
import 'package:flow_editor/core/state_management/theme_provider.dart';
import 'package:flow_editor/layout/sugiyama_layout.dart'; // ✅ 布局算法引入

class SfnEditorPage extends ConsumerStatefulWidget {
  const SfnEditorPage({super.key});

  @override
  ConsumerState<SfnEditorPage> createState() => _SfnEditorPageState();
}

class _SfnEditorPageState extends ConsumerState<SfnEditorPage> {
  final GlobalKey canvasKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _initAndLayoutNodes();
    });
  }

  void _initAndLayoutNodes() {
    final canvasContext = canvasKey.currentContext;
    if (canvasContext == null) return;

    final RenderBox canvasBox = canvasContext.findRenderObject() as RenderBox;
    final Size canvasSize = canvasBox.size;

    if (canvasSize == Size.zero) {
      WidgetsBinding.instance
          .addPostFrameCallback((_) => _initAndLayoutNodes());
      return;
    }

    const nodeWidth = 200.0;
    const nodeHeight = 40.0;

    final nodes = [
      const NodeModel(
        id: 'group1',
        type: 'middle',
        title: 'Group 1',
        position: Offset(100, 100),
        size: Size.zero,
        isGroup: true,
      ),
      const NodeModel(
        id: 'start_node',
        type: 'start',
        parentId: 'group1',
        position: Offset.zero,
        size: Size(nodeWidth, nodeHeight),
        title: 'Start',
      ),
      const NodeModel(
        id: 'node1',
        type: 'middle',
        parentId: 'group1',
        position: Offset.zero,
        size: Size(nodeWidth, nodeHeight),
        title: 'Node 1',
      ),
      const NodeModel(
        id: 'node2',
        type: 'middle',
        parentId: 'group1',
        position: Offset.zero,
        size: Size(nodeWidth, nodeHeight),
        title: 'Node 2',
      ),
      const NodeModel(
        id: 'node3',
        type: 'middle',
        parentId: 'group1',
        position: Offset.zero,
        size: Size(nodeWidth, nodeHeight),
        title: 'Node 3',
      ),
      const NodeModel(
        id: 'end_node',
        type: 'end',
        parentId: 'group1',
        position: Offset.zero,
        size: Size(nodeWidth, nodeHeight),
        title: 'End',
      ),
    ];

    final edges = [
      EdgeModel.generated(sourceNodeId: 'start_node', targetNodeId: 'node1'),
      EdgeModel.generated(sourceNodeId: 'node1', targetNodeId: 'node2'),
      EdgeModel.generated(sourceNodeId: 'node1', targetNodeId: 'node3'),
      EdgeModel.generated(sourceNodeId: 'node2', targetNodeId: 'end_node'),
      EdgeModel.generated(sourceNodeId: 'node3', targetNodeId: 'end_node'),
    ];

    final layout = SugiyamaLayoutStrategy();
    layout.performLayout(nodes, edges);

    // 🚩 去掉居中逻辑，直接使用布局计算的绝对位置
    final editorNotifier = ref.read(activeEditorNotifierProvider);
    final currentState = ref.read(activeEditorStateProvider);

    editorNotifier.replaceState(
      currentState.copyWith(
        nodeState: currentState.nodeState.copyWith(nodes: nodes),
        edgeState: currentState.edgeState.copyWith(edges: edges),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDark = ref.watch(themeModeProvider) == ThemeMode.dark;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Flow Editor'),
        actions: [
          IconButton(
            icon: Icon(isDark ? Icons.dark_mode : Icons.light_mode),
            onPressed: () {
              ref.read(themeModeProvider.notifier).state =
                  isDark ? ThemeMode.light : ThemeMode.dark;
            },
          ),
        ],
      ),
      body: Row(
        children: [
          const FlowNodeSidebar(),
          Expanded(
            child: Container(
              key: canvasKey,
              child: const SfnEditorCanvas(),
            ),
          ),
        ],
      ),
    );
  }
}
