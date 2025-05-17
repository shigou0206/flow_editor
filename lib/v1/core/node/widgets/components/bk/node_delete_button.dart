import 'package:flutter/material.dart';
import 'package:flow_editor/v1/core/node/models/node_model.dart';
import 'package:flow_editor/v1/core/node/behaviors/node_behavior.dart';

/// NodeDeleteButton 组件用于在节点右上角显示一个删除按钮。
///
/// 该组件使用 [Positioned] 放置在节点区域外（通过负偏移），
/// 以避免遮挡节点的主要交互区域。支持传入自定义按钮；
/// 如果没有提供，则使用默认的 [IconButton]。
class NodeDeleteButton extends StatelessWidget {
  final NodeModel node;
  final NodeBehavior? behavior;
  final Widget? customButton;

  const NodeDeleteButton({
    super.key,
    required this.node,
    this.behavior,
    this.customButton,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: -10,
      right: -10,
      width: 24,
      height: 24,
      child: customButton ??
          IconButton(
            key: const Key('delete_button'),
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(
              maxWidth: 24,
              maxHeight: 24,
            ),
            iconSize: 18,
            icon: const Icon(Icons.delete),
            onPressed: () {
              behavior?.onDelete(node);
            },
          ),
    );
  }
}
