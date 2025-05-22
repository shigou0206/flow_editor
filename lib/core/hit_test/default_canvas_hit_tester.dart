import 'dart:ui';

import 'package:flow_editor/core/hit_test/canvas_hit_tester.dart';
import 'package:flow_editor/core/models/node_model.dart';
import 'package:flow_editor/core/models/anchor_model.dart';
import 'package:flow_editor/core/models/edge_model.dart';
import 'package:flow_editor/core/models/hit_test_result.dart';
import 'package:flow_editor/core/models/config/hit_test_tolerance.dart';
import 'package:flow_editor/core/painters/path_generators/flexible_path_generator.dart';
import 'package:flow_editor/core/utils/hit_test_utils.dart';
import 'package:flutter/foundation.dart';

class DefaultCanvasHitTester implements CanvasHitTester {
  final List<NodeModel> Function() getNodes;
  final List<EdgeModel> Function() getEdges;
  final List<AnchorModel> Function() getAnchors;

  final Offset Function(
    NodeModel node,
    AnchorModel anchor,
    List<NodeModel> allNodes,
  ) computeAnchorWorldPosition;

  final HitTestTolerance tolerance;

  DefaultCanvasHitTester({
    required this.getNodes,
    required this.getEdges,
    required this.getAnchors,
    required this.computeAnchorWorldPosition,
    this.tolerance = const HitTestTolerance(),
  });

  @override
  String? hitTestNode(Offset pos) {
    for (final node in getNodes().reversed) {
      final x = node.position.dx;
      final y = node.position.dy;
      final w = node.size.width;
      final h = node.size.height;
      debugPrint('pos: $pos');
      debugPrint('hitTestNode: $x $y $w $h');

      final rect = Rect.fromLTWH(x, y, w, h);
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

    final nodes = getNodes();
    final edges = getEdges();
    final generator = FlexiblePathGenerator(nodes);

    for (final edge in edges) {
      if (edge.targetNodeId == null || edge.targetAnchorId == null) continue;

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
  String? hitTestElement(Offset pos) {
    return hitTestAnchor(pos) ?? hitTestNode(pos) ?? hitTestEdge(pos);
  }

  @override
  NodeModel? hitTestNodeModel(Offset pos) {
    final id = hitTestNode(pos);
    return id == null ? null : getNodes().firstWhereOrNull((n) => n.id == id);
  }

  @override
  AnchorModel? hitTestAnchorModel(Offset pos) {
    final id = hitTestAnchor(pos);
    if (id == null) return null;
    for (final node in getNodes()) {
      final match = node.anchors.firstWhereOrNull((a) => a.id == id);
      if (match != null) return match;
    }
    return null;
  }

  @override
  EdgeModel? hitTestEdgeModel(Offset pos) {
    final id = hitTestEdge(pos);
    return id == null ? null : getEdges().firstWhereOrNull((e) => e.id == id);
  }

  @override
  dynamic hitTestElementModel(Offset pos) {
    return hitTestAnchorModel(pos) ??
        hitTestNodeModel(pos) ??
        hitTestEdgeModel(pos);
  }

  @override
  ResizeHitResult? hitTestResizeHandle(Offset pos) {
    final threshold = tolerance.resizeHandle;
    for (final node in getNodes().reversed) {
      final rect = Rect.fromLTWH(
        node.position.dx,
        node.position.dy,
        node.size.width,
        node.size.height,
      );

      for (final entry in ResizeHandlePosition.values) {
        final handlePos = computeHandlePosition(rect, entry);
        if ((pos - handlePos).distance < threshold) {
          return ResizeHitResult(nodeId: node.id, handle: entry);
        }
      }
    }
    return null;
  }

  @override
  EdgeUiHitResult? hitTestEdgeOverlayElement(Offset pos) {
    final nodes = getNodes();
    final edges = getEdges();
    final generator = FlexiblePathGenerator(nodes);

    for (final edge in edges) {
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
    final edges = getEdges();
    final threshold = tolerance.waypoint;

    for (final edge in edges) {
      final waypoints = edge.waypoints ?? [];
      for (int i = 0; i < waypoints.length; i++) {
        if ((pos - waypoints[i]).distance < threshold) {
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
    for (final node in getNodes()) {
      final r = Rect.fromLTWH(node.position.dx, node.position.dy,
          node.size.width, node.size.height);
      final candidates = [
        r.centerLeft,
        r.centerRight,
        r.topCenter,
        r.bottomCenter,
      ];
      for (final p in candidates) {
        if ((pos - p).distance < radius) {
          return FloatingAnchorHitResult(nodeId: node.id, center: p);
        }
      }
    }
    return null;
  }

  @override
  InsertTargetHitResult? hitTestInsertPoint(Offset pos) {
    final edges = getEdges();
    for (final edge in edges) {
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
}
