import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flow_editor/core/node/models/node_model.dart';
import 'package:flow_editor/core/node/behaviors/node_behavior.dart';

/// 1. 基础版：仅包含 GestureDetector
class BaseNodeWidget extends StatelessWidget {
  final NodeModel node;
  final Widget child;
  final NodeBehavior? behavior;

  const BaseNodeWidget({
    super.key,
    required this.node,
    required this.child,
    this.behavior,
  });

  @override
  Widget build(BuildContext context) {
    // 使用 Positioned 定位节点
    return Positioned(
      left: node.x,
      top: node.y,
      width: node.width,
      height: node.height,
      child: GestureDetector(
        key: const Key('base_gesture_detector'),
        behavior: HitTestBehavior.opaque,
        onTap: () {
          debugPrint('BaseNodeWidget: onTap triggered');
          behavior?.onTap(node);
        },
        child: child,
      ),
    );
  }
}

/// 2. 悬停版：在基础版外增加 MouseRegion 处理悬停效果
class HoverNodeWidget extends StatelessWidget {
  final NodeModel node;
  final Widget child;
  final NodeBehavior? behavior;

  const HoverNodeWidget({
    super.key,
    required this.node,
    required this.child,
    this.behavior,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: node.x,
      top: node.y,
      width: node.width,
      height: node.height,
      child: MouseRegion(
        onEnter: (_) {
          debugPrint('HoverNodeWidget: mouse enter');
          behavior?.onHover(node, true);
        },
        onExit: (_) {
          debugPrint('HoverNodeWidget: mouse exit');
          behavior?.onHover(node, false);
        },
        child: GestureDetector(
          key: const Key('hover_gesture_detector'),
          behavior: HitTestBehavior.opaque,
          onTap: () {
            debugPrint('HoverNodeWidget: onTap triggered');
            behavior?.onTap(node);
          },
          child: child,
        ),
      ),
    );
  }
}

/// 3. 完整版：在悬停版基础上增加删除按钮（IconButton）
class FullNodeWidget extends StatelessWidget {
  final NodeModel node;
  final Widget child;
  final NodeBehavior? behavior;

  const FullNodeWidget({
    super.key,
    required this.node,
    required this.child,
    this.behavior,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: node.x,
      top: node.y,
      width: node.width,
      height: node.height,
      child: MouseRegion(
        onEnter: (_) {
          debugPrint('FullNodeWidget: mouse enter');
          behavior?.onHover(node, true);
        },
        onExit: (_) {
          debugPrint('FullNodeWidget: mouse exit');
          behavior?.onHover(node, false);
        },
        child: Stack(
          fit: StackFit.expand,
          clipBehavior: Clip.none,
          children: [
            GestureDetector(
              key: const Key('full_gesture_detector'),
              behavior: HitTestBehavior.opaque,
              onTap: () {
                debugPrint('FullNodeWidget: onTap triggered');
                behavior?.onTap(node);
              },
              child: child,
            ),
            // 删除按钮放在右上角（区域小，避免阻挡主要点击区域）
            Positioned(
              top: -10,
              right: -10,
              width: 24,
              height: 24,
              child: IconButton(
                key: const Key('delete_button'),
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(
                  maxWidth: 24,
                  maxHeight: 24,
                ),
                iconSize: 18,
                icon: const Icon(Icons.delete),
                onPressed: () {
                  debugPrint('FullNodeWidget: delete button pressed');
                  behavior?.onDelete(node);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// MockBehavior 实现，用于测试回调是否被触发
class _MockBehavior implements NodeBehavior {
  final void Function(NodeModel)? onTapImpl;
  final void Function(NodeModel)? onDeleteImpl;
  final void Function(NodeModel, bool)? onHoverImpl;

  _MockBehavior({this.onTapImpl, this.onDeleteImpl, this.onHoverImpl});

  @override
  void onTap(NodeModel node) => onTapImpl?.call(node);
  @override
  void onDoubleTap(NodeModel node) {}
  @override
  void onDelete(NodeModel node) => onDeleteImpl?.call(node);
  @override
  void onHover(NodeModel node, bool isHover) =>
      onHoverImpl?.call(node, isHover);
  @override
  void onContextMenu(NodeModel node, Offset position) {}
}

void main() {
  testWidgets('✅ FullNodeWidget onTap 回调触发测试', (WidgetTester tester) async {
    // 设置测试视图尺寸
    tester.view.physicalSize = const Size(400, 400);
    tester.view.devicePixelRatio = 1.0;

    bool tapped = false;

    final node = NodeModel(
      id: 'node1',
      x: 50,
      y: 100,
      width: 120,
      height: 60,
      type: 'default',
      title: 'Node Test',
      anchors: [],
    );

    final mockBehavior = _MockBehavior(
      onTapImpl: (node) {
        tapped = true;
        debugPrint('✅ onTap 触发成功, node.id=${node.id}');
      },
    );

    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: Stack(
          children: [
            // 这里使用完整版 FullNodeWidget，
            // 也可以尝试用 BaseNodeWidget 或 HoverNodeWidget 进行测试对比
            FullNodeWidget(
              node: node,
              behavior: mockBehavior,
              child: Container(
                color: Colors.blue,
                alignment: Alignment.center,
                child: const Text(
                  '点击测试',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    ));

    await tester.pumpAndSettle();

    // 使用 key 定位 FullNodeWidget 内部的 GestureDetector，然后模拟点击
    final gestureFinder = find.byKey(const Key('full_gesture_detector'));
    expect(gestureFinder, findsOneWidget);

    await tester.tap(gestureFinder);
    await tester.pumpAndSettle();

    debugPrint('点击后的 tapped 状态: $tapped');
    expect(tapped, isTrue, reason: '点击事件应成功触发 onTap 回调');
  });
}
