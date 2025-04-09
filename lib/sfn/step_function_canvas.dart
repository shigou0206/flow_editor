// lib/step_function_canvas.dart

import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// flow_layout
import 'package:flow_layout/graph/graph.dart';
import 'package:flow_layout/layout/layout.dart';

import 'models.dart';
import 'providers.dart';
import 'edge_painter.dart';

class StepFunctionCanvas extends ConsumerStatefulWidget {
  const StepFunctionCanvas({super.key});

  @override
  ConsumerState<StepFunctionCanvas> createState() => _StepFunctionCanvasState();
}

class _StepFunctionCanvasState extends ConsumerState<StepFunctionCanvas> {
  final _canvasKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    // 启动时先布局一次
    WidgetsBinding.instance.addPostFrameCallback((_) => _performLayout());
  }

  @override
  Widget build(BuildContext context) {
    final nodes = ref.watch(nodesProvider);
    final edges = ref.watch(edgesProvider);

    // 拿到路由信息
    final edgeRoutes = ref.watch(edgeRoutesProvider);

    return Stack(
      key: _canvasKey,
      children: [
        // 背景: 绘制所有边(带折线)
        Positioned.fill(
          child: CustomPaint(
            painter: EdgePainter(nodes, edges, edgeRoutes),
          ),
        ),

        // DragTarget覆盖画布: 用于拖拽插入节点(可选)
        Positioned.fill(
          child: DragTarget<NodeModel>(
            onWillAccept: (data) => true,
            onAcceptWithDetails: (details) {
              final localPos = _globalToLocal(details.offset);
              _insertNodeOnEdgeByDrag(localPos, details.data);
            },
            builder: (context, candidate, rejected) {
              return Container(
                color: candidate.isNotEmpty
                    ? Colors.blue.withOpacity(0.05)
                    : Colors.transparent,
                child: Center(
                  child: candidate.isNotEmpty
                      ? Text('拖拽到边上插入节点',
                          style: TextStyle(color: Colors.blue.shade300))
                      : null,
                ),
              );
            },
          ),
        ),

        // 渲染节点
        for (final node in nodes)
          Positioned(
            left: node.x - node.width / 2,
            top: node.y - node.height / 2,
            width: node.width,
            height: node.height,
            child: _buildNodeWidget(node),
          ),
      ],
    );
  }

  /// ================
  /// 构建节点Widget
  /// ================
  Widget _buildNodeWidget(NodeModel node) {
    return GestureDetector(
      onTap: () {
        // 点击节点 => 弹框让用户选择要连到哪个“下一个”节点
        _onTapNode(node);
      },
      onLongPress: () {
        // 长按删除节点
        _deleteNode(node.id);
      },
      child: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: node.type == NodeType.choice
              ? Colors.pink.shade100
              : Colors.orange.shade100,
          border: Border.all(
            color: node.type == NodeType.choice ? Colors.pink : Colors.orange,
            width: 2,
          ),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Text(node.title),
      ),
    );
  }

  /// ================
  /// 点击节点 => 选择已有节点 or 创建新节点
  /// ================
  Future<void> _onTapNode(NodeModel fromNode) async {
    final nodes = ref.read(nodesProvider);
    final edges = ref.read(edgesProvider);

    // 1) 弹出对话框
    final result = await showDialog<String>(
      context: context,
      builder: (ctx) {
        return SimpleDialog(
          title: Text('Select next node for "${fromNode.title}"'),
          children: [
            // 新建节点
            SimpleDialogOption(
              onPressed: () => Navigator.pop(ctx, 'create'),
              child: const Text(' + Create new node'),
            ),
            const Divider(),
            // 列出已有节点(排除自己)
            for (final n in nodes)
              if (n.id != fromNode.id)
                SimpleDialogOption(
                  onPressed: () => Navigator.pop(ctx, n.id),
                  child: Text('Connect to "${n.title}"'),
                ),
          ],
        );
      },
    );

    if (result == null) return;

    String targetNodeId;
    if (result == 'create') {
      final count = ref.read(nodeCounterProvider.notifier);
      final index = count.state;
      count.state++;

      final newId = 'node_$index';
      final newNode = NodeModel(
        id: newId,
        title: 'NewNode$index',
        type: NodeType.normal,
        x: fromNode.x + 100,
        y: fromNode.y + 80,
      );

      final updatedNodes = [...nodes, newNode];
      ref.read(nodesProvider.notifier).state = updatedNodes;

      targetNodeId = newId;
    } else {
      targetNodeId = result;
    }

    // 2) 增加一条 fromNode->targetNode 的边
    final updatedEdges = [...edges];
    final alreadyExists = updatedEdges.any(
      (e) => e.sourceId == fromNode.id && e.targetId == targetNodeId,
    );
    if (!alreadyExists) {
      final randomSuffix = math.Random().nextInt(9999);
      final newEdgeId = 'edge_${fromNode.id}_${targetNodeId}_$randomSuffix';

      updatedEdges.add(
        EdgeModel(
          id: newEdgeId,
          sourceId: fromNode.id,
          targetId: targetNodeId,
        ),
      );
      ref.read(edgesProvider.notifier).state = updatedEdges;
    }

    // 3) 重新布局
    WidgetsBinding.instance.addPostFrameCallback((_) => _performLayout());
  }

  /// ================
  /// 拖拽插入节点到边
  /// ================
  void _insertNodeOnEdgeByDrag(Offset dropPos, NodeModel template) {
    final edges = ref.read(edgesProvider);
    final nodes = ref.read(nodesProvider);

    final threshold = 30.0;
    String? hitEdgeId;
    double minDist = double.infinity;

    for (final edge in edges) {
      final srcNode = nodes.firstWhere((n) => n.id == edge.sourceId);
      final dstNode = nodes.firstWhere((n) => n.id == edge.targetId);

      final dist = _distanceToSegment(
        dropPos,
        Offset(srcNode.x, srcNode.y),
        Offset(dstNode.x, dstNode.y),
      );
      if (dist < minDist) {
        minDist = dist;
        hitEdgeId = edge.id;
      }
    }

    if (hitEdgeId != null && minDist < threshold) {
      _insertNodeOnEdge(hitEdgeId, template);
    } else {
      debugPrint('No edge hit (dist=$minDist), no insertion');
    }
  }

  void _insertNodeOnEdge(String edgeId, NodeModel template) {
    final edges = ref.read(edgesProvider);
    final nodes = ref.read(nodesProvider);
    final edge = edges.firstWhere((e) => e.id == edgeId);

    // 计数器
    final count = ref.read(nodeCounterProvider.notifier);
    final index = count.state;
    count.state++;

    final newNodeId = 'node_$index';

    final src = nodes.firstWhere((n) => n.id == edge.sourceId);
    final dst = nodes.firstWhere((n) => n.id == edge.targetId);

    // 放中点
    final cx = (src.x + dst.x) / 2;
    final cy = (src.y + dst.y) / 2;

    final newNode = NodeModel(
      id: newNodeId,
      title: template.title,
      type: template.type,
      x: cx,
      y: cy,
    );

    final updatedEdges = edges.where((e) => e.id != edgeId).toList();
    final updatedNodes = [...nodes, newNode];

    updatedEdges.addAll([
      EdgeModel(
        id: 'edge_${src.id}_$newNodeId',
        sourceId: src.id,
        targetId: newNodeId,
      ),
      EdgeModel(
        id: 'edge_${newNodeId}_${dst.id}',
        sourceId: newNodeId,
        targetId: dst.id,
      ),
    ]);

    ref.read(nodesProvider.notifier).state = updatedNodes;
    ref.read(edgesProvider.notifier).state = updatedEdges;

    WidgetsBinding.instance.addPostFrameCallback((_) => _performLayout());
  }

  /// ================
  /// 删除节点
  /// ================
  void _deleteNode(String nodeId) {
    final nodes = ref.read(nodesProvider);
    final edges = ref.read(edgesProvider);

    // 不允许删除 start / end(示例)
    if (nodeId == 'start' || nodeId == 'end') {
      return;
    }

    final incoming = edges.where((e) => e.targetId == nodeId).toList();
    final outgoing = edges.where((e) => e.sourceId == nodeId).toList();

    final updatedNodes = nodes.where((n) => n.id != nodeId).toList();
    var updatedEdges = edges
        .where((e) => e.sourceId != nodeId && e.targetId != nodeId)
        .toList();

    // 如果只有1 in + 1 out, 就连起来
    if (incoming.length == 1 && outgoing.length == 1) {
      final up = incoming.first;
      final down = outgoing.first;
      updatedEdges.add(EdgeModel(
        id: 'edge_${up.sourceId}_${down.targetId}',
        sourceId: up.sourceId,
        targetId: down.targetId,
      ));
    }

    ref.read(nodesProvider.notifier).state = updatedNodes;
    ref.read(edgesProvider.notifier).state = updatedEdges;

    WidgetsBinding.instance.addPostFrameCallback((_) => _performLayout());
  }

  /// ================
  /// 调用 dagre 布局 + 记录边的 points
  /// ================
  void _performLayout() {
    final nodes = ref.read(nodesProvider);
    final edges = ref.read(edgesProvider);

    final graph = Graph();

    // 设置节点
    for (var node in nodes) {
      graph.setNode(node.id, {
        'width': node.width,
        'height': node.height,
        // Dagre坐标初始: 左上角
        'x': node.x - node.width / 2,
        'y': node.y - node.height / 2,
      });
    }

    // 设置边
    for (var edge in edges) {
      graph.setEdge(edge.sourceId, edge.targetId);
    }

    // Graph config
    graph.setGraph({
      'rankdir': 'TB',
      'marginx': 20,
      'marginy': 20,
      'ranker': 'network-simplex',
    });

    // 调用dagre布局
    layout(graph);

    // 1) 更新节点位置
    final updatedNodes = <NodeModel>[];
    for (var node in nodes) {
      final nd = graph.node(node.id);
      if (nd != null && nd['x'] != null && nd['y'] != null) {
        final x = (nd['x'] as num).toDouble() + node.width / 2;
        final y = (nd['y'] as num).toDouble() + node.height / 2;
        updatedNodes.add(node.copyWith(x: x, y: y));
      } else {
        updatedNodes.add(node);
      }
    }
    ref.read(nodesProvider.notifier).state = updatedNodes;

    // 2) 收集edges的多段points
    final routes = <String, List<Offset>>{};
    for (final e in edges) {
      final edgeData = graph.edge(e.sourceId, e.targetId);
      if (edgeData != null && edgeData['points'] != null) {
        final points = edgeData['points'] as List;
        final offsetPoints = <Offset>[];
        for (final p in points) {
          final px = (p['x'] as num).toDouble();
          final py = (p['y'] as num).toDouble();
          offsetPoints.add(Offset(px, py));
        }
        routes[e.id] = offsetPoints;
      } else {
        // fallback
        routes[e.id] = [];
      }
    }
    // 更新edgeRoutesProvider
    ref.read(edgeRoutesProvider.notifier).state = routes;
  }

  // 计算点到线段的最短距离(拖拽插入用)
  double _distanceToSegment(Offset p, Offset a, Offset b) {
    final ap = p - a;
    final ab = b - a;
    final abLenSq = ab.dx * ab.dx + ab.dy * ab.dy;
    if (abLenSq == 0) {
      return (p - a).distance;
    }
    final t = (ap.dx * ab.dx + ap.dy * ab.dy) / abLenSq;
    if (t < 0) {
      return (p - a).distance;
    } else if (t > 1) {
      return (p - b).distance;
    } else {
      final proj = a + Offset(ab.dx * t, ab.dy * t);
      return (p - proj).distance;
    }
  }

  Offset _globalToLocal(Offset globalPos) {
    final box = _canvasKey.currentContext?.findRenderObject() as RenderBox?;
    if (box == null) return globalPos;
    return box.globalToLocal(globalPos);
  }
}
