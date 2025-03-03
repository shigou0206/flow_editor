import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:flow_editor/core/anchor/models/anchor_model.dart';
import 'package:flow_editor/core/anchor/models/anchor_enums.dart';
import 'package:flow_editor/core/types/position_enum.dart';
import 'package:flow_editor/core/anchor/painter/anchor_painter.dart';

void main() {
  group('AnchorPainter Golden Tests', () {
    final anchorSize = const Size(40, 40);

    Future<void> _pumpAnchorPainter(
      WidgetTester tester,
      AnchorModel anchor, {
      bool isHover = false,
      bool isSelected = false,
    }) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Center(
              child: CustomPaint(
                key: const Key('anchor_painter'), // 明确指定Key
                size: anchorSize,
                painter: AnchorPainter(
                  anchor: anchor,
                  isHover: isHover,
                  isSelected: isSelected,
                ),
              ),
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();
    }

    testWidgets('renders circle shape anchor correctly', (tester) async {
      final anchor = AnchorModel(
        id: 'anchor_circle',
        nodeId: 'node1',
        position: Position.top,
        shape: AnchorShape.circle,
        plusButtonColorHex: '#FF0000', // 红色
      );

      await _pumpAnchorPainter(tester, anchor);
      await expectLater(
        find.byKey(const Key('anchor_painter')),
        matchesGoldenFile('goldens/anchor_circle.png'),
      );
    });

    testWidgets('renders square shape anchor with hover state', (tester) async {
      final anchor = AnchorModel(
        id: 'anchor_square_hover',
        nodeId: 'node1',
        position: Position.right,
        shape: AnchorShape.square,
        plusButtonColorHex: '#00FF00', // 绿色
      );

      await _pumpAnchorPainter(tester, anchor, isHover: true);
      await expectLater(
        find.byKey(const Key('anchor_painter')),
        matchesGoldenFile('goldens/anchor_square_hover.png'),
      );
    });

    testWidgets('renders diamond shape anchor locked state', (tester) async {
      final anchor = AnchorModel(
        id: 'anchor_diamond_locked',
        nodeId: 'node1',
        position: Position.bottom,
        shape: AnchorShape.diamond,
        locked: true,
      );

      await _pumpAnchorPainter(tester, anchor);
      await expectLater(
        find.byKey(const Key('anchor_painter')),
        matchesGoldenFile('goldens/anchor_diamond_locked.png'),
      );
    });

    testWidgets('renders custom shape anchor selected', (tester) async {
      final anchor = AnchorModel(
        id: 'anchor_custom_selected',
        nodeId: 'node1',
        position: Position.left,
        shape: AnchorShape.custom,
        plusButtonColorHex: '#0000FF', // 蓝色
      );

      await _pumpAnchorPainter(tester, anchor, isSelected: true);
      await expectLater(
        find.byKey(const Key('anchor_painter')),
        matchesGoldenFile('goldens/anchor_custom_selected.png'),
      );
    });
  });
}
