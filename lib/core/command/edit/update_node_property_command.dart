import 'package:flow_editor/core/command/i_command.dart';
import 'package:flow_editor/core/command/command_context.dart';
import 'package:flow_editor/core/models/node_model.dart';

/// 通用的节点属性修改命令（支持 undo/redo）
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
    final nodes = st.nodeState.nodes;

    final idx = nodes.indexWhere((n) => n.id == nodeId);
    if (idx < 0) throw Exception('Node not found: $nodeId');

    if (!_hasExecuted) {
      _beforeNode = nodes[idx];
      _afterNode = updateFn(_beforeNode);
      _hasExecuted = true;
    }

    final updated = List<NodeModel>.from(nodes)..[idx] = _afterNode;
    ctx.updateState(st.copyWith(
      nodeState: st.nodeState.updateNodes(updated),
    ));
  }

  @override
  Future<void> undo() async {
    final st = ctx.getState();
    final nodes = st.nodeState.nodes;

    final idx = nodes.indexWhere((n) => n.id == nodeId);
    if (idx < 0) throw Exception('Node not found in undo: $nodeId');

    final restored = List<NodeModel>.from(nodes)..[idx] = _beforeNode;
    ctx.updateState(st.copyWith(
      nodeState: st.nodeState.updateNodes(restored),
    ));
  }
}
