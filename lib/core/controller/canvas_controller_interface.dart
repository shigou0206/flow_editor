// lib/core/input/controller/i_canvas_controller.dart

import 'package:flutter/material.dart';
import 'package:flow_editor/core/models/node_model.dart';
import 'package:flow_editor/core/models/edge_model.dart';

abstract class ICanvasController {
  // Node
  Future<void> addNode(NodeModel node);
  Future<void> deleteNode(String nodeId);
  Future<void> deleteNodeWithEdges(String nodeId);
  Future<void> moveNode(String nodeId, Offset to);
  Future<void> updateNodeProperty(
    String nodeId,
    NodeModel Function(NodeModel) updateFn,
  );
  Future<void> groupNodes(List<String> nodeIds);
  Future<void> ungroupNodes(String groupId);

  // Edge
  Future<void> addEdge(EdgeModel edge);
  Future<void> deleteEdge(String edgeId);
  Future<void> moveEdge(String edgeId, Offset from, Offset to);
  Future<void> updateEdgeProperty(
    String edgeId,
    EdgeModel Function(EdgeModel) updateFn,
  );

  // Viewport
  Future<void> panBy(Offset delta);
  Future<void> zoomAt(Offset focalPoint, double scaleDelta);

  // Selection
  Future<void> selectNodes(Set<String> nodeIds);
  Future<void> selectEdges(Set<String> edgeIds);
  Future<void> clearSelection();

  // Undo / Redo
  void undo();
  void redo();

  // Execution
  Future<void> runNode(String nodeId, {Map<String, dynamic>? data});
  Future<void> stopNode(String nodeId, {Map<String, dynamic>? data});
  Future<void> failNode(String nodeId, {Map<String, dynamic>? data});
  Future<void> completeNode(String nodeId, {Map<String, dynamic>? data});
  Future<void> runWorkflow({Map<String, dynamic>? data});
  Future<void> cancelWorkflow({Map<String, dynamic>? data});
  Future<void> failWorkflow({Map<String, dynamic>? data});
  Future<void> completeWorkflow({Map<String, dynamic>? data});
}
