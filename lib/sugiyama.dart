import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// flow_layout相关
import 'package:flow_layout/graph/graph.dart';
import 'package:flow_layout/layout/layout.dart';

// =============================
//  0) 节点类型
// =============================
enum NodeType { normal, choice }

// 扩展 Offset.normalize() 用来画箭头
extension OffsetExtension on Offset {
  Offset normalize() {
    final dist = distance;
    if (dist == 0) return Offset.zero;
    return this / dist;
  }
}

// =============================
//  1) 节点 & 边 数据模型
// =============================
class NodeModel {
  final String id;
  final double x;
  final double y;
  final double width;
  final double height;
  final String title;
  final NodeType type;

  NodeModel({
    required this.id,
    required this.title,
    required this.type,
    this.x = 0,
    this.y = 0,
    this.width = 100,
    this.height = 60,
  });

  NodeModel copyWith({
    double? x,
    double? y,
  }) {
    return NodeModel(
      id: id,
      title: title,
      type: type,
      x: x ?? this.x,
      y: y ?? this.y,
      width: width,
      height: height,
    );
  }
}

class EdgeModel {
  final String id;
  final String sourceId;
  final String targetId;

  EdgeModel({
    required this.id,
    required this.sourceId,
    required this.targetId,
  });
}

// =============================
//  2) Riverpod Providers
// =============================
final nodesProvider = StateProvider<List<NodeModel>>((ref) => [
      // 初始给2个节点
      NodeModel(
        id: 'start',
        title: 'Start',
        type: NodeType.normal,
        x: 200,
        y: 100,
      ),
      NodeModel(
        id: 'end',
        title: 'End',
        type: NodeType.normal,
        x: 200,
        y: 250,
      ),
    ]);

final edgesProvider = StateProvider<List<EdgeModel>>((ref) => [
      EdgeModel(id: 'edge_start_end', sourceId: 'start', targetId: 'end'),
    ]);

final nodeCounterProvider = StateProvider<int>((ref) => 1);

// =============================
//  3) 主App
// =============================
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
        body: Row(
          children: const [
            SizedBox(width: 200, child: NodeSidebar()),
            Expanded(child: StepFunctionCanvas()),
          ],
        ),
      ),
    );
  }
}

// =============================
//  4) Sidebar (拖拽模板)
// =============================
class NodeSidebar extends ConsumerWidget {
  const NodeSidebar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      children: [
        const SizedBox(height: 16),
        const Text(
          'Node Templates',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        // 普通 Task 节点
        Draggable<NodeModel>(
          data: NodeModel(
            id: 'task_template',
            title: 'Task',
            type: NodeType.normal,
          ),
          feedback: _dragFeedback('Task'),
          child: _sidebarItem('Task'),
        ),
        const SizedBox(height: 12),
        // Choice 节点
        Draggable<NodeModel>(
          data: NodeModel(
            id: 'choice_template',
            title: 'Choice',
            type: NodeType.choice,
          ),
          feedback: _dragFeedback('Choice'),
          child: _sidebarItem('Choice'),
        ),
        const SizedBox(height: 12),
        ElevatedButton(
          onPressed: () {
            // reset
            ref.read(nodesProvider.notifier).state = [
              NodeModel(
                id: 'start',
                title: 'Start',
                type: NodeType.normal,
                x: 200,
                y: 100,
              ),
              NodeModel(
                id: 'end',
                title: 'End',
                type: NodeType.normal,
                x: 200,
                y: 250,
              ),
            ];
            ref.read(edgesProvider.notifier).state = [
              EdgeModel(
                id: 'edge_start_end',
                sourceId: 'start',
                targetId: 'end',
              ),
            ];
            ref.read(nodeCounterProvider.notifier).state = 1;
          },
          child: const Text('Reset'),
        ),
      ],
    );
  }

  static Widget _sidebarItem(String label) {
    return Container(
      width: 100,
      height: 40,
      alignment: Alignment.center,
      margin: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.blue.shade100,
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(label),
    );
  }

  static Widget _dragFeedback(String label) {
    return Material(
      color: Colors.transparent,
      child: Container(
        width: 100,
        height: 40,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: Colors.blue.shade300,
          borderRadius: BorderRadius.circular(4),
        ),
        child: Text(label, style: const TextStyle(color: Colors.white)),
      ),
    );
  }
}

// =============================
//  5) StepFunctionCanvas
// =============================
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
    WidgetsBinding.instance.addPostFrameCallback((_) => _performLayout());
  }

  @override
  Widget build(BuildContext context) {
    final nodes = ref.watch(nodesProvider);
    final edges = ref.watch(edgesProvider);

    return Stack(
      key: _canvasKey,
      children: [
        // 1) 先画线
        Positioned.fill(
          child: CustomPaint(
            painter: EdgePainter(nodes, edges),
          ),
        ),
        // 2) DragTarget覆盖画布：检查拖拽是否命中某条边
        Positioned.fill(
          child: DragTarget<NodeModel>(
            onWillAccept: (data) => true,
            onAcceptWithDetails: (details) {
              final localPos = _globalToLocal(details.offset);
              _onDraggedOverCanvas(localPos, details.data);
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
        // 3) 渲染节点
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

  void _onDraggedOverCanvas(Offset localPos, NodeModel draggedData) {
    final edges = ref.read(edgesProvider);
    final nodes = ref.read(nodesProvider);

    final threshold = 30.0;
    String? hitEdgeId;
    double minDist = double.infinity;

    for (final edge in edges) {
      final srcNode = nodes.firstWhere((n) => n.id == edge.sourceId);
      final dstNode = nodes.firstWhere((n) => n.id == edge.targetId);

      final dist = _distanceToSegment(
        localPos,
        Offset(srcNode.x, srcNode.y),
        Offset(dstNode.x, dstNode.y),
      );
      if (dist < minDist) {
        minDist = dist;
        hitEdgeId = edge.id;
      }
    }

    if (hitEdgeId != null && minDist < threshold) {
      _insertNodeOnEdge(hitEdgeId, draggedData);
    } else {
      debugPrint('No edge hit. Not inserting. dist=$minDist');
    }
  }

  Widget _buildNodeWidget(NodeModel node) {
    return GestureDetector(
      onLongPress: () {
        // 删除节点
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

  /// 核心方法：在某条边上插入新节点
  /// 如果是Choice节点，保证至少 1 条入 + 2 条出 => 共3条边
  void _insertNodeOnEdge(String edgeId, NodeModel template) {
    final edges = ref.read(edgesProvider);
    final nodes = ref.read(nodesProvider);
    final edge = edges.firstWhere((e) => e.id == edgeId);

    // 计数器
    final count = ref.read(nodeCounterProvider.notifier);
    final index = count.state;
    count.state++;

    final newNodeId = 'node_$index';

    // 找到原边的源节点 / 目标节点
    final sourceNode = nodes.firstWhere((n) => n.id == edge.sourceId);
    final targetNode = nodes.firstWhere((n) => n.id == edge.targetId);

    // 新节点初始位置 = (源 + 目) / 2
    final initialX = (sourceNode.x + targetNode.x) / 2;
    final initialY = (sourceNode.y + targetNode.y) / 2;

    // 创建新节点
    final newNode = NodeModel(
      id: newNodeId,
      title: template.title,
      type: template.type,
      x: initialX,
      y: initialY,
    );

    // 删除旧边
    final updatedEdges = edges.where((e) => e.id != edgeId).toList();

    // 添加节点
    final updatedNodes = [...nodes, newNode];

    // 新增2条边：source->newNode, newNode->target
    updatedEdges.addAll([
      EdgeModel(
        id: 'edge_${edge.sourceId}_$newNodeId',
        sourceId: edge.sourceId,
        targetId: newNodeId,
      ),
      EdgeModel(
        id: 'edge_${newNodeId}_${edge.targetId}',
        sourceId: newNodeId,
        targetId: edge.targetId,
      ),
    ]);

    // ----------------------------
    // 如果是Choice节点，需确保最少有2条出边
    // 这时它已有 1条in(edge.source->choice) + 1条out(choice->edge.target)
    // 若 outEdges <2，就加一条到 end节点(或者其他节点)。
    // ----------------------------
    if (template.type == NodeType.choice) {
      // 找到Choice节点当前outEdges
      final outEdgesOfChoice =
          updatedEdges.where((e) => e.sourceId == newNodeId).toList();

      if (outEdgesOfChoice.length < 2) {
        // 假设我们要给它加一条到 'end' 节点
        final maybeEnd = updatedNodes.firstWhere(
          (n) => n.id == 'end',
          orElse: () => NodeModel(
            id: 'end',
            title: 'End',
            type: NodeType.normal,
          ),
        );
        if (maybeEnd != null) {
          final secondEdgeId =
              'edge_${newNodeId}_end_extra_${math.Random().nextInt(9999)}';
          updatedEdges.add(
            EdgeModel(
              id: secondEdgeId,
              sourceId: newNodeId,
              targetId: 'end',
            ),
          );
          debugPrint('Choice node => auto add second out edge to "end"');
        }
      }
    }

    // 更新 provider
    ref.read(nodesProvider.notifier).state = updatedNodes;
    ref.read(edgesProvider.notifier).state = updatedEdges;

    WidgetsBinding.instance.addPostFrameCallback((_) => _performLayout());
  }

  /// 删除节点
  void _deleteNode(String nodeId) {
    final nodes = ref.read(nodesProvider);
    final edges = ref.read(edgesProvider);

    // 保护 start/end 不删
    if (nodeId == 'start' || nodeId == 'end') {
      return;
    }

    final incoming = edges.where((e) => e.targetId == nodeId).toList();
    final outgoing = edges.where((e) => e.sourceId == nodeId).toList();

    final updatedNodes = nodes.where((n) => n.id != nodeId).toList();
    var updatedEdges = edges
        .where((e) => e.sourceId != nodeId && e.targetId != nodeId)
        .toList();

    // 若只有1 in + 1 out, 自动连起来
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

  // 计算点到线段的最短距离
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

  /// 执行 dagre 布局
  void _performLayout() {
    final nodes = ref.read(nodesProvider);
    final edges = ref.read(edgesProvider);

    final graph = Graph();

    for (var node in nodes) {
      graph.setNode(node.id, {
        'width': node.width,
        'height': node.height,
        'x': node.x - node.width / 2,
        'y': node.y - node.height / 2,
      });
    }

    for (var edge in edges) {
      graph.setEdge(edge.sourceId, edge.targetId);
    }

    layout(graph, {
      'rankdir': 'TB',
      'ranksep': 50,
      'edgesep': 10,
      'nodesep': 50,
    });

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
  }
}

// =============================
//  6) EdgePainter
// =============================
class EdgePainter extends CustomPainter {
  final List<NodeModel> nodes;
  final List<EdgeModel> edges;

  EdgePainter(this.nodes, this.edges);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.black
      ..strokeWidth = 2;

    final nodeMap = {for (var n in nodes) n.id: n};

    for (var e in edges) {
      final src = nodeMap[e.sourceId];
      final dst = nodeMap[e.targetId];
      if (src == null || dst == null) continue;

      final srcPos = Offset(src.x, src.y);
      final dstPos = Offset(dst.x, dst.y);

      canvas.drawLine(srcPos, dstPos, paint);
      _drawArrow(canvas, srcPos, dstPos, paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;

  // 绘制箭头
  void _drawArrow(Canvas canvas, Offset start, Offset end, Paint paint) {
    final arrowSize = 10.0;
    final direction = (end - start).normalize();
    final arrowEnd = end - direction * 15.0;

    final perpendicular = Offset(-direction.dy, direction.dx);
    final arrowPoint1 =
        arrowEnd - direction * arrowSize + perpendicular * (arrowSize / 2);
    final arrowPoint2 =
        arrowEnd - direction * arrowSize - perpendicular * (arrowSize / 2);

    final path = Path()
      ..moveTo(end.dx, end.dy)
      ..lineTo(arrowPoint1.dx, arrowPoint1.dy)
      ..lineTo(arrowPoint2.dx, arrowPoint2.dy)
      ..close();

    canvas.drawPath(path, paint);
  }
}
