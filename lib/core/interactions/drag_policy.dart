// lib/flow_editor/core/canvas/interaction/drag_policy.dart

import 'dart:ui';

/// 拖拽合法性策略
abstract class DragPolicy {
  /// 是否允许从侧边栏开始拖动这个节点
  bool canStartNodeDrag(String nodeId);

  /// 是否允许把节点放置到 canvasPos 上
  bool canDropNode(String nodeId, Offset canvasPos);

  /// 是否允许从锚点开始连边
  bool canStartEdgeDrag(String nodeId, String anchorId);

  /// 是否允许把连出的边放到 targetNodeId:targetAnchorId
  bool canDropEdge(String edgeId, String targetNodeId, String targetAnchorId);
}

/// 默认：不做任何限制
class DefaultDragPolicy implements DragPolicy {
  @override
  bool canStartNodeDrag(String nodeId) => true;

  @override
  bool canDropNode(String nodeId, Offset canvasPos) => true;

  @override
  bool canStartEdgeDrag(String nodeId, String anchorId) => true;

  @override
  bool canDropEdge(String edgeId, String targetNodeId, String targetAnchorId) =>
      true;
}
