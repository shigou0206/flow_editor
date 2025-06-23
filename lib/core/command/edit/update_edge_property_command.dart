import 'package:flow_editor/core/command/i_command.dart';
import 'package:flow_editor/core/command/command_context.dart';
import 'package:flow_editor/core/models/ui/edge_model.dart';

/// 通用更新边属性命令，支持 undo/redo
class UpdateEdgePropertyCommand implements ICommand {
  final CommandContext ctx;
  final String edgeId;
  final EdgeModel Function(EdgeModel) updateFn;

  late EdgeModel _beforeEdge;
  late EdgeModel _afterEdge;

  UpdateEdgePropertyCommand(this.ctx, this.edgeId, this.updateFn);

  @override
  String get description => 'Update property of edge $edgeId';

  @override
  Future<void> execute() async {
    final st = ctx.getState();
    final edges = st.edgeState.edges;

    final idx = edges.indexWhere((e) => e.id == edgeId);
    if (idx < 0) throw Exception('Edge not found: $edgeId');

    _beforeEdge = edges[idx];
    _afterEdge = updateFn(_beforeEdge);

    final updated = List<EdgeModel>.from(edges)..[idx] = _afterEdge;
    ctx.updateState(st.copyWith(
      edgeState: st.edgeState.updateEdges(updated),
    ));
  }

  @override
  Future<void> undo() async {
    final st = ctx.getState();
    final edges = st.edgeState.edges;

    final idx = edges.indexWhere((e) => e.id == edgeId);
    if (idx < 0) throw Exception('Edge not found during undo: $edgeId');

    final restored = List<EdgeModel>.from(edges)..[idx] = _beforeEdge;
    ctx.updateState(st.copyWith(
      edgeState: st.edgeState.updateEdges(restored),
    ));
  }
}
