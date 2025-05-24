import 'package:flutter/material.dart';
import 'package:flow_editor/core/models/node_model.dart';
import 'package:flow_editor/ui/node/factories/node_widget_factory_impl.dart';
import 'package:flow_editor/ui/node/node_widget_registry_initializer.dart';

class FlowNodeSidebar extends StatelessWidget {
  const FlowNodeSidebar({super.key, required this.onNodeTemplateDragged});

  final void Function(NodeModel) onNodeTemplateDragged;

  @override
  Widget build(BuildContext context) {
    final registry = initNodeWidgetRegistry();
    final nodeFactory = NodeWidgetFactoryImpl(registry: registry);

    final availableNodes = [
      const NodeModel(
        id: 'start_template',
        type: 'start',
        position: Offset.zero,
        size: Size(200, 40),
        title: 'Start',
      ),
      const NodeModel(
        id: 'end_template',
        type: 'end',
        position: Offset.zero,
        size: Size(200, 40),
        title: 'End',
      ),
      const NodeModel(
        id: 'placeholder_template',
        type: 'placeholder',
        position: Offset.zero,
        size: Size(200, 40),
        title: 'Placeholder',
      ),
      const NodeModel(
        id: 'middle_template',
        type: 'middle',
        position: Offset.zero,
        size: Size(200, 40),
        title: 'Middle',
      ),
    ];

    return Container(
      width: 220,
      padding: const EdgeInsets.all(8),
      color: Theme.of(context).colorScheme.surfaceContainerHighest,
      child: ListView(
        children: availableNodes
            .map((node) => Draggable<NodeModel>(
                  data: node,
                  feedback: Opacity(
                    opacity: 0.7,
                    child: SizedBox(
                      width: node.size.width,
                      height: node.size.height,
                      child: nodeFactory.createNodeWidget(node),
                    ),
                  ),
                  childWhenDragging: Opacity(
                    opacity: 0.3,
                    child: nodeFactory.createNodeWidget(node),
                  ),
                  child: nodeFactory.createNodeWidget(node),
                  onDragEnd: (_) => onNodeTemplateDragged(node),
                ))
            .toList(),
      ),
    );
  }
}
