import 'package:flutter/material.dart';
import 'dart:math' show pi;
import 'package:flow_editor/core/node/models/node_model.dart';
import 'package:flow_editor/core/edge/models/edge_model.dart';
import 'package:flow_editor/core/edge/models/edge_enums.dart';
import 'package:flow_editor/core/edge/models/edge_animation_config.dart';
import 'package:flow_editor/core/edge/edge_utils.dart'; // buildEdgePaint, dashPath, drawArrowHead, getBezierPath
import 'package:flow_editor/core/types/position_enum.dart';
import 'package:flow_editor/core/anchor/utils/anchor_position_utils.dart';

class EdgeRenderer extends CustomPainter {
  /// 当前画布内的所有节点（世界坐标）
  final List<NodeModel> nodes;

  /// 当前画布内的所有连线
  final List<EdgeModel> edges;

  /// 选中的边ID集合，用于高亮或其它效果
  final Set<String> selectedEdgeIds;

  /// 拖拽中的边ID
  final String? draggingEdgeId;

  /// 拖拽结束点（鼠标所在画布坐标）
  final Offset? draggingEnd;

  /// 是否绘制半连接（source连接了，target未连）
  final bool showHalfConnectedEdges;

  /// 默认是否使用贝塞尔曲线
  final bool defaultUseBezier;

  /// 用于与 NodeWidget 保持一致的锚点尺寸（影响 outside padding 计算）
  final double anchorWidgetSize;

  const EdgeRenderer({
    required this.nodes,
    required this.edges,
    this.selectedEdgeIds = const {},
    this.draggingEdgeId,
    this.draggingEnd,
    this.showHalfConnectedEdges = false,
    this.defaultUseBezier = false,
    this.anchorWidgetSize = 24.0,
  });

  @override
  void paint(Canvas canvas, Size size) {
    debugPrint('[EdgeRenderer] start paint => size=$size');

    // 遍历所有边绘制
    for (final edge in edges) {
      debugPrint('[EdgeRenderer] Checking edge: ${edge.id} '
          'isConnected=${edge.isConnected} '
          'source=${edge.sourceNodeId}:${edge.sourceAnchorId} '
          'target=${edge.targetNodeId}:${edge.targetAnchorId}');
      if (edge.isConnected &&
          edge.targetNodeId != null &&
          edge.targetAnchorId != null) {
        _drawEdge(canvas, edge);
      } else if (showHalfConnectedEdges) {
        _drawHalfConnectedEdge(canvas, edge);
      }
    }

    // 绘制拖拽中的 ghost line
    _drawDraggingEdge(canvas);
    debugPrint('[EdgeRenderer] end paint.');
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
    debugPrint('[EdgeRenderer] _drawEdge: '
        'sourceWorld=$sourceWorld, targetWorld=$targetWorld');
    if (sourceWorld == null || targetWorld == null) {
      debugPrint(
          '[EdgeRenderer] _drawEdge: Missing anchor info, skipping edge ${edge.id}');
      return;
    }

    final p1 = sourceWorld;
    final p2 = targetWorld;
    debugPrint('[EdgeRenderer] _drawEdge: p1=$p1, p2=$p2');

    Path path = _buildEdgePath(p1, p2, sourcePos, targetPos, edge);
    final isSelected = selectedEdgeIds.contains(edge.id);
    final paint = buildEdgePaint(edge.lineStyle, edge.animConfig, isSelected);
    debugPrint(
        '[EdgeRenderer] _drawEdge: paint: color=${paint.color}, strokeWidth=${paint.strokeWidth}');
    if (edge.lineStyle.dashPattern.isNotEmpty) {
      path = dashPath(
        path,
        edge.lineStyle.dashPattern,
        phase: _computeDashFlowPhase(edge.animConfig),
      );
      debugPrint('[EdgeRenderer] _drawEdge: applied dash pattern');
    }
    canvas.drawPath(path, paint);
    debugPrint('[EdgeRenderer] _drawEdge: Path drawn for edge ${edge.id}');

    if (edge.lineStyle.arrowEnd != ArrowType.none) {
      drawArrowHead(canvas, path, paint, edge.lineStyle, atStart: false);
      debugPrint('[EdgeRenderer] _drawEdge: Arrow drawn at end');
    }
    if (edge.lineStyle.arrowStart != ArrowType.none) {
      drawArrowHead(canvas, path, paint, edge.lineStyle, atStart: true);
      debugPrint('[EdgeRenderer] _drawEdge: Arrow drawn at start');
    }
  }

  void _drawHalfConnectedEdge(Canvas canvas, EdgeModel edge) {
    final (sourceWorld, _) = _getAnchorWorldInfo(
      edge.sourceNodeId,
      edge.sourceAnchorId,
    );
    if (sourceWorld == null) {
      debugPrint(
          '[EdgeRenderer] _drawHalfConnectedEdge: source anchor not found for edge ${edge.id}');
      return;
    }
    final p1 = sourceWorld;
    final p2 = p1 + const Offset(50, 0);
    final isSelected = selectedEdgeIds.contains(edge.id);
    final paint = buildEdgePaint(edge.lineStyle, edge.animConfig, isSelected);
    final path = _buildEdgePath(p1, p2, null, null, edge);
    debugPrint(
        '[EdgeRenderer] _drawHalfConnectedEdge: drawing half edge for ${edge.id}');
    canvas.drawPath(path, paint);
  }

  void _drawDraggingEdge(Canvas canvas) {
    if (draggingEdgeId == null || draggingEnd == null) {
      debugPrint('[EdgeRenderer] _drawDraggingEdge: No ghost edge to draw');
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
      debugPrint('[EdgeRenderer] _drawDraggingEdge: Source anchor not found');
      return;
    }
    final p1 = sourceWorld;
    final p2 = draggingEnd!;
    debugPrint('[EdgeRenderer] _drawDraggingEdge: ghost line from $p1 to $p2');
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
        path.lineTo(w[0], w[1]); // 这里假设是世界坐标
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
      debugPrint('[EdgeRenderer] _buildEdgePath: Using bezier curve');
      return result[0] as Path;
    }
    debugPrint('[EdgeRenderer] _buildEdgePath: Using straight line');
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

  (Offset?, Position?) _getAnchorWorldInfo(String nodeId, String anchorId) {
    final node = nodes.firstWhereOrNull((n) => n.id == nodeId);
    if (node == null) {
      debugPrint('[EdgeRenderer] _getAnchorWorldInfo: Node $nodeId not found');
      return (null, null);
    }
    final anchor = node.anchors.firstWhereOrNull((a) => a.id == anchorId);
    if (anchor == null) {
      debugPrint(
          '[EdgeRenderer] _getAnchorWorldInfo: Anchor $anchorId not found in node $nodeId');
      return (null, null);
    }
    final padding = computeAnchorPadding(
      node.anchors,
      anchorWidgetSize: anchorWidgetSize,
    );
    final containerPos = Offset(node.x - padding.left, node.y - padding.top);
    final localPos = computeAnchorLocalPosition(
      anchor,
      Size(node.width, node.height),
      anchorWidgetSize: anchorWidgetSize,
    );
    final worldPos = containerPos + localPos;
    debugPrint('[EdgeRenderer] _getAnchorWorldInfo: '
        'node=$nodeId, anchor=$anchorId, containerPos=$containerPos, localPos=$localPos, worldPos=$worldPos');
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
