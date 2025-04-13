import 'package:flutter/material.dart';
import 'package:flow_editor/core/node/models/node_model.dart';
import 'package:flow_editor/core/edge/models/edge_model.dart';
import 'package:flow_editor/core/anchor/utils/anchor_position_utils.dart';
import 'path_generator.dart';
import '../models/edge_path.dart';

class DirectPathGenerator implements PathGenerator {
  final List<NodeModel> nodes;

  DirectPathGenerator(this.nodes);

  @override
  EdgePath? generate(EdgeModel edge) {
    final sourceNode = nodes.firstWhereOrNull((n) => n.id == edge.sourceNodeId);

    final targetNode = nodes.firstWhereOrNull((n) => n.id == edge.targetNodeId);
    if (sourceNode == null || targetNode == null) return null;

    final sourceAnchor = sourceNode.anchors
        ?.firstWhereOrNull((a) => a.id == edge.sourceAnchorId);
    final targetAnchor = targetNode.anchors
        ?.firstWhereOrNull((a) => a.id == edge.targetAnchorId);

    if (sourceAnchor == null || targetAnchor == null) {
      final start = Offset(sourceNode.position.dx, sourceNode.position.dy);
      final end = Offset(targetNode.position.dx, targetNode.position.dy);
      return EdgePath(
          edge.id,
          Path()
            ..moveTo(start.dx, start.dy)
            ..lineTo(end.dx, end.dy));
    } else {
      final start = computeAnchorWorldPosition(sourceNode, sourceAnchor);
      final end = computeAnchorWorldPosition(targetNode, targetAnchor);
      return EdgePath(
          edge.id,
          Path()
            ..moveTo(start.dx + sourceAnchor.width / 2,
                start.dy + sourceAnchor.height / 2)
            ..lineTo(end.dx + targetAnchor.width / 2,
                end.dy + targetAnchor.height / 2));
    }
  }
}

extension FirstWhereOrNull<E> on Iterable<E> {
  E? firstWhereOrNull(bool Function(E e) test) =>
      cast<E?>().firstWhere((x) => x != null && test(x), orElse: () => null);
}
