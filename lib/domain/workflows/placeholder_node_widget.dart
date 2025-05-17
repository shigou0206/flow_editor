import 'package:flutter/material.dart';
import 'package:flow_editor/core/models/node_model.dart';
import 'package:flow_editor/core/behaviors/node_behavior.dart';
import 'package:flow_editor/core/behaviors/anchor_behavior.dart';
import 'package:flow_editor/core/models/node_enums.dart';
import 'package:flow_editor/domain/workflows/base/node_widget.dart';
import 'package:flow_editor/core/node/plugins/node_action_callbacks.dart';

class PlaceholderNodeWidget extends StatelessWidget {
  final NodeModel node;
  final NodeBehavior? behavior;
  final AnchorBehavior? anchorBehavior;

  /// 当点击占位节点内部按钮时调用，打开配置界面或转换为正式节点
  final NodeActionCallbacks? callbacks;

  const PlaceholderNodeWidget({
    super.key,
    required this.node,
    this.behavior,
    this.anchorBehavior,
    this.callbacks,
  });

  @override
  Widget build(BuildContext context) {
    return NodeWidget(
      node: node.copyWith(role: NodeRole.placeholder),
      behavior: behavior,
      anchorBehavior: anchorBehavior,
      header: null,
      body: Container(
        width: node.size.width,
        height: node.size.height,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(
            color: Colors.grey,
            width: 2,
            style: BorderStyle.solid,
          ),
          color: Colors.white,
          boxShadow: const [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 4,
              offset: Offset(1, 1),
            )
          ],
        ),
        child: Center(
          child: IconButton(
            icon: const Icon(
              Icons.add,
              color: Colors.grey,
              size: 32,
            ),
            onPressed: callbacks?.onConfigure != null
                ? () => callbacks!.onConfigure!(node)
                : null,
          ),
        ),
      ),
      footer: null,
    );
  }
}
