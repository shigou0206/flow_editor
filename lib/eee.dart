// lib/main.dart
import 'package:flutter/material.dart';

void main() => runApp(const DemoApp());

class DemoApp extends StatelessWidget {
  const DemoApp({super.key});
  @override
  Widget build(BuildContext context) => MaterialApp(
        debugShowCheckedModeBanner: false,
        home: const Scaffold(body: CanvasDemo()),
      );
}

class NodeData {
  Offset position;
  NodeData(this.position);
}

class CanvasDemo extends StatefulWidget {
  const CanvasDemo({super.key});
  @override
  State<CanvasDemo> createState() => _CanvasDemoState();
}

class _CanvasDemoState extends State<CanvasDemo> {
  // 模型：一堆节点
  final List<NodeData> _nodes = [
    NodeData(const Offset(100, 100)),
    NodeData(const Offset(300, 200)),
    NodeData(const Offset(500, 150)),
  ];

  // 画布平移/缩放因子
  Offset _offset = Offset.zero;
  double _scale = 1.0, _startScale = 1.0;

  @override
  Widget build(BuildContext context) {
    const viewSize = Size(1000, 1000);

    return Center(
      child: SizedBox(
        width: viewSize.width,
        height: viewSize.height,
        child: ClipRect(
          child: GestureDetector(
            behavior: HitTestBehavior.translucent,

            // 缩放开始
            onScaleStart: (details) {
              _startScale = _scale;
            },

            // 缩放/平移 统一在 onScaleUpdate 里处理
            onScaleUpdate: (details) {
              setState(() {
                // 缩放：
                _scale = (_startScale * details.scale).clamp(0.5, 3.0);
                // 平移：只有单指时才平移
                if ((details.scale - 1.0).abs() < 0.01) {
                  // 把每个节点的世界坐标，加上这次的平移增量
                  for (var node in _nodes) {
                    node.position += details.focalPointDelta;
                  }
                  // 同时记录一下 offset（如果你有背景也要移动的话）
                  _offset += details.focalPointDelta;
                }
              });
            },

            child: Stack(
              clipBehavior: Clip.none,
              children: [
                // 背景网格
                Positioned.fill(
                  child: CustomPaint(
                    painter: _GridPainter(
                      cellSize: 50,
                      offset: _offset,
                      scale: _scale,
                    ),
                  ),
                ),

                // 连线示例：直接用 Positioned + CustomPaint 画到两个节点之间
                ..._buildLinks(),

                // 节点
                for (int i = 0; i < _nodes.length; i++)
                  Positioned(
                    left: _nodes[i].position.dx * _scale + _offset.dx,
                    top: _nodes[i].position.dy * _scale + _offset.dy,
                    child: GestureDetector(
                      onPanUpdate: (d) {
                        setState(() {
                          // 拖拽节点：计算世界坐标的增量
                          final deltaWorld = d.delta / _scale;
                          _nodes[i].position += deltaWorld;
                        });
                      },
                      child: Container(
                        width: 100 * _scale,
                        height: 60 * _scale,
                        decoration: BoxDecoration(
                          color: Colors.blueAccent,
                          borderRadius: BorderRadius.circular(8 * _scale),
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          'Node $i',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16 * _scale,
                          ),
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  List<Widget> _buildLinks() {
    // 简单示例：把每相邻两点连一条直线
    List<Widget> widgets = [];
    for (int i = 0; i + 1 < _nodes.length; i++) {
      final a = _nodes[i].position;
      final b = _nodes[i + 1].position;
      widgets.add(
        Positioned.fill(
          child: CustomPaint(
            painter: _LinkPainter(
              p1: a * _scale + _offset,
              p2: b * _scale + _offset,
            ),
          ),
        ),
      );
    }
    return widgets;
  }
}

/// 背景网格，根据 offset/scale 动态绘制
class _GridPainter extends CustomPainter {
  final double cellSize;
  final Offset offset;
  final double scale;
  const _GridPainter({
    required this.cellSize,
    required this.offset,
    required this.scale,
  });

  @override
  void paint(Canvas canvas, Size size) {
    // 应用 offset/scale
    canvas.save();
    canvas.translate(offset.dx, offset.dy);
    canvas.scale(scale);

    final paint = Paint()
      ..color = Colors.grey.withOpacity(0.3)
      ..strokeWidth = 1;
    final width = size.width / scale;
    final height = size.height / scale;

    for (double x = -offset.dx / scale % cellSize; x < width; x += cellSize) {
      canvas.drawLine(Offset(x, 0), Offset(x, height), paint);
    }
    for (double y = -offset.dy / scale % cellSize; y < height; y += cellSize) {
      canvas.drawLine(Offset(0, y), Offset(width, y), paint);
    }

    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant _GridPainter old) {
    return old.offset != offset || old.scale != scale;
  }
}

/// 两点直线
class _LinkPainter extends CustomPainter {
  final Offset p1, p2;
  const _LinkPainter({required this.p1, required this.p2});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.black
      ..strokeWidth = 2;
    canvas.drawLine(p1, p2, paint);
  }

  @override
  bool shouldRepaint(covariant _LinkPainter old) {
    return old.p1 != p1 || old.p2 != p2;
  }
}
