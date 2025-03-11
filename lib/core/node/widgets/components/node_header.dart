import 'package:flutter/material.dart';

/// 用于描述头部按钮的通用数据结构
class NodeHeaderButton {
  final IconData icon;
  final VoidCallback onTap;
  final String tooltip;

  NodeHeaderButton({
    required this.icon,
    required this.onTap,
    required this.tooltip,
  });
}

/// 头部组件：根据“按钮列表”动态生成
class NodeHeader extends StatelessWidget {
  final List<NodeHeaderButton> buttons;

  const NodeHeader({super.key, required this.buttons});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: buttons.map((btn) {
        return IconButton(
          icon: Icon(btn.icon),
          tooltip: btn.tooltip,
          onPressed: btn.onTap,
          style: ButtonStyle(
            overlayColor: WidgetStateProperty.all(Colors.transparent),
          ),
        );
      }).toList(),
    );
  }
}
