// delete_node_with_auto_reconnect_command.dart

import 'package:flow_editor/core/command/i_command.dart';
import 'package:flow_editor/core/command/command_context.dart';
import 'package:flow_editor/core/models/edge_model.dart';
import 'package:flow_editor/core/command/edit/delete_edge_command.dart';
import 'package:flow_editor/core/command/edit/delete_node_command.dart';
// import 'package:flow_editor/core/command/composite_command.dart';
import 'package:flow_editor/core/command/edit/add_edge_command.dart';

class DeleteNodeWithAutoReconnectCommand implements ICommand {
  final CommandContext ctx;
  final String nodeId;

  late CompositeCommand _inner;

  DeleteNodeWithAutoReconnectCommand(this.ctx, this.nodeId) {
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
      // 首先删除所有与节点关联的边
      ...relatedEdges.map((e) => DeleteEdgeCommand(ctx, e.id)),
      // 然后删除节点
      DeleteNodeCommand(ctx, nodeId),
    ];

    final deletedNode = nodes.firstWhere((n) => n.id == nodeId);

    final allowReconnect =
        !['Choice', 'Parallel', 'Map'].contains(deletedNode.type);

    // 自动重连的条件判断
    if (allowReconnect &&
        incomingEdges.length == 1 &&
        outgoingEdges.length == 1) {
      final newEdge = EdgeModel.generated(
        sourceNodeId: incomingEdges.first.sourceNodeId,
        targetNodeId: outgoingEdges.first.targetNodeId,
      );
      // 创建新的重连边
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
