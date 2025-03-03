import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:flutter/material.dart';
import 'package:flow_editor/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('Node and Anchor Integration Tests', () {
    testWidgets('Anchor positions update correctly when Node is dragged',
        (WidgetTester tester) async {
      // 初始化应用
      app.main();
      await tester.pumpAndSettle();

      // 假设应用初始时，有一个已知位置的节点及anchor
      final nodeKey = const ValueKey('test_node_1');
      final anchorKey = const ValueKey('test_node_1_anchor_top');

      // 确保节点和Anchor已加载到屏幕上
      expect(find.byKey(nodeKey), findsOneWidget);
      expect(find.byKey(anchorKey), findsOneWidget);

      // 获取初始的节点与Anchor位置
      final nodeInitialRect = tester.getRect(find.byKey(nodeKey));
      final anchorInitialRect = tester.getRect(find.byKey(anchorKey));

      // 确认Anchor初始位置正确（这里以top位置举例）
      expect(
          anchorInitialRect.center.dx, closeTo(nodeInitialRect.center.dx, 1.0));
      expect(anchorInitialRect.top, closeTo(nodeInitialRect.top, 1.0));

      // 拖动节点到新位置（例如：向右下方拖动100像素）
      await tester.drag(find.byKey(nodeKey), const Offset(100, 100));
      await tester.pumpAndSettle();

      // 获取拖动后的新位置
      final nodeDraggedRect = tester.getRect(find.byKey(nodeKey));
      final anchorDraggedRect = tester.getRect(find.byKey(anchorKey));

      // 验证节点已移动
      expect(nodeDraggedRect.left, closeTo(nodeInitialRect.left + 100, 1.0));
      expect(nodeDraggedRect.top, closeTo(nodeInitialRect.top + 100, 1.0));

      // 验证Anchor位置随节点正确更新
      expect(
          anchorDraggedRect.center.dx, closeTo(nodeDraggedRect.center.dx, 1.0));
      expect(anchorDraggedRect.top, closeTo(nodeDraggedRect.top, 1.0));
    });

    testWidgets('Anchor positions remain accurate after zoom and pan',
        (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();

      final nodeKey = const ValueKey('test_node_2');
      final anchorKey = const ValueKey('test_node_2_anchor_bottom');

      expect(find.byKey(nodeKey), findsOneWidget);
      expect(find.byKey(anchorKey), findsOneWidget);

      final initialAnchorRect = tester.getRect(find.byKey(anchorKey));

      // 模拟缩放操作
      final gesture =
          await tester.startGesture(tester.getCenter(find.byType(Scaffold)));
      await gesture.moveBy(const Offset(0, -100));
      await tester.pumpAndSettle();

      // 模拟平移操作
      await tester.drag(find.byType(Scaffold), const Offset(-50, -50));
      await tester.pumpAndSettle();

      // 获取缩放平移后的Anchor位置
      final transformedAnchorRect = tester.getRect(find.byKey(anchorKey));

      // 验证Anchor的位置正确更新（根据实际的平移和缩放逻辑）
      expect(transformedAnchorRect.left, isNot(equals(initialAnchorRect.left)));
      expect(transformedAnchorRect.top, isNot(equals(initialAnchorRect.top)));

      // 若已知具体变换规则，建议使用更精准的验证（根据缩放、平移因子计算出期望值）
    });
  });
}
