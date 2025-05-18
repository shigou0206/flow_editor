import 'package:flow_editor/core/command/i_command.dart';
import 'package:flow_editor/core/command/command_context.dart';
import 'package:flow_editor/core/models/node_model.dart';

/// 将指定节点移到最底层（列表开头）
class SendToBackCommand implements ICommand {
  final CommandContext ctx;
  final String nodeId;
  late int _beforeIndex;

  SendToBackCommand(this.ctx, this.nodeId);

  @override
  String get description => 'Send node $nodeId to back';

  @override
  Future<void> execute() async {
    final st = ctx.getState();
    final wfId = st.activeWorkflowId;
    final oldList = st.nodes.nodesOf(wfId);
    final idx = oldList.indexWhere((n) => n.id == nodeId);
    if (idx < 0) {
      throw Exception('Node not found: $nodeId');
    }
    _beforeIndex = idx;

    final moved = List<NodeModel>.from(oldList);
    final node = moved.removeAt(idx);
    moved.insert(0, node);

    final newNodeState = st.nodes.updateWorkflowNodes(wfId, moved);
    ctx.updateState(st.copyWith(nodes: newNodeState));
  }

  @override
  Future<void> undo() async {
    final st = ctx.getState();
    final wfId = st.activeWorkflowId;
    final curr = st.nodes.nodesOf(wfId);
    // curr[0] 应为 nodeId
    final moved = List<NodeModel>.from(curr);
    final node = moved.removeAt(0);
    moved.insert(_beforeIndex, node);

    final newNodeState = st.nodes.updateWorkflowNodes(wfId, moved);
    ctx.updateState(st.copyWith(nodes: newNodeState));
  }
}
