import 'package:flutter/material.dart';
import 'package:flow_editor/core/edge/models/edge_model.dart';
import 'package:flow_editor/core/edge/plugins/edge_overlay_plugin.dart';
import 'package:flow_editor/core/edge/utils/edge_utils.dart';
import 'package:flow_editor/core/edge/widgets/edge_button_overlay.dart';
import 'package:flow_editor/core/node/node_state/node_state.dart';
import 'package:flow_editor/core/node/models/node_model.dart';
import 'package:flow_editor/core/anchor/models/anchor_model.dart';
import 'package:flow_editor/core/anchor/utils/anchor_position_utils.dart';

/// 删除按钮插件，依赖 NodeState 获取节点与锚点位置
class EdgeDeleteButtonPlugin implements EdgeOverlayPlugin {
  final NodeState nodeState;
  final void Function(String edgeId) onDeleteEdge;

  EdgeDeleteButtonPlugin({
    required this.nodeState,
    required this.onDeleteEdge,
  });

  @override
  List<Widget> buildEdgeOverlays({
    required EdgeModel edge,
    required Offset Function(Offset) screenOffsetConvert,
    required double scale,
  }) {
    if (!edge.isConnected || edge.targetNodeId == null) {
      return [];
    }

    final sourceNode = _getNode(edge.sourceNodeId);
    if (sourceNode == null) return [];

    final sourceAnchor = _getAnchor(sourceNode, edge.sourceAnchorId);
    if (sourceAnchor == null) return [];

    final targetNode = _getNode(edge.targetNodeId!);
    if (targetNode == null) return [];

    final targetAnchor = _getAnchor(targetNode, edge.targetAnchorId!);
    if (targetAnchor == null) return [];

    final sourceWorld = computeAnchorWorldPosition(sourceNode, sourceAnchor);
    final targetWorld = computeAnchorWorldPosition(targetNode, targetAnchor);

    final sourceScreen = screenOffsetConvert(sourceWorld);
    final targetScreen = screenOffsetConvert(targetWorld);

    final result = buildEdgePathAndCenter(
      mode: edge.lineStyle.edgeMode,
      sourceX: sourceScreen.dx,
      sourceY: sourceScreen.dy,
      sourcePos: sourceAnchor.position,
      targetX: targetScreen.dx,
      targetY: targetScreen.dy,
      targetPos: targetAnchor.position,
      curvature: 0.25,
      hvOffset: 50.0,
      orthoDist: 40.0,
    );

    return [
      EdgeButtonOverlay(
        edgeCenter: result.center,
        onDeleteEdge: () => onDeleteEdge(edge.id),
      ),
    ];
  }

  /// 从 NodeState 中查找节点
  NodeModel? _getNode(String nodeId) {
    return nodeState.nodesByWorkflow.values
        .expand((list) => list) // 修正：原来是 .values.expand((m) => m.values)
        .firstWhereOrNull((node) => node.id == nodeId);
  }

  /// 查找 anchor
  AnchorModel? _getAnchor(NodeModel node, String anchorId) {
    return node.anchors.firstWhereOrNull((a) => a.id == anchorId);
  }
}

// firstWhereOrNull 辅助扩展
extension DeletePluginFirstWhereOrNull<E> on Iterable<E> {
  E? firstWhereOrNull(bool Function(E e) test) =>
      cast<E?>().firstWhere((x) => x != null && test(x), orElse: () => null);
}
