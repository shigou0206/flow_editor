import 'package:flutter/material.dart';
import 'dart:math' as math;

// 1) 如果你已经将前面拆分的所有 Sugiyama 文件放在某个目录，
//   这里把它们 import 进来即可，比如：
import 'core/layout/node_model.dart';
import 'core/layout/edge_model.dart';
import 'core/layout/sugiyama_configuration.dart';
import 'core/layout/sugiyama_layout.dart';

// --------------------- 示例入口 ---------------------
void main() {
  runApp(const MySugiyamaDemoApp());
}

// --------------------- 主App ---------------------
class MySugiyamaDemoApp extends StatelessWidget {
  const MySugiyamaDemoApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SugiyamaDemoScreen(),
    );
  }
}

// --------------------- 具体的屏幕 ---------------------
class SugiyamaDemoScreen extends StatefulWidget {
  @override
  State<SugiyamaDemoScreen> createState() => _SugiyamaDemoScreenState();
}

class _SugiyamaDemoScreenState extends State<SugiyamaDemoScreen> {
  // 2) 准备节点和边 (仅示例)
  final nodes = <Node>[
    Node(id: 1, width: 60, height: 40),
    Node(id: 2, width: 70, height: 40),
    Node(id: 3, width: 100, height: 50),
    Node(id: 4, width: 60, height: 40),
    Node(id: 5, width: 50, height: 30),
    Node(id: 6, width: 50, height: 30),
    Node(id: 7, width: 80, height: 40),
    Node(id: 10, width: 60, height: 40),
    Node(id: 11, width: 60, height: 40),
  ];

  final edges = <Edge>[
    Edge(sourceId: 1, targetId: 2),
    Edge(sourceId: 2, targetId: 3),
    Edge(sourceId: 3, targetId: 4),
    Edge(sourceId: 4, targetId: 5),
    Edge(sourceId: 2, targetId: 11),
    Edge(sourceId: 11, targetId: 7),
    Edge(sourceId: 1, targetId: 6),
    Edge(sourceId: 6, targetId: 7),
    Edge(sourceId: 7, targetId: 3),
    Edge(sourceId: 1, targetId: 10),
    Edge(sourceId: 10, targetId: 11),
  ];

  // 配置
  final config = SugiyamaConfiguration()
    ..orientation = SugiyamaConfiguration.ORIENTATION_TOP_BOTTOM
    ..nodeSeparation = 40
    ..levelSeparation = 50
    ..iterations = 24;

  @override
  void initState() {
    super.initState();

    // 3) 在 initState 中执行布局
    runSugiyamaLayout(nodes: nodes, edges: edges, config: config);
    // 布局完成后，nodes[*].x,y 已有值
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sugiyama Demo'),
      ),
      body: InteractiveViewer(
        boundaryMargin: const EdgeInsets.all(1000),
        minScale: 0.1,
        maxScale: 2.5,
        child: CustomPaint(
          // 4) 使用自定义画笔，传入节点、边
          painter: _SugiyamaPainter(nodes, edges),
          // 这里给个比较大的画布，让我们可以自由拖动
          size: const Size(3000, 2000),
        ),
      ),
    );
  }
}

// --------------------- 自定义画笔： 绘制节点和边 ---------------------
class _SugiyamaPainter extends CustomPainter {
  final List<Node> nodes;
  final List<Edge> edges;

  _SugiyamaPainter(this.nodes, this.edges);

  @override
  void paint(Canvas canvas, Size size) {
    // 1) 先计算 (minX, maxX, minY, maxY)
    double minX = double.infinity;
    double maxX = double.negativeInfinity;
    double minY = double.infinity;
    double maxY = double.negativeInfinity;

    for (var n in nodes) {
      final left = n.x;
      final right = n.x + n.width;
      final top = n.y;
      final bottom = n.y + n.height;

      if (left < minX) minX = left;
      if (top < minY) minY = top;
      if (right > maxX) maxX = right;
      if (bottom > maxY) maxY = bottom;
    }

    final layoutWidth = maxX - minX;
    final layoutHeight = maxY - minY;

    // 2) 计算平移量，使包围盒居中于 size (即 CustomPaint 的 size)
    //   注意：size 可能是 3000x2000 或者屏幕大小
    //   这里先假设 size 就是我们可视画布
    final offsetX = (size.width - layoutWidth) / 2.0;
    final offsetY = (size.height - layoutHeight) / 2.0;

    // 3) 准备画笔
    final paintEdge = Paint()
      ..color = Colors.black
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;

    final paintNodeBorder = Paint()
      ..color = Colors.blue
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;

    final paintNodeFill = Paint()
      ..color = Colors.lightGreen.withOpacity(0.3)
      ..style = PaintingStyle.fill;

    // 4) 先画边
    for (var e in edges) {
      final src = nodes.firstWhere((n) => n.id == e.sourceId,
          orElse: () => Node(id: -1));
      final tgt = nodes.firstWhere((n) => n.id == e.targetId,
          orElse: () => Node(id: -1));
      if (src.id < 0 || tgt.id < 0) continue;

      // 假设边连节点中心
      final start = Offset(
        src.x + src.width / 2 - minX + offsetX,
        src.y + src.height / 2 - minY + offsetY,
      );
      final end = Offset(
        tgt.x + tgt.width / 2 - minX + offsetX,
        tgt.y + tgt.height / 2 - minY + offsetY,
      );

      canvas.drawLine(start, end, paintEdge);
      _drawArrow(canvas, paintEdge, start, end);
    }

    // 5) 再画节点
    final textPainter = TextPainter(textDirection: TextDirection.ltr);

    for (var n in nodes) {
      // 计算在画布上的位置：平移 + (x - minX)
      final rectLeft = n.x - minX + offsetX;
      final rectTop = n.y - minY + offsetY;
      final rect = Rect.fromLTWH(rectLeft, rectTop, n.width, n.height);

      // 填充
      canvas.drawRect(rect, paintNodeFill);
      // 边框
      canvas.drawRect(rect, paintNodeBorder);

      // 绘制文本
      final label = 'id=${n.id}';
      textPainter.text = TextSpan(
        text: label,
        style: const TextStyle(fontSize: 12, color: Colors.black),
      );
      textPainter.layout();
      final dx = rectLeft + (n.width - textPainter.width) / 2;
      final dy = rectTop + (n.height - textPainter.height) / 2;
      textPainter.paint(canvas, Offset(dx, dy));
    }
  }

  @override
  bool shouldRepaint(covariant _SugiyamaPainter oldDelegate) => true;

  void _drawArrow(Canvas canvas, Paint paint, Offset start, Offset end) {
    const arrowSize = 8.0;
    final angle = math.atan2(end.dy - start.dy, end.dx - start.dx);

    final path = Path();
    path.moveTo(end.dx, end.dy);
    path.lineTo(
      end.dx - arrowSize * math.cos(angle - math.pi / 6),
      end.dy - arrowSize * math.sin(angle - math.pi / 6),
    );
    path.moveTo(end.dx, end.dy);
    path.lineTo(
      end.dx - arrowSize * math.cos(angle + math.pi / 6),
      end.dy - arrowSize * math.sin(angle + math.pi / 6),
    );
    canvas.drawPath(path, paint);
  }
}
