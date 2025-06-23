import 'dart:ui';

import 'package:flow_editor/core/command/i_command.dart';
import 'package:flow_editor/core/command/command_context.dart';
import 'package:flow_editor/core/models/ui/node_model.dart';

import 'package:uuid/uuid.dart';

/// 复制节点并生成一个新的节点（ID不同）
class DuplicateNodeCommand implements ICommand {
  final CommandContext ctx;
  final String originalNodeId;
  late NodeModel duplicatedNode;

  DuplicateNodeCommand(this.ctx, this.originalNodeId);

  @override
  String get description => 'Duplicate node $originalNodeId';

  @override
  Future<void> execute() async {
    final st = ctx.getState();
    final nodes = st.nodeState.nodes;

    final originalNode = nodes.firstWhere((n) => n.id == originalNodeId);

    // 生成新节点
    duplicatedNode = originalNode.copyWith(
      id: const Uuid().v4(),
      position: originalNode.position + const Offset(20, 20),
    );

    final updatedNodes = [...nodes, duplicatedNode];
    final updatedNodeState = st.nodeState.updateNodes(updatedNodes);

    ctx.updateState(st.copyWith(nodeState: updatedNodeState));
  }

  @override
  Future<void> undo() async {
    final st = ctx.getState();
    final nodes = st.nodeState.nodes;

    final updatedNodes = nodes.where((n) => n.id != duplicatedNode.id).toList();

    final updatedNodeState = st.nodeState.updateNodes(updatedNodes);

    ctx.updateState(st.copyWith(nodeState: updatedNodeState));
  }
}
