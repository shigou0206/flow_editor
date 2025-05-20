import 'package:flow_editor/core/command/i_command.dart';
import 'package:flow_editor/core/command/command_context.dart';
import 'package:flow_editor/core/models/node_model.dart';
import 'package:flow_editor/core/models/enums/node_enums.dart';

/// 修改单个节点的执行状态，并可选地同时更新 data 字段
class ChangeNodeStatusCommand implements ICommand {
  final CommandContext ctx;
  final String nodeId;
  final NodeStatus newStatus;
  final Map<String, dynamic>? newData;

  late final NodeStatus _oldStatus;
  late final Map<String, dynamic>? _oldData;

  ChangeNodeStatusCommand(
    this.ctx,
    this.nodeId,
    this.newStatus, {
    this.newData,
  });

  @override
  String get description =>
      'Change node $nodeId status to $newStatus${newData != null ? ' and update data' : ''}';

  @override
  Future<void> execute() async {
    final st = ctx.getState();
    final wf = st.activeWorkflowId;
    final nodeState = st.nodes;
    final nodes = nodeState.nodesOf(wf);
    final idx = nodes.indexWhere((n) => n.id == nodeId);
    if (idx < 0) throw Exception('Node not found: $nodeId');

    final oldNode = nodes[idx];
    _oldStatus = oldNode.status;
    _oldData = Map.of(oldNode.data);

    // 构造新的节点
    var updatedNode = oldNode.copyWith(status: newStatus);
    if (newData != null) {
      // 将新的 data 完全替换，或做 merge 也可
      updatedNode = updatedNode.copyWith(data: newData ?? {});
    }

    // 更新列表
    final newList = List<NodeModel>.from(nodes)..[idx] = updatedNode;
    final newNodeState = nodeState.updateWorkflowNodes(wf, newList);
    ctx.updateState(st.copyWith(nodes: newNodeState));
  }

  @override
  Future<void> undo() async {
    final st = ctx.getState();
    final wf = st.activeWorkflowId;
    final nodeState = st.nodes;
    final nodes = nodeState.nodesOf(wf);
    final idx = nodes.indexWhere((n) => n.id == nodeId);
    if (idx < 0) throw Exception('Node not found during undo: $nodeId');

    var restored = nodes[idx].copyWith(status: _oldStatus);
    if (_oldData != null) {
      restored = restored.copyWith(data: _oldData);
    }

    final newList = List<NodeModel>.from(nodes)..[idx] = restored;
    final newNodeState = nodeState.updateWorkflowNodes(wf, newList);
    ctx.updateState(st.copyWith(nodes: newNodeState));
  }
}
