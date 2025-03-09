import 'package:flow_editor/core/node/models/node_model.dart';

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
}
