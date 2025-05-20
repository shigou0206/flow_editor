// lib/core/command/edit/group_nodes_command.dart

import 'dart:ui';
import 'package:flow_editor/core/command/i_command.dart';
import 'package:flow_editor/core/command/command_context.dart';
import 'package:flow_editor/core/models/node_model.dart';
import 'package:flow_editor/core/models/state/selection_state.dart';

class GroupNodesCommand implements ICommand {
  final CommandContext ctx;
  final List<String> nodeIds;

  // 将 groupId 提前计算并保存，redo 时也能复用
  final String _groupId;

  // 执行前的原始节点列表
  List<NodeModel>? _originalNodes;
  // 执行前的原始选区
  Set<String>? _originalSelection;

  GroupNodesCommand(this.ctx, this.nodeIds)
      : _groupId = '${nodeIds.join('_')}_group';

  @override
  String get description => 'Group nodes ${nodeIds.join(",")}';

  @override
  Future<void> execute() async {
    final st = ctx.getState();

    // 只在第一次执行时保存原始状态
    _originalNodes ??=
        List.from(st.nodes.nodesByWorkflow[st.activeWorkflowId]!);
    _originalSelection ??= st.selection.nodeIds;

    // 找到成员节点
    final members =
        _originalNodes!.where((n) => nodeIds.contains(n.id)).toList();

    // 计算包围盒
    final minX =
        members.map((n) => n.position.dx).reduce((a, b) => a < b ? a : b);
    final minY =
        members.map((n) => n.position.dy).reduce((a, b) => a < b ? a : b);
    final maxX = members
        .map((n) => n.position.dx + n.size.width)
        .reduce((a, b) => a > b ? a : b);
    final maxY = members
        .map((n) => n.position.dy + n.size.height)
        .reduce((a, b) => a > b ? a : b);

    // 创建组节点
    final groupNode = NodeModel(
      id: _groupId,
      position: Offset(minX, minY),
      size: Size(maxX - minX, maxY - minY),
      isGroup: true,
      isGroupRoot: true,
    );

    // 更新成员 parentId
    final updatedMembers = _originalNodes!.map((n) {
      if (nodeIds.contains(n.id)) {
        return n.copyWith(parentId: _groupId);
      }
      return n;
    }).toList();

    // 把组节点插入到成员前面
    final insertIndex =
        updatedMembers.indexWhere((n) => nodeIds.contains(n.id));
    updatedMembers.insert(insertIndex < 0 ? 0 : insertIndex, groupNode);

    // 更新选区
    final newSelection = SelectionState(nodeIds: {_groupId});

    // 合成新的 EditorState
    ctx.updateState(
      st.copyWith(
        nodes: st.nodes.copyWith(
          nodesByWorkflow: {
            st.activeWorkflowId: updatedMembers,
          },
        ),
        selection: newSelection,
      ),
    );
  }

  @override
  Future<void> undo() async {
    final st = ctx.getState();
    // 恢复原始节点和选区
    ctx.updateState(
      st.copyWith(
        nodes: st.nodes.copyWith(
          nodesByWorkflow: {
            st.activeWorkflowId: _originalNodes!,
          },
        ),
        selection: SelectionState(nodeIds: _originalSelection!),
      ),
    );
  }
}
