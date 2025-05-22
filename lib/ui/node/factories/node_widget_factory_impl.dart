import 'package:flutter/widgets.dart';
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
