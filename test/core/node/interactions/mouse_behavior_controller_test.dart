import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter_test/flutter_test.dart';

// 假设以下路径为你项目实际路径，请根据需要修改
import 'package:flow_editor/core/node/interaction/mouse_behavior_controller.dart';
import 'package:flow_editor/core/node/interaction/node_interaction_controller.dart';

// 一个简单的模拟 NodeInteractionController，用来检测事件是否被触发
class MockNodeInteractionController extends NodeInteractionController {
  bool tapped = false;
  bool hovered = false;
  Offset? contextPosition;

  MockNodeInteractionController()
      : super(
          onTap: (node) => {},
          onDoubleTap: (node) => {},
          onHover: (node, isHover) => {},
          onContextMenu: (node, pos) => {},
          onDelete: (node) => {},
        );

  void handleTapTest() {
    tapped = true;
  }

  void handleHoverTest() {
    hovered = true;
  }

  void handleContextMenuTest(Offset position) {
    contextPosition = position;
  }
}

/// 一个演示用子组件，从 [MouseBehaviorController] 获取 [NodeInteractionController]，
/// 并在点击或右键时触发对应回调
class DemoChildWidget extends StatelessWidget {
  const DemoChildWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = MouseBehaviorController.of(context);

    return GestureDetector(
      onTap: () {
        if (controller is MockNodeInteractionController) {
          controller.handleTapTest();
        }
      },
      onSecondaryTapDown: (details) {
        if (controller is MockNodeInteractionController) {
          controller.handleContextMenuTest(details.localPosition);
        }
      },
      child: MouseRegion(
        onEnter: (_) {
          if (controller is MockNodeInteractionController) {
            controller.handleHoverTest();
          }
        },
        child: const Text('Demo Child'),
      ),
    );
  }
}

void main() {
  group('MouseBehaviorController Tests', () {
    testWidgets('子组件可以获取并调用 NodeInteractionController 回调',
        (WidgetTester tester) async {
      final mockController = MockNodeInteractionController();

      await tester.pumpWidget(
        MaterialApp(
          home: MouseBehaviorController(
            controller: mockController,
            child: const Scaffold(
              body: Center(
                child: DemoChildWidget(),
              ),
            ),
          ),
        ),
      );

      // 1) 检测初始状态
      expect(mockController.tapped, isFalse);
      expect(mockController.hovered, isFalse);
      expect(mockController.contextPosition, isNull);

      // 2) 模拟鼠标进入
      final textFinder = find.text('Demo Child');
      final centerPos = tester.getCenter(textFinder);
      final gesture = await tester.createGesture(kind: PointerDeviceKind.mouse);
      await gesture.moveTo(centerPos);
      await tester.pump();
      // 检查 hovered
      expect(mockController.hovered, isTrue,
          reason: 'MouseRegion onEnter should trigger handleHoverTest.');

      // 3) 模拟左键点击
      await tester.tap(textFinder);
      await tester.pump();
      expect(mockController.tapped, isTrue,
          reason: 'onTap should trigger handleTapTest in controller.');

      // 4) 模拟右键点击 (pointerDown + pointerUp with kSecondaryMouseButton)
      final rightClickPos = Offset(centerPos.dx + 1, centerPos.dy + 1);
      await tester.sendEventToBinding(PointerDownEvent(
        position: rightClickPos,
        buttons: kSecondaryMouseButton,
      ));
      await tester.pump();
      await tester.sendEventToBinding(PointerUpEvent(
        position: rightClickPos,
        buttons: kSecondaryMouseButton,
      ));
      await tester.pumpAndSettle();

      // 5) 检查 contextPosition
      // 只断言不为 null，避免因组件布局导致绝对值不一致
      expect(mockController.contextPosition, isNotNull,
          reason: 'Right-click should trigger handleContextMenuTest.');
    });
  });
}
