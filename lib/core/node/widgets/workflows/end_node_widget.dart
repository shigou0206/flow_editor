import 'package:flutter/material.dart';
import 'package:flow_editor/core/node/models/node_model.dart';
import 'package:flow_editor/core/node/behaviors/node_behavior.dart';
import 'package:flow_editor/core/anchor/behaviors/anchor_behavior.dart';
import 'package:flow_editor/core/node/widgets/components/node_header.dart';
import 'package:flow_editor/core/node/models/node_enums.dart';
import 'package:flow_editor/core/node/widgets/workflows/base/node_widget.dart';

class EndNodeWidget extends StatelessWidget {
  final NodeModel node;
  final NodeBehavior? behavior;
  final AnchorBehavior? anchorBehavior;

  /// 菜单按钮回调
  final VoidCallback? onMenu;

  const EndNodeWidget({
    super.key,
    required this.node,
    this.behavior,
    this.anchorBehavior,
    this.onMenu,
  });

  @override
  Widget build(BuildContext context) {
    return NodeWidget(
      node: node.copyWith(role: NodeRole.end),
      behavior: behavior,
      anchorBehavior: anchorBehavior,
      header: NodeHeader(
        width: node.width,
        height: 30.0,
        buttons: [
          NodeHeaderButton(
            icon: Icons.more_vert,
            onTap: onMenu ?? () {},
            tooltip: 'Menu',
          ),
        ],
      ),
      body: Container(
        width: node.width,
        height: node.height,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: const LinearGradient(
            colors: [Color(0xFFE53935), Color(0xFFEF5350)],
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
          ),
          boxShadow: const [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 8,
              offset: Offset(2, 2),
            )
          ],
          border: Border.all(color: Colors.redAccent, width: 4),
        ),
        child: const Center(
          child: Icon(
            Icons.stop,
            color: Colors.white,
            size: 40,
          ),
        ),
      ),
      footer: null,
      onDelete: () {}, // 禁止删除
    );
  }
}
