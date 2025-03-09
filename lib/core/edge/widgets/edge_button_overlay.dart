// file: core/edge/widgets/edge_button_overlay.dart
import 'package:flutter/material.dart';

class EdgeButtonOverlay extends StatelessWidget {
  final Offset edgeCenter; // 边的中点(屏幕坐标)
  final VoidCallback onDeleteEdge; // 删除回调
  final double size;

  const EdgeButtonOverlay({
    super.key,
    required this.edgeCenter,
    required this.onDeleteEdge,
    this.size = 24.0,
  });

  @override
  Widget build(BuildContext context) {
    // 用 Positioned 将按钮放在中点位置
    return Positioned(
      left: edgeCenter.dx - size / 2,
      top: edgeCenter.dy - size / 2,
      child: IconButton(
        icon: const Icon(Icons.delete, color: Colors.red),
        iconSize: size,
        padding: EdgeInsets.zero,
        constraints: const BoxConstraints(),
        onPressed: onDeleteEdge,
      ),
    );
  }
}
