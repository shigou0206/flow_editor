import 'package:flutter/material.dart';
import 'package:flow_editor/v2/core/models/edge_model.dart';
import 'package:flow_editor/v2/core/models/node_model.dart';
import 'package:flow_editor/v2/core/models/enums.dart';
import 'package:flow_editor/v2/core/painters/path_generators/path_generator.dart';
import 'package:flow_editor/v2/core/painters/path_generators/edge_path.dart';
import 'package:flow_editor/v2/core/transform/transform_service.dart';
import 'package:flow_editor/v2/core/types/coordinate_typedefs.dart';
import 'package:flow_editor/v2/core/utils/edge_utils.dart';

class FlexiblePathGenerator implements PathGenerator {
  final List<NodeModel> nodes;
  final TransformService transform;
  final AnchorResolver anchorWorld;

  FlexiblePathGenerator(
    this.nodes, {
    required this.transform,
    required this.anchorWorld,
  });

  // ──────────────────────────────────────────
  @override
  EdgePath? generate(
    EdgeModel edge, {
    EdgeMode type = EdgeMode.bezier,
    bool smooth = true,
    double smoothRadius = 10,
  }) {
    // ① world 端点
    final pts = _edgeWorldPoints(edge);
    if (pts.length < 2) return null;

    // ② 若自带 waypoints 就按折线 / 圆滑生成
    if (edge.waypoints != null && edge.waypoints!.isNotEmpty) {
      final path = _generateFromWaypoints(pts,
          smooth: smooth, smoothRadius: smoothRadius);
      return EdgePath(edge.id, path);
    }

    // ③ 按风格生成（起点终点）
    final path = _createPath(
        pts.first, pts.last, type, _sourcePos(edge), _targetPos(edge));
    if (edge.attachments.isNotEmpty) {
      BezierUtils.lockAttachments(edge, path);
    }
    return EdgePath(edge.id, path);
  }

  @override
  EdgePath generateGhost(
    EdgeModel edge,
    Offset draggingEnd, {
    EdgeMode type = EdgeMode.bezier,
  }) {
    final p0 = _edgeWorldPoints(edge).first;
    final path = _createPath(
      p0,
      draggingEnd,
      type,
      _sourcePos(edge),
      _revisePos(_sourcePos(edge)),
    );
    return EdgePath(edge.id, path);
  }

  // ───────── helpers ─────────
  List<Offset> _edgeWorldPoints(EdgeModel e) {
    final list = <Offset>[];

    // 起点
    if (e.sourceNodeId != null) {
      final srcNode = nodes.firstWhereOrNull((n) => n.id == e.sourceNodeId);
      if (srcNode != null) {
        final anchor =
            srcNode.anchors.firstWhereOrNull((a) => a.id == e.sourceAnchorId);
        list.add(anchorWorld(srcNode.id, anchor?.id));
      }
    } else {
      list.add(
          transform.toWorld(e.start ?? Offset.zero, e.coordSpace, e.parentId));
    }

    // waypoints
    if (e.waypoints != null) {
      list.addAll(e.waypoints!
          .map((p) => transform.toWorld(p, e.coordSpace, e.parentId)));
    }

    // 终点
    if (e.targetNodeId != null) {
      final tgtNode = nodes.firstWhereOrNull((n) => n.id == e.targetNodeId);
      if (tgtNode != null) {
        final anchor =
            tgtNode.anchors.firstWhereOrNull((a) => a.id == e.targetAnchorId);
        list.add(anchorWorld(tgtNode.id, anchor?.id));
      }
    } else {
      list.add(
          transform.toWorld(e.end ?? Offset.zero, e.coordSpace, e.parentId));
    }

    return list;
  }

  // 起终锚点的方位
  Position? _sourcePos(EdgeModel e) => nodes
      .firstWhereOrNull((n) => n.id == e.sourceNodeId)
      ?.anchors
      .firstWhereOrNull((a) => a.id == e.sourceAnchorId)
      ?.position;

  Position? _targetPos(EdgeModel e) => nodes
      .firstWhereOrNull((n) => n.id == e.targetNodeId)
      ?.anchors
      .firstWhereOrNull((a) => a.id == e.targetAnchorId)
      ?.position;

  // 若为 null 给个对称方位
  Position _revisePos(Position? p) => switch (p) {
        Position.left => Position.right,
        Position.right => Position.left,
        Position.top => Position.bottom,
        _ => Position.top
      };

  // 生成各模式的 Path
  Path _createPath(
    Offset start,
    Offset end,
    EdgeMode mode,
    Position? srcPos,
    Position? tgtPos,
  ) {
    switch (mode) {
      case EdgeMode.bezier:
        return getBezierPath(
            sourceX: start.dx,
            sourceY: start.dy,
            sourcePos: srcPos ?? Position.right,
            targetX: end.dx,
            targetY: end.dy,
            targetPos: tgtPos ?? Position.left,
            curvature: .25)[0];

      case EdgeMode.hvBezier:
        return getHVBezierPath(
            sourceX: start.dx,
            sourceY: start.dy,
            sourcePos: srcPos ?? Position.right,
            targetX: end.dx,
            targetY: end.dy,
            targetPos: tgtPos ?? Position.left,
            offset: 50)[0];

      case EdgeMode.orthogonal3:
        return getOrthogonalPath3Segments(
            sx: start.dx,
            sy: start.dy,
            tx: end.dx,
            ty: end.dy,
            sourcePos: srcPos,
            targetPos: tgtPos,
            offsetDist: 40);

      case EdgeMode.orthogonal5:
        return getOrthogonalPath5Segments(
            sx: start.dx,
            sy: start.dy,
            tx: end.dx,
            ty: end.dy,
            sourcePos: srcPos,
            targetPos: tgtPos,
            offsetDist: 40);

      case EdgeMode.line:
      default:
        return simpleLinePath(start, end);
    }
  }

  // 折线路径 (支持 smooth)
  Path _generateFromWaypoints(
    List<Offset> pts, {
    bool smooth = false,
    double smoothRadius = 10,
  }) {
    final path = Path()..moveTo(pts.first.dx, pts.first.dy);
    if (!smooth || pts.length < 3) {
      for (final p in pts.skip(1)) {
        path.lineTo(p.dx, p.dy);
      }
      return path;
    }

    for (var i = 1; i < pts.length - 1; i++) {
      final prev = pts[i - 1], cur = pts[i], next = pts[i + 1];
      final vIn = (prev - cur).direction;
      final vOut = (next - cur).direction;
      final pIn = cur + Offset.fromDirection(vIn, smoothRadius);
      final pOut = cur + Offset.fromDirection(vOut, smoothRadius);
      if (i == 1) {
        path.lineTo(pIn.dx, pIn.dy);
      } else {
        path.lineTo(pIn.dx, pIn.dy);
      }
      path.quadraticBezierTo(cur.dx, cur.dy, pOut.dx, pOut.dy);
    }
    path.lineTo(pts.last.dx, pts.last.dy);
    return path;
  }
}

// small helpers
extension IterableX<E> on Iterable<E> {
  E? firstWhereOrNull(bool Function(E) test) {
    for (final e in this) {
      if (test(e)) return e;
    }
    return null;
  }
}
