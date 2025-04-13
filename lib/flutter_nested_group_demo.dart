import 'package:flutter/material.dart';

void main() => runApp(
      const MaterialApp(home: Scaffold(body: CanvasWidget())),
    );

/// 节点模型：所有节点以扁平结构存储，通过 parentId 构成树
/// position 保存的是局部坐标（即相对于所在 group 内部区域的左上角）
/// 最终的绝对坐标可通过扩展方法计算
class NodeModel {
  final String id;
  final String? parentId;
  final String label;
  Offset position; // 局部布局时的坐标
  Size size; // 对于 group，由内部子节点包围盒加 padding 得到；普通节点为固定尺寸
  final bool isGroup;
  final bool isGroupRoot;

  NodeModel({
    required this.id,
    this.parentId,
    required this.label,
    required this.position,
    required this.size,
    this.isGroup = false,
    this.isGroupRoot = false,
  });
}

/// 扩展方法：递归计算节点的绝对坐标，传入整个节点列表来查找父节点
extension AbsolutePositionExtension on NodeModel {
  Offset absolutePosition(List<NodeModel> allNodes) {
    if (parentId == null) {
      return position;
    } else {
      final parent =
          allNodes.firstWhere((n) => n.id == parentId, orElse: () => this);
      return parent.absolutePosition(allNodes) + position;
    }
  }
}

/// CanvasWidget 用于展示树形节点结构
/// 主要分为两个阶段：
/// 1. 内部布局阶段：计算各 group 内部子节点的局部布局（局部坐标保持在 NodeModel.position 中）
/// 2. 渲染时调用绝对坐标扩展方法，动态计算最终的绝对位置
class CanvasWidget extends StatefulWidget {
  const CanvasWidget({super.key});
  @override
  State<CanvasWidget> createState() => _CanvasWidgetState();
}

class _CanvasWidgetState extends State<CanvasWidget> {
  final List<NodeModel> nodes = [];
  // 内部边距和节点间距，用于 group 内部布局
  final EdgeInsets groupPadding = const EdgeInsets.all(16);
  final double nodeSpacing = 12;

  @override
  void initState() {
    super.initState();
    // 示例数据：
    // 注意：顶层 group1 的 position 为绝对坐标 (100, 100)
    // 子节点 position 为局部坐标（相对于所在 group 内部区域左上角）
    nodes.addAll([
      // 顶层 group1
      NodeModel(
        id: 'group1',
        label: 'Group 1',
        position: const Offset(100, 100),
        size: Size.zero, // 待内部布局计算
        isGroup: true,
      ),
      // group1 内的 Root 节点，局部坐标 (16,16)
      NodeModel(
        id: 'root1',
        parentId: 'group1',
        label: 'Root',
        position: const Offset(16, 16),
        size: const Size(100, 40),
        isGroupRoot: true,
      ),
      // group1 内的普通节点 Node 1.1，局部坐标 (16,68)
      NodeModel(
        id: 'node11',
        parentId: 'group1',
        label: 'Node 1.1',
        position: const Offset(16, 68),
        size: const Size(100, 40),
      ),
      // group1 内的子组 group2，局部坐标 (16,120)
      NodeModel(
        id: 'group2',
        parentId: 'group1',
        label: 'SubGroup',
        position: const Offset(16, 120),
        size: const Size(150, 100), // 假设 group2 内部布局计算后的局部尺寸
        isGroup: true,
      ),
      // group2 内的普通节点 Node 2.1，局部坐标 (16,16)
      NodeModel(
        id: 'node21',
        parentId: 'group2',
        label: 'Node 2.1',
        position: const Offset(16, 16),
        size: const Size(100, 40),
      ),
      // group2 内的普通节点 Node 2.2，局部坐标 (16,68)
      NodeModel(
        id: 'node22',
        parentId: 'group2',
        label: 'Node 2.2',
        position: const Offset(16, 68),
        size: const Size(100, 40),
      ),
    ]);
  }

  @override
  Widget build(BuildContext context) {
    // 第一步：内部布局阶段
    _updateGroupLocalLayouts();
    // 第二步：在渲染时，我们不再全局修改节点位置，而是采用扩展方法计算绝对坐标
    final sorted = _getSortedByDepthFirst();

    return Container(
      color: Colors.grey.shade200,
      child: Stack(
        children: sorted.map((node) {
          // 使用扩展方法 get absolutePosition，每次动态计算
          final absPos = node.absolutePosition(nodes);
          return Positioned(
            left: absPos.dx,
            top: absPos.dy,
            child: node.isGroup ? _renderGroup(node) : _renderNode(node),
          );
        }).toList(),
      ),
    );
  }

  /////////////////////////////////////////////////
  /// 第一阶段：内部布局更新（局部坐标）         ///
  /////////////////////////////////////////////////

  /// 更新所有 group 内部布局，递归从顶层开始
  void _updateGroupLocalLayouts() {
    void layoutGroup(String? parentId) {
      for (final group
          in nodes.where((n) => n.parentId == parentId && n.isGroup)) {
        // 递归对子组布局
        layoutGroup(group.id);
        _computeGroupLocalLayout(group);
      }
    }

    layoutGroup(null);
  }

  /// 根据 group 内部子节点的局部坐标与尺寸计算包围盒，并更新 group 的局部尺寸
  void _computeGroupLocalLayout(NodeModel group) {
    final children = nodes.where((n) => n.parentId == group.id).toList();
    if (children.isEmpty) return;
    final Rect bb = _calculateBoundingBox(children);
    group.size = Size(
      bb.width + groupPadding.horizontal,
      bb.height + groupPadding.vertical,
    );
    // 此处不修改 group.position（顶层 group 的 position 已由外部指定，内部 group 的 position保持局部坐标）
  }

  Rect _calculateBoundingBox(List<NodeModel> children) {
    final left =
        children.map((n) => n.position.dx).reduce((a, b) => a < b ? a : b);
    final top =
        children.map((n) => n.position.dy).reduce((a, b) => a < b ? a : b);
    final right = children
        .map((n) => n.position.dx + n.size.width)
        .reduce((a, b) => a > b ? a : b);
    final bottom = children
        .map((n) => n.position.dy + n.size.height)
        .reduce((a, b) => a > b ? a : b);
    return Rect.fromLTRB(left, top, right, bottom);
  }

  //////////////////////////////////////////////////////
  /// 排序与渲染：深度优先遍历排序              ///
  //////////////////////////////////////////////////////
  List<NodeModel> _getSortedByDepthFirst() {
    List<NodeModel> result = [];
    void visit(String? parentId) {
      for (final node in nodes.where((n) => n.parentId == parentId)) {
        if (node.isGroup) result.add(node);
        visit(node.id);
        if (!node.isGroup) result.add(node);
      }
    }

    visit(null);
    return result;
  }

  //////////////////////////////////////////////////////
  /// 渲染组件
  //////////////////////////////////////////////////////
  Widget _renderGroup(NodeModel group) {
    return Container(
      width: group.size.width,
      height: group.size.height,
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: Colors.blue.withOpacity(0.1),
        border: Border.all(color: Colors.blue, width: 2),
      ),
      child: Text(
        group.label,
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _renderNode(NodeModel node) {
    return Container(
      width: node.size.width,
      height: node.size.height,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: node.isGroupRoot ? Colors.redAccent : Colors.orangeAccent,
        border: Border.all(color: Colors.black),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(node.label),
    );
  }
}
