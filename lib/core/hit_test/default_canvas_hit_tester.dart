import 'dart:ui';
import 'package:flow_editor/core/hit_test/canvas_hit_tester.dart';
import 'package:flow_editor/core/models/node_model.dart';
import 'package:flow_editor/core/models/anchor_model.dart';
import 'package:flow_editor/core/models/edge_model.dart';
import 'package:flow_editor/core/models/hit_test_result.dart';
import 'package:flow_editor/core/models/config/hit_test_tolerance.dart';
import 'package:flow_editor/core/painters/path_generators/flexible_path_generator.dart';
import 'package:flow_editor/core/utils/hit_test_utils.dart';

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
      final absPos = node.absolutePosition(nodes);
      final absNode = node.copyWith(position: absPos);
      for (final anchor in node.anchors) {
        final center = computeAnchorWorldPosition(absNode, anchor, nodes);
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
      final absPos = node.absolutePosition(nodes);
      final absNode = node.copyWith(position: absPos);
      for (final anchor in node.anchors) {
        final center = computeAnchorWorldPosition(absNode, anchor, nodes);
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

  String? hitTestEdgeWithRect(Rect rect, [Offset? mouseCanvasPos]) {
    final edges = getEdges();
    final generator = FlexiblePathGenerator(getNodes());

    final intersectingEdges = <String, Path>{};

    for (final edge in edges) {
      final result = generator.generate(edge, type: edge.lineStyle.edgeMode);
      if (result == null) continue;

      final path = result.path;
      if (_pathIntersectsRect(path, rect)) {
        intersectingEdges[edge.id] = path;
      }
    }

    if (intersectingEdges.isEmpty) return null;

    // 如果只有一条边，直接返回
    if (intersectingEdges.length == 1 || mouseCanvasPos == null) {
      return intersectingEdges.keys.first;
    }

    // 多条边，找最近的
    double minDist = double.infinity;
    String? closestEdgeId;
    intersectingEdges.forEach((id, path) {
      final dist = distanceToPath(path, mouseCanvasPos);
      if (dist < minDist) {
        minDist = dist;
        closestEdgeId = id;
      }
    });

    return closestEdgeId;
  }

// 检测矩形与路径交叉
  bool _pathIntersectsRect(Path path, Rect rect) {
    final rectPath = Path()..addRect(rect);
    final intersection = Path.combine(PathOperation.intersect, path, rectPath);
    return !intersection.getBounds().isEmpty;
  }
}
