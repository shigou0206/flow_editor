import 'package:flutter_test/flutter_test.dart';
import 'package:flow_editor/core/edge/models/edge_model.dart';
import 'package:flow_editor/core/edge/models/edge_line_style.dart';
import 'package:flow_editor/core/edge/models/edge_enums.dart';
import 'package:flow_editor/core/edge/models/edge_animation_config.dart';

void main() {
  group('EdgeModel Tests', () {
    test('should create EdgeModel with required fields', () {
      const edge = EdgeModel(
        id: 'edge1',
        sourceNodeId: 'node1',
        sourceAnchorId: 'anchor1',
      );

      expect(edge.id, 'edge1');
      expect(edge.sourceNodeId, 'node1');
      expect(edge.sourceAnchorId, 'anchor1');
      expect(edge.isConnected, false);
      expect(edge.edgeType, 'default');
    });

    test('should create EdgeModel with all fields', () {
      const lineStyle = EdgeLineStyle(
        colorHex: '#FF0000',
        strokeWidth: 2.0,
        dashPattern: [5, 2],
        arrowEnd: ArrowType.triangle,
      );

      const animConfig = EdgeAnimationConfig(
        animate: true,
        animationType: 'flowPulse',
        animationSpeed: 1.0,
      );

      const edge = EdgeModel(
        id: 'edge1',
        sourceNodeId: 'node1',
        sourceAnchorId: 'anchor1',
        targetNodeId: 'node2',
        targetAnchorId: 'anchor2',
        isConnected: true,
        edgeType: 'flow',
        status: 'running',
        locked: true,
        lockedByUser: 'user1',
        version: 2,
        zIndex: 1,
        waypoints: [
          [100, 100],
          [200, 200]
        ],
        lineStyle: lineStyle,
        animConfig: animConfig,
        label: 'Flow Edge',
        labelStyle: {'fontSize': 14},
        data: {'customKey': 'value'},
      );

      expect(edge.targetNodeId, 'node2');
      expect(edge.targetAnchorId, 'anchor2');
      expect(edge.isConnected, true);
      expect(edge.edgeType, 'flow');
      expect(edge.status, 'running');
      expect(edge.locked, true);
      expect(edge.lockedByUser, 'user1');
      expect(edge.version, 2);
      expect(edge.zIndex, 1);
      expect(edge.waypoints, [
        [100, 100],
        [200, 200]
      ]);
      expect(edge.lineStyle.colorHex, '#FF0000');
      expect(edge.animConfig.animate, true);
      expect(edge.label, 'Flow Edge');
      expect(edge.labelStyle?['fontSize'], 14);
      expect(edge.data['customKey'], 'value');
    });

    test('should correctly use copyWith', () {
      const edge = EdgeModel(
        id: 'edge1',
        sourceNodeId: 'node1',
        sourceAnchorId: 'anchor1',
      );

      final newEdge = edge.copyWith(
        targetNodeId: 'node2',
        isConnected: true,
        status: 'completed',
      );

      expect(newEdge.id, edge.id);
      expect(newEdge.sourceNodeId, edge.sourceNodeId);
      expect(newEdge.targetNodeId, 'node2');
      expect(newEdge.isConnected, true);
      expect(newEdge.status, 'completed');
    });

    test('should correctly serialize to JSON', () {
      const edge = EdgeModel(
        id: 'edge1',
        sourceNodeId: 'node1',
        sourceAnchorId: 'anchor1',
        targetNodeId: 'node2',
        lineStyle: EdgeLineStyle(colorHex: '#FF0000'),
      );

      final json = edge.toJson();

      expect(json['id'], 'edge1');
      expect(json['sourceNodeId'], 'node1');
      expect(json['targetNodeId'], 'node2');
      expect(json['lineStyle']['colorHex'], '#FF0000');
    });

    test('should correctly deserialize from JSON', () {
      final json = {
        'id': 'edge1',
        'sourceNodeId': 'node1',
        'sourceAnchorId': 'anchor1',
        'targetNodeId': 'node2',
        'isConnected': true,
        'lineStyle': {
          'colorHex': '#FF0000',
          'strokeWidth': 2.0,
          'arrowEnd': 'triangle',
        },
        'animConfig': {
          'animate': true,
          'animationType': 'flowPulse',
        },
      };

      final edge = EdgeModel.fromJson(json);

      expect(edge.id, 'edge1');
      expect(edge.sourceNodeId, 'node1');
      expect(edge.targetNodeId, 'node2');
      expect(edge.isConnected, true);
      expect(edge.lineStyle.colorHex, '#FF0000');
      expect(edge.lineStyle.strokeWidth, 2.0);
      expect(edge.lineStyle.arrowEnd, ArrowType.triangle);
      expect(edge.animConfig.animate, true);
      expect(edge.animConfig.animationType, 'flowPulse');
    });

    group('EdgeLineStyle Tests', () {
      test('should parse line styles correctly from JSON', () {
        final jsonRound = {'lineCap': 'round'};
        final jsonSquare = {'lineCap': 'square'};
        final jsonInvalid = {'lineCap': 'invalid'};

        expect(EdgeLineStyle.fromJson(jsonRound).lineCap, EdgeLineCap.round);
        expect(EdgeLineStyle.fromJson(jsonSquare).lineCap, EdgeLineCap.square);
        expect(EdgeLineStyle.fromJson(jsonInvalid).lineCap, EdgeLineCap.butt);
      });

      test('should parse arrow types correctly from JSON', () {
        final jsonTriangle = {'arrowStart': 'triangle'};
        final jsonDiamond = {'arrowStart': 'diamond'};
        final jsonArrow = {'arrowStart': 'arrow'};
        final jsonInvalid = {'arrowStart': 'invalid'};

        expect(EdgeLineStyle.fromJson(jsonTriangle).arrowStart,
            ArrowType.triangle);
        expect(
            EdgeLineStyle.fromJson(jsonDiamond).arrowStart, ArrowType.diamond);
        expect(EdgeLineStyle.fromJson(jsonArrow).arrowStart, ArrowType.arrow);
        expect(EdgeLineStyle.fromJson(jsonInvalid).arrowStart, ArrowType.none);
      });

      test('EdgeModel locked prevents certain updates (hypothetical)', () {
        // 假设你想在 locked=true 时做一定检查
        // 目前 EdgeModel 测试仅能验证它的字段保持正确
        // 如果你在 EdgeModel 层没有逻辑，改在 EdgeStateNotifier 测
        // 下面仅示范 lock, lockedByUser usage:

        const lockedEdge = EdgeModel(
          id: 'edge-locked',
          sourceNodeId: 'nodeA',
          sourceAnchorId: 'anchorA',
          locked: true,
          lockedByUser: 'admin1',
        );

        expect(lockedEdge.locked, isTrue);
        expect(lockedEdge.lockedByUser, 'admin1');

        // copyWith to see if locked remains
        final updatedEdge = lockedEdge.copyWith(status: 'attemptUpdate');
        // locked remains true, lockedByUser remains 'admin1'
        expect(updatedEdge.locked, isTrue);
        expect(updatedEdge.lockedByUser, 'admin1');
        expect(updatedEdge.status,
            'attemptUpdate'); // can still set status in model
      });

      test('EdgeModel locked serialization', () {
        const lockedEdge = EdgeModel(
          id: 'edgeX',
          sourceNodeId: 'nodeX',
          sourceAnchorId: 'aX',
          locked: true,
          lockedByUser: 'userX',
        );

        final json = lockedEdge.toJson();
        expect(json['locked'], isTrue);
        expect(json['lockedByUser'], 'userX');

        final restored = EdgeModel.fromJson(json);
        expect(restored.locked, isTrue);
        expect(restored.lockedByUser, 'userX');
      });

      test('EdgeModel half-connected scenario (no targetNodeId)', () {
        const partialEdge = EdgeModel(
          id: 'edgeHalf',
          sourceNodeId: 'nodeA',
          sourceAnchorId: 'anchorA',
          // no targetNodeId/targetAnchorId => isConnected defaults to false
          isConnected: false,
        );

        expect(partialEdge.targetNodeId, isNull);
        expect(partialEdge.isConnected, isFalse);

        // If later we connect it -> copyWith
        final connectedEdge = partialEdge.copyWith(
          targetNodeId: 'nodeB',
          targetAnchorId: 'anchorB',
          isConnected: true,
        );

        expect(connectedEdge.targetNodeId, 'nodeB');
        expect(connectedEdge.targetAnchorId, 'anchorB');
        expect(connectedEdge.isConnected, isTrue);
      });

      test('EdgeModel half-connected JSON round-trip', () {
        final jsonMap = {
          'id': 'edgeHalf',
          'sourceNodeId': 'nodeA',
          'sourceAnchorId': 'aA',
          // no targetNodeId
          'isConnected': false,
        };

        final partialEdge = EdgeModel.fromJson(jsonMap);
        expect(partialEdge.targetNodeId, isNull);
        expect(partialEdge.isConnected, isFalse);

        final reJson = partialEdge.toJson();
        // ensure it doesn't produce "null" or error
        expect(reJson['targetNodeId'], isNull);
        expect(reJson['isConnected'], false);
      });

      test('EdgeModel with custom waypoints', () {
        const edgeWps = EdgeModel(
          id: 'edgeWp',
          sourceNodeId: 'node1',
          sourceAnchorId: 'anchor1',
          waypoints: [
            [150, 200],
            [250, 250],
            [300, 200],
          ],
        );

        expect(edgeWps.waypoints, hasLength(3));
        expect(edgeWps.waypoints![1], [250, 250]);

        // copyWith to add more waypoints
        final extended = edgeWps.copyWith(
          waypoints: [
            [150, 200],
            [200, 300],
            [250, 250],
            [300, 200],
          ],
        );
        expect(extended.waypoints, hasLength(4));
      });

      test('EdgeModel waypoints serialization', () {
        const edgeWps = EdgeModel(
          id: 'edgeWp2',
          sourceNodeId: 'nodeA',
          sourceAnchorId: 'anchorA',
          waypoints: [
            [100, 100],
            [200, 200],
          ],
        );

        final json = edgeWps.toJson();
        expect(json['waypoints'], [
          [100.0, 100.0],
          [200.0, 200.0],
        ]);

        final from = EdgeModel.fromJson(json);
        expect(from.waypoints, hasLength(2));
        expect(from.waypoints![0], [100.0, 100.0]);
      });

      test('EdgeModel with custom animation fields', () {
        const anim = EdgeAnimationConfig(
          animate: true,
          animationType: 'dashFlow',
          dashFlowPhase: 0.3,
          dashFlowSpeed: 1.5,
        );

        const edge = EdgeModel(
          id: 'edgeAnim',
          sourceNodeId: 'nodeAnim',
          sourceAnchorId: 'anchorAnim',
          animConfig: anim,
        );

        expect(edge.animConfig.animate, isTrue);
        expect(edge.animConfig.animationType, 'dashFlow');
        expect(edge.animConfig.dashFlowPhase, 0.3);
        expect(edge.animConfig.dashFlowSpeed, 1.5);
      });

      test('EdgeAnimationConfig copyWith & JSON', () {
        const anim = EdgeAnimationConfig(
          animate: true,
          animationType: 'flowPulse',
          dashFlowPhase: 0.2,
        );

        final updated = anim.copyWith(
          dashFlowPhase: 0.5,
          animationSpeed: 2.0,
        );
        expect(updated.dashFlowPhase, 0.5);
        expect(updated.animationSpeed, 2.0);
        expect(updated.animationType, 'flowPulse'); // stays the same

        final json = updated.toJson();
        expect(json['dashFlowPhase'], 0.5);
        expect(json['animationSpeed'], 2.0);

        final restored = EdgeAnimationConfig.fromJson(json);
        expect(restored.dashFlowPhase, 0.5);
        expect(restored.animationSpeed, 2.0);
        expect(restored.animationType, 'flowPulse');
      });
    });
  });
}
