// import 'package:flutter/material.dart';
// import 'package:flow_editor/core/models/node_model.dart';
// import 'package:flow_editor/core/models/edge_model.dart';
// import 'package:flow_editor/ui/edge/edge_style_resolver.dart';
// import 'package:flow_editor/core/painters/path_generators/path_generator.dart';
// import 'package:flow_editor/core/utils/canvas_utils.dart';
// import 'package:flow_editor/core/models/styles/edge_line_style.dart';

// class EdgeRenderer extends CustomPainter {
//   final List<NodeModel> nodes;
//   final List<EdgeModel> edges;
//   final PathGenerator pathGenerator;
//   final EdgeStyleResolver styleResolver;

//   final Set<String> selectedEdgeIds;
//   final String? hoveredEdgeId;

//   final String? draggingEdgeId;
//   final Offset? draggingEnd;

//   EdgeRenderer({
//     required this.nodes,
//     required this.edges,
//     required this.pathGenerator,
//     this.styleResolver = const EdgeStyleResolver(),
//     this.selectedEdgeIds = const {},
//     this.hoveredEdgeId,
//     this.draggingEdgeId,
//     this.draggingEnd,
//   });

//   @override
//   void paint(Canvas canvas, Size size) {
//     for (final edge in edges) {
//       _drawEdge(canvas, edge);
//     }
//     _drawGhostEdge(canvas);
//   }

//   void _drawEdge(Canvas canvas, EdgeModel edge) {
//     final isHighlighted = edge.id == hoveredEdgeId;
//     debugPrint('🎨 渲染边 ${edge.id}, isHighlighted: $isHighlighted');

//     final edgePath = pathGenerator.generate(edge);

//     if (edgePath == null) return;

//     final isSelected = selectedEdgeIds.contains(edge.id);
//     final isHovered = hoveredEdgeId == edge.id;

//     final paint = styleResolver.resolvePaint(
//       edge.lineStyle,
//       isSelected,
//       isHover: isHovered,
//     );

//     canvas.drawPath(edgePath.path, paint);

//     List<Offset>? absoluteWaypoints;
//     if (edge.waypoints != null && edge.waypoints!.isNotEmpty) {
//       absoluteWaypoints = mapEdgeWaypointsToAbsolute(edge, nodes);
//     }

//     styleResolver.drawArrowIfNeeded(
//       canvas: canvas,
//       path: edgePath.path,
//       paint: paint,
//       style: edge.lineStyle,
//       waypoints: absoluteWaypoints,
//     );
//   }

//   void _drawGhostEdge(Canvas canvas) {
//     if (draggingEdgeId == null || draggingEnd == null) return;

//     final edge = edges.firstWhere(
//       (e) => e.id == draggingEdgeId,
//       orElse: () => EdgeModel(
//         id: draggingEdgeId!,
//         sourceNodeId: '',
//         sourceAnchorId: '',
//         targetNodeId: null,
//         targetAnchorId: null,
//       ),
//     );

//     final ghostEdgePath = pathGenerator.generateGhost(edge, draggingEnd!);
//     if (ghostEdgePath == null) return;

//     final paint = styleResolver.resolveGhostPaint(const EdgeLineStyle());

//     canvas.drawPath(ghostEdgePath.path, paint);

//     styleResolver.drawArrowIfNeeded(
//       canvas: canvas,
//       path: ghostEdgePath.path,
//       paint: paint,
//       style: const EdgeLineStyle(),
//     );
//   }

//   @override
//   bool shouldRepaint(covariant EdgeRenderer oldDelegate) {
//     return oldDelegate.nodes != nodes ||
//         oldDelegate.edges != edges ||
//         oldDelegate.draggingEdgeId != draggingEdgeId ||
//         oldDelegate.draggingEnd != draggingEnd ||
//         oldDelegate.hoveredEdgeId != hoveredEdgeId ||
//         oldDelegate.selectedEdgeIds != selectedEdgeIds;
//   }
// }

import 'package:flutter/material.dart';
import 'package:flow_editor/core/models/ui/node_model.dart';
import 'package:flow_editor/core/models/ui/edge_model.dart';
import 'package:flow_editor/ui/edge/edge_style_resolver.dart';
import 'package:flow_editor/core/painters/path_generators/path_generator.dart';
import 'package:flow_editor/core/utils/canvas_utils.dart';
import 'package:flow_editor/core/models/styles/edge_line_style.dart';

class EdgeRenderer extends CustomPainter {
  final BuildContext context; // 新增 context 以访问主题颜色
  final List<NodeModel> nodes;
  final List<EdgeModel> edges;
  final PathGenerator pathGenerator;
  final EdgeStyleResolver styleResolver;

  final Set<String> selectedEdgeIds;
  final String? hoveredEdgeId;

  final String? draggingEdgeId;
  final Offset? draggingEnd;

  EdgeRenderer({
    required this.context, // 新增 context 参数
    required this.nodes,
    required this.edges,
    required this.pathGenerator,
    this.styleResolver = const EdgeStyleResolver(),
    this.selectedEdgeIds = const {},
    this.hoveredEdgeId,
    this.draggingEdgeId,
    this.draggingEnd,
  });

  @override
  void paint(Canvas canvas, Size size) {
    for (final edge in edges) {
      _drawEdge(canvas, edge);
    }
    _drawGhostEdge(canvas);
  }

  void _drawEdge(Canvas canvas, EdgeModel edge) {
    final edgePath = pathGenerator.generate(edge);
    if (edgePath == null) return;

    final isSelected = selectedEdgeIds.contains(edge.id);
    final isHovered = hoveredEdgeId == edge.id;

    final paint = _resolvePaint(
      lineStyle: edge.lineStyle,
      isSelected: isSelected,
      isHovered: isHovered,
    );

    canvas.drawPath(edgePath.path, paint);

    List<Offset>? absoluteWaypoints;
    if (edge.waypoints != null && edge.waypoints!.isNotEmpty) {
      absoluteWaypoints = mapEdgeWaypointsToAbsolute(edge, nodes);
    }

    styleResolver.drawArrowIfNeeded(
      canvas: canvas,
      path: edgePath.path,
      paint: paint,
      style: edge.lineStyle,
      waypoints: absoluteWaypoints,
    );
  }

  void _drawGhostEdge(Canvas canvas) {
    if (draggingEdgeId == null || draggingEnd == null) return;

    final edge = edges.firstWhere(
      (e) => e.id == draggingEdgeId,
      orElse: () => EdgeModel(
        id: draggingEdgeId!,
        sourceNodeId: '',
        sourceAnchorId: '',
        targetNodeId: null,
        targetAnchorId: null,
      ),
    );

    final ghostEdgePath = pathGenerator.generateGhost(edge, draggingEnd!);
    if (ghostEdgePath == null) return;

    final paint = _resolveGhostPaint();

    canvas.drawPath(ghostEdgePath.path, paint);

    styleResolver.drawArrowIfNeeded(
      canvas: canvas,
      path: ghostEdgePath.path,
      paint: paint,
      style: const EdgeLineStyle(),
    );
  }

  Paint _resolvePaint({
    required EdgeLineStyle lineStyle,
    bool isSelected = false,
    bool isHovered = false,
  }) {
    final theme = Theme.of(context).colorScheme;

    Color color = theme.outlineVariant;
    double strokeWidth = lineStyle.strokeWidth;
    double opacity = 0.9; // 提高默认透明度

    if (isSelected) {
      color = theme.primary;
      strokeWidth += 1.5;
      opacity = 1.0;
    } else if (isHovered) {
      color = theme.secondary;
      strokeWidth += 1.0;
      opacity = 1.0;
    }

    return Paint()
      ..color = color.withOpacity(opacity)
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;
  }

  Paint _resolveGhostPaint() {
    final theme = Theme.of(context).colorScheme;

    return Paint()
      ..color = theme.primary.withOpacity(0.5) // 使用primary颜色提高对比度
      ..strokeWidth = 2.0
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;
  }

  @override
  bool shouldRepaint(covariant EdgeRenderer oldDelegate) {
    return oldDelegate.nodes != nodes ||
        oldDelegate.edges != edges ||
        oldDelegate.draggingEdgeId != draggingEdgeId ||
        oldDelegate.draggingEnd != draggingEnd ||
        oldDelegate.hoveredEdgeId != hoveredEdgeId ||
        oldDelegate.selectedEdgeIds != selectedEdgeIds;
  }
}
