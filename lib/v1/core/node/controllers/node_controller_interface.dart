import 'package:flutter/material.dart';
import 'package:flow_editor/v1/core/node/models/node_model.dart';
import 'package:flow_editor/v1/core/anchor/models/anchor_model.dart';

abstract class INodeController {
  void upsertNode(NodeModel node);
  void upsertNodes(List<NodeModel> nodes);
  void removeNode(String nodeId);
  void removeNodes(List<String> nodeIds);
  void clearNodes();
  NodeModel? getNode(String nodeId);
  List<NodeModel> getAllNodes();
  List<NodeModel> getNodesByType(String type);
  bool nodeExists(String nodeId);
  AnchorModel? findAnchorNear(
    Offset worldPos,
    String excludeAnchorId, {
    double hitTestRadius = 20.0,
  });
}
