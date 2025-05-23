// lib/core/controller/interfaces/interaction_controller.dart

import 'package:flutter/widgets.dart';
import 'package:flow_editor/core/models/anchor_model.dart';

/// InteractionController 处理临时的视觉交互状态，不直接修改业务数据
abstract class IInteractionController {
  // === 节点拖拽相关 ===

  void startNodeDrag(String nodeId);
  void updateNodeDrag(Offset delta);

  /// 拖拽结束后返回总位移，业务层决定如何持久化处理
  Offset endNodeDrag();
  void cancelNodeDrag();

  // === 边拖拽相关 ===

  void startEdgeDrag(String anchorId);
  void updateEdgeDrag(Offset canvasPos);

  /// 拖拽边结束时返回源 AnchorModel 和目标信息，业务层决定是否添加实际的边
  AnchorModel endEdgeDrag({String? targetNodeId, String? targetAnchorId});
  void cancelEdgeDrag();

  /// 为临时边生成一个唯一的 edgeId
  String generateTempEdgeId(AnchorModel sourceAnchor);

  // === 框选操作 ===

  void marqueeSelect(Rect area);
  void cancelMarqueeSelection();

  // === 其他临时交互（仅视觉效果） ===

  void copySelection();
  void pasteClipboard();

  /// 临时视觉删除，不改变实际数据，需业务层确认实际删除
  void deleteSelection();
}
