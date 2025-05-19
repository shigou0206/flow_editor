import 'package:flutter/material.dart';
import 'package:vector_math/vector_math_64.dart' as vector_math;

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext c) => MaterialApp(home: const CanvasWindowDemo());
}

class CanvasWindowDemo extends StatefulWidget {
  const CanvasWindowDemo({super.key});
  @override
  State<CanvasWindowDemo> createState() => _CanvasWindowDemoState();
}

class _CanvasWindowDemoState extends State<CanvasWindowDemo> {
  Offset _offset = Offset.zero;
  double _scale = 1.0, _startScale = 1.0;

  // world-space nodes
  final List<Offset> _nodes = [
    const Offset(100, 100),
    const Offset(300, 200),
    const Offset(500, 150),
  ];

  // 从屏幕点映射到世界坐标
  Offset _toWorld(Offset p) {
    final m = Matrix4.identity()
      ..translate(_offset.dx, _offset.dy)
      ..scale(_scale);
    final inv = Matrix4.inverted(m);
    final v = inv.transform3(vector_math.Vector3(p.dx, p.dy, 0));
    return Offset(v.x, v.y);
  }

  @override
  Widget build(BuildContext context) {
    const viewW = 800.0, viewH = 600.0;
    const canvasExtent = 100000.0; // “无限”模拟

    return Scaffold(
      body: Center(
        child: SizedBox(
          width: viewW,
          height: viewH,
          child: ClipRect(
            // 固定窗口，裁剪视口外内容
            child: GestureDetector(
              behavior: HitTestBehavior.translucent,
              // 缩放 & 平移手势
              onScaleStart: (d) => _startScale = _scale,
              onScaleUpdate: (d) {
                setState(() {
                  _scale = (_startScale * d.scale).clamp(0.5, 4.0);
                  if ((d.scale - 1.0).abs() < 0.01) {
                    _offset += d.focalPointDelta;
                  }
                });
              },
              // 点击命中
              onTapDown: (d) {
                final w = _toWorld(d.localPosition);
                String? hit;
                for (var i = 0; i < _nodes.length; i++) {
                  if (Rect.fromLTWH(_nodes[i].dx, _nodes[i].dy, 100, 60)
                      .contains(w)) {
                    hit = 'Node $i';
                    break;
                  }
                }
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Tapped $hit at $w')),
                );
              },
              // OverflowBox 放开子树尺寸限制，再用 Transform 渲染无限画布
              child: OverflowBox(
                maxWidth: double.infinity,
                maxHeight: double.infinity,
                alignment: Alignment.topLeft,
                child: Transform(
                  alignment: Alignment.topLeft,
                  transform: Matrix4.identity()
                    ..translate(_offset.dx, _offset.dy)
                    ..scale(_scale),
                  child: SizedBox(
                    width: canvasExtent,
                    height: canvasExtent,
                    child: Stack(
                      children: [
                        // 网格背景
                        CustomPaint(
                          size: const Size(canvasExtent, canvasExtent),
                          painter: _GridPainter(cellSize: 50),
                        ),
                        // 可拖拽节点
                        for (var i = 0; i < _nodes.length; i++)
                          Positioned(
                            left: _nodes[i].dx,
                            top: _nodes[i].dy,
                            child: GestureDetector(
                              behavior: HitTestBehavior.opaque,
                              onPanUpdate: (d) {
                                final before = _toWorld(d.localPosition);
                                final after =
                                    _toWorld(d.localPosition + d.delta);
                                setState(() {
                                  _nodes[i] += (after - before);
                                });
                              },
                              child: Container(
                                width: 100,
                                height: 60,
                                decoration: BoxDecoration(
                                  color: Colors.blueAccent,
                                  borderRadius: BorderRadius.circular(6),
                                  boxShadow: const [BoxShadow(blurRadius: 4)],
                                ),
                                alignment: Alignment.center,
                                child: Text('Node $i',
                                    style:
                                        const TextStyle(color: Colors.white)),
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _GridPainter extends CustomPainter {
  final double cellSize;
  const _GridPainter({required this.cellSize});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = Colors.grey.withOpacity(0.3);
    for (double x = 0; x <= size.width; x += cellSize) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), paint);
    }
    for (double y = 0; y <= size.height; y += cellSize) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter _) => false;
}
