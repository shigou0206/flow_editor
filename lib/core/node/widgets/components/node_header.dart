import 'package:flutter/material.dart';

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

class NodeHeader extends StatelessWidget {
  final List<NodeHeaderButton> buttons;
  final double width;
  final double height;

  const NodeHeader({
    super.key,
    required this.buttons,
    required this.width,
    this.height = 24, // ✅ 默认高度小一点
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: buttons.map((btn) {
          return Expanded(
            child: Tooltip(
              message: btn.tooltip,
              child: InkWell(
                onTap: btn.onTap,
                child: Center(
                  child: Icon(
                    btn.icon,
                    size: height * 0.6, // ✅ 图标大小相对 header 高度自适应
                  ),
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
