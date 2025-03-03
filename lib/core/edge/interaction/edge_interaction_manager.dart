import 'package:flow_editor/core/state_management/edge_state/edge_state_provider.dart';
import 'package:flow_editor/core/edge/models/edge_model.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// EdgeInteractionManager:
/// - 提供在交互层(如 CanvasInteractionManager)点击或拖拽到边时的处理
/// - 通过 EdgeStateNotifier 操作 edges
class EdgeInteractionManager {
  EdgeInteractionManager({required this.read});

  /// 通过 read(...) 来获取 Riverpod 的 edgeStateProvider.notifier
  final T Function<T>(ProviderListenable<T>) read;

  // region =========== 基础操作 ===========

  /// 创建一条新的边
  EdgeModel createEdge({
    required String workflowId,
    required String sourceNodeId,
    required String sourceAnchorId,
    required String targetNodeId,
    required String targetAnchorId,
    String edgeType = 'default',
  }) {
    final newEdge = EdgeModel(
      id: _generateEdgeId(), // 你可用 uuid
      sourceNodeId: sourceNodeId,
      sourceAnchorId: sourceAnchorId,
      targetNodeId: targetNodeId,
      targetAnchorId: targetAnchorId,
      edgeType: edgeType,
    );
    read(edgeStateProvider.notifier).upsertEdge(workflowId, newEdge);
    return newEdge;
  }

  /// 删除指定边
  void deleteEdge(String workflowId, String edgeId) {
    read(edgeStateProvider.notifier).removeEdge(workflowId, edgeId);
  }

  /// 或删除全部与 nodeId 关联的边
  void deleteEdgesOfNode(String workflowId, String nodeId) {
    read(edgeStateProvider.notifier).removeEdgesOfNode(workflowId, nodeId);
  }

  // endregion

  // region =========== 交互事件 ===========

  /// 当鼠标点击在边上
  void onEdgeTap(String workflowId, String edgeId, Offset localPos) {
    // 你可做选中/高亮/上下文菜单等:
    print('EdgeInteractionManager: tapped $edgeId at $localPos in $workflowId');
    // e.g. toggle selected in some selection manager
  }

  /// 当鼠标悬停在边上 (可选)
  void onEdgeHover(String workflowId, String edgeId, bool isHover) {
    // e.g. update hoveredEdgeId
  }

  /// 当用户拖拽边端点 (source/target)
  /// 只有在你的系统支持 "reconnect edge" 时才需要
  void onDragEdgeEndpoint({
    required String workflowId,
    required String edgeId,
    required bool isSourceSide,
    required Offset newWorldPos,
  }) {
    // 1) 你可先 hitTest 查找是否落到其他 node or anchor
    // 2) if found => update edge's nodeId/anchorId
    // 3) edgeStateProvider.notifier.upsertEdge(...)
  }

  // endregion

  // region =========== 内部辅助 ===========

  String _generateEdgeId() {
    // 你可用 uuid 或自定义
    // return Uuid().v4();
    return 'edge-${DateTime.now().millisecondsSinceEpoch}';
  }

  // endregion
}
