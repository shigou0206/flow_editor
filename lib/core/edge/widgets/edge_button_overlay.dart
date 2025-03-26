// file: core/edge/widgets/edge_button_overlay.dart
import 'package:flutter/material.dart';

class EdgeButtonOverlay extends StatelessWidget {
  final Offset edgeCenter; // 可选：用于调试或者其他需求，但不用于定位
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
    return IconButton(
      icon: const Icon(Icons.delete, color: Colors.red),
      iconSize: size,
      padding: EdgeInsets.zero,
      constraints: const BoxConstraints(),
      onPressed: onDeleteEdge,
    );
  }
}
