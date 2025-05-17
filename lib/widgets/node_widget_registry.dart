import 'package:flutter/widgets.dart';
import 'package:flow_editor/core/models/node_model.dart';
import 'package:flow_editor/core/behaviors/node_behavior.dart';
import 'package:flow_editor/core/behaviors/anchor_behavior.dart';
import 'package:flow_editor/core/plugin/node_action_callbacks.dart';

typedef NodeWidgetBuilder = Widget Function(
    NodeModel node,
    NodeBehavior? nodeBehavior,
    AnchorBehavior? anchorBehavior,
    NodeActionCallbacks? callbacks);

class NodeWidgetRegistry {
  final Map<String, _NodeWidgetConfig> _configs = {};

  void register<T extends NodeModel>({
    required String type,
    required NodeWidgetBuilder builder,
    bool useDefaultContainer = true,
  }) {
    _configs[type] = _NodeWidgetConfig(
      (node, nodeBehavior, anchorBehavior, callbacks) =>
          builder(node as T, nodeBehavior, anchorBehavior, callbacks),
      useDefaultContainer,
    );
  }

  // ignore: library_private_types_in_public_api
  _NodeWidgetConfig? getConfig(String type) => _configs[type];
}

class _NodeWidgetConfig {
  final NodeWidgetBuilder builder;
  final bool useDefaultContainer;

  _NodeWidgetConfig(this.builder, this.useDefaultContainer);
}
