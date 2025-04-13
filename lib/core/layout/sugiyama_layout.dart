import 'package:flutter/widgets.dart';
import 'package:flow_editor/core/edge/models/edge_model.dart';
import 'package:flow_editor/core/node/models/node_model.dart';
import 'package:flow_editor/core/layout/layout_strategy.dart';
import 'package:flow_editor/core/canvas/utils.dart';
import 'package:flow_layout/graph/graph.dart';
import 'package:flow_layout/layout.dart';
import 'package:collection/collection.dart';

class SugiyamaLayoutStrategy implements LayoutStrategy {
  @override
  void performLayout(
    List<NodeModel> nodes,
    List<EdgeModel> edges,
  ) {
    void layoutGroup(String? parentId) {
      for (final group
          in nodes.where((n) => n.parentId == parentId && n.isGroup)) {
        layoutGroup(group.id);
        _performGraphLayoutForGroup(group, nodes, edges);
      }
    }

    layoutGroup(null);

    for (final node in nodes) {
      node.position = node.absolutePosition(nodes);
    }

    for (final edge in edges) {
      if (edge.waypoints != null) {
        final absPoints = mapEdgeWaypointsToAbsolute(edge, nodes);
        edge.waypoints = absPoints.map((p) => [p.dx, p.dy]).toList();
      }
    }
  }

  void _performGraphLayoutForGroup(
      NodeModel group, List<NodeModel> nodes, List<EdgeModel> edges) {
    final children = nodes.where((n) => n.parentId == group.id).toList();
    if (children.isEmpty) return;

    final groupEdges = edges.where((edge) {
      final src =
          nodes.firstWhereOrNull((node) => node.id == edge.sourceNodeId);
      final tgt =
          nodes.firstWhereOrNull((node) => node.id == edge.targetNodeId);
      return src != null &&
          tgt != null &&
          src.parentId == group.id &&
          tgt.parentId == group.id;
    }).toList();

    final graph = Graph();
    // 添加子节点到 graph，局部坐标视为左上角坐标
    for (final node in children) {
      graph.setNode(node.id, {
        'width': node.size.width,
        'height': node.size.height,
        'x': node.position.dx,
        'y': node.position.dy,
      });
    }
    // 可选：添加顺序边到 graph 中
    for (final edge in edges) {
      final src = nodes.firstWhereOrNull((n) => n.id == edge.sourceNodeId);
      final tgt = nodes.firstWhereOrNull((n) => n.id == edge.targetNodeId);
      if (src != null &&
          tgt != null &&
          src.parentId == group.id &&
          tgt.parentId == group.id) {
        graph.setEdge(edge.sourceNodeId, edge.targetNodeId, {'id': edge.id});
      }
    }
    graph.setGraph({
      'rankdir': 'TB',
      'marginx': 20,
      'marginy': 20,
      'ranker': 'network-simplex',
    });
    layout(graph); // 调用 flow_layout 的布局算法

    // 更新子节点局部坐标归一化
    for (final node in children) {
      final nd = graph.node(node.id);
      if (nd != null && nd['x'] != null && nd['y'] != null) {
        final newX = (nd['x'] as num).toDouble() - node.size.width / 2;
        final newY = (nd['y'] as num).toDouble() - node.size.height / 2;
        node.position = Offset(newX, newY);
      }
    }
    // 使用 graph.label 来获取整个子图的计算宽高
    final labelData = graph.label;
    group.size = Size(labelData['width'], labelData['height']);

    for (final e in groupEdges) {
      final edgeData = graph.edge(e.sourceNodeId, e.targetNodeId);
      debugPrint('处理边 ${e.id} 的路由点');
      if (edgeData != null && edgeData['points'] != null) {
        final points = edgeData['points'] as List;
        final offsetPoints = <Offset>[];
        debugPrint('  边 ${e.id} 有 ${points.length} 个路由点');

        // 添加中间路由点
        for (final p in points) {
          final px = (p['x'] as num).toDouble();
          final py = (p['y'] as num).toDouble();
          offsetPoints.add(Offset(px, py));
          debugPrint('    点: ($px, $py)');
        }
        e.waypoints = offsetPoints.map((p) => [p.dx, p.dy]).toList();
      }
    }
  }
}
