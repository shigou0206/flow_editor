// file: edge_factory_test.dart
import 'package:flutter_test/flutter_test.dart';
import 'package:flow_editor/core/edge/factories/edge_factory.dart';
import 'package:flow_editor/core/edge/models/edge_line_style.dart';
import 'package:flow_editor/core/edge/models/edge_animation_config.dart';

void main() {
  group('EdgeFactory Tests', () {
    late EdgeFactory factory;

    setUp(() {
      factory = EdgeFactory();
      factory.registerEdgeType(
        'flow',
        const EdgeTypeConfig(
          defaultLineStyle: EdgeLineStyle(
            colorHex: '#FF0000',
            strokeWidth: 2.0,
            dashPattern: [5, 5],
          ),
          defaultAnimConfig: EdgeAnimationConfig(
            animateDash: true,
            dashFlowPhase: 0.5,
          ),
          lockedByDefault: false,
        ),
      );

      factory.registerEdgeType(
        'dependency',
        const EdgeTypeConfig(
          defaultLineStyle: EdgeLineStyle(
            colorHex: '#00FF00',
            strokeWidth: 1.5,
          ),
          lockedByDefault: true,
        ),
      );
    });

    test('should create edge with registered type "flow" defaults', () {
      final edge = factory.createEdge(
        edgeType: 'flow',
        sourceNodeId: 'node1',
        sourceAnchorId: 'anchor1',
        targetNodeId: 'node2',
        targetAnchorId: 'anchor2',
      );

      expect(edge.edgeType, 'flow');
      expect(edge.lineStyle.colorHex, '#FF0000');
      expect(edge.lineStyle.strokeWidth, 2.0);
      expect(edge.lineStyle.dashPattern, [5, 5]);
      expect(edge.animConfig.animateDash, true);
      expect(edge.animConfig.dashFlowPhase, 0.5);
      expect(edge.locked, false);
      expect(edge.isConnected, true);
      expect(edge.id, isNotEmpty);
    });

    test('should create edge with registered type "dependency" defaults', () {
      final edge = factory.createEdge(
        edgeType: 'dependency',
        sourceNodeId: 'nodeA',
        sourceAnchorId: 'anchorA',
      );

      expect(edge.edgeType, 'dependency');
      expect(edge.lineStyle.colorHex, '#00FF00');
      expect(edge.lineStyle.strokeWidth, 1.5);
      expect(edge.lineStyle.dashPattern, []);
      expect(edge.locked, true);
      expect(edge.isConnected, false); // 因为没有targetNodeId
    });

    test('should fallback to defaults for unregistered type', () {
      final edge = factory.createEdge(
        edgeType: 'unknown',
        sourceNodeId: 'nodeX',
        sourceAnchorId: 'anchorX',
      );

      expect(edge.edgeType, 'unknown');
      expect(edge.lineStyle.colorHex, '#000000'); // default EdgeLineStyle
      expect(edge.lineStyle.strokeWidth, 1.0); // default EdgeLineStyle
      expect(edge.animConfig.animateDash, false); // default EdgeAnimationConfig
      expect(edge.locked, false); // default locked
    });

    test('generated edge id should be unique', () async {
      final edge1 = factory.createEdge(
        edgeType: 'flow',
        sourceNodeId: 'node1',
        sourceAnchorId: 'anchor1',
      );

      await Future.delayed(const Duration(milliseconds: 1)); // 确保不同的毫秒数

      final edge2 = factory.createEdge(
        edgeType: 'flow',
        sourceNodeId: 'node2',
        sourceAnchorId: 'anchor2',
      );

      expect(edge1.id, isNot(equals(edge2.id)));
    });
  });
}
