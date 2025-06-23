import 'dart:ui';

import 'package:flow_editor/core/hit_test/canvas_hit_tester.dart';
import 'package:flow_editor/core/models/ui/node_model.dart';
import 'package:flow_editor/core/models/ui/anchor_model.dart';
import 'package:flow_editor/core/models/ui/edge_model.dart';
import 'package:flow_editor/core/models/ui/hit_test_result.dart';
import 'package:flow_editor/core/models/config/hit_test_tolerance.dart';
import 'package:flow_editor/core/painters/path_generators/flexible_path_generator.dart';
import 'package:flow_editor/core/utils/hit_test_utils.dart';
import 'package:flutter/foundation.dart';

class DefaultCanvasHitTester implements CanvasHitTester {
  final List<NodeModel> Function() getNodes;
  final List<EdgeModel> Function() getEdges;
  final Offset Function(NodeModel, AnchorModel, List<NodeModel>)
      computeAnchorWorldPosition;
  final HitTestTolerance tolerance;

  DefaultCanvasHitTester({
    required this.getNodes,
    required this.getEdges,
    required this.computeAnchorWorldPosition,
    this.tolerance = const HitTestTolerance(),
  });

  @override
  String? hitTestNode(Offset pos) {
    final nodes = getNodes();
    for (final node in nodes.reversed) {
      final absPos = node.absolutePosition(nodes);
      final rect = Rect.fromLTWH(
          absPos.dx, absPos.dy, node.size.width, node.size.height);
      if (rect.contains(pos)) return node.id;
    }
    return null;
  }

  @override
  String? hitTestAnchor(Offset pos) {
    final nodes = getNodes();
    for (final node in nodes) {
      for (final anchor in node.anchors) {
        final center = computeAnchorWorldPosition(node, anchor, nodes);
        if ((pos - center).distance < tolerance.anchor) {
          return anchor.id;
        }
      }
    }
    return null;
  }

  @override
  String? hitTestEdge(Offset pos) {
    double minDist = double.infinity;
    String? hitEdgeId;
    final generator = FlexiblePathGenerator(getNodes());

    for (final edge in getEdges()) {
      final result = generator.generate(edge, type: edge.lineStyle.edgeMode);
      if (result == null) continue;
      final d = distanceToPath(result.path, pos);
      if (d < minDist) {
        minDist = d;
        hitEdgeId = edge.id;
      }
    }

    return (minDist < tolerance.edge) ? hitEdgeId : null;
  }

  @override
  String? hitTestElement(Offset pos) =>
      hitTestAnchor(pos) ?? hitTestNode(pos) ?? hitTestEdge(pos);

  @override
  NodeModel? hitTestNodeModel(Offset pos) => _firstMatch(getNodes(), (n) {
        final absPos = n.absolutePosition(getNodes());
        final rect =
            Rect.fromLTWH(absPos.dx, absPos.dy, n.size.width, n.size.height);
        return rect.contains(pos);
      });

  @override
  AnchorHitResult? hitTestAnchorResult(Offset pos) {
    final nodes = getNodes();
    for (final node in nodes) {
      for (final anchor in node.anchors) {
        final center = computeAnchorWorldPosition(node, anchor, nodes) +
            Offset(anchor.size.width / 2, anchor.size.height / 2);
        debugPrint('hitTestAnchorResult: ${anchor.id}');
        debugPrint('pos: $pos');
        debugPrint('center: $center');
        debugPrint('distance: ${(pos - center).distance}');
        if ((pos - center).distance < tolerance.anchor) {
          return AnchorHitResult(nodeId: node.id, anchor: anchor);
        }
      }
    }
    return null;
  }

  @override
  EdgeModel? hitTestEdgeModel(Offset pos) {
    final id = hitTestEdge(pos);
    return id == null ? null : getEdges().firstWhereOrNull((e) => e.id == id);
  }

  @override
  Object? hitTestElementModel(Offset pos) =>
      hitTestAnchorResult(pos) ??
      hitTestNodeModel(pos) ??
      hitTestEdgeModel(pos);

  @override
  ResizeHitResult? hitTestResizeHandle(Offset pos) {
    final nodes = getNodes();
    for (final node in nodes.reversed) {
      final absPos = node.absolutePosition(nodes);
      final rect = Rect.fromLTWH(
          absPos.dx, absPos.dy, node.size.width, node.size.height);
      for (final handle in ResizeHandlePosition.values) {
        final handlePos = computeHandlePosition(rect, handle);
        if ((pos - handlePos).distance < tolerance.resizeHandle) {
          return ResizeHitResult(nodeId: node.id, handle: handle);
        }
      }
    }
    return null;
  }

  @override
  EdgeUiHitResult? hitTestEdgeOverlayElement(Offset pos) {
    final generator = FlexiblePathGenerator(getNodes());

    for (final edge in getEdges()) {
      final result = generator.generate(edge, type: edge.lineStyle.edgeMode);
      if (result == null || edge.overlays.isEmpty) continue;

      final metric = result.path.computeMetrics().firstOrNull;
      if (metric == null) continue;

      for (final overlay in edge.overlays) {
        final p = metric
            .getTangentForOffset(metric.length * overlay.positionRatio)
            ?.position;
        if (p == null) continue;

        final center = p + overlay.offset;
        final size = overlay.size ?? const Size(16, 16);
        final rect = Rect.fromCenter(
            center: center, width: size.width, height: size.height);

        if (rect.contains(pos)) {
          return EdgeUiHitResult(
            edgeId: edge.id,
            type: overlay.type,
            bounds: rect,
          );
        }
      }
    }
    return null;
  }

  @override
  EdgeWaypointHitResult? hitTestEdgeWaypoint(Offset pos) {
    for (final edge in getEdges()) {
      final waypoints = edge.waypoints ?? [];
      for (int i = 0; i < waypoints.length; i++) {
        if ((pos - waypoints[i]).distance < tolerance.waypoint) {
          return EdgeWaypointHitResult(
            edgeId: edge.id,
            index: i,
            center: waypoints[i],
          );
        }
      }
    }
    return null;
  }

  @override
  FloatingAnchorHitResult? hitTestFloatingAnchor(Offset pos) {
    const radius = 12.0;
    final nodes = getNodes();
    for (final node in nodes) {
      final absPos = node.absolutePosition(nodes);
      final r = Rect.fromLTWH(
          absPos.dx, absPos.dy, node.size.width, node.size.height);
      for (final p in [
        r.centerLeft,
        r.centerRight,
        r.topCenter,
        r.bottomCenter
      ]) {
        if ((pos - p).distance < radius) {
          return FloatingAnchorHitResult(nodeId: node.id, center: p);
        }
      }
    }
    return null;
  }

  @override
  InsertTargetHitResult? hitTestInsertPoint(Offset pos) {
    for (final edge in getEdges()) {
      final mid = computeEdgeMidpoint(edge);
      if ((pos - mid).distance < 16.0) {
        return InsertTargetHitResult(
          targetType: 'edge',
          targetId: edge.id,
          position: mid,
        );
      }
    }
    return null;
  }

  @override
  EdgeWaypointPathHitResult? hitTestEdgeWaypointPath(Offset pos) {
    double minDist = double.infinity;
    String? closestEdgeId;
    Offset? nearestPoint;

    final generator = FlexiblePathGenerator(getNodes());

    for (final edge in getEdges()) {
      if (edge.waypoints == null || edge.waypoints!.length < 2) continue;

      final path = generator.generate(edge)?.path;
      if (path == null) continue;

      final metrics = path.computeMetrics();
      for (final metric in metrics) {
        const steps = 100;
        for (int i = 0; i <= steps; i++) {
          final tangent = metric.getTangentForOffset(metric.length * i / steps);
          if (tangent == null) continue;
          final point = tangent.position;
          final dist = (pos - point).distance;
          if (dist < minDist) {
            minDist = dist;
            closestEdgeId = edge.id;
            nearestPoint = point;
          }
        }
      }
    }

    return (closestEdgeId != null && minDist < tolerance.edge)
        ? EdgeWaypointPathHitResult(
            edgeId: closestEdgeId,
            distance: minDist,
            nearestPoint: nearestPoint!,
          )
        : null;
  }

  T? _firstMatch<T>(Iterable<T> list, bool Function(T) test) {
    for (final item in list) {
      if (test(item)) return item;
    }
    return null;
  }

  @override
  String? hitTestEdgeWithRect(Rect rect) {
    final edges = getEdges();
    final nodes = getNodes();

    for (final edge in edges) {
      final waypoints = edge.waypoints;
      if (waypoints == null || waypoints.length < 2) continue;

      for (int i = 0; i < waypoints.length - 1; i++) {
        final wp1 = _getAbsoluteWaypointPosition(edge, waypoints[i], nodes);
        final wp2 = _getAbsoluteWaypointPosition(edge, waypoints[i + 1], nodes);

        if (_lineIntersectsRect(wp1, wp2, rect)) {
          debugPrint('✅ Edge intersects: ${edge.id}');
          return edge.id; // 立即返回相交的边
        }
      }
    }

    debugPrint('❌ No edges intersect with the rect.');
    return null;
  }

// 递归找到waypoint的全局坐标
  Offset _getAbsoluteWaypointPosition(
      EdgeModel edge, Offset waypoint, List<NodeModel> nodes) {
    // 找到所属的group节点，如果不存在group，返回waypoint本身
    NodeModel? groupNode = _findParentGroupNode(edge, nodes);
    Offset absolutePosition = waypoint;

    while (groupNode != null) {
      absolutePosition += groupNode.position;
      groupNode = _findParentGroupNodeByNode(groupNode, nodes);
    }

    return absolutePosition;
  }

// 根据 edge 找到其所属的最近group节点
  NodeModel? _findParentGroupNode(EdgeModel edge, List<NodeModel> nodes) {
    final sourceNode =
        nodes.firstWhereOrNull((node) => node.id == edge.sourceNodeId);
    if (sourceNode == null) return null;

    return _findParentGroupNodeByNode(sourceNode, nodes);
  }

// 根据一个节点找到其所属的最近group节点
  NodeModel? _findParentGroupNodeByNode(NodeModel node, List<NodeModel> nodes) {
    return nodes.firstWhereOrNull((n) => n.id == node.parentId && n.isGroup);
  }

// 判断矩形与线段是否相交
  bool _lineIntersectsRect(Offset p1, Offset p2, Rect rect) {
    if (rect.contains(p1) || rect.contains(p2)) return true;

    final rectLines = [
      [rect.topLeft, rect.topRight],
      [rect.topRight, rect.bottomRight],
      [rect.bottomRight, rect.bottomLeft],
      [rect.bottomLeft, rect.topLeft],
    ];

    for (final line in rectLines) {
      if (_linesIntersect(p1, p2, line[0], line[1])) return true;
    }
    return false;
  }

// 判断两条线段是否相交
  bool _linesIntersect(Offset a1, Offset a2, Offset b1, Offset b2) {
    double cross(Offset p1, Offset p2, Offset p3) =>
        (p2.dx - p1.dx) * (p3.dy - p1.dy) - (p2.dy - p1.dy) * (p3.dx - p1.dx);

    return (cross(a1, a2, b1) * cross(a1, a2, b2) < 0) &&
        (cross(b1, b2, a1) * cross(b1, b2, a2) < 0);
  }
}
