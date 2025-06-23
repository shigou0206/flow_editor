import 'package:flow_editor/core/command/i_command.dart';
import 'package:flow_editor/core/command/command_context.dart';
import 'package:flow_editor/core/models/ui/node_model.dart';
import 'package:flow_editor/core/models/ui/edge_model.dart';
import 'package:flow_editor/layout/layout_strategy.dart';
import 'package:flow_editor/layout/sugiyama_layout.dart';
import 'package:flutter/foundation.dart';

class LayoutCommand implements ICommand {
  final CommandContext ctx;
  final LayoutStrategy layoutStrategy;

  late List<NodeModel> _beforeNodes;
  late List<EdgeModel> _beforeEdges;

  LayoutCommand(
    this.ctx, {
    LayoutStrategy? layoutStrategy,
  }) : layoutStrategy = layoutStrategy ?? SugiyamaLayoutStrategy();

  @override
  String get description => 'Apply Sugiyama Layout';

  @override
  Future<void> execute() async {
    final st = ctx.getState();

    // ✅ 使用深拷贝保存布局前状态，用于undo
    _beforeNodes = st.nodeState.nodes.map((n) => n.copyWith()).toList();
    _beforeEdges = st.edgeState.edges.map((e) => e.copyWith()).toList();

    // 对当前节点和边执行布局
    final nodes = st.nodeState.nodes.map((n) => n.copyWith()).toList();
    final edges = st.edgeState.edges.map((e) => e.copyWith()).toList();

    layoutStrategy.performLayout(nodes, edges);
    for (final edge in edges) {
      debugPrint('✅ Edge ${edge.id} waypoints: ${edge.waypoints}');
    }

    // 更新布局后的节点和边
    ctx.updateState(
      st.copyWith(
        nodeState: st.nodeState.updateNodes(nodes),
        edgeState: st.edgeState.updateEdges(edges),
      ),
    );
  }

  @override
  Future<void> undo() async {
    final st = ctx.getState();

    // 恢复布局前的状态
    ctx.updateState(
      st.copyWith(
        nodeState: st.nodeState.updateNodes(_beforeNodes),
        edgeState: st.edgeState.updateEdges(_beforeEdges),
      ),
    );
  }
}
