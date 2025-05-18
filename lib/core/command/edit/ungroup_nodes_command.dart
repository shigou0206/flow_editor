import 'package:flow_editor/core/command/i_command.dart';
import 'package:flow_editor/core/command/command_context.dart';
import 'package:flow_editor/core/models/state/selection_state.dart';
import 'package:flow_editor/core/models/node_model.dart';

/// 取消对某个分组节点（group root）的分组操作
class UngroupNodesCommand implements ICommand {
  final CommandContext ctx;

  /// 要取消分组的分组根节点 ID
  final String groupId;

  late List<NodeModel> _beforeNodes;
  late SelectionState _beforeSelection;

  UngroupNodesCommand(this.ctx, this.groupId);

  @override
  String get description => 'Ungroup nodes under $groupId';

  @override
  Future<void> execute() async {
    // 保存执行前的节点列表和选区
    final st = ctx.getState();
    _beforeNodes = st.nodes.nodesByWorkflow[st.activeWorkflowId]!;
    _beforeSelection = st.selection;

    // 找出要取消分组的子节点
    final children = _beforeNodes
        .where((n) => n.parentId == groupId)
        .toList(growable: false);

    // 移除分组根节点，清空子节点 parentId
    final updatedNodes = _beforeNodes.where((n) => n.id != groupId).map((n) {
      if (children.any((c) => c.id == n.id)) {
        return n.copyWith(parentId: null);
      }
      return n;
    }).toList(growable: false);

    // 更新状态和选区：选区变成原来所有子节点
    final newSelection = st.selection.copyWith(
      nodeIds: children.map((c) => c.id).toSet(),
    );

    // 生成新的 EditorState
    ctx.updateState(
      st.copyWith(
        nodes: st.nodes.copyWith(
          nodesByWorkflow: {
            ...st.nodes.nodesByWorkflow,
            st.activeWorkflowId: updatedNodes,
          },
        ),
        selection: newSelection,
      ),
    );
  }

  @override
  Future<void> undo() async {
    final st = ctx.getState();
    // 恢复原先的节点列表和选区
    ctx.updateState(
      st.copyWith(
        nodes: st.nodes.copyWith(
          nodesByWorkflow: {
            ...st.nodes.nodesByWorkflow,
            st.activeWorkflowId: _beforeNodes,
          },
        ),
        selection: _beforeSelection,
      ),
    );
  }
}
