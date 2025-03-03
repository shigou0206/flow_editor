import 'package:flutter/material.dart';
import 'package:riverpod/riverpod.dart';

import '../../state_management/edge_state/edge_state_provider.dart';
import '../behaviors/edge_behavior.dart';

/// EdgeInteractionController (或 EdgeInteractionManager)
/// 负责处理边 (Edge) 的各种交互事件：点击、双击、删除、拖拽端点、右键菜单、悬停等；
/// 内部可调用 [EdgeBehavior] 做业务逻辑，并更新 [EdgeState] (通过 EdgeStateNotifier)。
class EdgeInteractionController {
  /// 可选：注入一个 [EdgeBehavior]，为所有边统一定义基本逻辑。
  /// 也可在实际使用时为不同Edge分配不同Behavior。
  final EdgeBehavior? behavior;

  /// Riverpod Ref，用于读/写 [edgeStateProvider]。
  final ProviderContainer container;

  EdgeInteractionController({
    this.behavior,
    required this.container,
  }) {
    this.read = container.read;
  }

  late final T Function<T>(ProviderListenable<T>) read;

  /// 当用户「单击」某条边。
  ///
  /// [workflowId]: 多工作流场景下标识当前的 workflow。
  /// [edgeId]: 被点击的边ID。
  /// [localPos]: 点击位置(相对坐标,若需要)。
  void onEdgeTap(String workflowId, String edgeId, Offset localPos) {
    final state = read(edgeStateProvider);
    final edge = state.edgesOf(workflowId)[edgeId];
    if (edge == null) return;

    // 行为回调
    behavior?.onEdgeTap(edge, localPos: localPos);

    // 常见做法：选中此边(如果 locked==true 仍可选中？视需求决定)
    read(edgeStateProvider.notifier).toggleSelectEdge(edgeId);
  }

  /// 当用户「双击」某条边(若你检测到doubleTap)。
  void onEdgeDoubleTap(String workflowId, String edgeId, Offset localPos) {
    final state = read(edgeStateProvider);
    final edge = state.edgesOf(workflowId)[edgeId];
    if (edge == null) return;

    // 行为回调
    behavior?.onEdgeDoubleTap(edge, localPos: localPos);
  }

  /// 当用户「右键点击」或「上下文菜单」某条边。
  ///
  /// [localPos]: 用于在此位置弹出菜单等。
  void onEdgeContextMenu(String workflowId, String edgeId, Offset localPos) {
    final state = read(edgeStateProvider);
    final edge = state.edgesOf(workflowId)[edgeId];
    if (edge == null) return;

    behavior?.onEdgeContextMenu(edge, localPos);
  }

  /// 当用户删除某条边(例如按键盘delete或UI按钮)。
  ///
  /// 如果你的需求是「锁定的边不可删除」，
  /// 可以在 removeEdge 或这里先判断 edge.locked => return。
  void onEdgeDelete(String workflowId, String edgeId) {
    final state = read(edgeStateProvider);
    final edge = state.edgesOf(workflowId)[edgeId];
    if (edge == null) return;

    // 行为回调
    behavior?.onEdgeDelete(edge);

    // 若要阻止删除 locked:
    // if (edge.locked) return;
    // 也可以放在 removeEdge(...) 做判断

    // 移除
    read(edgeStateProvider.notifier).removeEdge(workflowId, edgeId);
  }

  /// 当用户拖拽边端点(源 or 目标)以重新连接到另一Node/Anchor。
  ///
  /// [isSourceSide] = true表示拖拽的是source端；false表示target端。
  void onDragEdgeEndpoint({
    required String workflowId,
    required String edgeId,
    required bool isSourceSide,
    required String newNodeId,
    required String newAnchorId,
  }) {
    final state = read(edgeStateProvider);
    final oldMap = state.edgesOf(workflowId);
    final edge = oldMap[edgeId];
    if (edge == null) return;

    // 行为回调 => 可检查是否允许重新连接
    behavior?.onEdgeEndpointDrag(edge, isSourceSide, newNodeId, newAnchorId);

    // 若Behavior没阻止 => 更新Edge
    final updatedEdge = isSourceSide
        ? edge.copyWith(sourceNodeId: newNodeId, sourceAnchorId: newAnchorId)
        : edge.copyWith(targetNodeId: newNodeId, targetAnchorId: newAnchorId);

    read(edgeStateProvider.notifier).upsertEdge(workflowId, updatedEdge);
  }

  /// 当用户悬停在边上(鼠标移入/移出)。
  void onEdgeHover(String workflowId, String edgeId, bool isHover) {
    final state = read(edgeStateProvider);
    final edge = state.edgesOf(workflowId)[edgeId];
    if (edge == null) return;

    behavior?.onEdgeHover(edge, isHover);
  }

  /// 如果你想在"创建"一条新边时触发 behavior?.onEdgeCreated(edge)，
  /// 你可写一个 createEdge(...) 函数, 并在 upsertEdge 之前调用。
  ///
  /// 例如:
  ///
  /// void createEdge(
  ///   String workflowId,
  ///   EdgeModel newEdge,
  /// ) {
  ///   behavior?.onEdgeCreated(newEdge);
  ///   read(edgeStateProvider.notifier).upsertEdge(workflowId, newEdge);
  /// }
  ///
  /// 同理, 如果旧Edge->newEdge, 你可 behavior?.onEdgeUpdated(oldEdge, newEdge).
}
