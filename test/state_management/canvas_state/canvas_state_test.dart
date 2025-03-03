import 'package:flutter_test/flutter_test.dart';
import 'package:flow_editor/core/state_management/canvas_state/canvas_state.dart';
import 'package:flow_editor/core/canvas/models/canvas_visual_config.dart';
import 'package:flow_editor/core/canvas/models/canvas_interaction_config.dart';
import 'package:flow_editor/core/canvas/models/canvas_interaction_mode.dart';

void main() {
  group('CanvasState Tests (Final)', () {
    late CanvasState defaultState;

    setUp(() {
      // 使用默认构造
      defaultState = const CanvasState();
    });

    group('Constructor', () {
      test('Default constructor sets correct defaults', () {
        expect(defaultState.offset, Offset.zero);
        expect(defaultState.scale, 1.0);
        expect(defaultState.mode, CanvasInteractionMode.panCanvas);
        expect(defaultState.version, 1);
        expect(defaultState.focusItemId, isNull);

        // 确保CanvasVisualConfig默认showGrid==false
        expect(defaultState.visualConfig.showGrid, false);

        // interactionConfig默认 minScale=0.1, maxScale=10.0
        expect(defaultState.interactionConfig.minScale, 0.1);
        expect(defaultState.interactionConfig.maxScale, 10.0);
      });

      test('Custom constructor sets all fields', () {
        const customState = CanvasState(
          offset: Offset(100, 100),
          scale: 2.5,
          mode: CanvasInteractionMode.multiSelect,
          version: 3,
          focusItemId: 'node-xyz',
          visualConfig: CanvasVisualConfig(showGrid: true),
          interactionConfig: CanvasInteractionConfig(
            minScale: 0.5,
            maxScale: 2.0,
            allowPan: false,
          ),
        );

        expect(customState.offset, const Offset(100, 100));
        expect(customState.scale, 2.5);
        expect(customState.mode, CanvasInteractionMode.multiSelect);
        expect(customState.version, 3);
        expect(customState.focusItemId, 'node-xyz');

        // 这里期望 true，因为自定义了
        expect(customState.visualConfig.showGrid, true);

        expect(customState.interactionConfig.minScale, 0.5);
        expect(customState.interactionConfig.maxScale, 2.0);
        expect(customState.interactionConfig.allowPan, false);
      });
    });

    group('copyWith', () {
      test('Updates only specified fields', () {
        final updated = defaultState.copyWith(
          offset: const Offset(30, 40),
          scale: 1.2,
        );

        expect(updated.offset, const Offset(30, 40));
        expect(updated.scale, 1.2);

        // 未指定的字段应保持原值
        expect(updated.mode, defaultState.mode);
        expect(updated.version, defaultState.version);
        expect(updated.focusItemId, defaultState.focusItemId);
      });

      test('Clamps scale within interactionConfig min/maxScale', () {
        const state = CanvasState(
          interactionConfig:
              CanvasInteractionConfig(minScale: 1.0, maxScale: 2.0),
        );

        // scale < 1.0 => clamp to 1.0
        final tooSmall = state.copyWith(scale: 0.5);
        expect(tooSmall.scale, 1.0);

        // scale > 2.0 => clamp to 2.0
        final tooLarge = state.copyWith(scale: 5.0);
        expect(tooLarge.scale, 2.0);
      });

      test(
          'Allows new interactionConfig, then clamps scale based on new config',
          () {
        const original = CanvasState(
          scale: 1.0,
          interactionConfig:
              CanvasInteractionConfig(minScale: 1.0, maxScale: 2.0),
        );

        final updated = original.copyWith(
          interactionConfig:
              const CanvasInteractionConfig(minScale: 0.3, maxScale: 3.0),
          scale: 0.2,
        );

        // 新配置 minScale=0.3 => 最终scale应clamp到0.3
        expect(updated.scale, 0.3);
      });

      test('copyWith does not mutate original', () {
        const original = CanvasState(offset: Offset(10, 10));
        final copied = original.copyWith(offset: const Offset(50, 50));

        expect(copied.offset, const Offset(50, 50));
        expect(original.offset, const Offset(10, 10));
      });
    });

    group('Serialization', () {
      test('toJson serializes all fields', () {
        const state = CanvasState(
          offset: Offset(12, 34),
          scale: 1.8,
          mode: CanvasInteractionMode.multiSelect,
          version: 5,
          focusItemId: 'some-node',
          visualConfig: CanvasVisualConfig(showGrid: true),
          interactionConfig: CanvasInteractionConfig(
            minScale: 0.8,
            maxScale: 1.8,
          ),
        );

        final json = state.toJson();
        expect(json['offsetX'], 12.0);
        expect(json['offsetY'], 34.0);
        expect(json['scale'], 1.8);
        expect(json['mode'], 'multiSelect');
        expect(json['version'], 5);
        expect(json['focusItemId'], 'some-node');
        expect(json['visualConfig'], isA<Map>());
        expect(json['interactionConfig'], isA<Map>());
      });

      test('fromJson restores valid fields', () {
        final jsonMap = {
          'offsetX': 50.0,
          'offsetY': 60.0,
          'scale': 2.5,
          'mode': 'editNode',
          'version': 99,
          'focusItemId': 'node-abc',
          'visualConfig': {'showGrid': true},
          'interactionConfig': {
            'minScale': 0.5,
            'maxScale': 3.0,
          }
        };

        final restored = CanvasState.fromJson(jsonMap);
        expect(restored.offset, const Offset(50, 60));
        expect(restored.scale, 2.5);
        expect(restored.mode, CanvasInteractionMode.editNode);
        expect(restored.version, 99);
        expect(restored.focusItemId, 'node-abc');
        expect(restored.visualConfig.showGrid, true);
        expect(restored.interactionConfig.minScale, 0.5);
        expect(restored.interactionConfig.maxScale, 3.0);
      });

      test('fromJson handles invalid numeric values gracefully', () {
        final jsonMap = {
          'offsetX': 'NaN',
          'offsetY': null,
          'scale': 'Infinity',
          'version': 'not_a_number',
        };

        final restored = CanvasState.fromJson(jsonMap);
        // fallback to default
        expect(restored.offset, Offset.zero);
        expect(restored.scale, 1.0);
        expect(restored.version, 1);
      });

      test('fromJson partially valid JSON', () {
        final jsonMap = {
          'offsetX': 150,
          'offsetY': 'invalid',
          'scale': 0.3,
          'mode': 'multiSelect',
        };

        final restored = CanvasState.fromJson(jsonMap);

        // offsetY 无效 => fallback=0
        expect(restored.offset, const Offset(150, 0));
        // fromJson不clamp => 仍是0.3
        expect(restored.scale, 0.3);
        expect(restored.mode, CanvasInteractionMode.multiSelect);
      });
    });
  });
}
