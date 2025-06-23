import 'package:flow_editor/core/command/i_command.dart';
import 'package:flow_editor/core/command/command_context.dart';
import 'package:flow_editor/core/models/ui_state/selection_state.dart';
import 'package:flow_editor/core/models/ui/node_model.dart';

/// 取消对某个分组节点（group root）的分组操作
class UngroupNodesCommand implements ICommand {
  final CommandContext ctx;
  final String groupId;

  late List<NodeModel> _beforeNodes;
  late SelectionState _beforeSelection;

  UngroupNodesCommand(this.ctx, this.groupId);

  @override
  String get description => 'Ungroup nodes under $groupId';

  @override
  Future<void> execute() async {
    final st = ctx.getState();
    _beforeNodes = List.of(st.nodeState.nodes);
    _beforeSelection = st.selection;

    // 找出要取消分组的子节点
    final children = _beforeNodes.where((n) => n.parentId == groupId).toList();

    // 移除 group 节点，清空子节点的 parentId
    final updated = _beforeNodes
        .where((n) => n.id != groupId)
        .map((n) => nodeIdIn(children, n.id) ? n.copyWith(parentId: null) : n)
        .toList();

    final newSelection = SelectionState(
      nodeIds: children.map((c) => c.id).toSet(),
    );

    ctx.updateState(
      st.copyWith(
        nodeState: st.nodeState.updateNodes(updated),
        selection: newSelection,
      ),
    );
  }

  @override
  Future<void> undo() async {
    final st = ctx.getState();
    ctx.updateState(
      st.copyWith(
        nodeState: st.nodeState.updateNodes(_beforeNodes),
        selection: _beforeSelection,
      ),
    );
  }

  bool nodeIdIn(List<NodeModel> nodes, String id) {
    return nodes.any((n) => n.id == id);
  }
}
