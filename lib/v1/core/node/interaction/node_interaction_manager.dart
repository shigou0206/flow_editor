import 'package:flutter/material.dart';
import 'package:flow_editor/v1/core/node/models/node_model.dart';
import 'package:flow_editor/v1/core/node/behaviors/node_behavior.dart';

/// NodeInteractionManager 负责集中管理和调度节点交互事件：
/// - 多选：通过 Set<NodeModel> 追踪当前选中的节点；
/// - 切换选中：toggleNodeSelection；
/// - 批量操作（如批量删除）；
/// - 节点拖拽、移动：onNodeDrag；
/// - 置顶/置底：bringNodeToFront/sendNodeToBack；
/// - 在单选场景下，可通过 [selectedNode] 获取当前选中节点。
class NodeInteractionManager {
  /// 全局节点列表，所有节点存放在这里
  final List<NodeModel> allNodes;

  /// 追踪当前已选中的节点（支持多选）
  final Set<NodeModel> _selectedNodes = {};

  /// 返回所有选中的节点
  Set<NodeModel> get selectedNodes => _selectedNodes;

  /// 如果只选中了一个节点，或当多选时只返回集合中的第一个
  NodeModel? get selectedNode =>
      _selectedNodes.isNotEmpty ? _selectedNodes.first : null;

  NodeInteractionManager(this.allNodes);

  // =================== 选中逻辑 ===================

  /// 选中节点：如果 [multiSelect] = false，则清空已选集合再选中该节点
  void selectNode(NodeModel node, {bool multiSelect = false}) {
    if (!multiSelect) {
      _selectedNodes.clear();
    }
    _selectedNodes.add(node);
  }

  /// 切换节点选中：若已选则取消，否则选中
  void toggleNodeSelection(NodeModel node) {
    if (_selectedNodes.contains(node)) {
      _selectedNodes.remove(node);
    } else {
      _selectedNodes.add(node);
    }
  }

  /// 取消选中指定节点
  void deselectNode(NodeModel node) {
    _selectedNodes.remove(node);
  }

  /// 判断某个节点是否已被选中
  bool isNodeSelected(NodeModel node) {
    return _selectedNodes.contains(node);
  }

  /// 清空当前所有选中节点
  void clearSelection() => _selectedNodes.clear();

  /// 一次性选中 [allNodes] 中的全部节点
  void selectAll() {
    _selectedNodes.clear();
    _selectedNodes.addAll(allNodes);
  }

  // =================== 基本事件 ===================

  /// 单击事件：选中节点 + 调用 behavior.onTap
  void onNodeTap(
    NodeModel node,
    NodeBehavior behavior, {
    bool multiSelect = false,
  }) {
    selectNode(node, multiSelect: multiSelect);
    behavior.onTap(node);
  }

  /// 双击事件：默认单选 + 调用 behavior.onDoubleTap
  void onNodeDoubleTap(NodeModel node, NodeBehavior behavior) {
    selectNode(node, multiSelect: false);
    behavior.onDoubleTap(node);
  }

  /// 悬停事件：调用 behavior.onHover
  void onNodeHover(NodeModel node, NodeBehavior behavior, bool isHover) {
    behavior.onHover(node, isHover);
  }

  /// 右键点击：调用 behavior.onContextMenu
  void onNodeContextMenu(
    NodeModel node,
    NodeBehavior behavior,
    Offset position,
  ) {
    behavior.onContextMenu(node, position);
  }

  // =================== 删除逻辑 ===================

  /// 删除单个节点
  void onNodeDelete(NodeModel node, NodeBehavior behavior) {
    allNodes.remove(node);
    _selectedNodes.remove(node);
    behavior.onDelete(node);
  }

  /// 批量删除所有选中节点
  void deleteSelectedNodes(NodeBehavior behavior) {
    for (final node in _selectedNodes) {
      allNodes.remove(node);
      behavior.onDelete(node);
    }
    _selectedNodes.clear();
  }

  // =================== 拖拽/移动逻辑 ===================

  /// 当节点被拖拽移动到 [newPosition]
  void onNodeDrag(NodeModel node, Offset newPosition) {
    // 确保 node.x / node.y 可变
    node.position = newPosition;
  }

  // =================== 置顶/置底操作 ===================

  /// 将 [node] 移到列表末尾，视为置顶
  void bringNodeToFront(NodeModel node) {
    allNodes.remove(node);
    allNodes.add(node);
  }

  /// 将 [node] 移到列表开头，视为置底
  void sendNodeToBack(NodeModel node) {
    allNodes.remove(node);
    allNodes.insert(0, node);
  }
}
