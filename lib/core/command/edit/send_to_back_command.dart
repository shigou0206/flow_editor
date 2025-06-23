import 'package:flow_editor/core/command/i_command.dart';
import 'package:flow_editor/core/command/command_context.dart';
import 'package:flow_editor/core/models/ui/node_model.dart';

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
    final oldList = st.nodeState.nodes;

    final idx = oldList.indexWhere((n) => n.id == nodeId);
    if (idx < 0) throw Exception('Node not found: $nodeId');

    _beforeIndex = idx;

    final moved = List<NodeModel>.from(oldList);
    final node = moved.removeAt(idx);
    moved.insert(0, node);

    final updatedState = st.nodeState.updateNodes(moved);
    ctx.updateState(st.copyWith(nodeState: updatedState));
  }

  @override
  Future<void> undo() async {
    final st = ctx.getState();
    final list = List<NodeModel>.from(st.nodeState.nodes);

    final node = list.removeAt(0);
    list.insert(_beforeIndex, node);

    final updatedState = st.nodeState.updateNodes(list);
    ctx.updateState(st.copyWith(nodeState: updatedState));
  }
}
