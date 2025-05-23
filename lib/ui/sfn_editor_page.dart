import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flow_editor/core/models/node_model.dart';
import 'package:flow_editor/core/models/edge_model.dart';
import 'package:flow_editor/core/models/anchor_model.dart';
import 'package:flow_editor/core/models/enums/position_enum.dart';
import 'package:flow_editor/core/state_management/providers.dart';
import 'package:flow_editor/ui/canvas/flow_editor_canvas.dart';
import 'package:flow_editor/ui/sidebar/flow_node_sidebar.dart';
import 'package:flow_editor/core/state_management/theme_provider.dart';

class SfnEditorPage extends ConsumerStatefulWidget {
  const SfnEditorPage({super.key});

  @override
  ConsumerState<SfnEditorPage> createState() => _SfnEditorPageState();
}

class _SfnEditorPageState extends ConsumerState<SfnEditorPage> {
  final GlobalKey canvasKey = GlobalKey();
  bool initialized = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (!initialized) {
      initialized = true;
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _initCenteredNodesAndEdge();
      });
    }
  }

  void _initCenteredNodesAndEdge() {
    final store = ref.read(activeEditorNotifierProvider);
    final currentState = ref.read(activeEditorStateProvider);
    final RenderBox canvasBox =
        canvasKey.currentContext?.findRenderObject() as RenderBox;

    final Size canvasSize = canvasBox.size;

    const nodeWidth = 200.0;
    const nodeHeight = 40.0;
    const verticalSpacing = 150.0;

    // 计算居中位置
    final centerX = (canvasSize.width - nodeWidth) / 2;
    final centerY =
        (canvasSize.height - (nodeHeight * 2 + verticalSpacing)) / 2;

    final startNodePosition = Offset(centerX, centerY);
    final endNodePosition =
        Offset(centerX, centerY + nodeHeight + verticalSpacing);

    final startNode = NodeModel(
      id: 'start_node',
      type: 'start',
      position: startNodePosition,
      size: const Size(nodeWidth, nodeHeight),
      title: 'Start',
      anchors: const [
        AnchorModel(id: 'out', position: Position.bottom, size: Size(10, 10)),
      ],
    );

    final endNode = NodeModel(
      id: 'end_node',
      type: 'end',
      position: endNodePosition,
      size: const Size(nodeWidth, nodeHeight),
      title: 'End',
      anchors: const [
        AnchorModel(id: 'in', position: Position.top, size: Size(10, 10)),
      ],
    );

    const edge = EdgeModel(
      id: 'start_to_end_edge',
      sourceNodeId: 'start_node',
      sourceAnchorId: 'out',
      targetNodeId: 'end_node',
      targetAnchorId: 'in',
    );

    store.replaceState(
      currentState.copyWith(
        nodeState: currentState.nodeState.copyWith(
          nodes: [startNode, endNode],
        ),
        edgeState: currentState.edgeState.copyWith(
          edges: [edge],
        ),
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
          FlowNodeSidebar(onNodeTemplateDragged: (node) {
            // 处理侧边栏节点拖动逻辑
          }),
          Expanded(
            child: Container(
              key: canvasKey, // ✅ 加上GlobalKey
              child: const FlowEditorCanvas(),
            ),
          ),
        ],
      ),
    );
  }
}
