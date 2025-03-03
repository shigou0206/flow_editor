import 'package:flutter_test/flutter_test.dart';
import 'package:flow_editor/core/node/models/node_model.dart';
import 'package:flow_editor/core/node/interaction/node_interaction_controller.dart';

/// 一个模拟的 NodeBehavior，用于测试 NodeInteractionController 是否正确调用各个回调。
class MockNodeBehavior {
  bool onTapCalled = false;
  bool onDoubleTapCalled = false;
  bool onHoverCalled = false;
  bool onContextMenuCalled = false;
  bool onDeleteCalled = false;

  void onTap(NodeModel node) => onTapCalled = true;
  void onDoubleTap(NodeModel node) => onDoubleTapCalled = true;
  void onHover(NodeModel node, bool isHover) => onHoverCalled = true;
  void onContextMenu(NodeModel node, Offset position) =>
      onContextMenuCalled = true;
  void onDelete(NodeModel node) => onDeleteCalled = true;
}

void main() {
  group('NodeInteractionController Tests', () {
    late NodeInteractionController controller;
    late MockNodeBehavior mockBehavior;
    late NodeModel node;

    setUp(() {
      // 创建一个 MockNodeBehavior 以捕获方法调用
      mockBehavior = MockNodeBehavior();
      // 设定一个测试节点
      node = NodeModel(
        id: 'test-node',
        x: 0,
        y: 0,
        width: 100,
        height: 50,
        type: 'default',
        title: 'Test Node',
        anchors: [],
      );

      // 初始化 NodeInteractionController 并绑定 MockNodeBehavior 方法
      controller = NodeInteractionController(
        onTap: mockBehavior.onTap,
        onDoubleTap: mockBehavior.onDoubleTap,
        onHover: mockBehavior.onHover,
        onContextMenu: mockBehavior.onContextMenu,
        onDelete: mockBehavior.onDelete,
      );
    });

    test('onTap 事件被正确转发给 NodeBehavior', () {
      controller.handleTap(node);
      expect(mockBehavior.onTapCalled, isTrue, reason: '应该调用 onTap 方法');
    });

    test('onDoubleTap 事件被正确转发给 NodeBehavior', () {
      controller.handleDoubleTap(node);
      expect(mockBehavior.onDoubleTapCalled, isTrue,
          reason: '应该调用 onDoubleTap 方法');
    });

    test('onHover 事件被正确转发给 NodeBehavior', () {
      controller.handleHover(node, true);
      expect(mockBehavior.onHoverCalled, isTrue, reason: '应该调用 onHover 方法');
    });

    test('onContextMenu 事件被正确转发给 NodeBehavior', () {
      controller.handleContextMenu(node, const Offset(10, 10));
      expect(mockBehavior.onContextMenuCalled, isTrue,
          reason: '应该调用 onContextMenu 方法');
    });

    test('onDelete 事件被正确转发给 NodeBehavior', () {
      controller.handleDelete(node);
      expect(mockBehavior.onDeleteCalled, isTrue, reason: '应该调用 onDelete 方法');
    });

    test('copyWith 可复制并覆盖部分回调', () {
      // 创建一个新的回调，用于覆盖 onTap
      bool newTapCalled = false;
      void newOnTap(NodeModel node) => newTapCalled = true;

      // 使用 copyWith 生成新的控制器
      final newController = controller.copyWith(onTap: newOnTap);

      // 调用原控制器，应该只调用原 onTap
      controller.handleTap(node);
      expect(mockBehavior.onTapCalled, isTrue);
      expect(newTapCalled, isFalse);

      // 调用新控制器，应该只调用 newOnTap
      newController.handleTap(node);
      expect(newTapCalled, isTrue, reason: '新的 onTap 方法应该被调用');
    });
  });
}
