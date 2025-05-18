// lib/core/command/edit/bring_to_front_command.dart

import 'package:flow_editor/core/command/i_command.dart';
import 'package:flow_editor/core/command/command_context.dart';
import 'package:flow_editor/core/models/node_model.dart';

/// 将指定节点移到最上层（列表末尾），以保证渲染在最前面
class BringToFrontCommand implements ICommand {
  final CommandContext ctx;
  final String nodeId;

  /// 执行前的节点列表
  late final List<NodeModel> _before;
  bool _recorded = false;

  BringToFrontCommand(this.ctx, this.nodeId);

  @override
  String get description => 'Bring node $nodeId to front';

  @override
  Future<void> execute() async {
    final st = ctx.getState();

    final workflowId = st.activeWorkflowId;
    final oldList = st.nodes.nodesOf(workflowId);

    // 仅第一次执行时记录原始顺序
    if (!_recorded) {
      _before = List.of(oldList);
      _recorded = true;
    }

    // 找到并移除目标节点
    final idx = oldList.indexWhere((n) => n.id == nodeId);
    if (idx < 0) {
      throw Exception('Node not found: $nodeId');
    }

    final node = oldList[idx];
    final newList = List<NodeModel>.from(oldList)
      ..removeAt(idx)
      ..add(node);

    // 更新 state
    final newNodesState = st.nodes.updateWorkflowNodes(workflowId, newList);
    ctx.updateState(st.copyWith(nodes: newNodesState));
  }

  @override
  Future<void> undo() async {
    final st = ctx.getState();
    final workflowId = st.activeWorkflowId;
    // 恢复执行前的顺序
    final newNodesState = st.nodes.updateWorkflowNodes(workflowId, _before);
    ctx.updateState(st.copyWith(nodes: newNodesState));
  }
}
