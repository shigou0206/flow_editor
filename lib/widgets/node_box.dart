// lib/widgets/node_box.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flow_editor/core/models/node_model.dart';

class NodeBox extends ConsumerWidget {
  const NodeBox({
    super.key,
    required this.node,
    required this.canvasOffset,
    required this.canvasScale,
  });

  final NodeModel node;
  final Offset canvasOffset;
  final double canvasScale;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final bg =
        isDark ? Colors.white.withOpacity(.05) : Colors.black.withOpacity(.05);
    final border = isDark ? Colors.grey.shade700 : Colors.grey.shade400;
    final txt = isDark ? Colors.white : Colors.black87;

    final screenPos = node.position * canvasScale + canvasOffset;
    final size = node.size * canvasScale;

    return Positioned(
      left: screenPos.dx - size.width / 2,
      top: screenPos.dy - size.height / 2,
      width: size.width,
      height: size.height,
      child: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: bg,
          borderRadius: BorderRadius.circular(6),
          border: Border.all(color: border, width: 1),
        ),
        child: FittedBox(
          fit: BoxFit.scaleDown,
          child: Text(node.title ?? '',
              style: TextStyle(color: txt, fontWeight: FontWeight.w600)),
        ),
      ),
    );
  }
}
