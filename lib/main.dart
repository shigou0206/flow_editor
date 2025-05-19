// main.dart
import 'package:flutter/material.dart';
import 'package:vector_math/vector_math_64.dart' as vector_math;

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext c) => MaterialApp(home: const CanvasWindow());
}

class CanvasWindow extends StatefulWidget {
  const CanvasWindow({super.key});
  @override
  _CanvasWindowState createState() => _CanvasWindowState();
}

class _CanvasWindowState extends State<CanvasWindow> {
  // 画布的 pan/zoom 状态
  Offset _offset = Offset.zero;
  double _scale = 1.0, _startScale = 1.0;

  // 节点在世界坐标的位置
  final List<Offset> _nodes = [
    const Offset(100, 100),
    const Offset(300, 200),
    const Offset(500, 150),
  ];

  // CompositedTransform 的链接
  final LayerLink _link = LayerLink();

  // 将屏幕坐标映射到世界坐标
  Offset _toWorld(Offset screen) {
    // world = (screen - offset) / scale
    return (screen - _offset) / _scale;
  }

  @override
  Widget build(BuildContext context) {
    const viewportSize = Size(1000, 1000);
    const canvasSize = 100000.0; // 模拟“无限”

    return Scaffold(
      body: Center(
        child: SizedBox(
          width: viewportSize.width,
          height: viewportSize.height,
          child: ClipRect(
            // ① 视口窗口
            child: GestureDetector(
              behavior: HitTestBehavior.translucent,
              onScaleStart: (d) => _startScale = _scale,
              onScaleUpdate: (d) {
                setState(() {
                  _scale = (_startScale * d.scale).clamp(0.5, 4.0);
                  if ((d.scale - 1.0).abs() < 0.01) {
                    _offset += d.focalPointDelta;
                  }
                });
              },
              onTapDown: (d) {
                final world = _toWorld(d.localPosition);
                String? hit;
                for (var i = 0; i < _nodes.length; i++) {
                  if (Rect.fromLTWH(_nodes[i].dx, _nodes[i].dy, 100, 60)
                      .contains(world)) {
                    hit = 'Node $i';
                    break;
                  }
                }
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Tapped $hit at $world')),
                );
              },

              // ② 将整个内容包在 CompositedTransformTarget
              child: CompositedTransformTarget(
                link: _link,
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
                      width: canvasSize,
                      height: canvasSize,
                      child: CustomPaint(
                        painter: _GridPainter(cellSize: 50),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),

      // ③ Overlay 层（通过 builder 插入）
      //    我们放在同一个 Navigator.overlay 中，和上面 Target 协同工作。
      //    Flutter 框架会自动把这些 overlay follower 绘制在 Target 之上。
      //    你可以在 build() 中通过一个 Overlay 来插入，或者在 MaterialApp 上下文里 wrap：
      //    这里只示意性地放在同一个 build 里：
      floatingActionButton: Builder(
        builder: (ctx) {
          // 延迟插入 OverlayEntry 保证 context 已经 mount
          WidgetsBinding.instance.addPostFrameCallback((_) {
            final overlay = Overlay.of(ctx)!;
            // 首先移除已有
            overlay.context.visitChildElements((el) {
              if (el.widget is _NodeOverlay) {
                el.markNeedsBuild();
              }
            });
            // 再插入
            for (var i = 0; i < _nodes.length; i++) {
              overlay.insert(
                OverlayEntry(
                  builder: (_) => _NodeOverlay(
                    index: i,
                    link: _link,
                    worldPos: _nodes[i],
                    onDrag: (newWorld) {
                      setState(() => _nodes[i] = newWorld);
                    },
                  ),
                ),
              );
            }
          });
          return const SizedBox.shrink();
        },
      ),
    );
  }
}

// Overlay 上的单个节点
class _NodeOverlay extends StatelessWidget {
  final int index;
  final LayerLink link;
  final Offset worldPos;
  final ValueChanged<Offset> onDrag;
  const _NodeOverlay({
    required this.index,
    required this.link,
    required this.worldPos,
    required this.onDrag,
  });

  @override
  Widget build(BuildContext context) {
    return CompositedTransformFollower(
      link: link,
      showWhenUnlinked: false,
      offset: worldPos, // world → screen 偏移由 transformTarget + follower 自动合成
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onPanUpdate: (d) {
          // d.delta 已经是屏幕单位，映射到世界要用 inverse scale
          onDrag(worldPos +
              d.delta /
                  (context
                      .findAncestorStateOfType<_CanvasWindowState>()!
                      ._scale));
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
          child:
              Text('Node $index', style: const TextStyle(color: Colors.white)),
        ),
      ),
    );
  }
}

class _GridPainter extends CustomPainter {
  final double cellSize;
  const _GridPainter({required this.cellSize});
  @override
  void paint(Canvas c, Size s) {
    final p = Paint()..color = Colors.grey.withOpacity(0.3);
    for (double x = 0; x <= s.width; x += cellSize) {
      c.drawLine(Offset(x, 0), Offset(x, s.height), p);
    }
    for (double y = 0; y <= s.height; y += cellSize) {
      c.drawLine(Offset(0, y), Offset(s.width, y), p);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter o) => false;
}
