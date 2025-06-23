import 'dart:ui';
import 'package:flow_editor/core/command/i_command.dart';
import 'package:flow_editor/core/command/command_context.dart';
import 'package:flow_editor/core/models/ui/node_model.dart';
import 'package:flow_editor/core/models/ui_state/selection_state.dart';

class GroupNodesCommand implements ICommand {
  final CommandContext ctx;
  final List<String> nodeIds;
  final String _groupId;

  List<NodeModel>? _originalNodes;
  Set<String>? _originalSelection;

  GroupNodesCommand(this.ctx, this.nodeIds)
      : _groupId = '${nodeIds.join('_')}_group';

  @override
  String get description => 'Group nodes ${nodeIds.join(",")}';

  @override
  Future<void> execute() async {
    final st = ctx.getState();

    _originalNodes ??= List.of(st.nodeState.nodes);
    _originalSelection ??= st.selection.nodeIds;

    final members =
        _originalNodes!.where((n) => nodeIds.contains(n.id)).toList();

    if (members.isEmpty) return;

    final minX =
        members.map((n) => n.position.dx).reduce((a, b) => a < b ? a : b);
    final minY =
        members.map((n) => n.position.dy).reduce((a, b) => a < b ? a : b);
    final maxX = members
        .map((n) => n.position.dx + n.size.width)
        .reduce((a, b) => a > b ? a : b);
    final maxY = members
        .map((n) => n.position.dy + n.size.height)
        .reduce((a, b) => a > b ? a : b);

    final groupNode = NodeModel(
      id: _groupId,
      type: 'group',
      position: Offset(minX, minY),
      size: Size(maxX - minX, maxY - minY),
      isGroup: true,
      isGroupRoot: true,
    );

    final updated = _originalNodes!.map((n) {
      if (nodeIds.contains(n.id)) {
        return n.copyWith(parentId: _groupId);
      }
      return n;
    }).toList();

    final insertIndex = updated.indexWhere((n) => nodeIds.contains(n.id));
    updated.insert(insertIndex < 0 ? 0 : insertIndex, groupNode);

    final newSelection = SelectionState(nodeIds: {_groupId});

    ctx.updateState(st.copyWith(
      nodeState: st.nodeState.updateNodes(updated),
      selection: newSelection,
    ));
  }

  @override
  Future<void> undo() async {
    if (_originalNodes == null || _originalSelection == null) return;

    final st = ctx.getState();
    ctx.updateState(st.copyWith(
      nodeState: st.nodeState.updateNodes(_originalNodes!),
      selection: SelectionState(nodeIds: _originalSelection!),
    ));
  }
}
