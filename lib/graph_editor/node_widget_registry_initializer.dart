// node_widget_registry_initializer.dart

import 'package:flow_editor/core/widgets/node_widget_registry.dart';
import 'package:flow_editor/core/models/node_model.dart';

// 这里引入你各种节点的自定义Widget
import 'package:flow_editor/domain/workflows/start_node_widget.dart';
import 'package:flow_editor/domain/workflows/end_node_widget.dart';
import 'package:flow_editor/domain/workflows/base/node_widget.dart';
import 'package:flow_editor/domain/workflows/placeholder_node_widget.dart';

NodeWidgetRegistry initNodeWidgetRegistry() {
  final registry = NodeWidgetRegistry();

  registry.register<NodeModel>(
    type: 'start',
    builder: (node, nodeBehavior, anchorBehavior, callbacks) => StartNodeWidget(
      node: node,
      behavior: nodeBehavior,
      anchorBehavior: anchorBehavior,
      callbacks: callbacks,
    ),
    useDefaultContainer: false,
  );

  registry.register<NodeModel>(
    type: 'end',
    builder: (node, nodeBehavior, anchorBehavior, callbacks) => EndNodeWidget(
      node: node,
      behavior: nodeBehavior,
      anchorBehavior: anchorBehavior,
      callbacks: callbacks,
    ),
    useDefaultContainer: false,
  );

  registry.register<NodeModel>(
    type: 'placeholder',
    builder: (node, nodeBehavior, anchorBehavior, callbacks) =>
        PlaceholderNodeWidget(
      node: node,
      behavior: nodeBehavior,
      anchorBehavior: anchorBehavior,
      callbacks: callbacks,
    ),
    useDefaultContainer: false,
  );

  registry.register<NodeModel>(
    type: 'middle',
    builder: (node, nodeBehavior, anchorBehavior, callbacks) => NodeWidget(
      node: node,
      behavior: nodeBehavior,
      anchorBehavior: anchorBehavior,
      callbacks: callbacks,
    ),
    useDefaultContainer: false,
  );

  return registry;
}
