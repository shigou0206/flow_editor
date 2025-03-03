// file: edge_interaction_manager.dart

import 'package:flutter/material.dart';
import 'package:riverpod/riverpod.dart';

import '../../state_management/edge_state/edge_state_provider.dart';
import '../behaviors/edge_behavior.dart';
import 'edge_controller.dart';

/// EdgeInteractionManager: 处理画布层面检测到的事件（点击/双击/右键/拖拽端点/悬停），
/// 并与 [EdgeController] / [EdgeBehavior] 配合进行实际业务逻辑和状态更新。
class EdgeInteractionManager {
  final EdgeController edgeController;
  final Ref ref;

  /// 可选：若 EdgeController 内已经有 behavior, 这里可以不再单独存 behavior
  final EdgeBehavior? behavior;

  EdgeInteractionManager({
    required this.edgeController,
    required this.ref,
    this.behavior,
  });

  /// 当用户点击某条边
  void onEdgeTap(String workflowId, String edgeId, Offset localPos) {
    final state = ref.read(edgeStateProvider);
    final edge = state.edgesOf(workflowId)[edgeId];
    if (edge == null) return;

    // 若你想先调用 Behavior, 再让 EdgeController 做选中
    behavior?.onEdgeTap(edge, localPos: localPos);

    // 也可考虑 doubleTap detection
    edgeController.selectEdge(edgeId, multiSelect: false);
  }

  /// 当用户双击某条边
  void onEdgeDoubleTap(String workflowId, String edgeId, Offset localPos) {
    final state = ref.read(edgeStateProvider);
    final edge = state.edgesOf(workflowId)[edgeId];
    if (edge == null) return;

    behavior?.onEdgeDoubleTap(edge, localPos: localPos);
    // 可能你要切换编辑模式, or do something
  }

  /// 当用户右键(上下文菜单)
  void onEdgeContextMenu(String workflowId, String edgeId, Offset localPos) {
    final state = ref.read(edgeStateProvider);
    final edge = state.edgesOf(workflowId)[edgeId];
    if (edge == null) return;

    behavior?.onEdgeContextMenu(edge, localPos);
    // 是否要做 anything with edgeController?
  }

  /// 当用户删除某条边(比如键盘 delete)
  void onEdgeDelete(String workflowId, String edgeId) {
    final state = ref.read(edgeStateProvider);
    final edge = state.edgesOf(workflowId)[edgeId];
    if (edge == null) return;

    behavior?.onEdgeDelete(edge);
    // 由EdgeController去执行真正删除 => onEdgeCreated, ...
    edgeController.deleteEdge(workflowId, edge);
  }

  /// 当用户拖拽边的源或目标端点
  void onDragEdgeEndpoint({
    required String workflowId,
    required String edgeId,
    required bool isSourceSide,
    required String newNodeId,
    required String newAnchorId,
  }) {
    final state = ref.read(edgeStateProvider);
    final edge = state.edgesOf(workflowId)[edgeId];
    if (edge == null) return;

    behavior?.onEdgeEndpointDrag(edge, isSourceSide, newNodeId, newAnchorId);

    // 自行构建 updatedEdge
    final updatedEdge = isSourceSide
        ? edge.copyWith(sourceNodeId: newNodeId, sourceAnchorId: newAnchorId)
        : edge.copyWith(targetNodeId: newNodeId, targetAnchorId: newAnchorId);

    // 用 controller.updateEdge => 触发 onEdgeUpdated
    edgeController.updateEdge(workflowId, edge, updatedEdge);
  }

  /// 当用户在某条边上悬停
  void onEdgeHover(String workflowId, String edgeId, bool isHover) {
    final edge = ref.read(edgeStateProvider).edgesOf(workflowId)[edgeId];
    if (edge == null) return;

    behavior?.onEdgeHover(edge, isHover);
  }
}
