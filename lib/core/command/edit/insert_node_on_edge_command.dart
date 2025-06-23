import 'package:flow_editor/core/command/i_command.dart';
import 'package:flow_editor/core/command/command_context.dart';
import 'package:flow_editor/core/models/ui/node_model.dart';
import 'package:flow_editor/core/models/ui/edge_model.dart';

/// 在一条边上插入一个节点，将原边拆分为两段
class InsertNodeOnEdgeCommand implements ICommand {
  final CommandContext ctx;
  final String edgeId;
  final NodeModel node;
  final String newEdge1Id;
  final String newEdge2Id;

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

    final oldEdges = st.edgeState.edges;
    final idx = oldEdges.indexWhere((e) => e.id == edgeId);
    if (idx < 0) throw Exception('Edge not found: $edgeId');

    _oldEdge = oldEdges[idx];
    _oldSource = _oldEdge.sourceNodeId!;
    _oldTarget = _oldEdge.targetNodeId!;

    // 构造新的边集合：删旧加两新
    final filteredEdges = [...oldEdges]..removeAt(idx);
    final new1 = EdgeModel(
        id: newEdge1Id, sourceNodeId: _oldSource, targetNodeId: node.id);
    final new2 = EdgeModel(
        id: newEdge2Id, sourceNodeId: node.id, targetNodeId: _oldTarget);
    final updatedEdges = [...filteredEdges, new1, new2];

    // 插入节点
    final newNodes = [...st.nodeState.nodes, node];

    ctx.updateState(
      st.copyWith(
        nodeState: st.nodeState.updateNodes(newNodes),
        edgeState: st.edgeState.updateEdges(updatedEdges),
      ),
    );
  }

  @override
  Future<void> undo() async {
    final st = ctx.getState();

    final restoredNodes = [...st.nodeState.nodes]
      ..removeWhere((n) => n.id == node.id);

    final restoredEdges = [...st.edgeState.edges]
      ..removeWhere((e) => e.id == newEdge1Id || e.id == newEdge2Id)
      ..add(_oldEdge);

    ctx.updateState(
      st.copyWith(
        nodeState: st.nodeState.updateNodes(restoredNodes),
        edgeState: st.edgeState.updateEdges(restoredEdges),
      ),
    );
  }
}
