import 'package:flow_editor/v1/core/edge/models/edge_model.dart';
import 'package:flow_editor/v1/core/node/models/node_model.dart';
import 'package:flutter/material.dart';
import 'package:collection/collection.dart';

extension AbsolutePositionExtension on NodeModel {
  Offset absolutePosition(List<NodeModel> allNodes) {
    if (parentId == null) {
      return position;
    } else {
      final parent =
          allNodes.firstWhere((n) => n.id == parentId, orElse: () => this);
      final parentPosition = parent.absolutePosition(allNodes);
      final absolutePosition = parentPosition + position;
      return absolutePosition;
    }
  }
}

List<Offset> mapEdgeWaypointsToAbsolute(
    EdgeModel edge, List<NodeModel> allNodes) {
  final NodeModel? source =
      allNodes.firstWhereOrNull((n) => n.id == edge.sourceNodeId);
  if (source == null) return [];

  // 如果源节点没有父组件，则认为其路由点已经是绝对坐标
  if (source.parentId == null) {
    return edge.waypoints!.map((pt) => Offset(pt[0], pt[1])).toList();
  }

  // 查找源节点的父组件
  final NodeModel? group =
      allNodes.firstWhereOrNull((n) => n.id == source.parentId);
  if (group == null) {
    return edge.waypoints!.map((pt) => Offset(pt[0], pt[1])).toList();
  }

  // 计算该 group 的绝对位置
  final Offset groupAbs = group.absolutePosition(allNodes);
  // 将边的每个相对路由点映射到绝对坐标
  return edge.waypoints!
      .map((pt) => Offset(pt[0] + groupAbs.dx, pt[1] + groupAbs.dy))
      .toList();
}

double rectToPathDistance(Rect rect, Path path, {int precision = 10}) {
  final pathMetrics = path.computeMetrics().toList();
  double minDistance = double.infinity;

  for (final metric in pathMetrics) {
    for (int i = 0; i <= precision; i++) {
      final tangent = metric.getTangentForOffset(metric.length * i / precision);
      if (tangent == null) continue;
      final pos = tangent.position;
      final nearestX = pos.dx.clamp(rect.left, rect.right);
      final nearestY = pos.dy.clamp(rect.top, rect.bottom);
      final nearestPoint = Offset(nearestX, nearestY);
      final dist = (pos - nearestPoint).distance;
      if (dist < minDistance) {
        minDistance = dist;
      }
    }
  }

  return minDistance;
}
