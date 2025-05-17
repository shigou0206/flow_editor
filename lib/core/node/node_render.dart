import 'package:flutter/material.dart';
import 'package:flow_editor/core/models/node_model.dart';

class NodeRenderer extends CustomPainter {
  final List<NodeModel> nodes;
  final Offset offset;
  final double scale;
  final Widget Function(NodeModel node)? nodeBuilder;

  NodeRenderer({
    required this.nodes,
    this.offset = Offset.zero,
    this.scale = 1.0,
    this.nodeBuilder,
  });

  @override
  void paint(Canvas canvas, Size size) {
    for (final node in nodes) {
      _renderNode(canvas, node);
    }
  }

  void _renderNode(Canvas canvas, NodeModel node) {
    final paint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill
      ..strokeWidth = 1;

    final rect = Rect.fromLTWH(
      (node.position.dx + offset.dx) * scale,
      (node.position.dy + offset.dy) * scale,
      node.size.width * scale,
      node.size.height * scale,
    );

    canvas.drawRRect(
      RRect.fromRectAndRadius(rect, const Radius.circular(8.0)),
      paint,
    );

    // 边框
    final borderPaint = Paint()
      ..color = Colors.grey.shade400
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1;

    canvas.drawRRect(
      RRect.fromRectAndRadius(rect, const Radius.circular(8.0)),
      borderPaint,
    );

    // 文本
    final textPainter = TextPainter(
      text: TextSpan(
        text: node.title,
        style: TextStyle(color: Colors.black87, fontSize: 14 * scale),
      ),
      textDirection: TextDirection.ltr,
      maxLines: 2,
      ellipsis: '...',
    );

    textPainter.layout(maxWidth: rect.width - 8.0);

    textPainter.paint(
      canvas,
      Offset(
          rect.left + 4.0, rect.top + (rect.height - textPainter.height) / 2),
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
