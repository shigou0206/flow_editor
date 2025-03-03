import 'package:flutter/material.dart';
import 'package:riverpod/riverpod.dart';

import '../../state_management/edge_state/edge_state_provider.dart';
import '../behaviors/edge_behavior.dart';
import '../models/edge_model.dart';
import '../../state_management/edge_state/edge_state.dart';

/// EdgeController: 提供对 Edge 的高层操作 (create, update, delete, select等)，
/// 并调用 [EdgeBehavior] 和 [EdgeStateNotifier] 做实际处理。
class EdgeController {
  EdgeController({
    required ProviderContainer container,
    required this.behavior,
    required this.workflowId,
  }) : _read = container.read;

  final EdgeBehavior behavior;
  final String workflowId;

  /// 用于读/写状态的函数
  final T Function<T>(ProviderListenable<T>) _read;

  // region =========== Edge 基础操作 (增删改) ===========

  /// 创建一条新的 Edge
  void createEdge(EdgeModel newEdge) {
    behavior.onEdgeCreated(newEdge);
    _read(edgeStateProvider(workflowId).notifier).upsertEdge(newEdge);
  }

  /// 更新一条现有 Edge
  void updateEdge(EdgeModel oldEdge, EdgeModel updatedEdge) {
    if (oldEdge != updatedEdge) {
      behavior.onEdgeUpdated(oldEdge, updatedEdge);
      _read(edgeStateProvider(workflowId).notifier).upsertEdge(updatedEdge);
    } else {
      debugPrint("[EdgeController] No changes for edge ${oldEdge.id}, skip");
    }
  }

  /// 删除一条 Edge，若 locked 则跳过
  void deleteEdge(EdgeModel edge) {
    if (edge.locked) {
      debugPrint("[EdgeController] Edge ${edge.id} locked, skip delete");
      return;
    }
    behavior.onEdgeDelete(edge);
    _read(edgeStateProvider(workflowId).notifier).removeEdge(edge.id);
  }

  /// 批量删除 (跳过 locked)
  void deleteEdges(List<EdgeModel> edges) {
    final deletable = edges.where((e) => !e.locked).toList();
    for (final edge in deletable) {
      behavior.onEdgeDelete(edge);
    }
    final ids = deletable.map((e) => e.id).toList();
    _read(edgeStateProvider(workflowId).notifier).removeEdges(ids);
  }

  // endregion

  // region =========== 选中 / 取消选中相关 ===========

  /// 选中一条 Edge
  void selectEdge(String edgeId, {bool multiSelect = false}) {
    final state = _read(edgeStateProvider(workflowId));
    final edge = _findEdgeInState(edgeId, state);
    if (edge == null) {
      debugPrint("[EdgeController] selectEdge: Edge $edgeId not found");
      return;
    }

    behavior.onEdgeSelected(edge);
    _read(edgeStateProvider(workflowId).notifier)
        .selectEdge(edgeId, multiSelect: multiSelect);
  }

  /// 取消选中一条 Edge
  void deselectEdge(String edgeId) {
    final state = _read(edgeStateProvider(workflowId));
    final edge = _findEdgeInState(edgeId, state);
    if (edge == null) {
      debugPrint("[EdgeController] deselectEdge: Edge $edgeId not found");
      return;
    }

    behavior.onEdgeDeselected(edge);
    _read(edgeStateProvider(workflowId).notifier).deselectEdge(edgeId);
  }

  /// 批量选中
  void selectEdges(List<String> edgeIds) {
    final notifier = _read(edgeStateProvider(workflowId).notifier);
    final state = _read(edgeStateProvider(workflowId));

    for (final eId in edgeIds) {
      final edge = _findEdgeInState(eId, state);
      if (edge != null) {
        behavior.onEdgeSelected(edge);
        // 用 multiSelect=true，避免覆盖已有选中
        notifier.selectEdge(eId, multiSelect: true);
      } else {
        debugPrint("[EdgeController] selectEdges: Edge $eId not found");
      }
    }
  }

  /// 清空所有已选
  void clearSelectedEdges() {
    _read(edgeStateProvider(workflowId).notifier).clearSelection();
  }

  // endregion

  // region =========== Ghost Edge 拖拽相关 ===========

  /// 开始拖拽（创建一个临时Edge + 记录拖拽状态）
  void startEdgeDrag(EdgeModel tempEdge, Offset startPos) {
    // 也可区分 onEdgeDragStart(...)，视需求而定
    behavior.onEdgeCreated(tempEdge);
    _read(edgeStateProvider(workflowId).notifier)
        .startEdgeDrag(tempEdge, startPos);
  }

  /// 更新 Ghost Edge 的终点位置
  void updateEdgeDrag(Offset currentPos) {
    _read(edgeStateProvider(workflowId).notifier).updateEdgeDrag(currentPos);
  }

  /// 结束拖拽：若 canceled 或没 target => remove edge；否则 finalize
  void endEdgeDrag({
    required bool canceled,
    String? targetNodeId,
    String? targetAnchorId,
  }) {
    // 这里也可做：behavior.onEdgeDragEnd(...)
    _read(edgeStateProvider(workflowId).notifier).endEdgeDrag(
      canceled: canceled,
      targetNodeId: targetNodeId,
      targetAnchorId: targetAnchorId,
    );
  }

  // endregion

  // region =========== 内部辅助 ===========

  EdgeModel? _findEdgeInState(String edgeId, EdgeState state) {
    return state.edgesOf(workflowId)[edgeId];
  }

  // endregion
}
