import 'package:flow_editor/core/command/i_command.dart';
import 'package:flow_editor/core/command/command_context.dart';
import 'package:flow_editor/core/models/node_model.dart';
import 'package:flow_editor/core/models/edge_model.dart';

/// 在已有的 edgeId 边上插入一个新节点 node，
/// 并将原边分成两条：source->new、new->target
class InsertNodeOnEdgeCommand implements ICommand {
  final CommandContext ctx;
  final String edgeId;
  final NodeModel node;
  final String newEdge1Id;
  final String newEdge2Id;

  /// 临时保存：被拆的原边、原 source 和 target
  late EdgeModel _oldEdge;
  late String _oldSource;
  late String _oldTarget;

  InsertNodeOnEdgeCommand({
    required this.ctx,
    required this.edgeId,
    required this.node,
    required this.newEdge1Id,
    required this.newEdge2Id,
  });

  @override
  String get description => 'Insert node ${node.id} on edge $edgeId';

  @override
  Future<void> execute() async {
    final st = ctx.getState();
    final editor = st; // EditorState

    // 1. 找到原边
    final edges = editor.edges.edgesOf(editor.activeWorkflowId);
    final old = edges.firstWhere(
      (e) => e.id == edgeId,
      orElse: () => throw Exception('Edge not found: $edgeId'),
    );
    _oldEdge = old;
    _oldSource = old.sourceNodeId!;
    _oldTarget = old.targetNodeId!;

    // 2. 更新节点列表：追加新节点
    final updatedNodes = editor.nodes.updateWorkflowNodes(
      editor.activeWorkflowId,
      [...editor.nodes.nodesOf(editor.activeWorkflowId), node],
    );

    // 3. 更新边列表：移除旧边，添加两条新边
    final filtered = edges.where((e) => e.id != edgeId).toList();
    final new1 = EdgeModel(
      id: newEdge1Id,
      sourceNodeId: _oldSource,
      targetNodeId: node.id,
    );
    final new2 = EdgeModel(
      id: newEdge2Id,
      sourceNodeId: node.id,
      targetNodeId: _oldTarget,
    );
    final updatedEdges = [
      ...filtered,
      new1,
      new2,
    ];
    final updatedEdgeState =
        editor.edges.updateWorkflowEdges(editor.activeWorkflowId, updatedEdges);

    // 4. push new EditorState
    ctx.updateState(
      editor.copyWith(
        nodes: updatedNodes,
        edges: updatedEdgeState,
      ),
    );
  }

  @override
  Future<void> undo() async {
    final st = ctx.getState();
    final editor = st;

    // 回退到原先的节点集合
    final nodesList = editor.nodes.nodesOf(editor.activeWorkflowId)
      ..removeWhere((n) => n.id == node.id);
    final revertedNodes =
        editor.nodes.updateWorkflowNodes(editor.activeWorkflowId, nodesList);

    // 回退到原先的边集合
    final edgesList = editor.edges.edgesOf(editor.activeWorkflowId)
      ..removeWhere((e) => e.id == newEdge1Id || e.id == newEdge2Id)
      ..add(_oldEdge);
    final revertedEdges =
        editor.edges.updateWorkflowEdges(editor.activeWorkflowId, edgesList);

    ctx.updateState(
      editor.copyWith(
        nodes: revertedNodes,
        edges: revertedEdges,
      ),
    );
  }
}
