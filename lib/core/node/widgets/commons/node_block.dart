import 'package:flutter/material.dart';
import '../../models/node_model.dart';
import '../../behaviors/node_behavior.dart';

/// NodeBlock：节点主体 (只负责UI，删除按钮等，不处理单击/双击/右键/鼠标悬停)
class NodeBlock extends StatelessWidget {
  final NodeModel node;
  final Widget child;
  final NodeBehavior? behavior;

  const NodeBlock({
    Key? key,
    required this.node,
    required this.child,
    this.behavior,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (ctx, constraints) {
        final double w =
            constraints.hasBoundedWidth ? constraints.maxWidth : node.width;
        final double h =
            constraints.hasBoundedHeight ? constraints.maxHeight : node.height;

        return SizedBox(
          width: w,
          height: h,
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              // 主体容器
              Container(
                width: w,
                height: h,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(6),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 4,
                      offset: const Offset(2, 2),
                    ),
                  ],
                ),
                alignment: Alignment.center,
                child: child,
              ),
              // 删除按钮（漂浮在右上角）
              Positioned(
                top: -10,
                right: -10,
                width: 24,
                height: 24,
                child: IconButton(
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(
                    maxWidth: 24,
                    maxHeight: 24,
                  ),
                  iconSize: 18,
                  icon: const Icon(Icons.delete),
                  onPressed: () => behavior?.onDelete(node),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
