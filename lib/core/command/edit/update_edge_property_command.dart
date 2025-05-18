import 'package:flow_editor/core/command/i_command.dart';
import 'package:flow_editor/core/command/command_context.dart';
import 'package:flow_editor/core/models/edge_model.dart';

/// 通用的“更新边属性”命令：
/// 通过传入一个 updateFn（EdgeModel -> EdgeModel）来修改指定边，
/// 并保存修改前后的快照以支持 undo/redo。
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
    final workflowId = st.activeWorkflowId;

    // 拿到当前 EdgeState 和该工作流下的列表
    final edgeState = st.edges;
    final edges = edgeState.edgesByWorkflow[workflowId] ?? [];

    final idx = edges.indexWhere((e) => e.id == edgeId);
    if (idx < 0) {
      throw Exception('Edge not found: $edgeId');
    }

    _beforeEdge = edges[idx];
    _afterEdge = updateFn(_beforeEdge);

    // 构造新的边列表
    final updatedList = List<EdgeModel>.from(edges);
    updatedList[idx] = _afterEdge;

    // 更新 EditorState 中的 EdgeState
    final newEdgeState = edgeState.copyWith(
      edgesByWorkflow: {
        ...edgeState.edgesByWorkflow,
        workflowId: updatedList,
      },
    );
    ctx.updateState(st.copyWith(edges: newEdgeState));
  }

  @override
  Future<void> undo() async {
    final st = ctx.getState();
    final workflowId = st.activeWorkflowId;
    final edgeState = st.edges;
    final edges = edgeState.edgesByWorkflow[workflowId] ?? [];

    final idx = edges.indexWhere((e) => e.id == edgeId);
    if (idx < 0) {
      throw Exception('Edge not found during undo: $edgeId');
    }

    final restored = List<EdgeModel>.from(edges);
    restored[idx] = _beforeEdge;

    final newEdgeState = edgeState.copyWith(
      edgesByWorkflow: {
        ...edgeState.edgesByWorkflow,
        workflowId: restored,
      },
    );
    ctx.updateState(st.copyWith(edges: newEdgeState));
  }
}
