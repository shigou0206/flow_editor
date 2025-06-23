import 'package:flow_editor/core/command/i_command.dart';
import 'package:flow_editor/core/command/command_context.dart';
import 'package:flow_editor/core/models/ui/edge_model.dart';

/// 向当前 workflow 添加一条边
class AddEdgeCommand implements ICommand {
  final CommandContext ctx;
  final EdgeModel edge;

  late int _insertIndex;

  AddEdgeCommand(this.ctx, this.edge);

  @override
  String get description => 'Add edge ${edge.id}';

  @override
  Future<void> execute() async {
    final st = ctx.getState();
    final current = st.edgeState.edges;
    _insertIndex = current.length;

    final updated = List<EdgeModel>.from(current)..add(edge);
    final newEdgeState = st.edgeState.updateEdges(updated);

    ctx.updateState(st.copyWith(edgeState: newEdgeState));
  }

  @override
  Future<void> undo() async {
    final st = ctx.getState();
    final current = st.edgeState.edges;

    if (_insertIndex < 0 || _insertIndex >= current.length) return;

    final updated = List<EdgeModel>.from(current)..removeAt(_insertIndex);
    final newEdgeState = st.edgeState.updateEdges(updated);

    ctx.updateState(st.copyWith(edgeState: newEdgeState));
  }
}
