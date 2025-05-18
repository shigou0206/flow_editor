import 'package:flutter/material.dart';
import 'package:flow_editor/core/models/edge_model.dart';
import 'package:flow_editor/del/behaviors/edge_behavior.dart';
import 'package:flow_editor/del/controllers/edge_controller_interface.dart';

/// DefaultEdgeBehavior: 对 EdgeBehavior 所有方法提供默认空实现。
class DefaultEdgeBehavior implements EdgeBehavior {
  @override
  final IEdgeController edgeController;

  DefaultEdgeBehavior({
    required this.edgeController,
  });

  @override
  void onEdgeTap(EdgeModel edge, {Offset? localPos}) {}

  @override
  void onEdgeDoubleTap(EdgeModel edge, {Offset? localPos}) {}

  @override
  void onEdgeHover(EdgeModel edge, bool isHover) {}

  @override
  void onEdgeContextMenu(EdgeModel edge, Offset localPos) {}

  @override
  void onEdgeDelete(EdgeModel edge) {}

  @override
  void onEdgeEndpointDrag(
    EdgeModel edge,
    bool isSourceSide,
    String newNodeId,
    String newAnchorId,
  ) {}

  @override
  void onEdgeCreated(EdgeModel edge) {}

  @override
  void onEdgeUpdated(EdgeModel oldEdge, EdgeModel newEdge) {}

  @override
  void onEdgeSelected(EdgeModel edge) {}

  @override
  void onEdgeDeselected(EdgeModel edge) {}
}
