import 'package:flutter/material.dart';
import '../../models/shape_node_model.dart';
import 'painters/rectangle_painter.dart';

class ShapeNodeWidget extends StatelessWidget {
  final ShapeNodeModel node;

  const ShapeNodeWidget({super.key, required this.node});

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size(node.width, node.height),
      painter: RectanglePainter(node.color),
      child: Center(
        child: Text(
          node.label,
          style: const TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
