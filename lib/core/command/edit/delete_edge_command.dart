import 'package:flow_editor/core/command/i_command.dart';
import 'package:flow_editor/core/command/command_context.dart';
import 'package:flow_editor/core/models/edge_model.dart';

/// 从当前工作流中删除指定 edgeId 的边
class DeleteEdgeCommand implements ICommand {
  final CommandContext ctx;
  final String edgeId;

  late EdgeModel _removedEdge;
  late int _removedIndex;

  DeleteEdgeCommand(this.ctx, this.edgeId);

  @override
  String get description => 'Delete edge $edgeId';

  @override
  Future<void> execute() async {
    final st = ctx.getState();
    final current = st.edgeState.edges;

    final idx = current.indexWhere((e) => e.id == edgeId);
    if (idx < 0) throw Exception('Edge not found: $edgeId');

    _removedIndex = idx;
    _removedEdge = current[idx];

    final updated = List<EdgeModel>.from(current)..removeAt(idx);
    final newState = st.edgeState.updateEdges(updated);

    ctx.updateState(st.copyWith(edgeState: newState));
  }

  @override
  Future<void> undo() async {
    final st = ctx.getState();
    final current = st.edgeState.edges;

    final updated = List<EdgeModel>.from(current)
      ..insert(_removedIndex, _removedEdge);

    final newState = st.edgeState.updateEdges(updated);
    ctx.updateState(st.copyWith(edgeState: newState));
  }
}
