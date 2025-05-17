// lib/bezier_edge_demo.dart
// -----------------------------------------------------------------------------
// Demo 要点
//   • 节点 A / B 可拖动            → 改变 Bézier 端点
//   • 控制点 cp1 / cp2 可拖动      → 改变曲线形状
//   • Anchor a1 / a2 永远贴曲线     (25% & 75% 位置)
//      · a1 = 橙色   a2 = 紫色
//      · 被拖动（选中）时高亮黄
// -----------------------------------------------------------------------------
import 'dart:ui';
import 'package:flutter/material.dart';

void main() => runApp(const MaterialApp(home: BezierEdgeDemo()));

// ───────────────────────────── data models ─────────────────────────────
class NodeModel {
  NodeModel({required this.id, required this.position});
  final String id;
  Offset position;
  static const Size size = Size(70, 46);
}

class ControlPoint {
  ControlPoint({required this.id, required this.pos});
  final String id;
  Offset pos;
}

class EdgeAnchor {
  EdgeAnchor({required this.id, required this.seg, required this.t});
  final String id;
  int seg;
  double t;
  Offset offset = Offset.zero;
}

class _Nearest {
  const _Nearest(this.seg, this.t);
  final int seg;
  final double t;
}

class EdgeModel {
  EdgeModel({required this.anchors});
  final List<EdgeAnchor> anchors;
  Path path = Path();

  Offset anchorWorld(EdgeAnchor a) {
    final ms = path.computeMetrics().toList();
    if (ms.isEmpty) return Offset.zero;
    final seg = a.seg.clamp(0, ms.length - 1);
    return ms[seg].getTangentForOffset(ms[seg].length * a.t)!.position +
        a.offset;
  }

  // ★ 修正：同步更新 offset，保证 world 坐标不跳
  void rebuild(NodeModel nA, NodeModel nB, ControlPoint cp1, ControlPoint cp2) {
    // 1️⃣ 重新生成曲线
    path = Path()
      ..moveTo(nA.position.dx, nA.position.dy)
      ..cubicTo(cp1.pos.dx, cp1.pos.dy, cp2.pos.dx, cp2.pos.dy, nB.position.dx,
          nB.position.dy);

    // 2️⃣ 计算锚点
    final ms = path.computeMetrics().toList();
    if (ms.isEmpty) return;

    for (final a in anchors) {
      // 锚点当前的世界坐标（拖拽后的位置）
      final world = anchorWorld(a);

      // 找到曲线上最近的参数位置
      final near = _nearest(ms, world);
      a.seg = near.seg;
      a.t = near.t;

      // 曲线新基准点
      final base =
          ms[a.seg].getTangentForOffset(ms[a.seg].length * a.t)!.position;

      // 3️⃣ 重新计算 offset，让 world 不变
      a.offset = world - base;
    }
  }

  _Nearest _nearest(List<PathMetric> ms, Offset p) {
    double best = double.infinity;
    int seg = 0;
    double tt = 0;
    for (var i = 0; i < ms.length; i++) {
      final m = ms[i];
      const sample = 30;
      for (var s = 0; s <= sample; s++) {
        final t = s / sample;
        final pos = m.getTangentForOffset(m.length * t)!.position;
        final d = (pos - p).distance;
        if (d < best) {
          best = d;
          seg = i;
          tt = t;
        }
      }
    }
    return _Nearest(seg, tt);
  }
}

// ───────────────────────────── main widget ─────────────────────────────
class BezierEdgeDemo extends StatefulWidget {
  const BezierEdgeDemo({Key? key}) : super(key: key);
  @override
  State<BezierEdgeDemo> createState() => _BezierDemoState();
}

class _BezierDemoState extends State<BezierEdgeDemo> {
  late NodeModel nA, nB;
  late ControlPoint cp1, cp2;
  late EdgeModel edge;

  String? dragId;
  Offset? last;

  @override
  void initState() {
    super.initState();
    nA = NodeModel(id: 'A', position: const Offset(80, 260));
    nB = NodeModel(id: 'B', position: const Offset(360, 120));

    cp1 = ControlPoint(id: 'cp1', pos: nA.position + const Offset(90, -130));
    cp2 = ControlPoint(id: 'cp2', pos: nB.position + const Offset(-110, 140));

    edge = EdgeModel(anchors: [
      EdgeAnchor(id: 'a1', seg: 0, t: .25), // 25%
      EdgeAnchor(id: 'a2', seg: 0, t: .75), // 75%
    ]);
    _refresh();
  }

  void _refresh() => edge.rebuild(nA, nB, cp1, cp2);

  // ── gestures
  void _start(Offset p) {
    const pick = 18.0;
    final hits = <String, Offset>{
      'A': nA.position,
      'B': nB.position,
      'cp1': cp1.pos,
      'cp2': cp2.pos,
      'a1': edge.anchorWorld(edge.anchors[0]),
      'a2': edge.anchorWorld(edge.anchors[1]),
    };
    dragId = hits.entries
        .firstWhere((e) => (e.value - p).distance <= pick,
            orElse: () => const MapEntry('', Offset.zero))
        .key;
    if (dragId!.isNotEmpty) last = p;
  }

  void _update(Offset p) {
    if (dragId == null || dragId!.isEmpty) return;
    final d = p - last!;
    last = p;
    setState(() {
      switch (dragId) {
        case 'A':
          nA.position += d;
          break;
        case 'B':
          nB.position += d;
          break;
        case 'cp1':
          cp1.pos += d;
          break;
        case 'cp2':
          cp2.pos += d;
          break;
        case 'a1':
          edge.anchors[0].offset += d;
          break;
        case 'a2':
          edge.anchors[1].offset += d;
          break;
      }
      _refresh();
    });
  }

  void _end() {
    dragId = null;
    last = null;
  }

  @override
  Widget build(BuildContext ctx) => Scaffold(
        appBar: AppBar(title: const Text('Bézier Edge Demo')),
        body: LayoutBuilder(
          builder: (_, cons) => GestureDetector(
            behavior: HitTestBehavior.translucent,
            onPanStart: (d) => _start(d.localPosition),
            onPanUpdate: (d) => _update(d.localPosition),
            onPanEnd: (_) => _end(),
            child: CustomPaint(
              size: cons.biggest,
              painter: _Painter(nA, nB, cp1, cp2, edge, dragId ?? ''),
            ),
          ),
        ),
      );
}

// ───────────────────────────── painter ─────────────────────────────
class _Painter extends CustomPainter {
  _Painter(this.nA, this.nB, this.cp1, this.cp2, this.edge, this.hl);
  final NodeModel nA, nB;
  final ControlPoint cp1, cp2;
  final EdgeModel edge;
  final String hl;

  @override
  void paint(Canvas c, Size s) {
    _grid(c, s);

    // curve
    c.drawPath(
        edge.path,
        Paint()
          ..color = Colors.blue
          ..style = PaintingStyle.stroke
          ..strokeWidth = 3);

    // helper lines
    c.drawLine(nA.position, cp1.pos, _dash);
    c.drawLine(cp2.pos, nB.position, _dash);

    // nodes
    _node(c, nA);
    _node(c, nB);

    // control points
    _dot(c, cp1.pos, hl == 'cp1', Colors.green);
    _dot(c, cp2.pos, hl == 'cp2', Colors.green);
    _label(c, 'cp1', cp1.pos, 10);
    _label(c, 'cp2', cp2.pos, 10);

    // anchors
    _drawAnchor(c, edge.anchors[0], Colors.orange);
    _drawAnchor(c, edge.anchors[1], Colors.purple);
  }

  // helpers
  final Paint _dash = Paint()
    ..color = Colors.grey
    ..strokeWidth = 1;

  void _dot(Canvas c, Offset p, bool hi, Color base) {
    c.drawCircle(p, 10, Paint()..color = hi ? Colors.yellow : base);
    c.drawCircle(
        p,
        10,
        Paint()
          ..color = Colors.white
          ..style = PaintingStyle.stroke
          ..strokeWidth = 2);
  }

  void _drawAnchor(Canvas c, EdgeAnchor a, Color base) {
    final p = edge.anchorWorld(a);
    _dot(c, p, hl == a.id, base);
    _label(c, a.id, p, 10);
  }

  void _node(Canvas c, NodeModel n) {
    c.drawRRect(
        RRect.fromRectAndRadius(
            Rect.fromCenter(
                center: n.position,
                width: NodeModel.size.width,
                height: NodeModel.size.height),
            const Radius.circular(6)),
        Paint()..color = Colors.black.withOpacity(.8));
    _label(c, n.id, n.position, 12);
  }

  void _label(Canvas c, String text, Offset center, double size) {
    final tp = TextPainter(
        text: TextSpan(
            text: text, style: TextStyle(fontSize: size, color: Colors.white)),
        textDirection: TextDirection.ltr)
      ..layout();
    tp.paint(c, center - Offset(tp.width / 2, tp.height / 2));
  }

  void _grid(Canvas c, Size s) {
    const step = 40.0;
    final g = Paint()..color = Colors.grey.withOpacity(.15);
    for (double x = 0; x <= s.width; x += step) {
      c.drawLine(Offset(x, 0), Offset(x, s.height), g);
    }
    for (double y = 0; y <= s.height; y += step) {
      c.drawLine(Offset(0, y), Offset(s.width, y), g);
    }
  }

  @override
  bool shouldRepaint(covariant _Painter old) =>
      nA.position != old.nA.position ||
      nB.position != old.nB.position ||
      cp1.pos != old.cp1.pos ||
      cp2.pos != old.cp2.pos ||
      edge.path != old.edge.path ||
      hl != old.hl;
}
