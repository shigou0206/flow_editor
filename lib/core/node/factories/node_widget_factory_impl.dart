import 'package:flutter/widgets.dart';
import 'package:flow_editor/core/node/models/node_model.dart';
import 'package:flow_editor/core/node/widgets/commons/node_widget.dart';
import 'package:flow_editor/core/node/node_widget_registry.dart';
import 'package:flow_editor/core/node/factories/node_widget_factory.dart';
import 'package:flow_editor/core/node/behaviors/node_behavior.dart';
import 'package:flow_editor/core/anchor/behaviors/anchor_behavior.dart';

class NodeWidgetFactoryImpl implements NodeWidgetFactory {
  final NodeWidgetRegistry registry;
  final NodeBehavior? nodeBehavior;
  final AnchorBehavior? anchorBehavior;

  NodeWidgetFactoryImpl({
    required this.registry,
    this.nodeBehavior,
    this.anchorBehavior,
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
              behavior: nodeBehavior,
              anchorBehavior: anchorBehavior,
              child: widget,
            )
          : widget;
    }
    throw Exception('Unsupported node type: ${node.type}');
  }
}
