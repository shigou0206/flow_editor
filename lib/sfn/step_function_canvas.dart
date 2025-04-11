import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// 导入 dagre 布局依赖（如使用 flow_layout 包）
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
  Offset _canvasOffset = Offset.zero;

  @override
  void initState() {
    super.initState();
    // 首次布局
    WidgetsBinding.instance.addPostFrameCallback((_) => _performLayout());
  }

  @override
  Widget build(BuildContext context) {
    final nodes = ref.watch(nodesProvider);
    final edges = ref.watch(edgesProvider);
    final edgeRoutes = ref.watch(edgeRoutesProvider);

    return Stack(
      key: _canvasKey,
      children: [
        // 背景：绘制所有边（包括折线）
        Positioned.fill(
          child: CustomPaint(
            painter:
                EdgePainter(nodes, edges, edgeRoutes, offset: _canvasOffset),
          ),
        ),
        // 用于拖拽插入节点的目标区域
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
        // 渲染每个节点
        for (final node in nodes)
          Positioned(
            left: node.x - node.width / 2 + _canvasOffset.dx,
            top: node.y - node.height / 2 + _canvasOffset.dy,
            width: node.width,
            height: node.height,
            child: _buildNodeWidget(node),
          ),
      ],
    );
  }

  /// 构建节点 Widget
  Widget _buildNodeWidget(NodeModel node) {
    return GestureDetector(
      onTap: () {
        _onTapNode(node);
      },
      onLongPress: () {
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

  /// 点击节点后弹出选择连线或创建新节点的对话框
  Future<void> _onTapNode(NodeModel fromNode) async {
    final nodes = ref.read(nodesProvider);
    final edges = ref.read(edgesProvider);

    final result = await showDialog<String>(
      context: context,
      builder: (ctx) {
        return SimpleDialog(
          title: Text('Select next node for "${fromNode.title}"'),
          children: [
            SimpleDialogOption(
              onPressed: () => Navigator.pop(ctx, 'create'),
              child: const Text(' + Create new node'),
            ),
            const Divider(),
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
    WidgetsBinding.instance.addPostFrameCallback((_) => _performLayout());
  }

  /// 拖拽插入节点到边：根据拖拽位置判断最近边是否需要插入节点
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

  /// 在指定边上插入新节点，拆分原有边
  void _insertNodeOnEdge(String edgeId, NodeModel template) {
    final edges = ref.read(edgesProvider);
    final nodes = ref.read(nodesProvider);
    final edge = edges.firstWhere((e) => e.id == edgeId);
    final count = ref.read(nodeCounterProvider.notifier);
    final index = count.state;
    count.state++;
    final newNodeId = 'node_$index';

    final src = nodes.firstWhere((n) => n.id == edge.sourceId);
    final dst = nodes.firstWhere((n) => n.id == edge.targetId);

    // 将新节点放在两节点连线中点位置
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

  /// 删除节点，同时尝试把入边和出边重新连接起来
  void _deleteNode(String nodeId) {
    final nodes = ref.read(nodesProvider);
    final edges = ref.read(edgesProvider);

    // 不允许删除 start / end 节点
    if (nodeId == 'start' || nodeId == 'end') {
      return;
    }

    final incoming = edges.where((e) => e.targetId == nodeId).toList();
    final outgoing = edges.where((e) => e.sourceId == nodeId).toList();

    final updatedNodes = nodes.where((n) => n.id != nodeId).toList();
    var updatedEdges = edges
        .where((e) => e.sourceId != nodeId && e.targetId != nodeId)
        .toList();

    // 如果只有 1 个入边和 1 个出边，则重连这两个节点
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

  /// 调用 dagre 布局算法，并更新节点及边的状态
  void _performLayout() {
    final nodes = ref.read(nodesProvider);
    final edges = ref.read(edgesProvider);
    debugPrint('开始布局: ${nodes.length} 个节点, ${edges.length} 条边');
    final graph = Graph();

    // 添加所有节点（左上角位置）
    for (var node in nodes) {
      final nodeX = node.x - node.width / 2;
      final nodeY = node.y - node.height / 2;
      debugPrint(
          '添加节点 ${node.id}: 中心(${node.x}, ${node.y}) -> 左上角($nodeX, $nodeY)');
      graph.setNode(node.id, {
        'width': node.width,
        'height': node.height,
        'x': node.x - node.width / 2,
        'y': node.y - node.height / 2,
      });
    }

    // 添加所有边
    for (var edge in edges) {
      debugPrint('添加边 ${edge.id}: ${edge.sourceId} -> ${edge.targetId}');
      graph.setEdge(edge.sourceId, edge.targetId);
    }

    // 设置 graph 配置
    graph.setGraph({
      'rankdir': 'TB',
      'marginx': 20,
      'marginy': 20,
      'ranker': 'network-simplex',
    });

    debugPrint('调用 dagre 布局算法');
    layout(graph);

    // 更新每个节点的位置（转为中心坐标）
    final updatedNodes = <NodeModel>[];
    for (var node in nodes) {
      final nd = graph.node(node.id);
      if (nd != null && nd['x'] != null && nd['y'] != null) {
        final x = (nd['x'] as num).toDouble() + node.width / 2;
        final y = (nd['y'] as num).toDouble() + node.height / 2;
        debugPrint('更新节点 ${node.id} 位置: (${node.x}, ${node.y}) -> ($x, $y)');
        updatedNodes.add(node.copyWith(x: x, y: y));
      } else {
        debugPrint('节点 ${node.id} 位置未变: (${node.x}, ${node.y})');
        updatedNodes.add(node);
      }
    }
    ref.read(nodesProvider.notifier).state = updatedNodes;

    // 收集每条边由 dagre 计算出的路由点，并调整坐标
    final routes = <String, List<Offset>>{};
    for (final e in edges) {
      final edgeData = graph.edge(e.sourceId, e.targetId);
      debugPrint('处理边 ${e.id} 的路由点');
      if (edgeData != null && edgeData['points'] != null) {
        final points = edgeData['points'] as List;
        final offsetPoints = <Offset>[];
        debugPrint('  边 ${e.id} 有 ${points.length} 个路由点');

        // 获取源和目标节点，用于判断是否需要在路由中补充节点中心
        final srcNode = nodes.firstWhere((n) => n.id == e.sourceId);
        final dstNode = nodes.firstWhere((n) => n.id == e.targetId);
        final srcPos = Offset(srcNode.x, srcNode.y);
        final dstPos = Offset(dstNode.x, dstNode.y);

        // 检查首尾点与节点的距离，判断是否需要调整
        bool needsAdjustment = false;
        if (points.isNotEmpty) {
          final firstPoint = points.first;
          final lastPoint = points.last;
          final firstPointOffset = Offset((firstPoint['x'] as num).toDouble(),
              (firstPoint['y'] as num).toDouble());
          // 与源节点左上角比较
          final distToSrc = (firstPointOffset -
                  (srcPos - Offset(srcNode.width / 2, srcNode.height / 2)))
              .distance;
          final lastPointOffset = Offset((lastPoint['x'] as num).toDouble(),
              (lastPoint['y'] as num).toDouble());
          final distToDst = (lastPointOffset -
                  (dstPos - Offset(dstNode.width / 2, dstNode.height / 2)))
              .distance;
          needsAdjustment = distToSrc > 20 || distToDst > 20;
          debugPrint(
              '  距离检查: 源节点距离=$distToSrc, 目标节点距离=$distToDst, 需要调整=$needsAdjustment');
        }

        if (needsAdjustment) {
          offsetPoints.add(srcPos);
        }

        for (final p in points) {
          // 注意：对每个点增加节点左上角至中心的偏移（假设节点尺寸一致）
          final px = (p['x'] as num).toDouble() + (srcNode.width / 2);
          final py = (p['y'] as num).toDouble() + (srcNode.height / 2);
          offsetPoints.add(Offset(px, py));
          debugPrint('    点: ($px, $py)');
        }

        if (needsAdjustment) {
          offsetPoints.add(dstPos);
        }
        routes[e.id] = offsetPoints;
      } else {
        debugPrint('  边 ${e.id} 没有路由点信息');
        routes[e.id] = [];
      }
    }
    debugPrint('收集了 ${routes.length} 条边的路由信息');
    ref.read(edgeRoutesProvider.notifier).state = routes;

    // 计算所有节点包围盒，居中画布
    _centerCanvas(updatedNodes);
    debugPrint('布局完成');
  }

  // 计算并设置全局偏移，使得所有节点整体居中显示
  void _centerCanvas(List<NodeModel> updatedNodes) {
    final box = _canvasKey.currentContext?.findRenderObject() as RenderBox?;
    if (box != null) {
      final size = box.size;
      double minX = double.infinity;
      double minY = double.infinity;
      double maxX = double.negativeInfinity;
      double maxY = double.negativeInfinity;
      for (final node in updatedNodes) {
        minX = math.min(minX, node.x - node.width / 2);
        maxX = math.max(maxX, node.x + node.width / 2);
        minY = math.min(minY, node.y - node.height / 2);
        maxY = math.max(maxY, node.y + node.height / 2);
      }
      final contentWidth = maxX - minX;
      final contentHeight = maxY - minY;
      setState(() {
        _canvasOffset = Offset(
          (size.width - contentWidth) / 2 - minX,
          (size.height - contentHeight) / 2 - minY,
        );
      });
    }
  }

  // 计算点到线段的最短距离（用于判断拖拽是否位于边附近）
  double _distanceToSegment(Offset p, Offset a, Offset b) {
    final ap = p - a;
    final ab = b - a;
    final abLenSq = ab.dx * ab.dx + ab.dy * ab.dy;
    if (abLenSq == 0) return (p - a).distance;
    final t = (ap.dx * ab.dx + ap.dy * ab.dy) / abLenSq;
    if (t < 0) return (p - a).distance;
    if (t > 1) return (p - b).distance;
    final proj = a + Offset(ab.dx * t, ab.dy * t);
    return (p - proj).distance;
  }

  // 将全局坐标转换为画布的本地坐标
  Offset _globalToLocal(Offset globalPos) {
    final box = _canvasKey.currentContext?.findRenderObject() as RenderBox?;
    return box != null ? box.globalToLocal(globalPos) : globalPos;
  }
}
