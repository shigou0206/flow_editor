import 'package:flow_editor/core/command/i_command.dart';
import 'package:flow_editor/core/command/command_context.dart';
import 'package:flow_editor/core/models/ui/node_model.dart';
import 'package:flow_editor/core/models/ui/edge_model.dart';

/// 将当前选中的节点与边复制到剪贴板（临时状态中）
class CopySelectionCommand implements ICommand {
  final CommandContext ctx;

  // 存储复制的节点与边
  late List<NodeModel> copiedNodes;
  late List<EdgeModel> copiedEdges;

  CopySelectionCommand(this.ctx);

  @override
  String get description => 'Copy selection';

  @override
  Future<void> execute() async {
    final st = ctx.getState();

    final selectedNodeIds = st.selection.nodeIds;
    final selectedEdgeIds = st.selection.edgeIds;

    // 获取选中的节点与边
    copiedNodes = st.nodeState.nodes
        .where((node) => selectedNodeIds.contains(node.id))
        .map((node) => node.copyWith())
        .toList();

    copiedEdges = st.edgeState.edges
        .where((edge) => selectedEdgeIds.contains(edge.id))
        .map((edge) => edge.copyWith())
        .toList();

    // 更新剪贴板临时状态
    ctx.updateState(st.copyWith(
      clipboard: st.clipboard.copyWith(
        nodes: copiedNodes,
        edges: copiedEdges,
      ),
    ));
  }

  @override
  Future<void> undo() async {
    // 复制到剪贴板是临时状态，不需要撤销操作
    // 可以置空剪贴板或者保持不变
  }
}
