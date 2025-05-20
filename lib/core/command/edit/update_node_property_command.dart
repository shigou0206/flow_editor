import 'package:flow_editor/core/command/i_command.dart';
import 'package:flow_editor/core/command/command_context.dart';
import 'package:flow_editor/core/models/node_model.dart';

/// 通用的“更新节点属性”命令：
/// 通过传入一个 updateFn（NodeModel -> NodeModel）来修改指定节点，
/// 并保存修改前后的快照以支持 undo/redo。
class UpdateNodePropertyCommand implements ICommand {
  final CommandContext ctx;
  final String nodeId;
  final NodeModel Function(NodeModel) updateFn;

  late final NodeModel _beforeNode;
  late final NodeModel _afterNode;
  bool _hasExecuted = false;

  UpdateNodePropertyCommand(this.ctx, this.nodeId, this.updateFn);

  @override
  String get description => 'Update property of node $nodeId';

  @override
  Future<void> execute() async {
    final st = ctx.getState();
    final workflowId = st.activeWorkflowId;
    final nodeState = st.nodes;
    final nodes = nodeState.nodesByWorkflow[workflowId] ?? [];

    final idx = nodes.indexWhere((n) => n.id == nodeId);
    if (idx < 0) {
      throw Exception('Node not found: $nodeId');
    }

    if (!_hasExecuted) {
      // 第一次执行：拍 before，计算 after
      _beforeNode = nodes[idx];
      _afterNode = updateFn(_beforeNode);
      _hasExecuted = true;
    }

    // 构造新的节点列表：每次都应用 afterNode
    final updatedList = List<NodeModel>.from(nodes);
    updatedList[idx] = _afterNode;

    // 更新 EditorState
    final newNodeState = nodeState.copyWith(
      nodesByWorkflow: {
        ...nodeState.nodesByWorkflow,
        workflowId: updatedList,
      },
    );
    ctx.updateState(st.copyWith(nodes: newNodeState));
  }

  @override
  Future<void> undo() async {
    final st = ctx.getState();
    final workflowId = st.activeWorkflowId;
    final nodeState = st.nodes;
    final nodes = nodeState.nodesByWorkflow[workflowId] ?? [];

    final idx = nodes.indexWhere((n) => n.id == nodeId);
    if (idx < 0) {
      throw Exception('Node not found in undo: $nodeId');
    }

    // 构造新的节点列表：把 beforeNode 放回去
    final restored = List<NodeModel>.from(nodes);
    restored[idx] = _beforeNode;

    final newNodeState = nodeState.copyWith(
      nodesByWorkflow: {
        ...nodeState.nodesByWorkflow,
        workflowId: restored,
      },
    );
    ctx.updateState(st.copyWith(nodes: newNodeState));
  }
}
