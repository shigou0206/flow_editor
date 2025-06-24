// delete_node_with_auto_reconnect_command.dart

import 'package:flow_editor/core/command/i_command.dart';
import 'package:flow_editor/core/command/command_context.dart';
import 'package:flow_editor/core/models/ui/edge_model.dart';
import 'package:flow_editor/core/command/edit/delete_edge_command.dart';
import 'package:flow_editor/core/command/edit/delete_node_command.dart';
import 'package:flow_editor/core/command/edit/add_edge_command.dart';

class DeleteNodeWithAutoReconnectCommand implements ICommand {
  final CommandContext ctx;
  final String nodeId;

  late CompositeCommand _inner;

  static const Set<String> protectedNodeIds = {
    'start_node',
    'end_node',
    'group_root',
  };

  DeleteNodeWithAutoReconnectCommand(this.ctx, this.nodeId) {
    if (protectedNodeIds.contains(nodeId)) {
      throw Exception('禁止删除特殊节点: $nodeId');
    }

    final state = ctx.getState();
    final nodes = state.nodeState.nodes;
    final edges = state.edgeState.edges;

    final relatedEdges = edges
        .where((e) => e.sourceNodeId == nodeId || e.targetNodeId == nodeId)
        .toList();

    final incomingEdges =
        relatedEdges.where((e) => e.targetNodeId == nodeId).toList();
    final outgoingEdges =
        relatedEdges.where((e) => e.sourceNodeId == nodeId).toList();

    final children = <ICommand>[
      // 删除关联的边
      ...relatedEdges.map((e) => DeleteEdgeCommand(ctx, e.id)),
      // 删除节点
      DeleteNodeCommand(ctx, nodeId),
    ];

    final deletedNode = nodes.firstWhere((n) => n.id == nodeId);

    final allowReconnect =
        !['choice', 'parallel', 'map'].contains(deletedNode.type);

    // 标记当前被删除节点是否为startAt节点 (start_node指向的节点)
    final isStartAtNode =
        incomingEdges.any((e) => e.sourceNodeId == 'start_node');

    if (isStartAtNode) {
      // 如果删除的是入口节点，需要重新连接start_node
      if (outgoingEdges.isNotEmpty) {
        final newStartEdge = EdgeModel.generated(
          sourceNodeId: 'start_node',
          targetNodeId: outgoingEdges.first.targetNodeId,
        );
        children.add(AddEdgeCommand(ctx, newStartEdge));
      }
      // 如果没有后继节点，则start_node不再连接任何节点（孤立）
    } else if (allowReconnect &&
        incomingEdges.length == 1 &&
        outgoingEdges.length == 1 &&
        !protectedNodeIds.contains(incomingEdges.first.sourceNodeId) &&
        !protectedNodeIds.contains(outgoingEdges.first.targetNodeId)) {
      // 一般节点的自动重连（不涉及start节点）
      final newEdge = EdgeModel.generated(
        sourceNodeId: incomingEdges.first.sourceNodeId,
        targetNodeId: outgoingEdges.first.targetNodeId,
      );
      children.add(AddEdgeCommand(ctx, newEdge));
    }

    _inner = CompositeCommand(
      'Delete node $nodeId with auto-reconnect',
      children,
    );
  }

  @override
  String get description => _inner.description;

  @override
  Future<void> execute() => _inner.execute();

  @override
  Future<void> undo() => _inner.undo();
}
