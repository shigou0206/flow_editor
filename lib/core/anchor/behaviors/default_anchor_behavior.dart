import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:flow_editor/core/anchor/behaviors/anchor_behavior.dart';
import 'package:flow_editor/core/anchor/models/anchor_model.dart';
import 'package:flow_editor/core/edge/models/edge_model.dart';
import 'package:flow_editor/core/edge/models/edge_line_style.dart';
import 'package:flow_editor/core/edge/models/edge_enums.dart';
import 'package:flow_editor/core/edge/edge_state/edge_state_provider.dart';
import 'package:flow_editor/core/node/node_state/node_state_provider.dart';
import 'package:flow_editor/core/anchor/utils/anchor_position_utils.dart';

/// DefaultAnchorBehavior 实现：支持拖拽连线（ghost edge 创建、更新、结束）
///
/// 该实现利用 Riverpod 的 WidgetRef 来操作 EdgeStateNotifier，并在每个关键步骤输出日志。
class DefaultAnchorBehavior implements AnchorBehavior {
  /// 使用 Riverpod 的 WidgetRef 进行状态管理
  final WidgetRef ref;

  /// 当前工作流 ID
  final String workflowId;

  /// 用于记录当前拖拽中的 ghost edge 的 ID
  String? _draggingEdgeId;

  DefaultAnchorBehavior({
    required this.ref,
    this.workflowId = 'workflow1',
  });

  @override
  void onAnchorTap(AnchorModel anchor) {}

  @override
  void onAnchorDoubleTap(AnchorModel anchor) {}

  @override
  void onAnchorHover(AnchorModel anchor, bool isHover) {}

  @override
  void onAnchorContextMenu(AnchorModel anchor, Offset localPos) {}

  @override
  void onAnchorDragStart(AnchorModel anchor, Offset startPos) {
    // 创建 ghost edge（半连接）
    final ghostEdgeId = 'ghostEdge_${DateTime.now().millisecondsSinceEpoch}';
    final ghostEdge = EdgeModel(
      id: ghostEdgeId,
      sourceNodeId: anchor.nodeId,
      sourceAnchorId: anchor.id,
      isConnected: false,
      lineStyle: const EdgeLineStyle(
        colorHex: '#FFA500', // 橙色，仅示例
        strokeWidth: 3,
        arrowEnd: ArrowType.normal,
        arrowStart: ArrowType.none,
        useBezier: false,
      ),
    );

    // 调用 EdgeStateNotifier 的 startEdgeDrag 方法，插入 ghost edge 并记录拖拽状态
    ref
        .read(edgeStateProvider(workflowId).notifier)
        .startEdgeDrag(ghostEdge, startPos);

    _draggingEdgeId = ghostEdgeId;
  }

  @override
  void onAnchorDragUpdate(AnchorModel anchor, Offset currentPos) {
    if (_draggingEdgeId == null) {
      return;
    }

    // 更新 ghost edge 的终点位置
    ref.read(edgeStateProvider(workflowId).notifier).updateEdgeDrag(currentPos);
  }

  @override
  void onAnchorDragEnd(
    AnchorModel anchor,
    Offset endPos, {
    bool canceled = false,
  }) {
    if (_draggingEdgeId == null) {
      return;
    }

    final ghostId = _draggingEdgeId!;
    _draggingEdgeId = null;

    if (canceled) {
      // 取消拖拽，移除 ghost edge
      ref.read(edgeStateProvider(workflowId).notifier).removeEdge(ghostId);
      return;
    }

    // 命中检测：在 endPos 附近搜索其它锚点
    final hitAnchor = _hitTestAnotherAnchor(endPos, anchor.id);
    if (hitAnchor == null) {
      // 未命中，则移除 ghost edge
      ref.read(edgeStateProvider(workflowId).notifier).removeEdge(ghostId);
    } else {
      // 命中后，将 ghost edge finalize 为已连接
      ref.read(edgeStateProvider(workflowId).notifier).endEdgeDrag(
            canceled: false,
            targetNodeId: hitAnchor.nodeId,
            targetAnchorId: hitAnchor.id,
          );
    }
  }

  /// 命中检测：在 [worldPos] 附近搜索其它锚点（示例实现，需根据项目具体情况完善）
  AnchorModel? _hitTestAnotherAnchor(Offset worldPos, String excludeAnchorId) {
    final nodeState = ref.read(nodeStateProvider(workflowId));
    const hitTestRadius = 20.0; // 根据实际情况调整

    for (final node in nodeState.nodesOf(workflowId).values) {
      for (final anchor in node.anchors) {
        // 跳过当前正在拖拽的 anchor
        if (anchor.id == excludeAnchorId) continue;

        // 如果你对 anchor 有边缘偏移，需要在计算时加上
        final padding = computeAnchorPadding(
          node.anchors,
          Size(node.width, node.height),
        );

        // 计算anchor的本地偏移
        final anchorLocalPos = computeAnchorLocalPosition(
          anchor,
          Size(node.width, node.height),
        );

        // 将 anchor 的本地坐标转换为世界坐标
        final anchorWorldPos = Offset(
          node.x - padding.left + anchorLocalPos.dx,
          node.y - padding.top + anchorLocalPos.dy,
        );

        // 计算与鼠标落点的距离
        final distance = (anchorWorldPos - worldPos).distance;

        if (distance <= hitTestRadius) {
          return anchor;
        }
      }
    }
    return null;
  }
}
