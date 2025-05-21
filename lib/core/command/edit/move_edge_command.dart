import 'dart:ui';

import 'package:flow_editor/core/command/i_command.dart';
import 'package:flow_editor/core/command/command_context.dart';
import 'package:flow_editor/core/models/edge_model.dart';

/// 将指定边的所有控制点（waypoints）平移一个偏移量
class MoveEdgeCommand implements ICommand {
  final CommandContext ctx;
  final String edgeId;
  final Offset delta;

  List<Offset>? _before;

  MoveEdgeCommand(this.ctx, this.edgeId, this.delta);

  @override
  String get description => 'Move edge $edgeId by $delta';

  @override
  Future<void> execute() async {
    final st = ctx.getState();
    final edges = st.edgeState.edges;

    final index = edges.indexWhere((e) => e.id == edgeId);
    if (index < 0) throw Exception('Edge not found: $edgeId');

    final edge = edges[index];
    _before = List.of(edge.waypoints ?? []);

    final moved = edge.copyWith(
      waypoints: edge.waypoints?.map((pt) => pt + delta).toList(),
    );

    final updatedEdges = List<EdgeModel>.from(edges)..[index] = moved;
    final newState = st.edgeState.updateEdges(updatedEdges);

    ctx.updateState(st.copyWith(edgeState: newState));
  }

  @override
  Future<void> undo() async {
    if (_before == null) return;

    final st = ctx.getState();
    final edges = st.edgeState.edges;

    final index = edges.indexWhere((e) => e.id == edgeId);
    if (index < 0) throw Exception('Edge not found during undo: $edgeId');

    final restored = edges[index].copyWith(waypoints: _before);
    final updatedEdges = List<EdgeModel>.from(edges)..[index] = restored;
    final newState = st.edgeState.updateEdges(updatedEdges);

    ctx.updateState(st.copyWith(edgeState: newState));
  }
}
