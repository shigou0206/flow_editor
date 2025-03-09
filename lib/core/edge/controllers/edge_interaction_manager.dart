import 'package:flutter/material.dart';
import 'package:riverpod/riverpod.dart';

import 'package:flow_editor/core/edge/edge_state/edge_state_provider.dart';
import 'package:flow_editor/core/edge/behaviors/edge_behavior.dart';
import 'package:flow_editor/core/edge/controllers/edge_controller.dart';
import 'package:flow_editor/core/edge/models/edge_model.dart';

/// EdgeInteractionManager: 专门处理「画布层面检测到的事件」：
/// 点击/双击/右键/拖拽端点/悬停等；
/// - 在合适时机调用 [EdgeController] 完成实际的增删改/选中等
/// - 同时也可调用 [EdgeBehavior] 做自定义回调
class EdgeInteractionManager {
  EdgeInteractionManager({
    required this.edgeController,
    required this.ref,
    this.behavior,
  });

  final EdgeController edgeController;

  /// 如果需要直接读取 EdgeState，也可以用这个 ref
  final Ref ref;

  /// 可选：若 [EdgeController] 内已有 behavior，可不再单独存
  final EdgeBehavior? behavior;

  // region =========== 事件处理 ===========

  /// 当用户点击某条边
  void onEdgeTap(String workflowId, String edgeId, Offset localPos) {
    final edge = _getEdge(workflowId, edgeId);
    if (edge == null) return;

    // 若需要行为回调
    behavior?.onEdgeTap(edge, localPos: localPos);

    // 调用 EdgeController 做选中
    edgeController.selectEdge(edgeId, multiSelect: false);
  }

  /// 当用户双击某条边
  void onEdgeDoubleTap(String workflowId, String edgeId, Offset localPos) {
    final edge = _getEdge(workflowId, edgeId);
    if (edge == null) return;

    behavior?.onEdgeDoubleTap(edge, localPos: localPos);
    // 其他操作，比如进入编辑模式
  }

  /// 当用户右键（上下文菜单）
  void onEdgeContextMenu(String workflowId, String edgeId, Offset localPos) {
    final edge = _getEdge(workflowId, edgeId);
    if (edge == null) return;

    behavior?.onEdgeContextMenu(edge, localPos);
    // 可能弹出菜单等
  }

  /// 当用户删除某条边（键盘delete）
  void onEdgeDelete(String workflowId, String edgeId) {
    final edge = _getEdge(workflowId, edgeId);
    if (edge == null) return;

    // 回调
    behavior?.onEdgeDelete(edge);
    // 删除
    edgeController.deleteEdge(edgeId);
  }

  /// 当用户拖拽边端点(源 or 目标)以重新连到别的node/anchor
  void onDragEdgeEndpoint({
    required String workflowId,
    required String edgeId,
    required bool isSourceSide,
    required String newNodeId,
    required String newAnchorId,
  }) {
    final edge = _getEdge(workflowId, edgeId);
    if (edge == null) return;

    behavior?.onEdgeEndpointDrag(edge, isSourceSide, newNodeId, newAnchorId);

    // 构建更新后的 edge
    final updated = isSourceSide
        ? edge.copyWith(sourceNodeId: newNodeId, sourceAnchorId: newAnchorId)
        : edge.copyWith(targetNodeId: newNodeId, targetAnchorId: newAnchorId);

    // 用 EdgeController 更新
    edgeController.updateEdge(edge, updated);
  }

  /// 当用户在某条边上悬停
  void onEdgeHover(String workflowId, String edgeId, bool isHover) {
    final edge = _getEdge(workflowId, edgeId);
    if (edge == null) return;

    behavior?.onEdgeHover(edge, isHover);
    // 显示 tooltip / 高亮等
  }

  // endregion

  // region =========== 内部辅助 ===========

  EdgeModel? _getEdge(String workflowId, String edgeId) {
    final state = ref.read(edgeStateProvider(workflowId));
    return state.edgesOf(workflowId)[edgeId];
  }

  // endregion
}
