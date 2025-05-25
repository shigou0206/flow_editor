import 'package:flutter/widgets.dart';

import 'package:flow_layout/graph/graph.dart';
import 'package:flow_layout/layout.dart';
import 'package:collection/collection.dart';
import 'package:flow_editor/core/models/edge_model.dart';
import 'package:flow_editor/core/models/node_model.dart';
import 'package:flow_editor/layout/layout_strategy.dart';
import 'package:flow_editor/core/models/config/sugiyama_layout_config.dart';

class SugiyamaLayoutStrategy implements LayoutStrategy {
  final SugiyamaLayoutConfig config;

  SugiyamaLayoutStrategy({this.config = const SugiyamaLayoutConfig()});

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
  }

  void _performGraphLayoutForGroup(
    NodeModel group,
    List<NodeModel> nodes,
    List<EdgeModel> edges,
  ) {
    final children = nodes.where((n) => n.parentId == group.id).toList();

    if (children.isEmpty) {
      final groupIndex = nodes.indexWhere((n) => n.id == group.id);
      if (groupIndex != -1) {
        nodes[groupIndex] = group.copyWith(size: config.emptyGroupSize);
      }
      return;
    }

    final groupEdges = edges.where((edge) {
      final src = nodes.firstWhereOrNull((n) => n.id == edge.sourceNodeId);
      final tgt = nodes.firstWhereOrNull((n) => n.id == edge.targetNodeId);
      return src?.parentId == group.id && tgt?.parentId == group.id;
    }).toList();

    final graph = Graph();

    for (final node in children) {
      graph.setNode(node.id, {
        'width': node.size.width,
        'height': node.size.height,
        'x': node.position.dx,
        'y': node.position.dy,
      });
    }

    for (final edge in groupEdges) {
      graph.setEdge(edge.sourceNodeId, edge.targetNodeId, {'id': edge.id});
    }

    graph.setGraph({
      'rankdir': config.rankDir,
      'marginx': config.nodeMarginX,
      'marginy': config.nodeMarginY,
      'ranker': config.ranker,
    });

    layout(graph);

    final compactOffsetX = config.compactLeft ? -config.nodeMarginX : 0.0;
    final compactOffsetY = config.compactTop ? -config.nodeMarginY : 0.0;

    final labelData = graph.label;
    final groupIndex = nodes.indexWhere((n) => n.id == group.id);

    Size? groupSize;
    if (groupIndex != -1) {
      // 一次性统一处理group尺寸的compact调整
      final compactHorizontal =
          (config.compactLeft ? config.nodeMarginX : 0.0) +
              (config.compactRight ? config.nodeMarginX : 0.0);
      final compactVertical = (config.compactTop ? config.nodeMarginY : 0.0) +
          (config.compactBottom ? config.nodeMarginY : 0.0);

      groupSize = Size(
        ((labelData['width'] as num?)?.toDouble() ?? 0) +
            config.groupHorizontalPadding -
            compactHorizontal,
        ((labelData['height'] as num?)?.toDouble() ?? 0) +
            config.groupVerticalPadding -
            compactVertical,
      );

      nodes[groupIndex] = group.copyWith(size: groupSize);
    }

    // 更新节点位置 (一次性应用偏移量)
    for (final node in children) {
      final nd = graph.node(node.id);
      if (nd != null && nd['x'] != null && nd['y'] != null) {
        var newX = 0.0;
        if (node.type == 'start' && groupSize != null) {
          newX = groupSize.width / 2 - node.size.width / 2;
        } else {
          newX = (nd['x'] as num).toDouble() -
              node.size.width / 2 +
              compactOffsetX;
        }

        final newY =
            (nd['y'] as num).toDouble() - node.size.height / 2 + compactOffsetY;

        final index = nodes.indexWhere((n) => n.id == node.id);
        if (index != -1) {
          nodes[index] = node.copyWith(position: Offset(newX, newY));
        }
      }
    }

    // 更新边的waypoints（一次性偏移）
    for (final e in groupEdges) {
      final edgeData = graph.edge(e.sourceNodeId, e.targetNodeId);
      if (edgeData != null && edgeData['points'] != null) {
        final points = edgeData['points'] as List;

        final offsetPoints = points.map((p) {
          final px = (p['x'] as num).toDouble() + compactOffsetX;
          final py = (p['y'] as num).toDouble() + compactOffsetY;
          return Offset(px, py);
        }).toList();

        final sourceNode =
            nodes.firstWhereOrNull((n) => n.id == e.sourceNodeId);
        if (sourceNode != null &&
            sourceNode.type == 'start' &&
            groupSize != null) {
          offsetPoints[0] = Offset(
            groupSize.width / 2, // 水平居中于group
            offsetPoints[0].dy, // 保持原有y坐标
          );
        }

        final edgeIndex = edges.indexWhere((ed) => ed.id == e.id);
        if (edgeIndex != -1) {
          edges[edgeIndex] = e.copyWith(waypoints: offsetPoints);
        }
      }
    }
  }
}
