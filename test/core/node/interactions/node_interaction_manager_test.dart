import 'package:flutter_test/flutter_test.dart';

// 请根据你项目的实际结构修改以下导入
import 'package:flow_editor/core/node/models/node_model.dart';
import 'package:flow_editor/core/node/behaviors/node_behavior.dart';
import 'package:flow_editor/core/node/interaction/node_interaction_manager.dart';

/// 一个简单的 MockBehavior 用来跟踪回调是否被调用
class MockBehavior implements NodeBehavior {
  bool tapped = false;
  bool doubleTapped = false;
  bool hoveredEnter = false;
  bool hoveredExit = false;
  bool contextMenuCalled = false;
  bool deleted = false;

  @override
  void onTap(NodeModel node) => tapped = true;

  @override
  void onDoubleTap(NodeModel node) => doubleTapped = true;

  @override
  void onHover(NodeModel node, bool isHover) {
    if (isHover) {
      hoveredEnter = true;
    } else {
      hoveredExit = true;
    }
  }

  @override
  void onContextMenu(NodeModel node, Offset position) {
    contextMenuCalled = true;
  }

  @override
  void onDelete(NodeModel node) => deleted = true;
}

void main() {
  group('NodeInteractionManager Tests', () {
    late NodeInteractionManager manager;
    late MockBehavior mockBehavior;
    late NodeModel nodeA;
    late NodeModel nodeB;

    setUp(() {
      mockBehavior = MockBehavior();

      // 准备一些节点数据
      nodeA = NodeModel(
        id: 'nodeA',
        x: 0,
        y: 0,
        width: 100,
        height: 50,
        type: 'default',
        title: 'Node A',
        anchors: [],
      );
      nodeB = NodeModel(
        id: 'nodeB',
        x: 200,
        y: 100,
        width: 150,
        height: 60,
        type: 'default',
        title: 'Node B',
        anchors: [],
      );

      // 创建 manager 并传入全局节点列表
      manager = NodeInteractionManager([nodeA, nodeB]);
    });

    test('初始状态', () {
      // 默认没有选中节点
      expect(manager.selectedNodes, isEmpty);
      expect(manager.selectedNode, isNull);
      // allNodes 中应包含 nodeA 与 nodeB
      expect(manager.allNodes.length, 2);
    });

    test('selectNode (单选)', () {
      // 选中 nodeA
      manager.selectNode(nodeA, multiSelect: false);
      expect(manager.selectedNodes.length, 1);
      expect(manager.selectedNode, nodeA);

      // 再选中 nodeB，应清空之前的，再选中 nodeB
      manager.selectNode(nodeB, multiSelect: false);
      expect(manager.selectedNodes.length, 1);
      expect(manager.selectedNode, nodeB);
    });

    test('selectNode (多选)', () {
      // 先选中 nodeA
      manager.selectNode(nodeA, multiSelect: false);
      // 再选中 nodeB，multiSelect = true
      manager.selectNode(nodeB, multiSelect: true);
      expect(manager.selectedNodes.length, 2);
      expect(manager.selectedNodes.contains(nodeA), isTrue);
      expect(manager.selectedNodes.contains(nodeB), isTrue);
    });

    test('toggleNodeSelection', () {
      // 先 toggle nodeA (选中)
      manager.toggleNodeSelection(nodeA);
      expect(manager.selectedNodes.contains(nodeA), isTrue);

      // 再 toggle nodeA (取消选中)
      manager.toggleNodeSelection(nodeA);
      expect(manager.selectedNodes.contains(nodeA), isFalse);
    });

    test('deselectNode', () {
      manager.selectNode(nodeA);
      manager.selectNode(nodeB, multiSelect: true);
      expect(manager.selectedNodes.length, 2);

      // 取消选中 nodeA
      manager.deselectNode(nodeA);
      expect(manager.selectedNodes.length, 1);
      expect(manager.selectedNodes.contains(nodeB), isTrue);
    });

    test('isNodeSelected', () {
      manager.selectNode(nodeA);
      expect(manager.isNodeSelected(nodeA), isTrue);
      expect(manager.isNodeSelected(nodeB), isFalse);
    });

    test('clearSelection', () {
      manager.selectNode(nodeA);
      manager.selectNode(nodeB, multiSelect: true);
      expect(manager.selectedNodes.length, 2);

      manager.clearSelection();
      expect(manager.selectedNodes, isEmpty);
      expect(manager.selectedNode, isNull);
    });

    test('selectAll', () {
      manager.selectAll();
      expect(manager.selectedNodes.length, 2);
      expect(manager.selectedNodes.containsAll([nodeA, nodeB]), isTrue);
    });

    test('onNodeTap', () {
      manager.onNodeTap(nodeA, mockBehavior);
      // 应选中 nodeA
      expect(manager.selectedNode, nodeA);
      // behavior.onTap 被调用
      expect(mockBehavior.tapped, isTrue);
    });

    test('onNodeDoubleTap', () {
      manager.onNodeDoubleTap(nodeB, mockBehavior);
      // 应选中 nodeB
      expect(manager.selectedNode, nodeB);
      // behavior.onDoubleTap 被调用
      expect(mockBehavior.doubleTapped, isTrue);
    });

    test('onNodeHover', () {
      manager.onNodeHover(nodeA, mockBehavior, true);
      expect(mockBehavior.hoveredEnter, isTrue);

      manager.onNodeHover(nodeA, mockBehavior, false);
      expect(mockBehavior.hoveredExit, isTrue);
    });

    test('onNodeContextMenu', () {
      manager.onNodeContextMenu(nodeA, mockBehavior, const Offset(50, 50));
      expect(mockBehavior.contextMenuCalled, isTrue);
    });

    test('onNodeDelete', () {
      manager.selectNode(nodeA);
      manager.onNodeDelete(nodeA, mockBehavior);
      // nodeA 应被移出 allNodes
      expect(manager.allNodes.contains(nodeA), isFalse);
      // 选中集合里也应移除
      expect(manager.selectedNodes.contains(nodeA), isFalse);
      // behavior.onDelete 被调用
      expect(mockBehavior.deleted, isTrue);
    });

    test('deleteSelectedNodes', () {
      manager.selectNode(nodeA);
      manager.selectNode(nodeB, multiSelect: true);
      expect(manager.selectedNodes.length, 2);

      manager.deleteSelectedNodes(mockBehavior);
      // allNodes 应变为空
      expect(manager.allNodes.isEmpty, isTrue);
      // 选中集合应变为空
      expect(manager.selectedNodes.isEmpty, isTrue);
      // behavior.onDelete 被调用
      expect(mockBehavior.deleted, isTrue);
    });

    test('onNodeDrag', () {
      // 移动 nodeA 到 (100, 200)
      manager.onNodeDrag(nodeA, const Offset(100, 200));
      expect(nodeA.x, 100);
      expect(nodeA.y, 200);
    });

    test('bringNodeToFront', () {
      // manager.allNodes 初始为 [nodeA, nodeB]
      manager.bringNodeToFront(nodeA);
      // bring nodeA to front, nodeB 在前，所以 nodeA 应放到末尾
      expect(manager.allNodes.last, nodeA);
    });

    test('sendNodeToBack', () {
      // manager.allNodes 初始为 [nodeA, nodeB]
      manager.sendNodeToBack(nodeB);
      // send nodeB to back => nodeB 应放到索引 0
      expect(manager.allNodes.first, nodeB);
    });
  });
}
