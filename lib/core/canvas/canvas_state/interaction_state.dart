// lib/flow_editor/interaction/interaction_state.dart
import 'dart:ui';
import 'package:flow_editor/core/anchor/models/anchor_model.dart';

/// 交互瞬时状态 —— 先只声明，不修改其它文件。
///
/// 后续如果想逐步迁移拖拽逻辑，可以在此文件继续扩展。
sealed class InteractionState {
  const InteractionState();
}

/// 空闲（默认）
class Idle extends InteractionState {
  const Idle();
}

/// 正在拖拽节点
class DragNode extends InteractionState {
  const DragNode({
    required this.nodeId,
    required this.lastCanvas,
  });
  final String nodeId; // 被拖节点 id
  final Offset lastCanvas; // 上一次更新时的画布坐标
}

/// 正在拖拽连线（幽灵边）
class DragEdge extends InteractionState {
  const DragEdge({
    required this.edgeId,
    required this.lastCanvas,
    required this.sourceAnchor,
  });

  final String edgeId; // 临时 Edge id
  final Offset lastCanvas; // 上一次更新的画布坐标
  final AnchorModel sourceAnchor;
}

/// 正在拖拽边的拐点，编辑形状
class DragWaypoint extends InteractionState {
  const DragWaypoint({
    required this.edgeId,
    required this.pointIndex,
    required this.lastCanvas,
  });

  final String edgeId; // 边 id
  final int pointIndex; // 被拖的拐点下标
  final Offset lastCanvas; // 上一次更新的画布坐标
}

/// 正在平移画布
class PanCanvas extends InteractionState {
  const PanCanvas({required this.lastGlobal});
  final Offset lastGlobal; // 上一次 PointerMove 的全局坐标
}
