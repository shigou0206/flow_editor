import 'package:flutter/widgets.dart';
import '../models/node_model.dart';
import '../widgets/commons/node_widget.dart';
import '../node_widget_registry.dart';
import 'node_widget_factory.dart';

class NodeWidgetFactoryImpl implements NodeWidgetFactory {
  final NodeWidgetRegistry registry;

  NodeWidgetFactoryImpl({required this.registry});

  @override
  Widget createNodeWidget(NodeModel node, {Key? key}) {
    final config = registry.getConfig(node.type);
    if (config != null) {
      final widget = config.builder(node);
      return config.useDefaultContainer
          ? NodeWidget(node: node, child: widget)
          : widget;
    }
    throw Exception('Unsupported node type: ${node.type}');
  }
}
