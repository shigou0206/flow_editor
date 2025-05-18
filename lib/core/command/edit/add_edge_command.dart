import 'package:flow_editor/core/command/i_command.dart';
import 'package:flow_editor/core/command/command_context.dart';
import 'package:flow_editor/core/models/edge_model.dart';

/// 向当前活跃工作流中添加一条边
class AddEdgeCommand implements ICommand {
  final CommandContext ctx;
  final EdgeModel edge;

  late int _insertIndex;

  AddEdgeCommand(this.ctx, this.edge);

  @override
  String get description => 'Add edge ${edge.id}';

  @override
  Future<void> execute() async {
    final st = ctx.getState(); // EditorState
    final wf = st.activeWorkflowId;
    final current = st.edges.edgesOf(wf);
    _insertIndex = current.length;
    final updated = List<EdgeModel>.from(current)..add(edge);
    final newEdgeState = st.edges.updateWorkflowEdges(wf, updated);
    ctx.updateState(st.copyWith(edges: newEdgeState));
  }

  @override
  Future<void> undo() async {
    final st = ctx.getState();
    final wf = st.activeWorkflowId;
    final current = st.edges.edgesOf(wf);
    // 如索引越界，则直接忽略
    if (_insertIndex < 0 || _insertIndex >= current.length) {
      return;
    }
    final updated = List<EdgeModel>.from(current)..removeAt(_insertIndex);
    final newEdgeState = st.edges.updateWorkflowEdges(wf, updated);
    ctx.updateState(st.copyWith(edges: newEdgeState));
  }
}
