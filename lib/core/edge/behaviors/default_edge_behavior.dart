import 'package:flutter/material.dart';
import 'package:flow_editor/core/edge/models/edge_model.dart';
import 'package:flow_editor/core/edge/behaviors/edge_behavior.dart';

/// DefaultEdgeBehavior: 对 EdgeBehavior 所有方法提供默认空实现，
/// 或简单的 debugPrint，以方便快速查看事件触发情况。
class DefaultEdgeBehavior implements EdgeBehavior {
  @override
  void onEdgeTap(EdgeModel edge, {Offset? localPos}) {
    debugPrint('Edge tapped: ${edge.id}, localPos=$localPos');
  }

  @override
  void onEdgeDoubleTap(EdgeModel edge, {Offset? localPos}) {
    debugPrint('Edge double-tapped: ${edge.id}, localPos=$localPos');
  }

  @override
  void onEdgeHover(EdgeModel edge, bool isHover) {
    debugPrint('Edge hover: ${edge.id}, isHover=$isHover');
  }

  @override
  void onEdgeContextMenu(EdgeModel edge, Offset localPos) {
    debugPrint('Edge context menu: ${edge.id} at $localPos');
  }

  @override
  void onEdgeDelete(EdgeModel edge) {
    debugPrint('Edge delete: ${edge.id}');
  }

  @override
  void onEdgeEndpointDrag(
    EdgeModel edge,
    bool isSourceSide,
    String newNodeId,
    String newAnchorId,
  ) {
    debugPrint(
      'Edge endpoint drag: ${edge.id}, '
      '${isSourceSide ? 'source' : 'target'} => ($newNodeId, $newAnchorId)',
    );
  }

  @override
  void onEdgeCreated(EdgeModel edge) {
    debugPrint('Edge created: ${edge.id}');
  }

  @override
  void onEdgeUpdated(EdgeModel oldEdge, EdgeModel newEdge) {
    debugPrint(
        'Edge updated: ${oldEdge.id}, type changed from ${oldEdge.edgeType} to ${newEdge.edgeType}?');
  }

  @override
  void onEdgeSelected(EdgeModel edge) {
    debugPrint('Edge selected: ${edge.id}');
  }

  @override
  void onEdgeDeselected(EdgeModel edge) {
    debugPrint('Edge deselected: ${edge.id}');
  }
}
