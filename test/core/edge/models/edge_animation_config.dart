// test/core/edge/models/edge_animation_config_test.dart

import 'package:flutter_test/flutter_test.dart';
import 'package:flow_editor/core/edge/models/edge_animation_config.dart';

void main() {
  group('EdgeAnimationConfig Tests', () {
    test('Default values are correct', () {
      const config = EdgeAnimationConfig();

      expect(config.animate, false);
      expect(config.animationType, null);
      expect(config.animationSpeed, null);
      expect(config.animationPhase, null);
      expect(config.animationColorHex, null);
      expect(config.animateDash, false);
      expect(config.dashFlowPhase, null);
      expect(config.dashFlowSpeed, null);
    });

    test('Initialization with provided values', () {
      const config = EdgeAnimationConfig(
        animate: true,
        animationType: 'flowPulse',
        animationSpeed: 2.5,
        animationPhase: 0.75,
        animationColorHex: '#FF0000',
        animateDash: true,
        dashFlowPhase: 0.2,
        dashFlowSpeed: 1.5,
      );

      expect(config.animate, true);
      expect(config.animationType, 'flowPulse');
      expect(config.animationSpeed, 2.5);
      expect(config.animationPhase, 0.75);
      expect(config.animationColorHex, '#FF0000');
      expect(config.animateDash, true);
      expect(config.dashFlowPhase, 0.2);
      expect(config.dashFlowSpeed, 1.5);
    });

    test('copyWith correctly updates fields', () {
      const original = EdgeAnimationConfig(
        animate: true,
        animationType: 'flowPulse',
      );

      final updated = original.copyWith(
        animationSpeed: 5.0,
        animateDash: true,
      );

      expect(updated.animate, true);
      expect(updated.animationType, 'flowPulse');
      expect(updated.animationSpeed, 5.0);
      expect(updated.animateDash, true);

      // 其他未更新字段应保持不变
      expect(updated.animationPhase, null);
      expect(updated.animationColorHex, null);
      expect(updated.dashFlowPhase, null);
      expect(updated.dashFlowSpeed, null);
    });

    test('toJson and fromJson correctly serialize and deserialize', () {
      const config = EdgeAnimationConfig(
        animate: true,
        animationType: 'dashBlink',
        animationSpeed: 1.2,
        animationPhase: 0.4,
        animationColorHex: '#00FF00',
        animateDash: true,
        dashFlowPhase: 0.3,
        dashFlowSpeed: 2.5,
      );

      final json = config.toJson();
      expect(json['animate'], true);
      expect(json['animationType'], 'dashBlink');
      expect(json['animationSpeed'], 1.2);
      expect(json['animationPhase'], 0.4);
      expect(json['animationColorHex'], '#00FF00');
      expect(json['animateDash'], true);
      expect(json['dashFlowPhase'], 0.3);
      expect(json['dashFlowSpeed'], 2.5);

      final deserialized = EdgeAnimationConfig.fromJson(json);
      expect(deserialized.animate, true);
      expect(deserialized.animationType, 'dashBlink');
      expect(deserialized.animationSpeed, 1.2);
      expect(deserialized.animationPhase, 0.4);
      expect(deserialized.animationColorHex, '#00FF00');
      expect(deserialized.animateDash, true);
      expect(deserialized.dashFlowPhase, 0.3);
      expect(deserialized.dashFlowSpeed, 2.5);
    });

    test('fromJson handles missing fields gracefully', () {
      final json = <String, dynamic>{'animate': true};
      final config = EdgeAnimationConfig.fromJson(json);

      expect(config.animate, true);
      expect(config.animationType, null);
      expect(config.animationSpeed, null);
      expect(config.animateDash, false);
      expect(config.dashFlowPhase, null);
    });
  });
}
