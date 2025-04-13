import 'package:flutter/material.dart';
import 'package:flow_editor/core/node/models/node_model.dart';
import 'package:flow_editor/core/edge/models/edge_model.dart';
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

    final start = Offset(sourceNode.x, sourceNode.y);
    final end = Offset(targetNode.x, targetNode.y);

    final path = Path()
      ..moveTo(start.dx, start.dy)
      ..lineTo(end.dx, end.dy);

    return EdgePath(edge.id, path);
  }
}

extension FirstWhereOrNull<E> on Iterable<E> {
  E? firstWhereOrNull(bool Function(E e) test) =>
      cast<E?>().firstWhere((x) => x != null && test(x), orElse: () => null);
}
