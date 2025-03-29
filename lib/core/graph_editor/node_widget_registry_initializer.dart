// node_widget_registry_initializer.dart

import 'package:flow_editor/core/node/node_widget_registry.dart';
import 'package:flow_editor/core/node/models/node_model.dart';

// 这里引入你各种节点的自定义Widget
import 'package:flow_editor/core/node/widgets/workflows/start_node_widget.dart';
import 'package:flow_editor/core/node/widgets/workflows/end_node_widget.dart';
import 'package:flow_editor/core/node/widgets/workflows/base/node_widget.dart';
import 'package:flow_editor/core/node/widgets/workflows/placeholder_node_widget.dart';

NodeWidgetRegistry initNodeWidgetRegistry() {
  final registry = NodeWidgetRegistry();

  registry.register<NodeModel>(
    type: 'start',
    builder: (node) => StartNodeWidget(node: node),
    useDefaultContainer: false,
  );

  registry.register<NodeModel>(
    type: 'end',
    builder: (node) => EndNodeWidget(node: node),
    useDefaultContainer: false,
  );

  registry.register<NodeModel>(
    type: 'placeholder',
    builder: (node) => PlaceholderNodeWidget(node: node),
    useDefaultContainer: false,
  );

  registry.register<NodeModel>(
    type: 'middle',
    builder: (node) => NodeWidget(node: node),
    useDefaultContainer: false,
  );

  return registry;
}
