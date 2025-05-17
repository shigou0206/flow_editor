import 'package:flutter/material.dart';
import 'package:flow_editor/v1/core/node/painter/configurable_border_painter.dart';

class NodeBody extends StatelessWidget {
  final BorderPainterConfig? config;
  final double width;
  final double? height;
  final Widget child;

  const NodeBody({
    super.key,
    this.config,
    required this.width,
    this.height,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      foregroundPainter:
          config != null ? ConfigurableBorderPainter(config: config!) : null,
      child: SizedBox(
        width: width,
        height: height, // ✅ 如果是 null，就自动适应父布局（如 Expanded）
        child: child,
      ),
    );
  }
}
