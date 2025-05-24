import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flow_editor/core/models/state/canvas_state.dart';
import 'package:flow_editor/core/models/state/node_state.dart';
import 'package:flow_editor/core/models/state/edge_state.dart';
import 'package:flow_editor/core/models/node_model.dart';
import 'package:flow_editor/core/models/edge_model.dart';
import 'package:flow_editor/core/models/state/selection_state.dart';
import 'package:flow_editor/core/models/state/interaction_transient_state.dart';
import 'package:flow_editor/core/models/config/input_config.dart';
import 'package:flow_editor/core/models/state/clipboard_state.dart';
import 'package:flow_editor/core/input/behavior_core/behavior_priority.dart';
part 'editor_state.freezed.dart';
part 'editor_state.g.dart';

@freezed
class EditorState with _$EditorState {
  const EditorState._();

  const factory EditorState({
    required CanvasState canvasState,
    required NodeState nodeState,
    required EdgeState edgeState,
    @Default(SelectionState()) SelectionState selection,
    @Default(InteractionState.idle()) InteractionState interaction,
    @Default(InputConfig()) InputConfig inputConfig,
    @Default(BehaviorPriority()) BehaviorPriority behaviorPriority,
    @Default(ClipboardState()) ClipboardState clipboard,
  }) = _EditorState;

  factory EditorState.fromJson(Map<String, dynamic> json) =>
      _$EditorStateFromJson(json);
}

extension EditorStateRendering on EditorState {
  /// 合并节点与拖拽中的节点，返回渲染用的节点列表
  List<NodeModel> get renderedNodes {
    final dragNode = interaction.mapOrNull(dragNode: (d) => d);
    if (dragNode == null) return nodeState.nodes;

    return nodeState.nodes.map((node) {
      if (node.id != dragNode.nodeId) return node;
      final delta = dragNode.lastCanvas - dragNode.startCanvas;
      return node.copyWith(position: node.position + delta);
    }).toList();
  }

  /// 合并边与拖拽中的边，包含ghost edge，用于渲染
  List<EdgeModel> get renderedEdges {
    final dragEdge = interaction.mapOrNull(dragEdge: (d) => d);
    final baseEdges = edgeState.edges;

    if (dragEdge == null) return baseEdges;

    // 创建临时的 ghostEdge
    final ghostEdge = EdgeModel(
      id: dragEdge.edgeId,
      sourceNodeId: dragEdge.sourceNodeId,
      sourceAnchorId: dragEdge.sourceAnchorId,
      targetNodeId: null,
      targetAnchorId: null,
      waypoints: [dragEdge.lastCanvas],
    );

    return [...baseEdges, ghostEdge];
  }
}

extension EditorStateExtras on EditorState {
  bool get isDragging => interaction.isDragging;
  bool get isHovering => interaction.isHovering;

  String? get focusedNodeId =>
      selection.nodeIds.length == 1 ? selection.nodeIds.first : null;

  NodeModel? get focusedNode => nodeState.nodes.firstWhereOrNull(
        (n) => n.id == focusedNodeId,
      );

  List<NodeModel> get selectedNodes =>
      nodeState.nodes.where((n) => selection.nodeIds.contains(n.id)).toList();

  List<EdgeModel> get selectedEdges =>
      edgeState.edges.where((e) => selection.edgeIds.contains(e.id)).toList();

  bool get hasNodes => nodeState.nodes.isNotEmpty;
  bool get hasEdges => edgeState.edges.isNotEmpty;

  Rect get nodeBounds {
    if (nodeState.nodes.isEmpty) return Rect.zero;

    final left = nodeState.nodes
        .map((n) => n.position.dx)
        .reduce((a, b) => a < b ? a : b);
    final top = nodeState.nodes
        .map((n) => n.position.dy)
        .reduce((a, b) => a < b ? a : b);
    final right = nodeState.nodes
        .map((n) => n.position.dx + n.size.width)
        .reduce((a, b) => a > b ? a : b);
    final bottom = nodeState.nodes
        .map((n) => n.position.dy + n.size.height)
        .reduce((a, b) => a > b ? a : b);

    return Rect.fromLTRB(left, top, right, bottom);
  }

  Offset get currentInteractionOffset => interaction.maybeWhen(
        dragNode: (_, __, lastCanvas) => lastCanvas,
        dragEdge: (_, __, ___, ____, lastCanvas) => lastCanvas,
        panCanvas: (_, lastGlobal) => lastGlobal,
        orElse: () => Offset.zero,
      );

  EditorState deepClone() => EditorState.fromJson(toJson());

  void debugLog() {
    debugPrint('EditorState Debug:');
    debugPrint('- Nodes: ${nodeState.nodes.length}');
    debugPrint('- Edges: ${edgeState.edges.length}');
    debugPrint('- Selected Nodes: ${selection.nodeIds}');
    debugPrint('- Selected Edges: ${selection.edgeIds}');
    debugPrint('- Interaction: $interaction');
  }

  /// 判断当前是否只有单个节点被选中
  bool get hasSingleNodeSelected => selection.nodeIds.length == 1;

  /// 判断当前是否有多个节点被选中
  bool get hasMultipleNodesSelected => selection.nodeIds.length > 1;

  /// 判断是否有边被选中
  bool get hasSelectedEdges => selection.edgeIds.isNotEmpty;

  /// 获取当前悬停的节点模型
  NodeModel? get hoveringNode => interaction.hoveringNodeId == null
      ? null
      : nodeState.nodes.firstWhereOrNull(
          (n) => n.id == interaction.hoveringNodeId,
        );

  /// 获取当前悬停的边模型
  EdgeModel? get hoveringEdge => interaction.hoveringEdgeId == null
      ? null
      : edgeState.edges.firstWhereOrNull(
          (e) => e.id == interaction.hoveringEdgeId,
        );

  /// 检查指定节点是否处于选中状态
  bool isNodeSelected(String nodeId) => selection.nodeIds.contains(nodeId);

  /// 检查指定边是否处于选中状态
  bool isEdgeSelected(String edgeId) => selection.edgeIds.contains(edgeId);

  /// 根据 ID 快速获取节点模型
  NodeModel? nodeById(String id) =>
      nodeState.nodes.firstWhereOrNull((n) => n.id == id);

  /// 根据 ID 快速获取边模型
  EdgeModel? edgeById(String id) =>
      edgeState.edges.firstWhereOrNull((e) => e.id == id);

  /// 获取所有 Group 节点
  List<NodeModel> get groupNodes =>
      nodeState.nodes.where((node) => node.isGroup).toList();

  /// 获取所有非 Group 节点
  List<NodeModel> get regularNodes =>
      nodeState.nodes.where((node) => !node.isGroup).toList();

  /// 获取指定 Group 节点内的所有子节点
  List<NodeModel> childrenOfGroup(String groupId) =>
      nodeState.nodes.where((node) => node.parentId == groupId).toList();

  /// 判断画布是否空白（没有任何节点和边）
  bool get isCanvasEmpty => nodeState.nodes.isEmpty && edgeState.edges.isEmpty;
}
