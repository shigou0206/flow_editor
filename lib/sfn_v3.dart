import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flow_editor/core/node/models/node_model.dart';
import 'package:flow_editor/core/edge/models/edge_model.dart';
import 'package:flow_editor/core/layout/sugiyama_layout.dart';
import 'package:flow_editor/core/canvas/utils.dart';
import 'package:flow_editor/core/edge/edge_renderer/edge_renderer.dart';
import 'package:flow_editor/core/edge/edge_renderer/path_generators/flexible_path_generator.dart';
import 'package:flow_editor/core/edge/style/edge_style_resolver.dart';
import 'package:flow_editor/core/node/node_state/node_state_provider.dart';
import 'package:flow_editor/core/edge/edge_state/edge_state_provider.dart';

void main() {
  runApp(const ProviderScope(child: StepFunctionLayoutApp()));
}

class StepFunctionLayoutApp extends StatelessWidget {
  const StepFunctionLayoutApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('StepFunction Layout Demo'),
        ),
        body: const Row(
          children: [
            SizedBox(width: 200, child: NodeSidebar()),
            Expanded(child: LayoutDemoPage()),
          ],
        ),
      ),
    );
  }
}

class NodeSidebar extends StatelessWidget {
  const NodeSidebar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 150,
      color: Colors.grey.shade300,
      child: Column(
        children: [
          // 从侧边栏拖拽一个节点
          Draggable<NodeModel>(
            data: NodeModel(
              id: 'task_${DateTime.now().millisecondsSinceEpoch}',
              title: 'Task',
              size: const Size(100, 40),
              position: Offset.zero,
            ),
            feedback: Opacity(
              opacity: 0.7,
              child: Container(
                width: 100,
                height: 40,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Colors.orangeAccent,
                  border: Border.all(color: Colors.black),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: const Text('Task'),
              ),
            ),
            child: Container(
              margin: const EdgeInsets.all(8),
              width: 100,
              height: 40,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: Colors.orangeAccent,
                border: Border.all(color: Colors.black),
                borderRadius: BorderRadius.circular(6),
              ),
              child: const Text('Task'),
            ),
          ),
        ],
      ),
    );
  }
}

class LayoutDemoPage extends ConsumerStatefulWidget {
  const LayoutDemoPage({super.key});

  @override
  ConsumerState<LayoutDemoPage> createState() => _LayoutDemoPageState();
}

class _LayoutDemoPageState extends ConsumerState<LayoutDemoPage> {
  final String workflowId = 'default';

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final nodeNotifier = ref.read(nodeStateProvider(workflowId).notifier);
      final edgeNotifier = ref.read(edgeStateProvider(workflowId).notifier);

      final nodes = _initGraph();
      final edges = _initEdges();

      _performLayout(nodes, edges);

      nodeNotifier.upsertNodes(nodes);
      edgeNotifier.addEdges(edges);
    });
  }

  // 示例初始节点
  List<NodeModel> _initGraph() => [
        NodeModel(
          id: 'group1',
          title: 'Group 1',
          position: const Offset(100, 100),
          size: Size.zero,
          isGroup: true,
        ),
        NodeModel(
          id: 'root1',
          title: 'Root 1',
          parentId: 'group1',
          position: const Offset(16, 16),
          size: const Size(100, 40),
          isGroupRoot: true,
        ),
        NodeModel(
          id: 'node11',
          title: 'Node 1.1',
          parentId: 'group1',
          position: const Offset(16, 68),
          size: const Size(100, 40),
        ),
        NodeModel(
          id: 'node12',
          title: 'Node 1.2',
          parentId: 'group1',
          position: const Offset(16, 68),
          size: const Size(100, 40),
        ),
        NodeModel(
          id: 'group2',
          title: 'Group 2',
          parentId: 'group1',
          position: const Offset(16, 120),
          size: const Size(150, 100),
          isGroup: true,
        ),
        NodeModel(
          id: 'node21',
          title: 'Node 2.1',
          parentId: 'group2',
          position: const Offset(16, 16),
          size: const Size(100, 40),
        ),
        NodeModel(
          id: 'node22',
          title: 'Node 2.2',
          parentId: 'group2',
          position: const Offset(16, 68),
          size: const Size(100, 40),
        ),
        NodeModel(
          id: 'node23',
          title: 'Node 2.3',
          parentId: 'group2',
          position: const Offset(16, 68),
          size: const Size(100, 40),
        ),
        NodeModel(
          id: 'node24',
          title: 'Node 2.4',
          parentId: 'group2',
          position: const Offset(16, 68),
          size: const Size(100, 40),
        ),
        NodeModel(
          id: 'nodeend',
          title: 'Node End',
          parentId: 'group1',
          position: const Offset(16, 180),
          size: const Size(100, 40),
        ),
      ];

  // 示例初始边
  List<EdgeModel> _initEdges() => [
        EdgeModel(sourceNodeId: 'root1', targetNodeId: 'node11'),
        EdgeModel(sourceNodeId: 'node11', targetNodeId: 'node12'),
        EdgeModel(sourceNodeId: 'node11', targetNodeId: 'group2'),
        EdgeModel(sourceNodeId: 'node21', targetNodeId: 'node22'),
        EdgeModel(sourceNodeId: 'node21', targetNodeId: 'node23'),
        EdgeModel(sourceNodeId: 'node24', targetNodeId: 'node23'),
        EdgeModel(sourceNodeId: 'group2', targetNodeId: 'nodeend'),
        EdgeModel(sourceNodeId: 'node12', targetNodeId: 'nodeend'),
        EdgeModel(sourceNodeId: 'node11', targetNodeId: 'nodeend'),
      ];

  // 布局算法
  void _performLayout(List<NodeModel> nodes, List<EdgeModel> edges) {
    final layout = SugiyamaLayoutStrategy();
    layout.performLayout(nodes, edges);
  }

  @override
  Widget build(BuildContext context) {
    // 从 Riverpod 读取节点和边
    final nodes = ref.watch(nodeStateProvider(workflowId)).nodesOf(workflowId);
    final edges = ref.watch(edgeStateProvider(workflowId)).edgesOf(workflowId);

    // 父子顺序，用于渲染 Group 在后面
    final sortedNodes = _getSortedByDepthFirst(nodes);

    return Scaffold(
      body: Container(
        color: Colors.grey.shade200,
        child: DragTarget<NodeModel>(
          onWillAcceptWithDetails: (details) {
            // 可以加一些自定义判断
            return true;
          },
          onAcceptWithDetails: (details) {
            final offset = details.offset; // 全局坐标
            _handleDroppedNode(offset, details.data);
          },
          builder: (context, candidateData, rejectedData) {
            return Stack(
              children: [
                // 绘制所有边
                CustomPaint(
                  painter: EdgeRenderer(
                    nodes: nodes,
                    edges: edges,
                    pathGenerator: FlexiblePathGenerator(nodes),
                    styleResolver: const EdgeStyleResolver(),
                  ),
                  size: Size.infinite,
                ),
                // 绘制所有节点
                for (final node in sortedNodes)
                  Positioned(
                    left: node.absolutePosition(nodes).dx,
                    top: node.absolutePosition(nodes).dy,
                    child:
                        node.isGroup ? _renderGroup(node) : _renderNode(node),
                  ),
              ],
            );
          },
        ),
      ),
    );
  }

  /// 处理拖入的节点
  void _handleDroppedNode(Offset globalPos, NodeModel nodeTemplate) {
    final nodeNotifier = ref.read(nodeStateProvider(workflowId).notifier);
    final edgeNotifier = ref.read(edgeStateProvider(workflowId).notifier);

    // 当前节点/边列表
    final nodes = nodeNotifier.getNodes();
    final edges = edgeNotifier.state.edgesOf(workflowId);

    // 计算在画布中的坐标 (无需缩放/平移时可直接使用globalPos)
    // 若有缩放/offset，可以在此计算
    final localPos = globalPos;
    final newId = 'node_${DateTime.now().millisecondsSinceEpoch}';

    // 创建并插入节点
    final newNode = NodeModel(
      id: newId,
      title: nodeTemplate.title,
      position: Offset(localPos.dx, localPos.dy),
      size: nodeTemplate.size,
    );
    nodeNotifier.upsertNode(newNode);

    // 🚩 计算节点Rect，检测最近的边
    final nodeRect = Rect.fromLTWH(
      newNode.position.dx,
      newNode.position.dy,
      newNode.size.width,
      newNode.size.height,
    );

    final potentialEdge = findNearestEdgeToRect(nodeRect, edges, nodes, 30.0);
    if (potentialEdge != null) {
      _insertNodeIntoEdge(newNode.id, potentialEdge);
    }

    // 重新布局
    _performLayout(
        nodeNotifier.getNodes(), edgeNotifier.state.edgesOf(workflowId));

    // 重新写回最新节点/边
    for (var nd in nodeNotifier.getNodes()) {
      nodeNotifier.upsertNode(nd);
    }
    edgeNotifier.updateEdges(edgeNotifier.state.edgesOf(workflowId));
  }

  /// 检测节点Rect到所有Edge的最短距离，若小于阈值则返回该Edge
  EdgeModel? findNearestEdgeToRect(Rect rect, List<EdgeModel> edges,
      List<NodeModel> nodes, double threshold) {
    final pathGenerator = FlexiblePathGenerator(nodes);
    EdgeModel? nearestEdge;
    double minDistance = threshold;

    for (final edge in edges) {
      final pathResult =
          pathGenerator.generate(edge, type: edge.lineStyle.edgeMode);
      if (pathResult == null) continue;

      final dist = rectToPathDistance(rect, pathResult.path);
      if (dist < minDistance) {
        minDistance = dist;
        nearestEdge = edge;
      }
    }
    return nearestEdge;
  }

  /// 计算Rect到Path的距离
  double rectToPathDistance(Rect rect, Path path, {int precision = 10}) {
    double minDistance = double.infinity;
    final metrics = path.computeMetrics();
    for (final metric in metrics) {
      for (int i = 0; i <= precision; i++) {
        final t = metric.length * i / precision;
        final tangent = metric.getTangentForOffset(t);
        if (tangent == null) continue;
        final pos = tangent.position;
        // 找到Rect上离pos最近的点
        final nearestX = pos.dx.clamp(rect.left, rect.right);
        final nearestY = pos.dy.clamp(rect.top, rect.bottom);
        final nearestPoint = Offset(nearestX, nearestY);
        final dist = (pos - nearestPoint).distance;
        if (dist < minDistance) {
          minDistance = dist;
        }
      }
    }
    return minDistance;
  }

  /// 将 node 插入到指定 edge 内：删除旧边，创建两条新边
  void _insertNodeIntoEdge(String nodeId, EdgeModel edge) {
    final edgeNotifier = ref.read(edgeStateProvider(workflowId).notifier);

    // 删除旧边
    edgeNotifier.removeEdge(edge.id);

    // 创建两条新边
    final newEdge1 = EdgeModel(
      sourceNodeId: edge.sourceNodeId,
      targetNodeId: nodeId,
      isConnected: true,
    );
    final newEdge2 = EdgeModel(
      sourceNodeId: nodeId,
      targetNodeId: edge.targetNodeId,
      isConnected: true,
    );

    // 加入状态
    edgeNotifier.addEdges([newEdge1, newEdge2]);
  }

  List<NodeModel> _getSortedByDepthFirst(List<NodeModel> nodes) {
    final result = <NodeModel>[];
    void visit(String? parentId) {
      for (final node in nodes.where((n) => n.parentId == parentId)) {
        if (node.isGroup) result.add(node);
        visit(node.id);
        if (!node.isGroup) result.add(node);
      }
    }

    visit(null);
    return result;
  }

  Widget _renderGroup(NodeModel group) => Container(
        width: group.size.width,
        height: group.size.height,
        padding: const EdgeInsets.all(4),
        decoration: BoxDecoration(
          color: Colors.blue.withOpacity(0.1),
          border: Border.all(color: Colors.blue, width: 2),
        ),
        child: Text(group.title ?? '', style: const TextStyle(fontSize: 12)),
      );

  Widget _renderNode(NodeModel node) => Container(
        width: node.size.width,
        height: node.size.height,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: Colors.orangeAccent,
          border: Border.all(color: Colors.black),
          borderRadius: BorderRadius.circular(6),
        ),
        child: Text(node.title ?? '', style: const TextStyle(fontSize: 12)),
      );
}
