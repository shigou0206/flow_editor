import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flow_editor/core/models/node_model.dart';
import 'package:flow_editor/ui/node/workflow/base/node_widget.dart';
import 'package:flow_editor/ui/node/node_widget_registry.dart';
import 'package:flow_editor/ui/node/factories/node_widget_factory.dart';

class NodeWidgetFactoryImpl implements NodeWidgetFactory {
  final NodeWidgetRegistry registry;

  NodeWidgetFactoryImpl({
    required this.registry,
  });

  @override
  Widget createNodeWidget(NodeModel node, {Key? key}) {
    if (node.isGroup) {
      // ✅ Group 节点特殊处理：透明背景但带一点颜色边框
      return Container(
        key: key,
        width: node.size.width,
        height: node.size.height,
        decoration: BoxDecoration(
          color: Colors.blue.withOpacity(0.05), // 极低透明度背景
          border:
              Border.all(color: Colors.blueAccent.withOpacity(0.4), width: 1),
          borderRadius: BorderRadius.circular(4),
        ),
      );
    }

    final config = registry.getConfig(node.type);
    if (config != null) {
      final widget = config.builder(node);
      return config.useDefaultContainer
          ? NodeWidget(
              key: key,
              node: node,
              child: widget,
            )
          : widget;
    }
    throw Exception('Unsupported node type: ${node.type}');
  }
}
