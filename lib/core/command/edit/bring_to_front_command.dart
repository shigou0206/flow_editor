import 'package:flow_editor/core/command/i_command.dart';
import 'package:flow_editor/core/command/command_context.dart';
import 'package:flow_editor/core/models/node_model.dart';

/// 将指定节点移到最上层（列表末尾），以保证渲染在最前面
class BringToFrontCommand implements ICommand {
  final CommandContext ctx;
  final String nodeId;

  late final List<NodeModel> _before;
  bool _recorded = false;

  BringToFrontCommand(this.ctx, this.nodeId);

  @override
  String get description => 'Bring node $nodeId to front';

  @override
  Future<void> execute() async {
    final st = ctx.getState();
    final oldList = st.nodeState.nodes;

    if (!_recorded) {
      _before = List.of(oldList);
      _recorded = true;
    }

    final idx = oldList.indexWhere((n) => n.id == nodeId);
    if (idx < 0) throw Exception('Node not found: $nodeId');

    final node = oldList[idx];
    final newList = List<NodeModel>.from(oldList)
      ..removeAt(idx)
      ..add(node);

    final updated = st.nodeState.updateNodes(newList);
    ctx.updateState(st.copyWith(nodeState: updated));
  }

  @override
  Future<void> undo() async {
    if (!_recorded) return;
    final st = ctx.getState();
    ctx.updateState(st.copyWith(
      nodeState: st.nodeState.updateNodes(_before),
    ));
  }
}
