import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flow_editor/v1/core/node/models/node_model.dart';
import 'package:flow_editor/v1/core/edge/models/edge_model.dart';
import 'package:flow_editor/v1/core/layout/sugiyama_layout.dart';
import 'package:flow_editor/v1/core/canvas/utils.dart';
import 'package:flow_editor/v1/core/edge/edge_renderer/edge_renderer.dart';
import 'package:flow_editor/v1/core/edge/edge_renderer/path_generators/flexible_path_generator.dart';
import 'package:flow_editor/v1/core/edge/style/edge_style_resolver.dart';

void main() {
  runApp(const ProviderScope(child: MaterialApp(home: LayoutDemoPage())));
}

class LayoutState {
  final List<NodeModel> nodes;
  final List<EdgeModel> edges;
  final Map<String, List<Offset>> edgeRoutes;
  final List<NodeModel> sortedNodes;

  LayoutState({
    required this.nodes,
    required this.edges,
    required this.edgeRoutes,
    required this.sortedNodes,
  });
}

final layoutStateProvider = StateProvider<LayoutState>((ref) => LayoutState(
      nodes: [],
      edges: [],
      edgeRoutes: {},
      sortedNodes: [],
    ));

class LayoutDemoPage extends ConsumerStatefulWidget {
  const LayoutDemoPage({super.key});

  @override
  ConsumerState<LayoutDemoPage> createState() => _LayoutDemoPageState();
}

class _LayoutDemoPageState extends ConsumerState<LayoutDemoPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final nodes = _initGraph();
      final edges = _initEdges();

      _performLayout(nodes, edges);

      ref.read(layoutStateProvider.notifier).state = LayoutState(
        nodes: nodes,
        edges: edges,
        edgeRoutes: _computeGlobalEdgeRoutes(nodes, edges),
        sortedNodes: _getSortedByDepthFirst(nodes),
      );
    });
  }

  List<NodeModel> _initGraph() => [
        NodeModel(
            id: 'group1',
            title: 'Group 1',
            position: const Offset(100, 100),
            size: Size.zero,
            isGroup: true),
        NodeModel(
            id: 'root1',
            title: 'Root 1',
            parentId: 'group1',
            position: const Offset(16, 16),
            size: const Size(100, 40),
            isGroupRoot: true),
        NodeModel(
            id: 'node11',
            title: 'Node 1.1',
            parentId: 'group1',
            position: const Offset(16, 68),
            size: const Size(100, 40)),
        NodeModel(
            id: 'node12',
            title: 'Node 1.2',
            parentId: 'group1',
            position: const Offset(16, 68),
            size: const Size(100, 40)),
        NodeModel(
            id: 'group2',
            title: 'Group 2',
            parentId: 'group1',
            position: const Offset(16, 120),
            size: const Size(150, 100),
            isGroup: true),
        NodeModel(
            id: 'node21',
            title: 'Node 2.1',
            parentId: 'group2',
            position: const Offset(16, 16),
            size: const Size(100, 40)),
        NodeModel(
            id: 'node22',
            title: 'Node 2.2',
            parentId: 'group2',
            position: const Offset(16, 68),
            size: const Size(100, 40)),
        NodeModel(
            id: 'node23',
            title: 'Node 2.3',
            parentId: 'group2',
            position: const Offset(16, 68),
            size: const Size(100, 40)),
        NodeModel(
            id: 'node24',
            title: 'Node 2.4',
            parentId: 'group2',
            position: const Offset(16, 68),
            size: const Size(100, 40)),
        NodeModel(
            id: 'nodeend',
            title: 'Node End',
            parentId: 'group1',
            position: const Offset(16, 180),
            size: const Size(100, 40)),
      ];

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

  void _performLayout(List<NodeModel> nodes, List<EdgeModel> edges) {
    final layout = SugiyamaLayoutStrategy();
    layout.performLayout(nodes, edges);
  }

  Map<String, List<Offset>> _computeGlobalEdgeRoutes(
          List<NodeModel> nodes, List<EdgeModel> edges) =>
      {
        for (final edge in edges)
          if (edge.waypoints != null)
            edge.id: mapEdgeWaypointsToAbsolute(edge, nodes)
      };

  List<NodeModel> _getSortedByDepthFirst(List<NodeModel> nodes) {
    List<NodeModel> result = [];

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

  @override
  Widget build(BuildContext context) {
    final layoutState = ref.watch(layoutStateProvider);

    return Scaffold(
      body: Container(
        color: Colors.grey.shade200,
        child: Stack(
          children: [
            CustomPaint(
              painter: EdgeRenderer(
                nodes: layoutState.nodes,
                edges: layoutState.edges,
                pathGenerator: FlexiblePathGenerator(layoutState.nodes),
                styleResolver: const EdgeStyleResolver(),
              ),
              size: Size.infinite,
            ),
            for (final node in layoutState.sortedNodes)
              Positioned(
                left: node.absolutePosition(layoutState.nodes).dx,
                top: node.absolutePosition(layoutState.nodes).dy,
                child: node.isGroup ? _renderGroup(node) : _renderNode(node),
              ),
          ],
        ),
      ),
    );
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
          color: node.isGroupRoot ? Colors.redAccent : Colors.orangeAccent,
          border: Border.all(color: Colors.black),
          borderRadius: BorderRadius.circular(6),
        ),
        child: Text(node.title ?? '', style: const TextStyle(fontSize: 12)),
      );
}
