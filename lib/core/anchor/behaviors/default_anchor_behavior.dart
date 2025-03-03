import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'anchor_behavior.dart';
import '../models/anchor_model.dart';
import '../../edge/models/edge_model.dart';
import '../../edge/models/edge_line_style.dart';
import '../../edge/models/edge_enums.dart';
import '../../state_management/edge_state/edge_state_provider.dart';

/// DefaultAnchorBehavior 实现：支持拖拽连线（ghost edge 创建、更新、结束）
class DefaultAnchorBehavior implements AnchorBehavior {
  /// 使用 Riverpod 的 Ref 进行状态管理
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
  void onAnchorTap(AnchorModel anchor) {
    debugPrint('[DefaultAnchorBehavior] onAnchorTap: ${anchor.id}');
  }

  @override
  void onAnchorDoubleTap(AnchorModel anchor) {
    debugPrint('[DefaultAnchorBehavior] onAnchorDoubleTap: ${anchor.id}');
  }

  @override
  void onAnchorHover(AnchorModel anchor, bool isHover) {
    debugPrint(
        '[DefaultAnchorBehavior] onAnchorHover: ${anchor.id}, isHover=$isHover');
  }

  @override
  void onAnchorContextMenu(AnchorModel anchor, Offset localPos) {
    debugPrint(
        '[DefaultAnchorBehavior] onAnchorContextMenu: ${anchor.id} at $localPos');
  }

  @override
  void onAnchorDragStart(AnchorModel anchor, Offset startPos) {
    debugPrint(
        '[DefaultAnchorBehavior] onAnchorDragStart: ${anchor.id}, startPos=$startPos');

    // 创建 ghost edge（半连接）
    final ghostEdgeId = 'ghostEdge_${DateTime.now().millisecondsSinceEpoch}';
    final ghostEdge = EdgeModel(
      id: ghostEdgeId,
      sourceNodeId: anchor.nodeId, // 要确保 AnchorModel 中保存 nodeId
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

    // 调用 EdgeStateNotifier 提供的 startEdgeDrag 方法，统一设置 draggingEdgeId 和 draggingEnd
    ref
        .read(edgeStateProvider.notifier)
        .startEdgeDrag(workflowId, ghostEdge, startPos);

    // 记录当前拖拽的 ghost edge ID
    _draggingEdgeId = ghostEdgeId;
    debugPrint('[DefaultAnchorBehavior] Created ghost edge: $_draggingEdgeId');
  }

  @override
  void onAnchorDragUpdate(AnchorModel anchor, Offset currentPos) {
    debugPrint(
        '[DefaultAnchorBehavior] onAnchorDragUpdate: ${anchor.id}, currentPos=$currentPos');
    if (_draggingEdgeId == null) {
      debugPrint(
          '[DefaultAnchorBehavior] updateEdgeDrag: No draggingEdgeId found');
      return;
    }
    // 更新 ghost edge 的终点位置
    ref
        .read(edgeStateProvider.notifier)
        .updateEdgeDrag(_draggingEdgeId!, currentPos);
  }

  @override
  void onAnchorDragEnd(AnchorModel anchor, Offset endPos,
      {bool canceled = false}) {
    debugPrint(
        '[DefaultAnchorBehavior] onAnchorDragEnd: ${anchor.id}, endPos=$endPos, canceled=$canceled');
    if (_draggingEdgeId == null) return;
    final ghostId = _draggingEdgeId!;
    _draggingEdgeId = null;

    if (canceled) {
      // 取消拖拽，则移除 ghost edge
      ref.read(edgeStateProvider.notifier).removeEdge(workflowId, ghostId);
      debugPrint(
          '[DefaultAnchorBehavior] Drag canceled, removed ghost edge: $ghostId');
      return;
    }

    // 命中检测（示例：遍历所有节点的锚点，若与 endPos 的距离在一定半径内则认为命中）
    final hitAnchor = _hitTestAnotherAnchor(endPos, anchor.id);
    if (hitAnchor == null) {
      // 未命中，则移除 ghost edge
      ref.read(edgeStateProvider.notifier).removeEdge(workflowId, ghostId);
      debugPrint(
          '[DefaultAnchorBehavior] No target hit, removed ghost edge: $ghostId');
    } else {
      // 命中后，将 ghost edge finalize 为已连接
      ref.read(edgeStateProvider.notifier).endEdgeDrag(
            workflowId: workflowId,
            canceled: false,
            targetNodeId: hitAnchor.nodeId,
            targetAnchorId: hitAnchor.id,
          );
      debugPrint(
          '[DefaultAnchorBehavior] Finalized ghost edge: $ghostId with target ${hitAnchor.nodeId}:${hitAnchor.id}');
    }
  }

  /// 命中检测：在 endPos 附近搜索其它锚点（示例实现，需根据项目具体情况完善）
  AnchorModel? _hitTestAnotherAnchor(Offset worldPos, String excludeAnchorId) {
    // 示例：此处仅返回 null。实际项目中，请通过遍历所有节点和它们的锚点，
    // 计算每个锚点的世界坐标，与 endPos 之间的距离，若距离在预设阈值内则返回该锚点。
    debugPrint(
        '[DefaultAnchorBehavior] _hitTestAnotherAnchor: worldPos=$worldPos, exclude=$excludeAnchorId');
    return null;
  }
}
