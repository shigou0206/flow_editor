import 'package:flow_editor/core/command/i_command.dart';
import 'package:flow_editor/core/command/command_context.dart';
import 'package:flow_editor/core/models/node_model.dart';

/// 向当前活跃 workflow 中添加一个节点
class AddNodeCommand implements ICommand {
  final CommandContext ctx;
  final NodeModel node;

  /// 构造时就捕获当前活跃的 workflowId，防止执行/撤销时发生切换
  final String _workflowId;

  AddNodeCommand(this.ctx, this.node)
      : _workflowId = ctx.getState().activeWorkflowId;

  @override
  String get description => 'Add node ${node.id} to $_workflowId';

  @override
  Future<void> execute() async {
    final st = ctx.getState();
    // 取当前 workflow 下的旧列表
    final oldList = st.nodes.nodesByWorkflow[_workflowId] ?? [];
    // 构造新列表
    final newList = [...oldList, node];
    // 新的 NodeState
    final newNodeState = st.nodes.copyWith(
      nodesByWorkflow: {
        ...st.nodes.nodesByWorkflow,
        _workflowId: newList,
      },
    );
    // 更新全局 EditorState
    ctx.updateState(st.copyWith(nodes: newNodeState));
  }

  @override
  Future<void> undo() async {
    final st = ctx.getState();
    final oldList = st.nodes.nodesByWorkflow[_workflowId] ?? [];
    final newList = oldList.where((n) => n.id != node.id).toList();
    final newNodeState = st.nodes.copyWith(
      nodesByWorkflow: {
        ...st.nodes.nodesByWorkflow,
        _workflowId: newList,
      },
    );
    ctx.updateState(st.copyWith(nodes: newNodeState));
  }
}
