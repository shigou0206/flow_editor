// file: test/edge/behaviors/edge_behavior_test.dart

import 'package:flutter_test/flutter_test.dart';
import 'package:flow_editor/core/edge/models/edge_model.dart';
import 'package:flow_editor/core/edge/behaviors/edge_behavior.dart';
import 'package:flow_editor/core/edge/behaviors/default_edge_behavior.dart';

void main() {
  group('DefaultEdgeBehavior Tests', () {
    late EdgeBehavior behavior;
    late EdgeModel edge;

    setUp(() {
      behavior = DefaultEdgeBehavior();
      edge = const EdgeModel(
        id: 'edge1',
        sourceNodeId: 'nodeA',
        sourceAnchorId: 'a1',
      );
    });

    test('onEdgeTap does not throw', () {
      // DefaultEdgeBehavior 里通常只是 debugPrint('Edge tapped: ...') 或空
      expect(() => behavior.onEdgeTap(edge), returnsNormally);
    });

    test('onEdgeDelete does not throw', () {
      expect(() => behavior.onEdgeDelete(edge), returnsNormally);
    });

    test('onEdgeContextMenu does not throw', () {
      final pos = const Offset(50, 100);
      expect(() => behavior.onEdgeContextMenu(edge, pos), returnsNormally);
    });

    test('onEdgeEndpointDrag does not throw', () {
      expect(
        () => behavior.onEdgeEndpointDrag(edge, true, 'nodeX', 'anchorX'),
        returnsNormally,
      );
    });

    test('onEdgeCreated/onEdgeUpdated/onEdgeSelected/onEdgeDeselected no error',
        () {
      final edge2 = edge.copyWith(id: 'edge2');
      // no advanced logic => just ensure no exception
      behavior.onEdgeCreated(edge2);
      behavior.onEdgeUpdated(edge, edge2);
      behavior.onEdgeSelected(edge2);
      behavior.onEdgeDeselected(edge2);
    });
  });
}
