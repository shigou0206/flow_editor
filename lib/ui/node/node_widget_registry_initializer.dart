// node_widget_registry_initializer.dart

import 'package:flow_editor/ui/node/node_widget_registry.dart';
import 'package:flow_editor/core/models/ui/node_model.dart';

// 已存在的Widget
import 'package:flow_editor/ui/node/workflow/start_node_widget.dart';
import 'package:flow_editor/ui/node/workflow/end_node_widget.dart';
import 'package:flow_editor/ui/node/workflow/placeholder_node_widget.dart';
import 'package:flow_editor/ui/node/workflow/middle_node_widget.dart';

// 🚩 所有 Workflow State 节点对应的Widget (你需自行实现)
// import 'package:flow_editor/ui/node/workflow/task_node_widget.dart';
// import 'package:flow_editor/ui/node/workflow/pass_node_widget.dart';
// import 'package:flow_editor/ui/node/workflow/choice_node_widget.dart';
// import 'package:flow_editor/ui/node/workflow/succeed_node_widget.dart';
// import 'package:flow_editor/ui/node/workflow/fail_node_widget.dart';
// import 'package:flow_editor/ui/node/workflow/wait_node_widget.dart';
// import 'package:flow_editor/ui/node/workflow/parallel_node_widget.dart';
// import 'package:flow_editor/ui/node/workflow/map_node_widget.dart';
// import 'package:flow_editor/ui/node/workflow/custom_node_widget.dart';

NodeWidgetRegistry initNodeWidgetRegistry() {
  final registry = NodeWidgetRegistry();

  // 已有的节点
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
    builder: (node) => MiddleNodeWidget(node: node),
    useDefaultContainer: false,
  );

  registry.register<NodeModel>(
    type: 'group',
    builder: (node) => MiddleNodeWidget(node: node),
    useDefaultContainer: false,
  );

  // 🚩 以下为完整的 Workflow State 节点注册

  // Task 节点
  registry.register<NodeModel>(
    type: 'Task',
    builder: (node) => MiddleNodeWidget(node: node),
    useDefaultContainer: false,
  );

  // Pass 节点
  registry.register<NodeModel>(
    type: 'Pass',
    builder: (node) => MiddleNodeWidget(node: node),
    useDefaultContainer: false,
  );

  // Choice 节点
  registry.register<NodeModel>(
    type: 'Choice',
    builder: (node) => MiddleNodeWidget(node: node),
    useDefaultContainer: false,
  );

  // Succeed 节点
  registry.register<NodeModel>(
    type: 'Succeed',
    builder: (node) => MiddleNodeWidget(node: node),
    useDefaultContainer: false,
  );

  // Fail 节点
  registry.register<NodeModel>(
    type: 'Fail',
    builder: (node) => MiddleNodeWidget(node: node),
    useDefaultContainer: false,
  );

  // Wait 节点
  registry.register<NodeModel>(
    type: 'Wait',
    builder: (node) => MiddleNodeWidget(node: node),
    useDefaultContainer: false,
  );

  // Parallel 节点
  registry.register<NodeModel>(
    type: 'Parallel',
    builder: (node) => MiddleNodeWidget(node: node),
    useDefaultContainer: false,
  );

  // Map 节点
  registry.register<NodeModel>(
    type: 'Map',
    builder: (node) => MiddleNodeWidget(node: node),
    useDefaultContainer: false,
  );

  // Custom 节点
  registry.register<NodeModel>(
    type: 'Custom',
    builder: (node) => MiddleNodeWidget(node: node),
    useDefaultContainer: false,
  );

  return registry;
}
