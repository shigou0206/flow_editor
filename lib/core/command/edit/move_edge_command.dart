import 'dart:ui';

import 'package:flow_editor/core/command/i_command.dart';
import 'package:flow_editor/core/command/command_context.dart';
import 'package:flow_editor/core/models/edge_model.dart';

/// 将指定边沿所有控制点平移一个偏移量
class MoveEdgeCommand implements ICommand {
  final CommandContext ctx;
  final String edgeId;
  final Offset delta;

  /// 原始点列表（用于 undo）
  List<Offset>? _before;

  MoveEdgeCommand(this.ctx, this.edgeId, this.delta);

  @override
  String get description => 'Move edge $edgeId by $delta';

  @override
  Future<void> execute() async {
    final st = ctx.getState();
    final wf = st.activeWorkflowId;
    final oldEdges = st.edges.edgesOf(wf);
    final index = oldEdges.indexWhere((e) => e.id == edgeId);
    if (index < 0) {
      throw Exception('Edge not found: $edgeId');
    }
    final edge = oldEdges[index];
    _before = List.of(edge.waypoints ?? []);

    final moved = edge.copyWith(
      waypoints: edge.waypoints?.map((pt) => pt + delta).toList(),
    );
    final newEdges = List<EdgeModel>.from(oldEdges)..[index] = moved;
    final newEdgeState = st.edges.updateWorkflowEdges(wf, newEdges);
    ctx.updateState(st.copyWith(edges: newEdgeState));
  }

  @override
  Future<void> undo() async {
    final st = ctx.getState();
    final wf = st.activeWorkflowId;
    final oldEdges = st.edges.edgesOf(wf);
    final index = oldEdges.indexWhere((e) => e.id == edgeId);
    if (index < 0) {
      throw Exception('Edge not found during undo: $edgeId');
    }
    final restored = oldEdges[index].copyWith(waypoints: _before);
    final newEdges = List<EdgeModel>.from(oldEdges)..[index] = restored;
    final newEdgeState = st.edges.updateWorkflowEdges(wf, newEdges);
    ctx.updateState(st.copyWith(edges: newEdgeState));
  }
}
