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
  }) {
    this.read = container.read;
  }

  final EdgeBehavior behavior;
  late final T Function<T>(ProviderListenable<T>) read;

  /// 创建一条新的 Edge
  /// [workflowId]: 多工作流场景标识
  /// [newEdge]: 新的 EdgeModel
  void createEdge(String workflowId, EdgeModel newEdge) {
    behavior.onEdgeCreated(newEdge);
    read(edgeStateProvider.notifier).upsertEdge(workflowId, newEdge);
  }

  /// 更新一条现有 Edge，仅当数据有变化时才执行
  void updateEdge(String workflowId, EdgeModel oldEdge, EdgeModel updatedEdge) {
    if (oldEdge != updatedEdge) {
      behavior.onEdgeUpdated(oldEdge, updatedEdge);
      read(edgeStateProvider.notifier).upsertEdge(workflowId, updatedEdge);
    } else {
      debugPrint("No changes detected for edge ${oldEdge.id}, skipping update");
    }
  }

  /// 删除一条 Edge，locked 时不执行删除
  void deleteEdge(String workflowId, EdgeModel edge) {
    if (edge.locked) {
      debugPrint("Edge ${edge.id} is locked, skipping delete");
      return;
    }

    behavior.onEdgeDelete(edge);
    read(edgeStateProvider.notifier).removeEdge(workflowId, edge.id);
  }

  /// 选中一条 Edge
  void selectEdge(String edgeId, {bool multiSelect = false}) {
    final state = read(edgeStateProvider);
    final edge = _findEdgeInState(edgeId, state);

    if (edge == null) {
      debugPrint("Attempted to select non-existing edge $edgeId");
      return;
    }

    behavior.onEdgeSelected(edge);
    read(edgeStateProvider.notifier)
        .selectEdge(edgeId, multiSelect: multiSelect);
  }

  /// 取消选中一条 Edge
  void deselectEdge(String edgeId) {
    final state = read(edgeStateProvider);
    final edge = _findEdgeInState(edgeId, state);

    if (edge == null) {
      debugPrint("Attempted to deselect non-existing edge $edgeId");
      return;
    }

    behavior.onEdgeDeselected(edge);
    read(edgeStateProvider.notifier).deselectEdge(edgeId);
  }

  /// 辅助函数：在 state 中查找 edge
  EdgeModel? _findEdgeInState(String edgeId, EdgeState state) {
    for (final workflowEdges in state.edgesByWorkflow.values) {
      if (workflowEdges.containsKey(edgeId)) {
        return workflowEdges[edgeId];
      }
    }
    return null;
  }
}
