// lib/core/command/edit/delete_node_command.dart

import 'package:flow_editor/core/command/i_command.dart';
import 'package:flow_editor/core/command/command_context.dart';
import 'package:flow_editor/core/models/node_model.dart';

/// 从当前 workflow 中删除一个节点
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
    final st = ctx.getState(); // EditorState
    final wf = st.activeWorkflowId;
    final current = st.nodes.nodesOf(wf);
    final idx = current.indexWhere((n) => n.id == nodeId);
    if (idx < 0) {
      // 节点不存在：标记无修改，但仍进历史，以便 undo/redo 行为一致
      _deletedNode = null;
      _deletedIndex = -1;
      return;
    }
    _deletedNode = current[idx];
    _deletedIndex = idx;
    final updated = List<NodeModel>.from(current)..removeAt(idx);

    final newNodeState = st.nodes.updateWorkflowNodes(wf, updated);
    ctx.updateState(st.copyWith(nodes: newNodeState));
  }

  @override
  Future<void> undo() async {
    if (_deletedNode == null || _deletedIndex < 0) {
      // nothing to undo
      return;
    }
    final st = ctx.getState();
    final wf = st.activeWorkflowId;
    final current = st.nodes.nodesOf(wf);
    final restored = List<NodeModel>.from(current)
      ..insert(_deletedIndex, _deletedNode!);

    final newNodeState = st.nodes.updateWorkflowNodes(wf, restored);
    ctx.updateState(st.copyWith(nodes: newNodeState));
  }
}
