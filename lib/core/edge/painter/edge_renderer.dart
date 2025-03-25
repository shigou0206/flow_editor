import 'package:flutter/material.dart';
import 'package:flow_editor/core/node/models/node_model.dart';
import 'package:flow_editor/core/edge/models/edge_model.dart';
import 'package:flow_editor/core/edge/models/edge_enums.dart';
import 'package:flow_editor/core/types/position_enum.dart';
import 'package:flow_editor/core/anchor/utils/anchor_position_utils.dart';
import 'package:flow_editor/core/edge/utils/edge_utils.dart';
import 'package:flow_editor/core/edge/style/edge_style_resolver.dart';

class EdgeRenderer extends CustomPainter {
  final List<NodeModel> nodes;
  final List<EdgeModel> edges;
  final Set<String> selectedEdgeIds;

  /// 当前正在拖拽的边ID
  final String? draggingEdgeId;

  /// 拖拽终点(鼠标位置)
  final Offset? draggingEnd;

  /// 是否绘制半连接（source端已确定，target端未定）的边
  final bool showHalfConnectedEdges;

  /// 用于控制边的绘制、样式：颜色 / dash / arrow
  final EdgeStyleResolver styleResolver;

  /// 新增: 悬停(hover)的边ID
  final String? hoveredEdgeId;

  const EdgeRenderer({
    required this.nodes,
    required this.edges,
    this.selectedEdgeIds = const {},
    this.draggingEdgeId,
    this.draggingEnd,
    this.hoveredEdgeId, // <-- 新增
    this.showHalfConnectedEdges = false,
    this.styleResolver = const EdgeStyleResolver(),
  });

  @override
  void paint(Canvas canvas, Size size) {
    // 1) 绘制已连接的边
    for (final edge in edges) {
      if (edge.isConnected &&
          edge.targetNodeId != null &&
          edge.targetAnchorId != null) {
        _drawEdge(canvas, edge);
      } else if (showHalfConnectedEdges) {
        _drawHalfConnectedEdge(canvas, edge);
      }
    }

    // 2) 绘制拖拽中的幽灵线
    _drawDraggingEdge(canvas);
  }

  /// 正常边绘制：使用 EdgeStyleResolver 构造 Path & Paint
  void _drawEdge(Canvas canvas, EdgeModel edge) {
    final (sourceWorld, sourcePos) =
        _getAnchorWorldInfo(edge.sourceNodeId, edge.sourceAnchorId);
    final (targetWorld, targetPos) =
        _getAnchorWorldInfo(edge.targetNodeId!, edge.targetAnchorId!);

    if (sourceWorld == null || targetWorld == null) return;

    // 1) 构建 Path
    final path = styleResolver.resolvePath(
      edge.lineStyle.edgeMode,
      sourceWorld,
      sourcePos,
      targetWorld,
      targetPos,
    );

    // 2) 判定是否选中, 是否 Hover
    final isSelected = selectedEdgeIds.contains(edge.id);
    final isHover = (edge.id == hoveredEdgeId); // <-- 判断当前边是否是 hovered

    // 3) 获取画笔
    final paint = styleResolver.resolvePaint(
      edge.lineStyle,
      isSelected,
      isHover: isHover,
    );

    // 4) 如果是 dash
    if (edge.lineStyle.dashPattern.isNotEmpty) {
      final dashedPath = dashPath(
        path,
        edge.lineStyle.dashPattern,
        phase: styleResolver.computeDashFlowPhase(edge.animConfig),
      );
      canvas.drawPath(dashedPath, paint);
    } else {
      canvas.drawPath(path, paint);
    }

    // 5) 箭头
    if (edge.lineStyle.arrowEnd != ArrowType.none) {
      drawArrowHead(canvas, path, paint, edge.lineStyle, atStart: false);
    }
    if (edge.lineStyle.arrowStart != ArrowType.none) {
      drawArrowHead(canvas, path, paint, edge.lineStyle, atStart: true);
    }
  }

  /// 半连接边：只有 source 端 anchor
  void _drawHalfConnectedEdge(Canvas canvas, EdgeModel edge) {
    final (sourceWorld, _) =
        _getAnchorWorldInfo(edge.sourceNodeId, edge.sourceAnchorId);
    if (sourceWorld == null) return;

    final fallbackEnd = sourceWorld + const Offset(50, 0);
    final isSelected = selectedEdgeIds.contains(edge.id);
    // 不做 hover 处理, 也可根据需求判断
    final paint = styleResolver.resolvePaint(
      edge.lineStyle,
      isSelected,
      isHover: false,
    );

    final path = Path()
      ..moveTo(sourceWorld.dx, sourceWorld.dy)
      ..lineTo(fallbackEnd.dx, fallbackEnd.dy);

    canvas.drawPath(path, paint);
  }

  /// 拖拽中的幽灵线
  void _drawDraggingEdge(Canvas canvas) {
    if (draggingEdgeId == null || draggingEnd == null) return;
    final edge = edges.firstWhereOrNull((e) => e.id == draggingEdgeId);
    if (edge == null || edge.isConnected) return;

    final (sourceWorld, sourcePos) =
        _getAnchorWorldInfo(edge.sourceNodeId, edge.sourceAnchorId);
    if (sourceWorld == null) return;

    final path = styleResolver.resolveGhostPath(
      edge.lineStyle.edgeMode,
      sourceWorld,
      sourcePos,
      draggingEnd!,
    );

    // 拖拽中的幽灵线，用 resolveGhostPaint
    final paint = styleResolver.resolveGhostPaint(edge.lineStyle);
    canvas.drawPath(path, paint);
  }

  /// 获取 anchor 世界坐标和方向
  (Offset?, Position?) _getAnchorWorldInfo(String nodeId, String anchorId) {
    final node = nodes.firstWhereOrNull((n) => n.id == nodeId);
    final anchor = node?.anchors.firstWhereOrNull((a) => a.id == anchorId);
    if (node == null || anchor == null) return (null, null);

    final worldPos = computeAnchorWorldPosition(node, anchor) +
        Offset(anchor.width / 2, anchor.height / 2);
    return (worldPos, anchor.position);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}

extension FirstWhereOrNull<E> on Iterable<E> {
  E? firstWhereOrNull(bool Function(E e) test) =>
      cast<E?>().firstWhere((x) => x != null && test(x), orElse: () => null);
}
