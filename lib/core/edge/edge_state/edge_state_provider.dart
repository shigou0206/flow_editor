import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'edge_state.dart';
import 'package:flow_editor/core/edge/models/edge_model.dart';

class EdgeStateNotifier extends StateNotifier<EdgeState> {
  final String workflowId;

  EdgeStateNotifier({required this.workflowId}) : super(const EdgeState());

  // --- Edge 增删改 ---

  void upsertEdge(EdgeModel edge) {
    final oldMap = state.edgesOf(workflowId);
    final updatedMap = {...oldMap, edge.id: edge};
    state = state.updateWorkflowEdges(workflowId, updatedMap);
  }

  void removeEdge(String edgeId) {
    final oldMap = state.edgesOf(workflowId);
    if (!oldMap.containsKey(edgeId)) return;
    final updatedMap = {...oldMap}..remove(edgeId);
    state = state.updateWorkflowEdges(workflowId, updatedMap);
  }

  void removeEdgesOfNode(String nodeId) {
    final oldMap = state.edgesOf(workflowId);
    final updatedMap = {...oldMap}..removeWhere((_, edge) =>
        edge.sourceNodeId == nodeId || edge.targetNodeId == nodeId);
    if (updatedMap.length != oldMap.length) {
      state = state.updateWorkflowEdges(workflowId, updatedMap);
    }
  }

  void setWorkflowEdges(Map<String, EdgeModel> edges) {
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
    if (state.draggingEdgeId == null) {
      return;
    }
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
    final oldEdge = state.edgesOf(workflowId)[edgeId];
    if (oldEdge == null) {
      return;
    }

    final exists = state.edgesOf(workflowId).values.any((edge) =>
        edge.sourceAnchorId == oldEdge.sourceAnchorId &&
        edge.targetAnchorId == targetAnchorId &&
        edge.isConnected);

    if (exists) {
      removeEdge(edgeId); // 删除临时边
    } else {
      final newEdge = oldEdge.copyWith(
        targetNodeId: targetNodeId,
        targetAnchorId: targetAnchorId,
        isConnected: true,
      );
      upsertEdge(newEdge);
    }

    // 强制确保拖拽状态清空
    if (state.draggingEdgeId != null || state.draggingEnd != null) {
      state = state.copyWith(
        draggingEdgeId: null,
        draggingEnd: null,
      );
    }
  }

  // --- 批量操作 ---

  void removeEdges(List<String> edgeIds) {
    final oldMap = state.edgesOf(workflowId);
    final updatedMap = {...oldMap}
      ..removeWhere((id, _) => edgeIds.contains(id));
    state = state.updateWorkflowEdges(workflowId, updatedMap);
  }
}

final edgeStateProvider =
    StateNotifierProvider.family<EdgeStateNotifier, EdgeState, String>(
  (ref, workflowId) => EdgeStateNotifier(workflowId: workflowId),
);
