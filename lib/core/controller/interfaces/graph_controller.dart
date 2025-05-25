// lib/core/controller/interfaces/graph_controller.dart

import 'dart:ui';
import 'package:flow_editor/core/models/node_model.dart';
import 'package:flow_editor/core/models/edge_model.dart';

/// 业务层：负责持久化数据操作
abstract class IGraphController {
  // Nodes
  Future<void> addNode(NodeModel node);
  Future<void> deleteNode(String nodeId);
  Future<void> deleteNodeWithEdges(String nodeId);
  Future<void> moveNode(String nodeId, Offset to);
  Future<void> updateNodeProperty(
    String nodeId,
    NodeModel Function(NodeModel) updateFn,
  );

  // Group
  // Future<void> addNodeGroup(NodeModel groupNode, List<NodeModel> children,
  //     List<EdgeModel> edges, Offset position);
  Future<void> groupNodes(List<String> nodeIds);
  Future<void> ungroupNodes(String groupId);
  Future<void> duplicateNode(String nodeId);

  // Edges
  Future<void> addEdge(EdgeModel edge);
  Future<void> deleteEdge(String edgeId);
  Future<void> moveEdge(String edgeId, Offset from, Offset to);
  Future<void> updateEdgeProperty(
    String edgeId,
    EdgeModel Function(EdgeModel) updateFn,
  );
  Future<void> insertNodeIntoEdge(NodeModel node, String edgeId);

  Future<void> insertNodeGroupIntoEdge(NodeModel groupNode,
      List<NodeModel> children, List<EdgeModel> edges, String edgeId);

  // Selection
  Future<void> selectNodes(Set<String> nodeIds);
  Future<void> selectEdges(Set<String> edgeIds);
  Future<void> clearSelection();

  // Clipboard operations
  Future<void> copySelection();
  Future<void> pasteClipboard();

  Future<void> applyLayout();

  // Undo & Redo
  Future<void> undo();
  Future<void> redo();
}
