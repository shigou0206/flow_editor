import 'package:flow_editor/core/command/i_command.dart';
import 'package:flow_editor/core/command/command_context.dart';
import 'package:flow_editor/core/command/edit/delete_edge_command.dart';
import 'package:flow_editor/core/command/edit/delete_node_command.dart';

/// 删除一个节点及其所有关联的边
class DeleteNodeWithEdgesCommand implements ICommand {
  final CommandContext ctx;
  final String nodeId;

  late final CompositeCommand _inner;

  DeleteNodeWithEdgesCommand(this.ctx, this.nodeId) {
    final state = ctx.getState();
    final edges = state.edgeState.edges;

    final relatedEdgeIds = edges
        .where((e) => e.sourceNodeId == nodeId || e.targetNodeId == nodeId)
        .map((e) => e.id)
        .toList();

    final children = <ICommand>[
      ...relatedEdgeIds.map((eid) => DeleteEdgeCommand(ctx, eid)),
      DeleteNodeCommand(ctx, nodeId),
    ];

    _inner = CompositeCommand(
      'Delete node $nodeId with ${relatedEdgeIds.length} edges',
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
