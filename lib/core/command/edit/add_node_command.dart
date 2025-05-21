import 'package:flow_editor/core/command/i_command.dart';
import 'package:flow_editor/core/command/command_context.dart';
import 'package:flow_editor/core/models/node_model.dart';

/// 向当前 workflow 添加一个节点
class AddNodeCommand implements ICommand {
  final CommandContext ctx;
  final NodeModel node;

  AddNodeCommand(this.ctx, this.node);

  @override
  String get description => 'Add node ${node.id}';

  @override
  Future<void> execute() async {
    final st = ctx.getState();
    final current = st.nodeState.nodes;

    final updatedList = [...current, node];
    final updatedNodeState = st.nodeState.updateNodes(updatedList);

    ctx.updateState(st.copyWith(nodeState: updatedNodeState));
  }

  @override
  Future<void> undo() async {
    final st = ctx.getState();
    final current = st.nodeState.nodes;

    final updatedList = current.where((n) => n.id != node.id).toList();
    final updatedNodeState = st.nodeState.updateNodes(updatedList);

    ctx.updateState(st.copyWith(nodeState: updatedNodeState));
  }
}
