import 'dart:ui';

import 'package:flow_editor/core/command/i_command.dart';
import 'package:flow_editor/core/command/command_context.dart';
import 'package:flow_editor/core/models/node_model.dart';

/// 在当前活跃工作流中将指定节点按照给定偏移量平移
class MoveNodeCommand implements ICommand {
  final CommandContext ctx;
  final String nodeId;
  final Offset delta;

  late NodeModel _before;
  late int _index;

  MoveNodeCommand(this.ctx, this.nodeId, this.delta);

  @override
  String get description => 'Move node $nodeId by $delta';

  @override
  Future<void> execute() async {
    final st = ctx.getState();
    final wf = st.activeWorkflowId;
    final all = st.nodes.nodesOf(wf);
    final idx = all.indexWhere((n) => n.id == nodeId);
    if (idx < 0) {
      throw Exception('Node not found: $nodeId');
    }
    _index = idx;
    _before = all[idx];
    // 构造新的 NodeModel，保持其它属性不变，只更新 position
    final moved = NodeModel(
      id: _before.id,
      position: _before.position + delta,
      size: _before.size,
      data: _before.data,
      style: _before.style,
    );
    final updated = List<NodeModel>.from(all)..[idx] = moved;
    final newNodes = st.nodes.updateWorkflowNodes(wf, updated);
    ctx.updateState(st.copyWith(nodes: newNodes));
  }

  @override
  Future<void> undo() async {
    final st = ctx.getState();
    final wf = st.activeWorkflowId;
    final all = st.nodes.nodesOf(wf);
    final restored = List<NodeModel>.from(all)..[_index] = _before;
    final newNodes = st.nodes.updateWorkflowNodes(wf, restored);
    ctx.updateState(st.copyWith(nodes: newNodes));
  }
}
