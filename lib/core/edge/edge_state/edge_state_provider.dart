import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flow_editor/core/models/state/edge_state.dart';
import 'package:flow_editor/core/models/edge_model.dart';

class EdgeStateNotifier extends StateNotifier<EdgeState> {
  final String workflowId;

  EdgeStateNotifier({required this.workflowId}) : super(const EdgeState());

  // 获取当前工作流的所有边
  List<EdgeModel> getEdges() => state.edgesOf(workflowId);

  void updateEdges(List<EdgeModel> edges) {
    state = state.updateWorkflowEdges(workflowId, edges);
  }

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
    if (!newSet.add(edgeId)) newSet.remove(edgeId);
    state = state.copyWith(selectedEdgeIds: newSet);
  }

  void selectEdge(String edgeId, {bool multiSelect = false}) {
    final newSet = multiSelect ? Set.of(state.selectedEdgeIds) : <String>{};
    newSet.add(edgeId);
    state = state.copyWith(selectedEdgeIds: newSet);
  }

  void deselectEdge(String edgeId) {
    final newSet = Set.of(state.selectedEdgeIds)..remove(edgeId);
    state = state.copyWith(selectedEdgeIds: newSet);
  }

  void clearSelection() => state = state.copyWith(selectedEdgeIds: {});

  // --- 拖拽交互 (Ghost Edge) ---

  void startEdgeDrag(EdgeModel tempEdge, Offset startPos) {
    upsertEdge(tempEdge);
    state = state.copyWith(draggingEdgeId: tempEdge.id, draggingEnd: startPos);
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
    debugPrint(
        '清理前 draggingEdgeId=${state.draggingEdgeId}, draggingEnd=${state.draggingEnd}');
    state = state.copyWith(clearDraggingEdgeId: true, clearDraggingEnd: true);
    debugPrint(
        '清理后 draggingEdgeId=${state.draggingEdgeId}, draggingEnd=${state.draggingEnd}');
  }

  void finalizeEdge({
    required String edgeId,
    required String targetNodeId,
    required String targetAnchorId,
  }) {
    final oldEdge = state.edgesOf(workflowId).firstWhere((e) => e.id == edgeId);

    if (oldEdge.sourceNodeId == targetNodeId ||
        oldEdge.sourceAnchorId == targetAnchorId) {
      removeEdge(edgeId);
      return;
    }

    final newEdge = oldEdge.copyWith(
      targetNodeId: targetNodeId,
      targetAnchorId: targetAnchorId,
      isConnected: true,
    );
    upsertEdge(newEdge);
  }
  // --- 批量操作 ---

  void removeEdges(List<String> edgeIds) {
    final oldList = state.edgesOf(workflowId);
    final updatedList = oldList.where((e) => !edgeIds.contains(e.id)).toList();
    if (updatedList.length != oldList.length) {
      state = state.updateWorkflowEdges(workflowId, updatedList);
    }
  }

  void addEdges(List<EdgeModel> edges) {
    final oldList = state.edgesOf(workflowId);
    final updatedList = [...oldList, ...edges];
    state = state.updateWorkflowEdges(workflowId, updatedList);
  }

  // --- 路由点（Waypoints）操作 ---
  void updateEdgeWaypoints(Map<String, List<Offset>> routes) {
    final edges = state.edgesOf(workflowId);
    final updatedEdges = edges.map((edge) {
      if (routes.containsKey(edge.id)) {
        final points =
            routes[edge.id]!.map((offset) => [offset.dx, offset.dy]).toList();
        return edge.copyWith(waypoints: points);
      }
      return edge;
    }).toList();

    state = state.updateWorkflowEdges(workflowId, updatedEdges);
  }
}

final edgeStateProvider =
    StateNotifierProvider.family<EdgeStateNotifier, EdgeState, String>(
  (ref, workflowId) => EdgeStateNotifier(workflowId: workflowId),
);
