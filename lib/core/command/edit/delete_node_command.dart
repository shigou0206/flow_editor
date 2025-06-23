import 'package:flow_editor/core/command/i_command.dart';
import 'package:flow_editor/core/command/command_context.dart';
import 'package:flow_editor/core/models/ui/node_model.dart';

/// 从当前工作流中删除一个节点
class DeleteNodeCommand implements ICommand {
  final CommandContext ctx;
  final String nodeId;

  late NodeModel? _deletedNode;
  late int _deletedIndex;

  DeleteNodeCommand(this.ctx, this.nodeId);

  @override
  String get description => 'Delete node $nodeId';

  @override
  Future<void> execute() async {
    final st = ctx.getState();
    final current = st.nodeState.nodes;

    final idx = current.indexWhere((n) => n.id == nodeId);
    if (idx < 0) {
      _deletedNode = null;
      _deletedIndex = -1;
      return;
    }

    _deletedNode = current[idx];
    _deletedIndex = idx;

    final updated = List<NodeModel>.from(current)..removeAt(idx);
    final newState = st.nodeState.updateNodes(updated);

    ctx.updateState(st.copyWith(nodeState: newState));
  }

  @override
  Future<void> undo() async {
    if (_deletedNode == null || _deletedIndex < 0) return;

    final st = ctx.getState();
    final current = st.nodeState.nodes;

    final restored = List<NodeModel>.from(current)
      ..insert(_deletedIndex, _deletedNode!);

    final newState = st.nodeState.updateNodes(restored);
    ctx.updateState(st.copyWith(nodeState: newState));
  }
}
