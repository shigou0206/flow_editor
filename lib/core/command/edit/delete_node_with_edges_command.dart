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
    // 在构造时，就根据当前状态，收集所有和 nodeId 相关的 edgeId
    final state = ctx.getState();
    final wf = state.activeWorkflowId;
    final edges = state.edges.edgesOf(wf);
    final relatedEdgeIds = edges
        .where((e) => e.sourceNodeId == nodeId || e.targetNodeId == nodeId)
        .map((e) => e.id)
        .toList();

    // 先删除所有相关边，再删除节点
    final children = <ICommand>[];
    for (var eid in relatedEdgeIds) {
      children.add(DeleteEdgeCommand(ctx, eid));
    }
    children.add(DeleteNodeCommand(ctx, nodeId));

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
