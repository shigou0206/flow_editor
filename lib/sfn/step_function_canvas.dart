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
  ConsumerState<StepFunctionCanvas> createState() => StepFunctionCanvasState();
}

class StepFunctionCanvasState extends ConsumerState<StepFunctionCanvas> {
  final _canvasKey = GlobalKey();
  Offset _canvasOffset = Offset.zero;
  double _scale = 1.0;
  Offset _lastFocalPoint = Offset.zero;
  bool _isDragging = false;
  String? _highlightedEdgeId;
  final bool debug = true; // 调试模式开关

  @override
  void initState() {
    super.initState();
    // 首次布局
    WidgetsBinding.instance.addPostFrameCallback((_) => performLayout());
  }

  @override
  Widget build(BuildContext context) {
    final nodes = ref.watch(nodesProvider);
    final edges = ref.watch(edgesProvider);
    final edgeRoutes = ref.watch(edgeRoutesProvider);

    return GestureDetector(
      onScaleStart: (details) {
        _lastFocalPoint = details.focalPoint;
        _isDragging = true;
      },
      onScaleUpdate: (details) {
        setState(() {
          // 处理缩放
          if (details.scale != 1.0) {
            _scale *= details.scale;
            // 限制缩放范围
            _scale = _scale.clamp(0.5, 3.0);
          }
          
          // 处理平移
          if (details.pointerCount > 1 || _isDragging) {
            final delta = details.focalPoint - _lastFocalPoint;
            _canvasOffset += delta / _scale;
            _lastFocalPoint = details.focalPoint;
          }
        });
      },
      onScaleEnd: (details) {
        _isDragging = false;
      },
      child: DragTarget<NodeModel>(
        onWillAccept: (data) => true,
        onAcceptWithDetails: (details) {
          final localPos = _globalToLocal(details.offset);
          debugPrint('DragTarget接收到拖拽，位置: $localPos, 数据: ${details.data.id}');
          _insertNodeOnEdgeByDrag(localPos, details.data);
        },
        onMove: (details) {
          final localPos = _globalToLocal(details.offset);
          _updateHighlightedEdge(localPos);
        },
        onLeave: (data) {
          setState(() {
            _highlightedEdgeId = null;
          });
        },
        builder: (context, candidate, rejected) {
          return Stack(
            children: [
              // 画布层 - 包含绘制的边和节点
              Transform(
                transform: Matrix4.identity()
                  ..translate(_canvasOffset.dx, _canvasOffset.dy)
                  ..scale(_scale),
                child: Stack(
                  key: _canvasKey,
                  children: [
                    // 背景：绘制所有边（包括折线）
                    Positioned.fill(
                      child: CustomPaint(
                        painter: EdgePainter(
                          edges: edges,
                          routes: edgeRoutes,
                          canvasOffset: Offset.zero,
                          debug: true,
                          highlightedEdgeId: _highlightedEdgeId,
                        ),
                      ),
                    ),
                    
                    // 渲染每个节点
                    for (final node in nodes)
                      Positioned(
                        left: node.x - node.width / 2,
                        top: node.y - node.height / 2,
                        width: node.width,
                        height: node.height,
                        child: _buildNodeWidget(node),
                      ),
                  ],
                ),
              ),
              
              // 拖拽提示层 - 仅在拖拽时显示
              if (candidate.isNotEmpty)
                Center(
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: Colors.blue.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(4),
                      border: Border.all(color: Colors.blue.shade300),
                    ),
                    child: Text(
                      '拖拽到边上插入节点',
                      style: TextStyle(color: Colors.blue.shade700, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
            ],
          );
        },
      ),
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
      
      // 弹出对话框让用户输入节点名称
      final nodeName = await showDialog<String>(
        context: context,
        builder: (ctx) {
          String name = 'Node$index';
          return AlertDialog(
            title: const Text('Enter node name'),
            content: TextField(
              autofocus: true,
              decoration: const InputDecoration(
                labelText: 'Node name',
              ),
              onChanged: (value) {
                name = value;
              },
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(ctx),
                child: const Text('Cancel'),
              ),
              TextButton(
                onPressed: () => Navigator.pop(ctx, name),
                child: const Text('OK'),
              ),
            ],
          );
        },
      );
      
      if (nodeName == null) return; // 用户取消了输入
      
      final newNode = NodeModel(
        id: newId,
        title: nodeName,
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
    WidgetsBinding.instance.addPostFrameCallback((_) => performLayout());
  }

  /// 拖拽插入节点到边：根据拖拽位置判断最近边是否需要插入节点
  void _insertNodeOnEdgeByDrag(Offset dropPos, NodeModel template) {
    final edges = ref.read(edgesProvider);
    final nodes = ref.read(nodesProvider);
    final threshold = 100.0; // 增大阈值，与高亮保持一致
    String? hitEdgeId;
    double minDist = double.infinity;

    debugPrint('尝试插入节点 - 拖放位置: ($dropPos)');
    debugPrint('当前边数量: ${edges.length}, 节点数量: ${nodes.length}');
    debugPrint('拖拽模板: ID=${template.id}, 类型=${template.type}, 标题=${template.title}');
    debugPrint('当前阈值: $threshold');

    // 如果没有边，直接返回
    if (edges.isEmpty) {
      debugPrint('没有可用的边进行检测');
      return;
    }

    // 对每条边进行检测
    for (final edge in edges) {
      try {
        final srcNode = nodes.firstWhere((n) => n.id == edge.sourceId);
        final dstNode = nodes.firstWhere((n) => n.id == edge.targetId);
        
        debugPrint('检查边 ${edge.id}:');
        debugPrint('  源节点: ID=${srcNode.id}, 位置=(${srcNode.x}, ${srcNode.y})');
        debugPrint('  目标节点: ID=${dstNode.id}, 位置=(${dstNode.x}, ${dstNode.y})');
        
        // 计算点到线段的距离
        final dist = _distanceToSegment(
          dropPos,
          Offset(srcNode.x, srcNode.y),
          Offset(dstNode.x, dstNode.y),
        );
        
        // 检查点是否在线段的范围内
        final isInRange = _isPointInLineRange(
          dropPos,
          Offset(srcNode.x, srcNode.y),
          Offset(dstNode.x, dstNode.y),
        );
        
        debugPrint('  到线段的距离: $dist');
        debugPrint('  是否在范围内: $isInRange');
        
        // 只有当点在范围内且距离小于阈值时才考虑这条边
        if (isInRange && dist < minDist) {
          minDist = dist;
          hitEdgeId = edge.id;
          debugPrint('  *** 找到可能的边: ${edge.id}, 距离: $dist');
        }
      } catch (e) {
        debugPrint('处理边 ${edge.id} 时出错: $e');
      }
    }

    // 如果找到了合适的边，插入节点
    if (hitEdgeId != null && minDist < threshold) {
      debugPrint('选中边: $hitEdgeId, 距离: $minDist, 将插入节点');
      _insertNodeOnEdge(hitEdgeId, template);
    } else {
      debugPrint('没有找到合适的边 (最小距离=$minDist, 阈值=$threshold)');
    }
  }

  /// 检查点是否在线段的范围内
  bool _isPointInLineRange(Offset p, Offset a, Offset b) {
    // 计算线段长度
    final lineLength = (b - a).distance;
    
    // 计算点到线段的投影位置
    final ap = p - a;
    final ab = b - a;
    final abLenSq = ab.dx * ab.dx + ab.dy * ab.dy;
    if (abLenSq == 0) return false; // 如果线段长度为0，直接返回false
    
    // 计算投影比例
    final t = (ap.dx * ab.dx + ap.dy * ab.dy) / abLenSq;
    
    // 放宽检查条件，允许点稍微超出线段端点
    // 原来是 t < 0 || t > 1，现在改为 t < -0.2 || t > 1.2
    if (t < -0.2 || t > 1.2) {
      return false;
    }
    
    // 计算点到线段的垂直距离
    final dist = _distanceToSegment(p, a, b);
    
    // 增大检测阈值，使拖放更容易命中
    // 原来是 dist < 50.0，现在改为 dist < 80.0
    return dist < 80.0;
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

    // 弹出对话框让用户输入节点名称
    showDialog<String>(
      context: context,
      builder: (ctx) {
        String name = 'Node$index';
        return AlertDialog(
          title: const Text('Enter node name'),
          content: TextField(
            autofocus: true,
            decoration: const InputDecoration(
              labelText: 'Node name',
            ),
            onChanged: (value) {
              name = value;
            },
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(ctx),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(ctx, name);
                
                // 创建新节点
                final newNode = NodeModel(
                  id: newNodeId,
                  title: name,
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

                WidgetsBinding.instance.addPostFrameCallback((_) => performLayout());
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
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

    WidgetsBinding.instance.addPostFrameCallback((_) => performLayout());
  }

  /// 调用 dagre 布局算法，并更新节点及边的状态
  void performLayout() {
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
        'x': nodeX,
        'y': nodeY,
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

        // 获取源和目标节点
        final srcNode = updatedNodes.firstWhere((n) => n.id == e.sourceId);
        final dstNode = updatedNodes.firstWhere((n) => n.id == e.targetId);
        
        // 添加源节点中心作为起点
        offsetPoints.add(Offset(srcNode.x, srcNode.y));

        // 添加中间路由点
        for (final p in points) {
          final px = (p['x'] as num).toDouble() + (srcNode.width / 2);
          final py = (p['y'] as num).toDouble() + (srcNode.height / 2);
          offsetPoints.add(Offset(px, py));
          debugPrint('    点: ($px, $py)');
        }

        // 添加目标节点中心作为终点
        offsetPoints.add(Offset(dstNode.x, dstNode.y));
        
        routes[e.id] = offsetPoints;
      } else {
        debugPrint('  边 ${e.id} 没有路由点信息');
        // 如果没有路由点，则使用源节点和目标节点的中心点
        final srcNode = updatedNodes.firstWhere((n) => n.id == e.sourceId);
        final dstNode = updatedNodes.firstWhere((n) => n.id == e.targetId);
        routes[e.id] = [
          Offset(srcNode.x, srcNode.y),
          Offset(dstNode.x, dstNode.y),
        ];
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

  // 更新高亮的边
  void _updateHighlightedEdge(Offset pos) {
    final edges = ref.read(edgesProvider);
    final nodes = ref.read(nodesProvider);
    final threshold = 100.0; // 增大阈值，使检测更容易
    String? newHighlightedEdgeId;
    double minDist = double.infinity;

    debugPrint('更新高亮边 - 鼠标位置: ($pos)');
    debugPrint('当前边数量: ${edges.length}, 节点数量: ${nodes.length}');
    debugPrint('当前阈值: $threshold');

    // 如果没有边，直接返回
    if (edges.isEmpty) {
      debugPrint('没有可用的边进行高亮');
      return;
    }

    // 对每条边进行检测
    for (final edge in edges) {
      try {
        final srcNode = nodes.firstWhere((n) => n.id == edge.sourceId);
        final dstNode = nodes.firstWhere((n) => n.id == edge.targetId);
        
        debugPrint('检查边 ${edge.id} 是否需要高亮:');
        debugPrint('  源节点: ${srcNode.id} 位置=(${srcNode.x}, ${srcNode.y})');
        debugPrint('  目标节点: ${dstNode.id} 位置=(${dstNode.x}, ${dstNode.y})');
        
        // 计算点到线段的距离
        final dist = _distanceToSegment(
          pos,
          Offset(srcNode.x, srcNode.y),
          Offset(dstNode.x, dstNode.y),
        );
        
        // 检查点是否在线段的范围内
        final isInRange = _isPointInLineRange(
          pos,
          Offset(srcNode.x, srcNode.y),
          Offset(dstNode.x, dstNode.y),
        );
        
        debugPrint('  到线段的距离: $dist');
        debugPrint('  是否在范围内: $isInRange');
        
        // 只有当点在范围内且距离小于阈值时才考虑这条边
        if (isInRange && dist < threshold && dist < minDist) {
          minDist = dist;
          newHighlightedEdgeId = edge.id;
          debugPrint('  *** 找到可能的高亮边: ${edge.id}, 距离: $dist');
        }
      } catch (e) {
        debugPrint('处理边 ${edge.id} 高亮时出错: $e');
      }
    }

    // 更新高亮边ID，必要时刷新界面
    if (newHighlightedEdgeId != _highlightedEdgeId) {
      setState(() {
        _highlightedEdgeId = newHighlightedEdgeId;
      });
      debugPrint('更新高亮边: $_highlightedEdgeId');
    }
  }

  // 将全局坐标转换为画布的本地坐标
  Offset _globalToLocal(Offset globalPos) {
    final box = _canvasKey.currentContext?.findRenderObject() as RenderBox?;
    if (box != null) {
      // 获取鼠标相对于画布组件的位置
      final localPos = box.globalToLocal(globalPos);
      
      // 基本转换
      final rawAdjustedPos = Offset(
        localPos.dx / _scale - _canvasOffset.dx,
        localPos.dy / _scale - _canvasOffset.dy,
      );
      
      // 添加额外的偏移量补偿，根据调试输出调整
      // 这些固定的补偿值是基于观察到的偏差模式
      final adjustedPos = Offset(
        rawAdjustedPos.dx - 100,  // 向左移动100个像素
        rawAdjustedPos.dy - 50,   // 向上移动50个像素
      );
      
      debugPrint('坐标转换:');
      debugPrint('  全局坐标: $globalPos');
      debugPrint('  本地坐标: $localPos');
      debugPrint('  原始调整坐标: $rawAdjustedPos');
      debugPrint('  补偿后坐标: $adjustedPos');
      
      return adjustedPos;
    }
    return globalPos;
  }
}

