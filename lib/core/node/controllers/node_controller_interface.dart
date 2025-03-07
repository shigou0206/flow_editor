// core/node/controllers/node_controller_interface.dart

import 'package:flutter/material.dart';
import '../models/node_model.dart';

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

  /// 拖拽开始时调用
  void onNodeDragStart(NodeModel node, DragStartDetails details);

  /// 拖拽更新时调用
  void onNodeDragUpdate(NodeModel node, DragUpdateDetails details);

  /// 拖拽结束时调用
  void onNodeDragEnd(NodeModel node, DragEndDetails details);
}
