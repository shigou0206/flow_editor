import 'package:flow_editor/core/models/node_model.dart';
import 'package:flutter/material.dart';

abstract class INodeController {
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
}
