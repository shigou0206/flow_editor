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
  }) = _EditorState;

  factory EditorState.fromJson(Map<String, dynamic> json) =>
      _$EditorStateFromJson(json);
}

/// lib/core/models/state/editor_state.dart

extension EditorStateRendering on EditorState {
  /// 把 nodeState.nodes + interaction.draggingNode 合并，
  /// 生成一个“渲染用”的节点列表。
  List<NodeModel> get renderedNodes {
    final dn = interaction.mapOrNull(dragNode: (d) => d);
    if (dn == null) return nodeState.nodes;

    return nodeState.nodes.map((node) {
      if (node.id != dn.nodeId) return node;
      // 计算偏移：当前画布坐标 - 拖拽开始时画布坐标
      // 注意这里需要把 lastCanvas 存在 interaction 中
      final delta = dn.lastCanvas - dn.startCanvas;
      return node.copyWith(position: node.position + delta);
    }).toList();
  }

  /// 把 edgeState.edges + interaction.dragEdge 合并，
  /// 生成一个“渲染用”的边列表，包含 ghost edge。
  List<EdgeModel> get renderedEdges {
    final de = interaction.mapOrNull(dragEdge: (d) => d);
    final base = edgeState.edges;
    if (de == null) return base;

    // 1) 更新那条正在拖动的边的终点到 de.lastCanvas
    final idx = base.indexWhere((e) => e.id == de.edgeId);
    final updated = List<EdgeModel>.from(base);
    if (idx >= 0) {
      final old = updated[idx];
      // 我这里假设 waypoints 最后一个点就是终点
      final points = List<Offset>.from(old.waypoints ?? []);
      if (points.isNotEmpty) {
        points[points.length - 1] = de.lastCanvas;
      } else {
        points.add(de.lastCanvas);
      }
      updated[idx] = old.copyWith(waypoints: points);
    }
    return updated;
  }
}

extension EditorStateExtras on EditorState {
  // 是否拖拽中
  bool get isDragging => interaction.isDragging;
  bool get isHovering => interaction.isHovering;

  // 快速访问焦点节点
  String? get focusedNodeId =>
      selection.nodeIds.length == 1 ? selection.nodeIds.first : null;

  NodeModel? get focusedNode => nodeState.nodes.firstWhereOrNull(
        (n) => n.id == focusedNodeId,
      );

  // 快速访问选中节点/边
  List<NodeModel> get selectedNodes =>
      nodeState.nodes.where((n) => selection.nodeIds.contains(n.id)).toList();

  List<EdgeModel> get selectedEdges =>
      edgeState.edges.where((e) => selection.edgeIds.contains(e.id)).toList();

  // 空状态检查
  bool get hasNodes => nodeState.nodes.isNotEmpty;
  bool get hasEdges => edgeState.edges.isNotEmpty;

  // 所有节点整体边界计算
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

  // 临时交互偏移快速获取
  Offset get currentInteractionOffset => interaction.maybeWhen(
        dragNode: (_, __, lastCanvas) => lastCanvas,
        dragEdge: (_, __, lastCanvas, ___) => lastCanvas,
        panCanvas: (_, lastGlobal) => lastGlobal,
        orElse: () => Offset.zero,
      );

  // 状态深拷贝
  EditorState deepClone() => EditorState.fromJson(toJson());

  // 调试状态打印
  void debugLog() {
    debugPrint('EditorState Debug:');
    debugPrint('- Nodes: ${nodeState.nodes.length}');
    debugPrint('- Edges: ${edgeState.edges.length}');
    debugPrint('- Selected Nodes: ${selection.nodeIds}');
    debugPrint('- Selected Edges: ${selection.edgeIds}');
    debugPrint('- Interaction: $interaction');
  }
}
