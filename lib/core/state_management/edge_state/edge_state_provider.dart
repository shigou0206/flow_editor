// core/state_management/edge_state/edge_state_provider.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'edge_state.dart';
import 'package:flow_editor/core/edge/models/edge_model.dart';

/// 管理 EdgeState 的 StateNotifier，提供对外的增删改、选中及拖拽交互接口
class EdgeStateNotifier extends StateNotifier<EdgeState> {
  EdgeStateNotifier() : super(const EdgeState());

  // --- 增删改 ---

  void upsertEdge(String workflowId, EdgeModel edge) {
    final oldMap = state.edgesOf(workflowId);
    final updatedMap = Map<String, EdgeModel>.from(oldMap);
    updatedMap[edge.id] = edge;
    state = state.updateWorkflowEdges(workflowId, updatedMap);
    debugPrint(
        '[EdgeStateNotifier] upsertEdge: ${edge.id} in workflow $workflowId');
  }

  void removeEdge(String workflowId, String edgeId) {
    final oldMap = state.edgesOf(workflowId);
    if (!oldMap.containsKey(edgeId)) return;
    final updatedMap = Map<String, EdgeModel>.from(oldMap)..remove(edgeId);
    state = state.updateWorkflowEdges(workflowId, updatedMap);
    debugPrint(
        '[EdgeStateNotifier] removeEdge: $edgeId from workflow $workflowId');
  }

  void removeEdgesOfNode(String workflowId, String nodeId) {
    final oldMap = state.edgesOf(workflowId);
    final updatedMap = Map<String, EdgeModel>.from(oldMap)
      ..removeWhere((_, edge) =>
          edge.sourceNodeId == nodeId || edge.targetNodeId == nodeId);
    if (updatedMap.length != oldMap.length) {
      state = state.updateWorkflowEdges(workflowId, updatedMap);
      debugPrint(
          '[EdgeStateNotifier] removeEdgesOfNode: for node $nodeId in workflow $workflowId');
    }
  }

  void setWorkflowEdges(String workflowId, Map<String, EdgeModel> edges) {
    state = state.updateWorkflowEdges(workflowId, edges);
    debugPrint('[EdgeStateNotifier] setWorkflowEdges for workflow $workflowId');
  }

  void removeWorkflow(String workflowId) {
    state = state.removeWorkflow(workflowId);
    debugPrint('[EdgeStateNotifier] removeWorkflow: $workflowId');
  }

  // --- 选中相关 ---
  void toggleSelectEdge(String edgeId) {
    final newSet = Set.of(state.selectedEdgeIds);
    if (newSet.contains(edgeId)) {
      newSet.remove(edgeId);
    } else {
      newSet.add(edgeId);
    }
    state = state.copyWith(selectedEdgeIds: newSet);
    debugPrint('[EdgeStateNotifier] toggleSelectEdge: $edgeId');
  }

  void selectEdge(String edgeId, {bool multiSelect = false}) {
    final newSet = multiSelect ? Set.of(state.selectedEdgeIds) : <String>{};
    newSet.add(edgeId);
    state = state.copyWith(selectedEdgeIds: newSet);
    debugPrint(
        '[EdgeStateNotifier] selectEdge: $edgeId, multiSelect=$multiSelect');
  }

  void deselectEdge(String edgeId) {
    final newSet = Set.of(state.selectedEdgeIds);
    newSet.remove(edgeId);
    state = state.copyWith(selectedEdgeIds: newSet);
    debugPrint('[EdgeStateNotifier] deselectEdge: $edgeId');
  }

  void clearSelection() {
    state = state.copyWith(selectedEdgeIds: {});
    debugPrint('[EdgeStateNotifier] clearSelection');
  }

  // --- 拖拽交互 (Ghost Edge) ---
  void startEdgeDrag(String workflowId, EdgeModel tempEdge, Offset startPos) {
    upsertEdge(workflowId, tempEdge);
    state = state.copyWith(
      draggingEdgeId: tempEdge.id,
      draggingEnd: startPos,
    );
    debugPrint(
        '[EdgeStateNotifier] startEdgeDrag: ${tempEdge.id} at $startPos in workflow $workflowId');
  }

  void updateEdgeDrag(String edgeId, Offset currentPos) {
    if (state.draggingEdgeId == null) {
      debugPrint('[EdgeStateNotifier] updateEdgeDrag: No draggingEdgeId found');
      return;
    }
    state = state.copyWith(draggingEdgeId: edgeId, draggingEnd: currentPos);
    debugPrint(
        '[EdgeStateNotifier] updateEdgeDrag: $edgeId updated to $currentPos');
  }

  void endEdgeDrag({
    required String workflowId,
    required bool canceled,
    String? targetNodeId,
    String? targetAnchorId,
  }) {
    final edgeId = state.draggingEdgeId;
    if (edgeId == null) return;
    if (canceled || targetNodeId == null || targetAnchorId == null) {
      removeEdge(workflowId, edgeId);
      debugPrint(
          '[EdgeStateNotifier] endEdgeDrag: removed ghost edge $edgeId due to cancellation or missing target');
    } else {
      final edgesMap = state.edgesOf(workflowId);
      final oldEdge = edgesMap[edgeId];
      if (oldEdge != null) {
        final newEdge = oldEdge.copyWith(
          targetNodeId: targetNodeId,
          targetAnchorId: targetAnchorId,
          isConnected: true,
        );
        upsertEdge(workflowId, newEdge);
        debugPrint(
            '[EdgeStateNotifier] endEdgeDrag: finalized edge $edgeId with target $targetNodeId/$targetAnchorId');
      }
    }
    state = state.copyWith(
      draggingEdgeId: null,
      draggingEnd: null,
    );
  }

  void finalizeEdge({
    required String workflowId,
    required String edgeId,
    required String targetNodeId,
    required String targetAnchorId,
  }) {
    final edgesMap = state.edgesOf(workflowId);
    final oldEdge = edgesMap[edgeId];
    if (oldEdge != null) {
      final newEdge = oldEdge.copyWith(
        targetNodeId: targetNodeId,
        targetAnchorId: targetAnchorId,
        isConnected: true,
      );
      upsertEdge(workflowId, newEdge);
      debugPrint(
          '[EdgeStateNotifier] finalizeEdge: finalized edge $edgeId with target $targetNodeId/$targetAnchorId');
    }
    state = state.copyWith(
      draggingEdgeId: null,
      draggingEnd: null,
    );
  }
}

final edgeStateProvider =
    StateNotifierProvider<EdgeStateNotifier, EdgeState>((ref) {
  return EdgeStateNotifier();
});
