import 'package:flutter/material.dart';
import 'package:riverpod/riverpod.dart';

import 'package:flow_editor/v1/core/edge/edge_state/edge_state_provider.dart';
import 'package:flow_editor/v1/core/edge/models/edge_model.dart';
import 'package:flow_editor/v1/core/edge/edge_state/edge_state.dart';
import 'package:flow_editor/v1/core/edge/controllers/edge_controller_interface.dart';

/// EdgeController: 纯粹对 Edge 的增删改查、选中等操作，不再调用 Behavior。
class EdgeController implements IEdgeController {
  EdgeController({
    required ProviderContainer container,
    required this.workflowId,
  }) : _read = container.read;

  final String workflowId;

  /// 用于读/写状态的函数
  final T Function<T>(ProviderListenable<T>) _read;

  // region =========== Edge 基础操作 (增删改) ===========

  /// 创建一条新的 Edge
  @override
  void createEdge(EdgeModel newEdge) {
    _read(edgeStateProvider(workflowId).notifier).upsertEdge(newEdge);
  }

  /// 更新一条现有 Edge
  @override
  void updateEdge(EdgeModel oldEdge, EdgeModel updatedEdge) {
    if (oldEdge != updatedEdge) {
      _read(edgeStateProvider(workflowId).notifier).upsertEdge(updatedEdge);
    }
  }

  /// 删除一条 Edge，若 locked 则跳过
  @override
  void deleteEdge(String edgeId) {
    final edge = _findEdgeInState(
      edgeId,
      _read(edgeStateProvider(workflowId)),
    );
    if (edge == null || edge.locked) {
      return;
    }
    _read(edgeStateProvider(workflowId).notifier).removeEdge(edgeId);
  }

  /// 批量删除 (跳过 locked)
  @override
  void deleteEdges(List<EdgeModel> edges) {
    final deletable = edges.where((e) => !e.locked).toList();
    if (deletable.isEmpty) return;
    final ids = deletable.map((e) => e.id).toList();
    _read(edgeStateProvider(workflowId).notifier).removeEdges(ids);
  }

  // endregion

  // region =========== 选中 / 取消选中相关 ===========

  /// 选中一条 Edge
  @override
  void selectEdge(String edgeId, {bool multiSelect = false}) {
    final state = _read(edgeStateProvider(workflowId));
    final edge = _findEdgeInState(edgeId, state);
    if (edge == null) return;

    _read(edgeStateProvider(workflowId).notifier)
        .selectEdge(edgeId, multiSelect: multiSelect);
  }

  /// 取消选中一条 Edge
  @override
  void deselectEdge(String edgeId) {
    final state = _read(edgeStateProvider(workflowId));
    final edge = _findEdgeInState(edgeId, state);
    if (edge == null) return;

    _read(edgeStateProvider(workflowId).notifier).deselectEdge(edgeId);
  }

  /// 批量选中
  @override
  void selectEdges(List<String> edgeIds) {
    final notifier = _read(edgeStateProvider(workflowId).notifier);
    final state = _read(edgeStateProvider(workflowId));

    for (final eId in edgeIds) {
      final edge = _findEdgeInState(eId, state);
      if (edge != null) {
        // 用 multiSelect=true，避免覆盖已有选中
        notifier.selectEdge(eId, multiSelect: true);
      }
    }
  }

  /// 清空所有已选
  @override
  void clearSelectedEdges() {
    _read(edgeStateProvider(workflowId).notifier).clearSelection();
  }

  // endregion

  // region =========== Ghost Edge 拖拽相关 ===========

  /// 开始拖拽（创建一个临时Edge + 记录拖拽状态）
  @override
  void startEdgeDrag(EdgeModel tempEdge, Offset startPos) {
    _read(edgeStateProvider(workflowId).notifier)
        .startEdgeDrag(tempEdge, startPos);
  }

  /// 更新 Ghost Edge 的终点位置
  @override
  void updateEdgeDrag(Offset currentPos) {
    _read(edgeStateProvider(workflowId).notifier).updateEdgeDrag(currentPos);
  }

  /// 结束拖拽：若 canceled 或没 target => remove edge；否则 finalize
  @override
  void endEdgeDrag({
    required bool canceled,
    String? targetNodeId,
    String? targetAnchorId,
  }) {
    _read(edgeStateProvider(workflowId).notifier).endEdgeDrag(
      canceled: canceled,
      targetNodeId: targetNodeId,
      targetAnchorId: targetAnchorId,
    );
  }

  // endregion

  // region =========== 内部辅助 ===========

  EdgeModel? _findEdgeInState(String edgeId, EdgeState state) {
    for (final edge in state.edgesOf(workflowId)) {
      if (edge.id == edgeId) return edge;
    }
    return null;
  }

  // endregion
}
