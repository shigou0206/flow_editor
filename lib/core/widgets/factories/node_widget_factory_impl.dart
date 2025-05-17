import 'package:flutter/widgets.dart';
import 'package:flow_editor/core/models/node_model.dart';
import 'package:flow_editor/core/node/widgets/commons/node_widget.dart';
import 'package:flow_editor/core/widgets/node_widget_registry.dart';
import 'package:flow_editor/core/widgets/factories/node_widget_factory.dart';
import 'package:flow_editor/core/behaviors/node_behavior.dart';
import 'package:flow_editor/core/behaviors/anchor_behavior.dart';
import 'package:flow_editor/core/node/plugins/node_action_callbacks.dart';

class NodeWidgetFactoryImpl implements NodeWidgetFactory {
  final NodeWidgetRegistry registry;
  final NodeBehavior? nodeBehavior;
  final AnchorBehavior? anchorBehavior;
  final NodeActionCallbacks? callbacks;

  NodeWidgetFactoryImpl({
    required this.registry,
    this.nodeBehavior,
    this.anchorBehavior,
    this.callbacks,
  });

  @override
  Widget createNodeWidget(NodeModel node, {Key? key}) {
    final config = registry.getConfig(node.type ?? '');
    if (config != null) {
      final widget =
          config.builder(node, nodeBehavior, anchorBehavior, callbacks);
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
