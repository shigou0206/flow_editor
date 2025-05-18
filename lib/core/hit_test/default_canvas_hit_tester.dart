import 'dart:ui';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flow_editor/core/hit_test/canvas_hit_tester.dart';
import 'package:flow_editor/core/state_management/providers/node_state_provider.dart';
import 'package:flow_editor/core/state_management/providers/edge_state_provider.dart';
import 'package:flow_editor/core/state_management/providers/canvas_state_provider.dart';
import 'package:flow_editor/core/painters/path_generators/flexible_path_generator.dart';
import 'package:flow_editor/core/utils/hit_test_utils.dart';
import 'package:flow_editor/core/utils/anchor_position_utils.dart';

/// 默认命中检测实现，基于 Provider 中的业务模型状态
class DefaultCanvasHitTester implements CanvasHitTester {
  final WidgetRef _ref;

  DefaultCanvasHitTester(this._ref);

  String get _wfId => _ref.read(multiCanvasStateProvider).activeWorkflowId;

  @override
  String? hitTestNode(Offset pos) {
    final nodes = _ref.read(nodeStateProvider(_wfId)).nodesOf(_wfId);
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
    const double threshold = 20.0;
    final nodes = _ref.read(nodeStateProvider(_wfId)).nodesOf(_wfId);
    for (final node in nodes) {
      for (final anchor in node.anchors ?? []) {
        final anchorPos = computeAnchorWorldPosition(
          node,
          anchor,
          nodes,
        );
        final center = anchorPos + Offset(anchor.width / 2, anchor.height / 2);
        if ((pos - center).distance < threshold) {
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
    final edges = _ref.read(edgeStateProvider(_wfId)).edgesOf(_wfId);
    final nodes = _ref.read(nodeStateProvider(_wfId)).nodesOf(_wfId);
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
