// file: core/edge/plugins/edge_delete_button_plugin.dart

import 'package:flutter/material.dart';
import 'package:flow_editor/core/edge/models/edge_model.dart';
import 'package:flow_editor/core/edge/plugins/edge_overlay_plugin.dart';
import 'package:flow_editor/core/edge/utils/edge_utils.dart';
import 'package:flow_editor/core/edge/widgets/edge_button_overlay.dart';
import 'package:flow_editor/core/node/node_state/node_state.dart';
import 'package:flow_editor/core/node/models/node_model.dart';
import 'package:flow_editor/core/anchor/models/anchor_model.dart';
import 'package:flow_editor/core/anchor/utils/anchor_position_utils.dart';

/// 让 "删除按钮" 以插件方式出现:
/// 需要 NodeState 来查找 node/anchor, 并调用 computeAnchorWorldPosition
class EdgeDeleteButtonPlugin implements EdgeOverlayPlugin {
  final NodeState nodeState; // 注入 NodeState, 以获取节点 & 锚点
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
    // 1) 先判断边是否已连接
    if (!edge.isConnected || edge.targetNodeId == null) {
      return [];
    }

    // 2) 查找源端节点/锚点
    final sourceNode = _getNode(edge.sourceNodeId);
    if (sourceNode == null) return [];
    final sourceAnchor = _getAnchor(sourceNode, edge.sourceAnchorId);
    if (sourceAnchor == null) return [];

    // 3) 查找目标节点/锚点
    final targetNode = _getNode(edge.targetNodeId!);
    if (targetNode == null) return [];
    final targetAnchor = _getAnchor(targetNode, edge.targetAnchorId!);
    if (targetAnchor == null) return [];

    // 4) 计算世界坐标
    final sourceWorld = computeAnchorWorldPosition(sourceNode, sourceAnchor);
    final targetWorld = computeAnchorWorldPosition(targetNode, targetAnchor);

    // 5) 转换为屏幕坐标
    final sourceScreen = screenOffsetConvert(sourceWorld);
    final targetScreen = screenOffsetConvert(targetWorld);

    // 6) 计算中点 (需要 anchor 的 position，用于贝塞尔/正交路径)
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
    final center = result.center;

    // 7) 返回删除按钮 Overlay
    return [
      EdgeButtonOverlay(
        edgeCenter: center,
        onDeleteEdge: () => onDeleteEdge(edge.id),
      ),
    ];
  }

  /// 从 NodeState 获取节点
  NodeModel? _getNode(String nodeId) {
    return nodeState.nodesByWorkflow.values
        .expand((m) => m.values)
        .firstWhereOrNull((n) => n.id == nodeId);
  }

  /// 从节点获取指定 anchor
  AnchorModel? _getAnchor(NodeModel node, String anchorId) {
    return node.anchors.firstWhereOrNull((a) => a.id == anchorId);
  }
}

// 如果项目已定义相同的扩展 firstWhereOrNull，请删除或合并
extension DeletePluginFirstWhereOrNull<E> on Iterable<E> {
  E? firstWhereOrNull(bool Function(E e) test) =>
      cast<E?>().firstWhere((x) => x != null && test(x), orElse: () => null);
}
