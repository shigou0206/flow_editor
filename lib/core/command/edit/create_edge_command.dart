// create_edge_command.dart

import 'package:flow_editor/core/command/i_command.dart';
import 'package:flow_editor/core/command/command_context.dart';
import 'package:flow_editor/core/models/edge_model.dart';

class CreateEdgeCommand implements ICommand {
  final CommandContext ctx;
  final EdgeModel edge;

  CreateEdgeCommand(this.ctx, this.edge);

  @override
  String get description => 'Create edge ${edge.id}';

  @override
  Future<void> execute() async {
    final st = ctx.getState();
    final updatedEdges = List<EdgeModel>.from(st.edgeState.edges)..add(edge);
    ctx.updateState(
      st.copyWith(edgeState: st.edgeState.updateEdges(updatedEdges)),
    );
  }

  @override
  Future<void> undo() async {
    final st = ctx.getState();
    final updatedEdges =
        st.edgeState.edges.where((e) => e.id != edge.id).toList();
    ctx.updateState(
      st.copyWith(edgeState: st.edgeState.updateEdges(updatedEdges)),
    );
  }
}
