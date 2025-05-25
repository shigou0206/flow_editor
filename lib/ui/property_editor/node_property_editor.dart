import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flow_editor/core/state_management/providers.dart';
import 'package:flow_editor/core/models/edge_model.dart';
import 'package:collection/collection.dart';
import 'node_property_editor_providers.dart';

class NodePropertyEditor extends ConsumerWidget {
  const NodePropertyEditor({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedNodeIds =
        ref.watch(selectionProvider.select((s) => s.nodeIds));
    final selectedNodeId =
        selectedNodeIds.isNotEmpty ? selectedNodeIds.first : null;

    final editorState = ref.watch(activeEditorStateProvider);

    if (selectedNodeId == null) {
      return const Center(child: Text('未选择节点'));
    }

    final selectedNode = editorState.nodeState.nodes
        .firstWhereOrNull((node) => node.id == selectedNodeId);

    if (selectedNode == null) {
      return const Center(child: Text('未找到选中节点'));
    }

    final availableNextNodes = editorState.nodeState.nodes
        .where(
          (node) =>
              node.id != selectedNodeId &&
              node.type != 'start' &&
              !node.isGroup,
        )
        .toList();

    final isChoiceNode = selectedNode.type == 'Choice';

    if (isChoiceNode) {
      final initialSelectedNodes = editorState.edgeState.edges
          .where((e) => e.sourceNodeId == selectedNodeId)
          .map((e) => e.targetNodeId)
          .toList();

      WidgetsBinding.instance.addPostFrameCallback((_) {
        final notifier =
            ref.read(choiceSelectedNextNodesProvider(selectedNodeId).notifier);
        if (notifier.state.isEmpty) {
          notifier.state = initialSelectedNodes.cast<String>();
        }
      });
    }

    final selectedChoiceNextNodes =
        ref.watch(choiceSelectedNextNodesProvider(selectedNodeId));

    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '编辑节点: ${selectedNode.id}',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: 20),
          Expanded(
            child: isChoiceNode
                ? ListView(
                    children: availableNextNodes.map((node) {
                      final isChecked =
                          selectedChoiceNextNodes.contains(node.id);
                      return CheckboxListTile(
                        value: isChecked,
                        title: Text(node.id),
                        onChanged: (selected) {
                          if (selected == null) return;
                          final notifier = ref.read(
                              choiceSelectedNextNodesProvider(selectedNodeId)
                                  .notifier);
                          final currentList = notifier.state;

                          if (selected && !currentList.contains(node.id)) {
                            notifier.state = [...currentList, node.id];
                          } else if (!selected &&
                              currentList.contains(node.id)) {
                            notifier.state = currentList
                                .where((id) => id != node.id)
                                .toList();
                          }
                        },
                      );
                    }).toList(),
                  )
                : _SingleNodeDropdown(
                    selectedNode: selectedNode,
                    availableNextNodes: availableNextNodes,
                  ),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () async {
              final controller = ref.read(activeCanvasControllerProvider);

              // 删除旧连接
              final currentEdges = editorState.edgeState.edges
                  .where((e) => e.sourceNodeId == selectedNodeId)
                  .toList();

              for (final edge in currentEdges) {
                await controller.graph.deleteEdge(edge.id);
              }

              if (isChoiceNode) {
                for (final nextId in selectedChoiceNextNodes) {
                  final newEdge = EdgeModel.generated(
                    sourceNodeId: selectedNodeId,
                    targetNodeId: nextId,
                  );
                  await controller.graph.addEdge(newEdge);
                }
              } else {
                final nextNodeId = ref.read(singleNextNodeProvider);
                if (nextNodeId == null) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('请选择下一个节点')),
                  );
                  return;
                }
                final newEdge = EdgeModel.generated(
                  sourceNodeId: selectedNodeId,
                  targetNodeId: nextNodeId,
                );
                await controller.graph.addEdge(newEdge);

                await controller.graph.updateNodeProperty(
                  selectedNodeId,
                  (node) => node.copyWith(
                    data: {...node.data, 'next': nextNodeId},
                  ),
                );
              }

              await controller.graph.applyLayout();

              if (context.mounted) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('节点更新并重新布局成功')),
                );
              }
            },
            child: const Text('保存'),
          ),
        ],
      ),
    );
  }
}

final singleNextNodeProvider = StateProvider<String?>((ref) => null);

class _SingleNodeDropdown extends ConsumerWidget {
  final dynamic selectedNode;
  final List<dynamic> availableNextNodes;

  const _SingleNodeDropdown({
    required this.selectedNode,
    required this.availableNextNodes,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final singleNextNode = ref.watch(singleNextNodeProvider);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(singleNextNodeProvider.notifier).state ??=
          selectedNode.data['next'] as String?;
    });

    return DropdownButtonFormField<String>(
      value: singleNextNode,
      decoration: const InputDecoration(
        labelText: 'Next 节点',
        border: OutlineInputBorder(),
      ),
      items: availableNextNodes
          .map((node) => DropdownMenuItem<String>(
                value: node.id,
                child: Text(node.id),
              ))
          .toList(),
      onChanged: (newNext) {
        ref.read(singleNextNodeProvider.notifier).state = newNext;
      },
      validator: (value) => value == null ? '请选择下一个节点' : null,
    );
  }
}
