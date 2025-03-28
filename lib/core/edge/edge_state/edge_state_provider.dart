import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flow_editor/core/edge/edge_state/edge_state.dart';
import 'package:flow_editor/core/edge/models/edge_model.dart';

class EdgeStateNotifier extends StateNotifier<EdgeState> {
  final String workflowId;

  EdgeStateNotifier({required this.workflowId}) : super(const EdgeState());

  // --- Edge 增删改 ---

  void upsertEdge(EdgeModel edge) {
    final oldList = state.edgesOf(workflowId);
    final updatedList = [
      ...oldList.where((e) => e.id != edge.id),
      edge,
    ];
    state = state.updateWorkflowEdges(workflowId, updatedList);
  }

  void removeEdge(String edgeId) {
    final oldList = state.edgesOf(workflowId);
    final updatedList = oldList.where((e) => e.id != edgeId).toList();
    if (updatedList.length != oldList.length) {
      state = state.updateWorkflowEdges(workflowId, updatedList);
    }
  }

  void removeEdgesOfNode(String nodeId) {
    final oldList = state.edgesOf(workflowId);
    final updatedList = oldList
        .where((e) => e.sourceNodeId != nodeId && e.targetNodeId != nodeId)
        .toList();
    if (updatedList.length != oldList.length) {
      state = state.updateWorkflowEdges(workflowId, updatedList);
    }
  }

  void setWorkflowEdges(List<EdgeModel> edges) {
    state = state.updateWorkflowEdges(workflowId, edges);
  }

  void removeWorkflow() {
    state = state.removeWorkflow(workflowId);
  }

  // --- Edge 选中相关 ---

  void toggleSelectEdge(String edgeId) {
    final newSet = Set.of(state.selectedEdgeIds);
    if (newSet.contains(edgeId)) {
      newSet.remove(edgeId);
    } else {
      newSet.add(edgeId);
    }
    state = state.copyWith(selectedEdgeIds: newSet);
  }

  void selectEdge(String edgeId, {bool multiSelect = false}) {
    final newSet = multiSelect ? Set.of(state.selectedEdgeIds) : <String>{};
    newSet.add(edgeId);
    state = state.copyWith(selectedEdgeIds: newSet);
  }

  void deselectEdge(String edgeId) {
    final newSet = Set.of(state.selectedEdgeIds);
    newSet.remove(edgeId);
    state = state.copyWith(selectedEdgeIds: newSet);
  }

  void clearSelection() {
    state = state.copyWith(selectedEdgeIds: {});
  }

  // --- 拖拽交互 (Ghost Edge) ---

  void startEdgeDrag(EdgeModel tempEdge, Offset startPos) {
    upsertEdge(tempEdge);
    state = state.copyWith(
      draggingEdgeId: tempEdge.id,
      draggingEnd: startPos,
    );
  }

  void updateEdgeDrag(Offset currentPos) {
    if (state.draggingEdgeId == null) return;
    state = state.copyWith(draggingEnd: currentPos);
  }

  void endEdgeDrag({
    required bool canceled,
    String? targetNodeId,
    String? targetAnchorId,
  }) {
    final edgeId = state.draggingEdgeId;
    if (edgeId == null) return;

    if (canceled || targetNodeId == null || targetAnchorId == null) {
      removeEdge(edgeId);
    } else {
      finalizeEdge(
        edgeId: edgeId,
        targetNodeId: targetNodeId,
        targetAnchorId: targetAnchorId,
      );
    }

    state = state.copyWith(
      draggingEdgeId: null,
      draggingEnd: null,
    );
  }

  void finalizeEdge({
    required String edgeId,
    required String targetNodeId,
    required String targetAnchorId,
  }) {
    final oldEdge = state.edgesOf(workflowId).firstWhere((e) => e.id == edgeId);

    // 检查：目标节点或目标 anchor 不能与源节点或源 anchor 相同
    if (oldEdge.sourceNodeId == targetNodeId ||
        oldEdge.sourceAnchorId == targetAnchorId) {
      // 如果目标与源相同，取消连接
      removeEdge(edgeId);
      state = state.copyWith(
        draggingEdgeId: null,
        draggingEnd: null,
      );
      return;
    }

    // 检查是否已存在同一对 source 和 target 的边（排除当前边本身）
    EdgeModel? existingEdge;
    for (final e in state.edgesOf(workflowId)) {
      if (e.id != edgeId &&
          e.sourceNodeId == oldEdge.sourceNodeId &&
          e.sourceAnchorId == oldEdge.sourceAnchorId &&
          e.targetNodeId == targetNodeId &&
          e.targetAnchorId == targetAnchorId &&
          e.isConnected) {
        existingEdge = e;
        break;
      }
    }

    if (existingEdge != null) {
      // 已存在相同 source-target 的边，则取消当前边的连接
      removeEdge(edgeId);
    } else {
      // 更新当前边为已连接状态
      final newEdge = oldEdge.copyWith(
        targetNodeId: targetNodeId,
        targetAnchorId: targetAnchorId,
        isConnected: true,
      );
      upsertEdge(newEdge);
    }

    // 清空拖拽状态
    state = state.copyWith(
      draggingEdgeId: null,
      draggingEnd: null,
    );
  }
  // --- 批量操作 ---

  void removeEdges(List<String> edgeIds) {
    final oldList = state.edgesOf(workflowId);
    final updatedList = oldList.where((e) => !edgeIds.contains(e.id)).toList();
    if (updatedList.length != oldList.length) {
      state = state.updateWorkflowEdges(workflowId, updatedList);
    }
  }
}

final edgeStateProvider =
    StateNotifierProvider.family<EdgeStateNotifier, EdgeState, String>(
  (ref, workflowId) => EdgeStateNotifier(workflowId: workflowId),
);
