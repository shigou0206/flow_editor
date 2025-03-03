import 'package:flutter_test/flutter_test.dart';
import 'package:flow_editor/core/edge/models/edge_line_style.dart';
import 'package:flow_editor/core/edge/models/edge_enums.dart';

void main() {
  group('EdgeLineStyle', () {
    test('Default values should be correctly initialized', () {
      const style = EdgeLineStyle();

      expect(style.colorHex, '#000000');
      expect(style.strokeWidth, 1.0);
      expect(style.dashPattern, []);
      expect(style.arrowStart, ArrowType.none);
      expect(style.arrowEnd, ArrowType.none);
      expect(style.arrowSize, 1.0);
      expect(style.arrowAngleDeg, 30);
    });

    test('copyWith updates the specified fields', () {
      const style = EdgeLineStyle(
        colorHex: '#ff0000',
        strokeWidth: 2.0,
        dashPattern: [5, 2],
        arrowStart: ArrowType.triangle,
        arrowEnd: ArrowType.diamond,
        arrowSize: 8.0,
        arrowAngleDeg: 30,
      );

      final updatedStyle = style.copyWith(
        strokeWidth: 3.5,
        arrowEnd: ArrowType.none,
      );

      expect(updatedStyle.colorHex, '#ff0000'); // unchanged
      expect(updatedStyle.strokeWidth, 3.5); // updated
      expect(updatedStyle.dashPattern, [5, 2]); // unchanged
      expect(updatedStyle.arrowStart, ArrowType.triangle); // unchanged
      expect(updatedStyle.arrowEnd, ArrowType.none); // updated
      expect(updatedStyle.arrowSize, 8.0); // unchanged
      expect(updatedStyle.arrowAngleDeg, 30); // unchanged
    });

    test('toJson and fromJson serialize correctly', () {
      const style = EdgeLineStyle(
        colorHex: '#abcdef',
        strokeWidth: 4.0,
        dashPattern: [10, 5],
        arrowStart: ArrowType.diamond,
        arrowEnd: ArrowType.triangle,
        arrowSize: 10.0,
        arrowAngleDeg: 45,
      );

      final json = style.toJson();
      final restored = EdgeLineStyle.fromJson(json);

      expect(restored, equals(style));
    });
  });
}
