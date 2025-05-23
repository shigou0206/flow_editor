import 'package:flow_editor/core/command/i_command.dart';
import 'package:flow_editor/core/command/command_context.dart';
import 'package:flow_editor/core/models/node_model.dart';
import 'package:flow_editor/core/models/edge_model.dart';
import 'package:uuid/uuid.dart';
import 'dart:ui';

/// 从剪贴板粘贴节点和边到画布
class PasteClipboardCommand implements ICommand {
  final CommandContext ctx;

  // 粘贴过程中生成的新节点和边
  late List<NodeModel> pastedNodes;
  late List<EdgeModel> pastedEdges;

  PasteClipboardCommand(this.ctx);

  @override
  String get description => 'Paste clipboard';

  @override
  Future<void> execute() async {
    final st = ctx.getState();
    final clipboard = st.clipboard;

    if (clipboard.nodes.isEmpty) return;

    final existingNodes = st.nodeState.nodes;
    final existingEdges = st.edgeState.edges;

    final nodeIdMap = <String, String>{}; // oldId -> newId
    const uuid = Uuid();

    // 生成新的节点（赋予新ID，位置轻微偏移）
    pastedNodes = clipboard.nodes.map((node) {
      final newId = uuid.v4();
      nodeIdMap[node.id] = newId;
      return node.copyWith(
        id: newId,
        position: node.position + const Offset(30, 30),
      );
    }).toList();

    // 生成对应的新边（使用新的节点ID）
    pastedEdges = clipboard.edges
        .map((edge) => edge.copyWith(
              id: uuid.v4(),
              sourceNodeId: nodeIdMap[edge.sourceNodeId] ?? edge.sourceNodeId,
              targetNodeId: nodeIdMap[edge.targetNodeId] ?? edge.targetNodeId,
            ))
        .toList();

    // 更新节点和边状态
    final updatedNodeState =
        st.nodeState.updateNodes([...existingNodes, ...pastedNodes]);
    final updatedEdgeState =
        st.edgeState.updateEdges([...existingEdges, ...pastedEdges]);

    ctx.updateState(st.copyWith(
      nodeState: updatedNodeState,
      edgeState: updatedEdgeState,
    ));
  }

  @override
  Future<void> undo() async {
    final st = ctx.getState();
    final existingNodes = st.nodeState.nodes;
    final existingEdges = st.edgeState.edges;

    // 移除之前粘贴的节点和边
    final remainingNodes = existingNodes
        .where((n) => !pastedNodes.any((pn) => pn.id == n.id))
        .toList();
    final remainingEdges = existingEdges
        .where((e) => !pastedEdges.any((pe) => pe.id == e.id))
        .toList();

    final updatedNodeState = st.nodeState.updateNodes(remainingNodes);
    final updatedEdgeState = st.edgeState.updateEdges(remainingEdges);

    ctx.updateState(st.copyWith(
      nodeState: updatedNodeState,
      edgeState: updatedEdgeState,
    ));
  }
}
