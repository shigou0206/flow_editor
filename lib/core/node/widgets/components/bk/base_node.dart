import 'package:flutter/material.dart';
import 'package:flow_editor/core/node/models/node_model.dart';

/// BaseNode 组件仅负责根据 [NodeModel] 中的位置信息和尺寸信息对其 [child] 进行定位。
///
/// 该组件内部使用 [Positioned] 进行布局，适用于 [Stack] 布局中。
class BaseNode extends StatelessWidget {
  final NodeModel node;
  final Widget child;

  const BaseNode({
    super.key,
    required this.node,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: node.x,
      top: node.y,
      width: node.width,
      height: node.height,
      child: child,
    );
  }
}
