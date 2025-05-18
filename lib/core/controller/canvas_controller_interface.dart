// // lib/core/input/controller/i_canvas_controller.dart

// import 'package:flutter/material.dart';
// import 'package:flow_editor/core/models/node_model.dart';
// import 'package:flow_editor/core/models/edge_model.dart';

// abstract class ICanvasController {
//   // Node
//   Future<void> addNode(NodeModel node);
//   Future<void> deleteNode(String nodeId);
//   Future<void> deleteNodeWithEdges(String nodeId);
//   Future<void> moveNode(String nodeId, Offset to);
//   Future<void> updateNodeProperty(
//     String nodeId,
//     NodeModel Function(NodeModel) updateFn,
//   );
//   Future<void> groupNodes(List<String> nodeIds);
//   Future<void> ungroupNodes(String groupId);

//   // Edge
//   Future<void> addEdge(EdgeModel edge);
//   Future<void> deleteEdge(String edgeId);
//   Future<void> moveEdge(String edgeId, Offset from, Offset to);
//   Future<void> updateEdgeProperty(
//     String edgeId,
//     EdgeModel Function(EdgeModel) updateFn,
//   );

//   // Viewport
//   Future<void> panBy(Offset delta);
//   Future<void> zoomAt(Offset focalPoint, double scaleDelta);

//   // Selection
//   Future<void> selectNodes(Set<String> nodeIds);
//   Future<void> selectEdges(Set<String> edgeIds);
//   Future<void> clearSelection();

//   // Undo / Redo
//   void undo();
//   void redo();

//   // Execution
//   Future<void> runNode(String nodeId, {Map<String, dynamic>? data});
//   Future<void> stopNode(String nodeId, {Map<String, dynamic>? data});
//   Future<void> failNode(String nodeId, {Map<String, dynamic>? data});
//   Future<void> completeNode(String nodeId, {Map<String, dynamic>? data});
//   Future<void> runWorkflow({Map<String, dynamic>? data});
//   Future<void> cancelWorkflow({Map<String, dynamic>? data});
//   Future<void> failWorkflow({Map<String, dynamic>? data});
//   Future<void> completeWorkflow({Map<String, dynamic>? data});
// }

// lib/core/controller/i_canvas_controller.dart

import 'dart:ui';
import 'package:flow_editor/core/models/node_model.dart';
import 'package:flow_editor/core/models/edge_model.dart';

/// 合并了：
// 1) Behavior 层需要的“低级画布操作”
// 2) 外部／命令层需要的“高层命令”
/// 的统一接口
abstract class ICanvasController {
  // === 低级画布操作（Behavior 层） ===

  /// 平移画布视口（BehaviorContext 会传入 delta）
  void panBy(Offset delta);

  /// 以 focalPoint 为中心缩放
  void zoomAt(Offset focalPoint, double scaleDelta);

  /// 开始拖节点
  void startNodeDrag(String nodeId);

  /// 拖动节点时增量回调
  void updateNodeDrag(Offset delta);

  /// 结束拖节点
  void endNodeDrag();

  /// 开始拖连线（从某个 anchorId）
  void startEdgeDrag(String anchorId);

  /// 更新拖连线时的坐标
  void updateEdgeDrag(Offset canvasPos);

  /// 结束连线拖动，可带上命中到的 node/anchor
  void endEdgeDrag({String? targetNodeId, String? targetAnchorId});

  /// 框选
  void marqueeSelect(Rect area);

  /// 删除当前选区（BehaviorPlugins 里的 DeleteKeyBehavior 会调用）
  void deleteSelection();

  /// 复制
  void copySelection();

  /// 粘贴
  void pasteClipboard();

  /// 撤销/重做（UndoRedoBehavior 会调用）
  void undo();
  void redo();

  // === 高层命令（Command 层 / 外部调用） ===

  // Node 增删改拖分组等
  Future<void> addNode(NodeModel node);
  Future<void> deleteNode(String nodeId);
  Future<void> deleteNodeWithEdges(String nodeId);
  Future<void> moveNode(String nodeId, Offset to);
  Future<void> updateNodeProperty(
    String nodeId,
    NodeModel Function(NodeModel) updateFn,
  );
  Future<void> groupNodes(List<String> nodeIds);
  Future<void> ungroupNodes(String groupId);

  // Edge 增删改拖
  Future<void> addEdge(EdgeModel edge);
  Future<void> deleteEdge(String edgeId);
  Future<void> moveEdge(String edgeId, Offset from, Offset to);
  Future<void> updateEdgeProperty(
    String edgeId,
    EdgeModel Function(EdgeModel) updateFn,
  );

  // 选区（可以复用 marqueeSelect/deleteSelection 也可以单独命令）
  Future<void> selectNodes(Set<String> nodeIds);
  Future<void> selectEdges(Set<String> edgeIds);
  Future<void> clearSelection();

  // 执行流（Execution）
  Future<void> runNode(String nodeId, {Map<String, dynamic>? data});
  Future<void> stopNode(String nodeId, {Map<String, dynamic>? data});
  Future<void> failNode(String nodeId, {Map<String, dynamic>? data});
  Future<void> completeNode(String nodeId, {Map<String, dynamic>? data});
  Future<void> runWorkflow({Map<String, dynamic>? data});
  Future<void> cancelWorkflow({Map<String, dynamic>? data});
  Future<void> failWorkflow({Map<String, dynamic>? data});
  Future<void> completeWorkflow({Map<String, dynamic>? data});
}
