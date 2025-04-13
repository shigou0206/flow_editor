import 'package:flutter/widgets.dart';
import 'package:flow_editor/core/edge/models/edge_model.dart';
import 'package:flow_editor/core/node/models/node_model.dart';
import 'package:flow_editor/core/node/node_state/node_state_provider.dart';
import 'package:flow_editor/core/edge/edge_state/edge_state_provider.dart';
import 'package:flow_editor/core/layout/layout_strategy.dart';
import 'package:flow_layout/graph/graph.dart';
import 'package:flow_layout/layout.dart';

class SugiyamaLayoutStrategy implements LayoutStrategy {
  @override
  void performLayout(
    List<NodeModel> nodes,
    List<EdgeModel> edges,
    NodeStateNotifier nodeNotifier,
    EdgeStateNotifier edgeNotifier,
  ) {
    final graph = Graph();

    for (var node in nodes) {
      graph.setNode(node.id, {
        'width': node.width,
        'height': node.height,
        'x': node.x - node.width / 2,
        'y': node.y - node.height / 2,
      });
    }

    for (var edge in edges) {
      graph.setEdge(edge.sourceNodeId, edge.targetNodeId!);
    }

    graph.setGraph({
      'rankdir': 'TB',
      'marginx': 20,
      'marginy': 20,
      'ranker': 'network-simplex',
    });

    layout(graph);

    final updatedNodes = <NodeModel>[];
    for (var node in nodes) {
      final nd = graph.node(node.id);
      if (nd != null && nd['x'] != null && nd['y'] != null) {
        final x = (nd['x'] as num).toDouble() + node.width / 2;
        final y = (nd['y'] as num).toDouble() + node.height / 2;
        updatedNodes.add(node.copyWith(x: x, y: y));
      } else {
        updatedNodes.add(node);
      }
    }
    nodeNotifier.upsertNodes(updatedNodes);

    final routes = <String, List<Offset>>{};
    for (final edge in edges) {
      final edgeData = graph.edge(edge.sourceNodeId, edge.targetNodeId!);
      if (edgeData != null && edgeData['points'] != null) {
        final points = edgeData['points'] as List;
        final offsetPoints = <Offset>[];
        final srcNode =
            updatedNodes.firstWhere((n) => n.id == edge.sourceNodeId);
        final dstNode =
            updatedNodes.firstWhere((n) => n.id == edge.targetNodeId);

        offsetPoints.add(Offset(srcNode.x, srcNode.y));
        for (final p in points) {
          final px = (p['x'] as num).toDouble();
          final py = (p['y'] as num).toDouble();
          offsetPoints.add(Offset(px, py));
        }
        offsetPoints.add(Offset(dstNode.x, dstNode.y));
        routes[edge.id] = offsetPoints;
      } else {
        final srcNode =
            updatedNodes.firstWhere((n) => n.id == edge.sourceNodeId);
        final dstNode =
            updatedNodes.firstWhere((n) => n.id == edge.targetNodeId);
        routes[edge.id] = [
          Offset(srcNode.x, srcNode.y),
          Offset(dstNode.x, dstNode.y),
        ];
      }
    }
    edgeNotifier.updateEdgeWaypoints(routes);
  }
}
