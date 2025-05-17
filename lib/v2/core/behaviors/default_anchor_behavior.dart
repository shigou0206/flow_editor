import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flow_editor/v2/core/behaviors/anchor_behavior.dart';
import 'package:flow_editor/v2/core/models/anchor_model.dart';
import 'package:flow_editor/v2/core/controllers/edge_controller_interface.dart';
import 'package:flow_editor/v2/core/models/edge_model.dart';
import 'package:flow_editor/v2/core/models/enums.dart';
import 'package:flow_editor/v2/core/models/style/edge_line_style.dart';
import 'package:flow_editor/v2/core/controllers/node_controller_interface.dart';

/// DefaultAnchorBehavior：通过 EdgeController 操作 ghost edge，
/// 命中检测则由 NodeController 提供。
class DefaultAnchorBehavior implements AnchorBehavior {
  /// 用于“操作 edgeState” (startEdgeDrag, updateEdgeDrag, deleteEdge, etc)
  @override
  final IEdgeController edgeController;

  /// 用于“节点/锚点 数据读取” (如 findAnchorNear)
  @override
  final INodeController nodeController;

  /// 可选，如果 Edge/NodeController 已经有 workflowId，就不一定要放这里
  @override
  final String workflowId;

  /// 记录当前正在拖拽的 ghost edge ID
  String? _draggingEdgeId;

  DefaultAnchorBehavior({
    required this.edgeController,
    required this.nodeController,
    required this.workflowId,
  });

  @override
  void onAnchorTap(AnchorModel anchor) {}

  @override
  void onAnchorDoubleTap(AnchorModel anchor) {}

  @override
  void onAnchorHover(AnchorModel anchor, bool isHover) {}

  @override
  void onAnchorContextMenu(AnchorModel anchor, Offset localPos) {}

  /// 拖拽开始：创建一个 ghost edge，调用 [edgeController.startEdgeDrag]
  @override
  void onAnchorDragStart(AnchorModel anchor, Offset startPos) {
    final ghostEdgeId = 'ghostEdge_${DateTime.now().millisecondsSinceEpoch}';
    final ghostEdge = EdgeModel(
      id: ghostEdgeId,
      sourceNodeId: anchor.nodeId,
      sourceAnchorId: anchor.id,
      isConnected: false,
      lineStyle: const EdgeLineStyle(
        colorHex: '#FFA500',
        strokeWidth: 3,
        arrowEnd: ArrowType.normal,
        arrowStart: ArrowType.none,
        edgeMode: EdgeMode.bezier,
      ),
    );

    edgeController.startEdgeDrag(ghostEdge, startPos);
    _draggingEdgeId = ghostEdgeId;
  }

  /// 拖拽进行中
  @override
  void onAnchorDragUpdate(AnchorModel anchor, Offset currentPos) {
    if (_draggingEdgeId == null) return;
    edgeController.updateEdgeDrag(currentPos);
  }

  /// 拖拽结束：若 canceled => 删除 ghost edge；否则判断是否命中别的 anchor
  @override
  void onAnchorDragEnd(
    AnchorModel anchor,
    Offset endPos, {
    bool canceled = false,
  }) {
    if (_draggingEdgeId == null) return;
    final ghostId = _draggingEdgeId!;
    _draggingEdgeId = null;

    if (canceled) {
      edgeController.deleteEdge(ghostId);
      return;
    }

    // 调用 nodeController 进行命中检测
    final hitAnchor = nodeController.findAnchorNear(endPos, anchor.id);
    if (hitAnchor == null) {
      // 未命中 => 删除 ghost
      edgeController.deleteEdge(ghostId);
    } else {
      // 命中 => finalize
      edgeController.endEdgeDrag(
        canceled: false,
        targetNodeId: hitAnchor.nodeId,
        targetAnchorId: hitAnchor.id,
      );
    }
  }
}
