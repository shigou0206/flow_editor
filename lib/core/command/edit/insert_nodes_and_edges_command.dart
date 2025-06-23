import 'package:flow_editor/core/command/i_command.dart';
import 'package:flow_editor/core/command/command_context.dart';
import 'package:flow_editor/core/models/ui/node_model.dart';
import 'package:flow_editor/core/models/ui/edge_model.dart';

class InsertNodesAndEdgesCommand implements ICommand {
  final CommandContext ctx;
  final List<NodeModel> nodesToInsert;
  final List<EdgeModel> edgesToInsert;

  InsertNodesAndEdgesCommand({
    required this.ctx,
    required this.nodesToInsert,
    required this.edgesToInsert,
  });

  @override
  String get description => 'Insert Nodes and Edges';

  @override
  Future<void> execute() async {
    final state = ctx.getState();

    final updatedNodes = [
      ...state.nodeState.nodes,
      ...nodesToInsert,
    ];

    final updatedEdges = [
      ...state.edgeState.edges,
      ...edgesToInsert,
    ];

    ctx.updateState(
      state.copyWith(
        nodeState: state.nodeState.updateNodes(updatedNodes),
        edgeState: state.edgeState.updateEdges(updatedEdges),
      ),
    );
  }

  @override
  Future<void> undo() async {
    final state = ctx.getState();

    final insertedNodeIds = nodesToInsert.map((node) => node.id).toSet();
    final insertedEdgeIds = edgesToInsert.map((edge) => edge.id).toSet();

    final updatedNodes = state.nodeState.nodes
        .where((node) => !insertedNodeIds.contains(node.id))
        .toList();

    final updatedEdges = state.edgeState.edges
        .where((edge) => !insertedEdgeIds.contains(edge.id))
        .toList();

    ctx.updateState(
      state.copyWith(
        nodeState: state.nodeState.updateNodes(updatedNodes),
        edgeState: state.edgeState.updateEdges(updatedEdges),
      ),
    );
  }
}
