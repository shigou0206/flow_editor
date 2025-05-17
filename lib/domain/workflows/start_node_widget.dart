import 'package:flutter/material.dart';
import 'package:flow_editor/core/models/node_model.dart';
import 'package:flow_editor/core/behaviors/node_behavior.dart';
import 'package:flow_editor/core/behaviors/anchor_behavior.dart';
import 'package:flow_editor/core/models/node_enums.dart';
import 'package:flow_editor/domain/workflows/base/node_widget.dart';
import 'package:flow_editor/core/node/plugins/node_action_callbacks.dart';

class StartNodeWidget extends StatelessWidget {
  final NodeModel node;
  final NodeBehavior? behavior;
  final AnchorBehavior? anchorBehavior;
  final NodeActionCallbacks? callbacks;

  const StartNodeWidget({
    super.key,
    required this.node,
    this.behavior,
    this.anchorBehavior,
    this.callbacks,
  });

  @override
  Widget build(BuildContext context) {
    return NodeWidget(
      node: node.copyWith(role: NodeRole.start),
      behavior: behavior,
      anchorBehavior: anchorBehavior,
      header: null,
      body: Container(
        width: node.size.width,
        height: node.size.height,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.grey[100],
          border: Border.all(color: Colors.black87, width: 2),
          boxShadow: const [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 4,
              offset: Offset(1, 2),
            ),
          ],
        ),
        child: const Center(
          child: Text(
            'Start',
            style: TextStyle(
              color: Color.fromARGB(221, 19, 19, 19),
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
        ),
      ),
      footer: null,
      callbacks: NodeActionCallbacks(
        onDelete: (node) {}, // 禁止删除
      ),
    );
  }
}
