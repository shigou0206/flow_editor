// import 'package:flutter/material.dart';
// import 'package:flow_editor/core/node/models/node_model.dart';
// import 'package:flow_editor/core/edge/models/edge_model.dart';
// import 'package:flow_editor/core/edge/models/edge_enums.dart';
// import 'package:flow_editor/core/types/position_enum.dart';
// import 'package:flow_editor/core/anchor/utils/anchor_position_utils.dart';
// import 'package:flow_editor/core/edge/utils/edge_utils.dart';
// import 'package:flow_editor/core/edge/style/edge_style_resolver.dart';

// class EdgeRenderer extends CustomPainter {
//   final List<NodeModel> nodes;
//   final List<EdgeModel> edges;
//   final Set<String> selectedEdgeIds;

//   final String? draggingEdgeId;
//   final Offset? draggingEnd;
//   final bool showHalfConnectedEdges;
//   final EdgeStyleResolver styleResolver;
//   final String? hoveredEdgeId;

//   const EdgeRenderer({
//     required this.nodes,
//     required this.edges,
//     this.selectedEdgeIds = const {},
//     this.draggingEdgeId,
//     this.draggingEnd,
//     this.hoveredEdgeId,
//     this.showHalfConnectedEdges = false,
//     this.styleResolver = const EdgeStyleResolver(),
//   });

//   @override
//   void paint(Canvas canvas, Size size) {
//     for (final edge in edges) {
//       if (edge.isConnected) {
//         if (_hasValidAnchors(edge)) {
//           _drawAnchorBasedEdge(canvas, edge);
//         } else if (_hasWaypoints(edge)) {
//           _drawWaypointsEdge(canvas, edge);
//         }
//       } else if (showHalfConnectedEdges) {
//         _drawHalfConnectedEdge(canvas, edge);
//       }
//     }

//     _drawDraggingEdge(canvas);
//   }

//   bool _hasValidAnchors(EdgeModel edge) {
//     return edge.sourceAnchorId != null &&
//         edge.targetAnchorId != null &&
//         nodes.any((n) => n.id == edge.sourceNodeId) &&
//         nodes.any((n) => n.id == edge.targetNodeId);
//   }

//   bool _hasWaypoints(EdgeModel edge) {
//     return edge.waypoints != null && edge.waypoints!.length >= 2;
//   }

//   void _drawAnchorBasedEdge(Canvas canvas, EdgeModel edge) {
//     final (sourceWorld, sourcePos) =
//         _getAnchorWorldInfo(edge.sourceNodeId, edge.sourceAnchorId);
//     final (targetWorld, targetPos) =
//         _getAnchorWorldInfo(edge.targetNodeId!, edge.targetAnchorId!);

//     if (sourceWorld == null || targetWorld == null) return;

//     final path = styleResolver.resolvePath(
//       edge.lineStyle.edgeMode,
//       sourceWorld,
//       sourcePos,
//       targetWorld,
//       targetPos,
//     );

//     _drawEdgePath(canvas, edge, path);
//   }

//   void _drawWaypointsEdge(Canvas canvas, EdgeModel edge) {
//     final points = edge.waypoints!.map((p) => Offset(p[0], p[1])).toList();

//     if (points.length < 2) return;

//     final path = Path()..moveTo(points[0].dx, points[0].dy);
//     for (var i = 1; i < points.length; i++) {
//       path.lineTo(points[i].dx, points[i].dy);
//     }

//     _drawEdgePath(canvas, edge, path);
//   }

//   void _drawEdgePath(Canvas canvas, EdgeModel edge, Path path) {
//     final isSelected = selectedEdgeIds.contains(edge.id);
//     final isHover = edge.id == hoveredEdgeId;

//     final paint = styleResolver.resolvePaint(
//       edge.lineStyle,
//       isSelected,
//       isHover: isHover,
//     );

//     if (edge.lineStyle.dashPattern.isNotEmpty) {
//       final dashedPath = dashPath(
//         path,
//         edge.lineStyle.dashPattern,
//         phase: styleResolver.computeDashFlowPhase(edge.animConfig),
//       );
//       canvas.drawPath(dashedPath, paint);
//     } else {
//       canvas.drawPath(path, paint);
//     }

//     if (edge.lineStyle.arrowEnd != ArrowType.none) {
//       drawArrowHead(canvas, path, paint, edge.lineStyle, atStart: false);
//     }
//     if (edge.lineStyle.arrowStart != ArrowType.none) {
//       drawArrowHead(canvas, path, paint, edge.lineStyle, atStart: true);
//     }
//   }

//   void _drawHalfConnectedEdge(Canvas canvas, EdgeModel edge) {
//     final (sourceWorld, _) =
//         _getAnchorWorldInfo(edge.sourceNodeId, edge.sourceAnchorId);
//     if (sourceWorld == null) return;

//     final fallbackEnd = sourceWorld + const Offset(50, 0);
//     final isSelected = selectedEdgeIds.contains(edge.id);
//     final paint = styleResolver.resolvePaint(edge.lineStyle, isSelected);

//     final path = Path()
//       ..moveTo(sourceWorld.dx, sourceWorld.dy)
//       ..lineTo(fallbackEnd.dx, fallbackEnd.dy);

//     canvas.drawPath(path, paint);
//   }

//   void _drawDraggingEdge(Canvas canvas) {
//     if (draggingEdgeId == null || draggingEnd == null) return;
//     final edge = edges.firstWhereOrNull((e) => e.id == draggingEdgeId);
//     if (edge == null || edge.isConnected) return;

//     final (sourceWorld, sourcePos) =
//         _getAnchorWorldInfo(edge.sourceNodeId, edge.sourceAnchorId);
//     if (sourceWorld == null) return;

//     final path = styleResolver.resolveGhostPath(
//       edge.lineStyle.edgeMode,
//       sourceWorld,
//       sourcePos,
//       draggingEnd!,
//     );

//     final paint = styleResolver.resolveGhostPaint(edge.lineStyle);
//     canvas.drawPath(path, paint);
//   }

//   (Offset?, Position?) _getAnchorWorldInfo(String nodeId, String? anchorId) {
//     final node = nodes.firstWhereOrNull((n) => n.id == nodeId);
//     if (anchorId == null) return (null, null);
//     final anchor = node?.anchors?.firstWhereOrNull((a) => a.id == anchorId);
//     if (node == null || anchor == null) return (null, null);

//     final worldPos = computeAnchorWorldPosition(node, anchor, nodes) +
//         Offset(anchor.width / 2, anchor.height / 2);
//     return (worldPos, anchor.position);
//   }

//   @override
//   bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
// }

// extension FirstWhereOrNull<E> on Iterable<E> {
//   E? firstWhereOrNull(bool Function(E e) test) =>
//       cast<E?>().firstWhere((x) => x != null && test(x), orElse: () => null);
// }
