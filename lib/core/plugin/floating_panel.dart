import 'package:flutter/material.dart';

/// 一个简单的浮动面板，左下角摆放
/// - 接收外部传入的 `children`，用 `Column` 或 `Row` 展示
/// - 可以自定义样式（Card、边框、阴影）
class FloatingPanel extends StatelessWidget {
  final List<Widget> children;
  final EdgeInsets padding;
  final double borderRadius;
  final double elevation;

  const FloatingPanel({
    super.key,
    required this.children,
    this.padding = const EdgeInsets.all(8),
    this.borderRadius = 8,
    this.elevation = 2,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: elevation,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(borderRadius),
      ),
      child: Padding(
        padding: padding,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: children,
        ),
      ),
    );
  }
}
