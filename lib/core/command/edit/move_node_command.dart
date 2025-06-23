import 'dart:ui';

import 'package:flow_editor/core/command/i_command.dart';
import 'package:flow_editor/core/command/command_context.dart';
import 'package:flow_editor/core/models/ui/node_model.dart';

/// 将指定节点平移一个 offset
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
    final nodes = st.nodeState.nodes;

    final idx = nodes.indexWhere((n) => n.id == nodeId);
    if (idx < 0) throw Exception('Node not found: $nodeId');

    _index = idx;
    _before = nodes[idx];

    final moved = _before.copyWith(position: _before.position + delta);
    final updated = List<NodeModel>.from(nodes)..[idx] = moved;
    ctx.updateState(st.copyWith(
      nodeState: st.nodeState.updateNodes(updated),
    ));
  }

  @override
  Future<void> undo() async {
    final st = ctx.getState();
    final nodes = List<NodeModel>.from(st.nodeState.nodes)..[_index] = _before;
    ctx.updateState(st.copyWith(
      nodeState: st.nodeState.updateNodes(nodes),
    ));
  }
}
