import 'dart:ui';
import 'package:flow_editor/core/hit_test/canvas_hit_tester.dart';
import 'package:flow_editor/core/models/node_model.dart';
import 'package:flow_editor/core/models/anchor_model.dart';
import 'package:flow_editor/core/models/edge_model.dart';
import 'package:flow_editor/core/painters/path_generators/flexible_path_generator.dart';
import 'package:flow_editor/core/utils/hit_test_utils.dart';

class DefaultCanvasHitTester implements CanvasHitTester {
  final List<NodeModel> Function() getNodes;
  final List<EdgeModel> Function() getEdges;
  final List<AnchorModel> Function() getAnchors;

  /// 由外部提供：给定节点与它的某个 AnchorModel，根据业务逻辑返回锚点的全局中心坐标
  final Offset Function(
          NodeModel node, AnchorModel anchor, List<NodeModel> allNodes)
      computeAnchorWorldPosition;

  /// 锚点命中阈值
  final double anchorThreshold;

  DefaultCanvasHitTester({
    required this.getNodes,
    required this.getEdges,
    required this.getAnchors,
    required this.computeAnchorWorldPosition,
    this.anchorThreshold = 20.0,
  });

  @override
  String? hitTestNode(Offset pos) {
    final nodes = getNodes();
    for (final node in nodes.reversed) {
      final rect = Rect.fromLTWH(
        node.position.dx,
        node.position.dy,
        node.size.width,
        node.size.height,
      );
      if (rect.contains(pos)) return node.id;
    }
    return null;
  }

  @override
  String? hitTestAnchor(Offset pos) {
    final nodes = getNodes();
    for (final node in nodes) {
      for (final anchor in node.anchors ?? []) {
        final center = computeAnchorWorldPosition(node, anchor, nodes);
        if ((pos - center).distance < anchorThreshold) {
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
    final edges = getEdges();
    final nodes = getNodes();
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
    return (minDist < 6.0) ? hitEdgeId : null;
  }

  @override
  String? hitTestElement(Offset pos) {
    final anchorId = hitTestAnchor(pos);
    if (anchorId != null) return anchorId;
    final nodeId = hitTestNode(pos);
    if (nodeId != null) return nodeId;
    return hitTestEdge(pos);
  }
}
