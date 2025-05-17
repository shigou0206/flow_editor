import 'dart:ui';
import 'package:flow_editor/v2/core/models/edge_model.dart';

/// IEdgeController: 用于定义对 Edge 的常见操作 (create, update, delete, select等)
/// 不包含具体实现，只是一个“协议”。
abstract class IEdgeController {
  // 增删改
  void createEdge(EdgeModel newEdge);
  void updateEdge(EdgeModel oldEdge, EdgeModel updatedEdge);
  void deleteEdge(String edgeId);
  void deleteEdges(List<EdgeModel> edges);

  // 选中 / 取消选中
  void selectEdge(String edgeId, {bool multiSelect = false});
  void deselectEdge(String edgeId);
  void selectEdges(List<String> edgeIds);
  void clearSelectedEdges();

  // Ghost Edge 拖拽
  void startEdgeDrag(EdgeModel tempEdge, Offset startPos);
  void updateEdgeDrag(Offset currentPos);
  void endEdgeDrag({
    required bool canceled,
    String? targetNodeId,
    String? targetAnchorId,
  });
}
