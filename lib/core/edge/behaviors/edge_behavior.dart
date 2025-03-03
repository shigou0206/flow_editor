// file: edge_behavior.dart
import 'package:flutter/material.dart';
import 'package:flow_editor/core/edge/models/edge_model.dart';

/// EdgeBehavior: 定义与「边」(Edge) 相关的业务逻辑或回调接口。
///
/// 当用户对连线进行各种操作(点击/悬停/右键、拖拽端点、双击、创建、选中等)，
/// [EdgeInteractionController] 会调用这些回调，以便不同的边类型或自定义逻辑能对事件作出特殊处理。
abstract class EdgeBehavior {
  /// 用户点击(单击)某条边时触发。
  ///
  /// [edge] 被点击的EdgeModel。
  /// [localPos] (可选) 在画布中的点击坐标。
  void onEdgeTap(EdgeModel edge, {Offset? localPos}) {}

  /// 用户双击某条边时触发。
  ///
  /// [edge] 被双击的EdgeModel。
  /// [localPos] (可选) 在画布中的双击坐标。
  void onEdgeDoubleTap(EdgeModel edge, {Offset? localPos}) {}

  /// 用户在边上悬停(鼠标移入/移出)时触发。
  ///
  /// [edge] 为悬停的边；[isHover] 表示进入(true)还是离开(false)。
  void onEdgeHover(EdgeModel edge, bool isHover) {}

  /// 用户右键(或长按)某条边时触发，通常用于上下文菜单。
  ///
  /// [edge] 被右键点击的边；[localPos] 为相对坐标，用于菜单位置等。
  void onEdgeContextMenu(EdgeModel edge, Offset localPos) {}

  /// 用户删除某条边(例如按键盘Delete或菜单)时触发。
  ///
  /// [edge] 被删除的边，可在此实现二次确认、或拒绝删除(若锁定)等。
  void onEdgeDelete(EdgeModel edge) {}

  /// 当用户拖拽边端点重新连接到另一个 Node/Anchor 时触发。
  ///
  /// [edge]           原本的EdgeModel(拖拽前)。
  /// [isSourceSide]   拖拽的是source端(true)还是target端(false)。
  /// [newNodeId]      拖拽落点的Node ID。
  /// [newAnchorId]    拖拽落点的Anchor ID。
  void onEdgeEndpointDrag(
    EdgeModel edge,
    bool isSourceSide,
    String newNodeId,
    String newAnchorId,
  ) {}

  /// 当边刚被创建(从无到有)时触发，或在 upsertEdge 时若是新增则可调用。
  ///
  /// [edge] 新创建的边，用于执行初始化或自定义操作(动画/网络同步等)。
  void onEdgeCreated(EdgeModel edge) {}

  /// 当边发生更新(替换 oldEdge -> newEdge)时触发，如更新 lineStyle、waypoints、animConfig等。
  ///
  /// 你可在此检查新老差异或记录日志。
  void onEdgeUpdated(EdgeModel oldEdge, EdgeModel newEdge) {}

  /// 当边被选中时触发(例如 onEdgeTap 后 setSelectedEdge)。
  ///
  /// 如果你在 EdgeStateNotifier 维护 selectedEdgeIds，可在选中后调用。
  void onEdgeSelected(EdgeModel edge) {}

  /// 当边被取消选中时触发。
  ///
  /// 类似 onEdgeSelected，但是在 deselect 场景下使用。
  void onEdgeDeselected(EdgeModel edge) {}
}
