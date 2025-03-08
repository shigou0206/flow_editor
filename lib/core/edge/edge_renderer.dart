import 'package:flutter/material.dart';
import 'package:flow_editor/core/node/models/node_model.dart';
import 'package:flow_editor/core/edge/models/edge_model.dart';
import 'package:flow_editor/core/edge/models/edge_enums.dart';
import 'package:flow_editor/core/edge/models/edge_animation_config.dart';
import 'package:flow_editor/core/edge/edge_utils.dart'; // 包含 buildEdgePaint、dashPath、drawArrowHead、getBezierPath
import 'package:flow_editor/core/types/position_enum.dart';
import 'package:flow_editor/core/anchor/utils/anchor_position_utils.dart';

class EdgeRenderer extends CustomPainter {
  /// 当前画布内所有节点（世界坐标）
  final List<NodeModel> nodes;

  /// 当前画布内所有连线
  final List<EdgeModel> edges;

  /// 选中的边ID集合，用于高亮等效果
  final Set<String> selectedEdgeIds;

  /// 拖拽中的边ID（ghost edge）
  final String? draggingEdgeId;

  /// 拖拽结束点（世界坐标下，由外层 Listener 提供）
  final Offset? draggingEnd;

  /// 是否绘制半连接（即目标未连的情况）
  final bool showHalfConnectedEdges;

  /// 默认是否使用贝塞尔曲线绘制边
  final bool defaultUseBezier;

  const EdgeRenderer({
    required this.nodes,
    required this.edges,
    this.selectedEdgeIds = const {},
    this.draggingEdgeId,
    this.draggingEnd,
    this.showHalfConnectedEdges = false,
    this.defaultUseBezier = false,
  });

  @override
  void paint(Canvas canvas, Size size) {
    for (final edge in edges) {
      if (edge.isConnected &&
          edge.targetNodeId != null &&
          edge.targetAnchorId != null) {
        _drawEdge(canvas, edge);
      } else if (showHalfConnectedEdges) {
        _drawHalfConnectedEdge(canvas, edge);
      }
    }
    _drawDraggingEdge(canvas);
  }

  void _drawEdge(Canvas canvas, EdgeModel edge) {
    final (sourceWorld, sourcePos) = _getAnchorWorldInfo(
      edge.sourceNodeId,
      edge.sourceAnchorId,
    );
    final (targetWorld, targetPos) = _getAnchorWorldInfo(
      edge.targetNodeId!,
      edge.targetAnchorId!,
    );

    if (sourceWorld == null || targetWorld == null) {
      return;
    }

    // 直接使用计算出的世界坐标
    final p1 = sourceWorld;
    final p2 = targetWorld;

    // 构建边的路径
    Path path = _buildEdgePath(p1, p2, sourcePos, targetPos, edge);
    final isSelected = selectedEdgeIds.contains(edge.id);
    final paint = buildEdgePaint(edge.lineStyle, edge.animConfig, isSelected);

    if (edge.lineStyle.dashPattern.isNotEmpty) {
      path = dashPath(
        path,
        edge.lineStyle.dashPattern,
        phase: _computeDashFlowPhase(edge.animConfig),
      );
    }
    canvas.drawPath(path, paint);

    if (edge.lineStyle.arrowEnd != ArrowType.none) {
      drawArrowHead(canvas, path, paint, edge.lineStyle, atStart: false);
    }
    if (edge.lineStyle.arrowStart != ArrowType.none) {
      drawArrowHead(canvas, path, paint, edge.lineStyle, atStart: true);
    }
  }

  void _drawHalfConnectedEdge(Canvas canvas, EdgeModel edge) {
    final (sourceWorld, _) = _getAnchorWorldInfo(
      edge.sourceNodeId,
      edge.sourceAnchorId,
    );
    if (sourceWorld == null) {
      return;
    }
    final p1 = sourceWorld;
    final p2 = p1 + const Offset(50, 0); // fallback: 假设水平向右延伸50像素
    final isSelected = selectedEdgeIds.contains(edge.id);
    final paint = buildEdgePaint(edge.lineStyle, edge.animConfig, isSelected);
    final path = _buildEdgePath(p1, p2, null, null, edge);
    canvas.drawPath(path, paint);
  }

  void _drawDraggingEdge(Canvas canvas) {
    if (draggingEdgeId == null || draggingEnd == null) {
      return;
    }
    final edge = edges.firstWhere(
      (e) => e.id == draggingEdgeId,
      orElse: () => const EdgeModel(
        id: 'tempDrag',
        sourceNodeId: 'tempSource',
        sourceAnchorId: 'tempAnchor',
      ),
    );
    final (sourceWorld, _) = _getAnchorWorldInfo(
      edge.sourceNodeId,
      edge.sourceAnchorId,
    );
    if (sourceWorld == null) {
      return;
    }
    final p1 = sourceWorld;
    final p2 = draggingEnd!;
    final paint = Paint()
      ..color = Colors.orange
      ..strokeWidth = 3
      ..style = PaintingStyle.stroke;
    final path = _buildEdgePath(p1, p2, null, null, edge);
    canvas.drawPath(path, paint);
  }

  Path _buildEdgePath(
    Offset p1,
    Offset p2,
    Position? sourcePos,
    Position? targetPos,
    EdgeModel edge,
  ) {
    if (edge.waypoints != null && edge.waypoints!.isNotEmpty) {
      final path = Path()..moveTo(p1.dx, p1.dy);
      for (final w in edge.waypoints!) {
        path.lineTo(w[0], w[1]); // 这里假设 waypoints 是世界坐标
      }
      path.lineTo(p2.dx, p2.dy);
      return path;
    }
    final useBezier = edge.lineStyle.useBezier || defaultUseBezier;
    if (useBezier && sourcePos != null && targetPos != null) {
      final result = getBezierPath(
        sourceX: p1.dx,
        sourceY: p1.dy,
        sourcePosition: sourcePos,
        targetX: p2.dx,
        targetY: p2.dy,
        targetPosition: targetPos,
        curvature: 0.25,
      );
      return result[0] as Path;
    }
    return Path()
      ..moveTo(p1.dx, p1.dy)
      ..lineTo(p2.dx, p2.dy);
  }

  double _computeDashFlowPhase(EdgeAnimationConfig anim) {
    if (anim.animateDash == true && anim.dashFlowPhase != null) {
      return anim.dashFlowPhase!;
    }
    return 0;
  }

  /// 核心：获取锚点的世界坐标和其位置（Position）
  (Offset?, Position?) _getAnchorWorldInfo(String nodeId, String anchorId) {
    final node = nodes.firstWhereOrNull((n) => n.id == nodeId);
    if (node == null) {
      return (null, null);
    }
    final anchor = node.anchors.firstWhereOrNull((a) => a.id == anchorId);
    if (anchor == null) {
      return (null, null);
    }

    // 计算锚点在世界坐标系中的位置
    final worldPos = computeAnchorWorldPosition(node, anchor) +
        Offset(anchor.width / 2, anchor.height / 2);

    return (worldPos, anchor.position);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

extension FirstWhereOrNull<E> on Iterable<E> {
  E? firstWhereOrNull(bool Function(E e) test) {
    for (final x in this) {
      if (test(x)) return x;
    }
    return null;
  }
}
