import 'package:flutter/material.dart';
import 'dart:math' show pi;
import 'package:flow_editor/core/models/node_model.dart';
import 'package:flow_editor/core/models/edge_model.dart';
import 'package:flow_editor/core/models/enums/edge_enums.dart';
import 'package:flow_editor/core/utils/anchor_position_utils.dart';
import 'package:flow_editor/core/utils/edge_utils.dart';
import 'package:flow_editor/core/utils/canvas_utils.dart';
import 'package:flow_editor/core/models/enums/position_enum.dart';
import 'package:flow_editor/core/painters/path_generators/path_generator.dart';
import 'package:flow_editor/core/models/edge_path.dart';

class FlexiblePathGenerator implements PathGenerator {
  final List<NodeModel> nodes;

  FlexiblePathGenerator(this.nodes);

  @override
  EdgePath? generate(EdgeModel edge,
      {EdgeMode type = EdgeMode.bezier,
      bool smooth = true,
      double smoothRadius = 10.0}) {
    final sourceNode = nodes.firstWhereOrNull((n) => n.id == edge.sourceNodeId);
    final targetNode = nodes.firstWhereOrNull((n) => n.id == edge.targetNodeId);
    if (sourceNode == null || targetNode == null) return null;

    if (edge.waypoints != null && edge.waypoints!.isNotEmpty) {
      final waypoints = mapEdgeWaypointsToAbsolute(edge, nodes);
      return EdgePath(
          edge.id,
          _generateFromWaypoints(waypoints,
              smooth: smooth, smoothRadius: smoothRadius));
    }

    final sourceAnchor =
        sourceNode.anchors.firstWhereOrNull((a) => a.id == edge.sourceAnchorId);
    final targetAnchor =
        targetNode.anchors.firstWhereOrNull((a) => a.id == edge.targetAnchorId);

    final start = sourceAnchor == null
        ? sourceNode.position
        : computeAnchorWorldPosition(sourceNode, sourceAnchor, nodes) +
            Offset(sourceAnchor.size.width / 2, sourceAnchor.size.height / 2);

    final end = targetAnchor == null
        ? targetNode.position
        : computeAnchorWorldPosition(targetNode, targetAnchor, nodes) +
            Offset(targetAnchor.size.width / 2, targetAnchor.size.height / 2);

    return EdgePath(
        edge.id,
        _createPath(
            start, end, type, sourceAnchor?.position, targetAnchor?.position));
  }

  @override
  EdgePath generateGhost(
    EdgeModel edge,
    Offset draggingEnd, {
    EdgeMode type = EdgeMode.bezier,
  }) {
    final sourceNode = nodes.firstWhereOrNull((n) => n.id == edge.sourceNodeId);
    if (sourceNode == null) return EdgePath(edge.id, Path());

    final sourceAnchor =
        sourceNode.anchors.firstWhereOrNull((a) => a.id == edge.sourceAnchorId);

    final start = sourceAnchor == null
        ? sourceNode.position
        : computeAnchorWorldPosition(sourceNode, sourceAnchor, nodes) +
            Offset(sourceAnchor.size.width / 2, sourceAnchor.size.height / 2);

    return EdgePath(
        edge.id,
        _createPath(start, draggingEnd, type, sourceAnchor?.position,
            revisePosition(sourceAnchor?.position)));
  }

  Path _createPath(Offset start, Offset end, EdgeMode type, Position? sourcePos,
      Position? targetPos) {
    Path path;

    switch (type) {
      case EdgeMode.bezier:
        path = getBezierPath(
          sourceX: start.dx,
          sourceY: start.dy,
          sourcePos: sourcePos ?? Position.right,
          targetX: end.dx,
          targetY: end.dy,
          targetPos: targetPos ?? Position.left,
          curvature: 0.25,
        )[0];
        break;
      case EdgeMode.hvBezier:
        path = getHVBezierPath(
          sourceX: start.dx,
          sourceY: start.dy,
          sourcePos: sourcePos ?? Position.right,
          targetX: end.dx,
          targetY: end.dy,
          targetPos: targetPos ?? Position.left,
          offset: 50.0,
        )[0];
        break;
      case EdgeMode.orthogonal3:
        path = getOrthogonalPath3Segments(
          sx: start.dx,
          sy: start.dy,
          sourcePos: sourcePos,
          tx: end.dx,
          ty: end.dy,
          targetPos: targetPos,
          offsetDist: 40,
        );
        break;
      case EdgeMode.orthogonal5:
        path = getOrthogonalPath5Segments(
          sx: start.dx,
          sy: start.dy,
          sourcePos: sourcePos,
          tx: end.dx,
          ty: end.dy,
          targetPos: targetPos,
          offsetDist: 40,
        );
        break;
      case EdgeMode.line:
      default:
        path = simpleLinePath(start, end);
    }

    return path;
  }

  Path _generateFromWaypoints(
    List<Offset> waypoints, {
    bool smooth = false,
    double smoothRadius = 10.0,
  }) {
    final path = Path();
    if (waypoints.length < 2) return path;

    path.moveTo(waypoints.first.dx, waypoints.first.dy);

    if (!smooth || waypoints.length < 3) {
      for (int i = 1; i < waypoints.length; i++) {
        path.lineTo(waypoints[i].dx, waypoints[i].dy);
      }
    } else {
      for (int i = 1; i < waypoints.length - 1; i++) {
        final prev = waypoints[i - 1];
        final current = waypoints[i];
        final next = waypoints[i + 1];

        // 计算进入和出去的向量
        final toPrev = (prev - current).direction;
        final toNext = (next - current).direction;

        // 计算圆滑的起始和结束点
        final startSmoothPoint =
            current + Offset.fromDirection(toPrev, smoothRadius);
        final endSmoothPoint =
            current + Offset.fromDirection(toNext, smoothRadius);

        if (i == 1) {
          // 第一个折点特殊处理
          path.lineTo(startSmoothPoint.dx, startSmoothPoint.dy);
        } else {
          path.lineTo(startSmoothPoint.dx, startSmoothPoint.dy);
        }

        // 使用二次贝塞尔曲线做圆滑处理
        path.quadraticBezierTo(
          current.dx,
          current.dy,
          endSmoothPoint.dx,
          endSmoothPoint.dy,
        );
      }
      // 最后一段直线
      path.lineTo(waypoints.last.dx, waypoints.last.dy);
    }

    return path;
  }

  double radians(double degrees) => degrees * pi / 180;
}

extension FirstWhereOrNull<E> on Iterable<E> {
  E? firstWhereOrNull(bool Function(E e) test) =>
      cast<E?>().firstWhere((x) => x != null && test(x), orElse: () => null);
}
