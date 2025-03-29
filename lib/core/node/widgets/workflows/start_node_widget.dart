import 'package:flutter/material.dart';
import 'package:flow_editor/core/node/models/node_model.dart';
import 'package:flow_editor/core/node/models/node_enums.dart';
import 'package:flow_editor/core/node/behaviors/node_behavior.dart';
import 'package:flow_editor/core/anchor/behaviors/anchor_behavior.dart';
import 'package:flow_editor/core/node/widgets/workflows/base/node_widget.dart';
import 'package:flow_editor/core/node/widgets/components/node_header.dart';

class StartNodeWidget extends StatelessWidget {
  final NodeModel node;
  final NodeBehavior? behavior;
  final AnchorBehavior? anchorBehavior;

  /// 运行和菜单按钮的回调
  final VoidCallback? onRun;
  final VoidCallback? onMenu;

  const StartNodeWidget({
    super.key,
    required this.node,
    this.behavior,
    this.anchorBehavior,
    this.onRun,
    this.onMenu,
  });

  @override
  Widget build(BuildContext context) {
    return NodeWidget(
      node: node.copyWith(role: NodeRole.start),
      behavior: behavior,
      anchorBehavior: anchorBehavior,
      header: NodeHeader(
        width: node.width,
        height: 30.0,
        buttons: [
          NodeHeaderButton(
            icon: Icons.play_arrow,
            onTap: onRun ?? () {},
            tooltip: 'Run',
          ),
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
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          gradient: LinearGradient(
            colors: [Color(0xFF4CAF50), Color(0xFF81C784)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 8,
              offset: Offset(2, 2),
            ),
          ],
        ),
        child: const Center(
          child: Icon(
            Icons.play_arrow,
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
