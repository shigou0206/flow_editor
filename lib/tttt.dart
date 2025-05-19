// main.dart
// -------------------------------------------------------------
// Canvas with separate layers to avoid clipping of node buttons
// Features: infinite pan/zoom for canvas, uncropped node and button overlays
// -------------------------------------------------------------

import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flow_editor/core/utils/anchor_position_utils.dart';
import 'package:flow_editor/core/models/node_model.dart';
import 'package:flow_editor/core/models/anchor_model.dart';
import 'package:flow_editor/core/models/edge_model.dart';
import 'package:flow_editor/core/models/state/node_state.dart';
import 'package:flow_editor/core/models/state/edge_state.dart';
import 'package:flow_editor/core/widgets/factories/node_widget_factory.dart';
import 'package:flow_editor/core/widgets/edge_button_overlay.dart';
import 'package:flow_editor/core/models/styles/canvas_visual_config.dart';
import 'package:flow_editor/core/painters/dotted_grid_painter.dart';
import 'package:flow_editor/core/painters/edge_renderer.dart';
import 'package:flow_editor/core/painters/path_generators/flexible_path_generator.dart';
import 'package:flow_editor/core/utils/edge_utils.dart';

extension _FirstWhereOrNull<T> on Iterable<T> {
  T? firstWhereOrNull(bool Function(T) test) {
    for (var e in this) if (test(e)) return e;
    return null;
  }
}

class CanvasRenderer extends StatefulWidget {
  final String workflowId;
  final Offset offset;
  final double scale;
  final NodeWidgetFactory nodeWidgetFactory;
  final NodeState nodeState;
  final EdgeState edgeState;
  final CanvasVisualConfig visualConfig;
  final bool isAnimated;
  final Duration duration;
  final String? hoveredEdgeId;

  const CanvasRenderer({
    Key? key,
    required this.workflowId,
    required this.offset,
    required this.scale,
    required this.nodeWidgetFactory,
    required this.nodeState,
    required this.edgeState,
    required this.visualConfig,
    this.hoveredEdgeId,
    this.isAnimated = false,
    this.duration = const Duration(seconds: 2),
  }) : super(key: key);

  @override
  State<CanvasRenderer> createState() => _CanvasRendererState();
}

class _CanvasRendererState extends State<CanvasRenderer>
    with SingleTickerProviderStateMixin {
  AnimationController? _controller;
  Animation<double>? _animation;

  @override
  void initState() {
    super.initState();
    if (widget.isAnimated) {
      _controller = AnimationController(vsync: this, duration: widget.duration);
      _animation = Tween(begin: 0.0, end: 1.0).animate(_controller!)
        ..addListener(() => setState(() {}));
      _controller!.forward();
    }
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final nodes = widget.nodeState.nodesOf(widget.workflowId);
    final edges = widget.edgeState.edgesOf(widget.workflowId);
    final validEdges = edges.where((e) => e.isConnected).toList();
    final ratio =
        widget.isAnimated && _animation != null ? _animation!.value : 0.45;

    // 1) Canvas Layer: grid + edges, clipped
    final canvasLayer = ClipRect(
      child: OverflowBox(
        maxWidth: double.infinity,
        maxHeight: double.infinity,
        alignment: Alignment.topLeft,
        child: Transform(
          alignment: Alignment.topLeft,
          transform: Matrix4.identity()
            ..translate(widget.offset.dx, widget.offset.dy)
            ..scale(widget.scale),
          child: Stack(children: [
            Positioned.fill(
              child: CustomPaint(
                painter: DottedGridPainter(
                  config: widget.visualConfig,
                  offset: Offset.zero,
                  scale: 1.0,
                  style: widget.visualConfig.backgroundStyle,
                  themeMode: Theme.of(context).brightness == Brightness.dark
                      ? ThemeMode.dark
                      : ThemeMode.light,
                ),
              ),
            ),
            CustomPaint(
              painter: EdgeRenderer(
                nodes: nodes,
                edges: edges,
                pathGenerator: FlexiblePathGenerator(nodes),
                draggingEdgeId: widget.edgeState.draggingEdgeId,
                draggingEnd: widget.edgeState.draggingEnd,
                hoveredEdgeId: widget.hoveredEdgeId,
                pathRatio: ratio,
              ),
            ),
          ]),
        ),
      ),
    );

    // 2) Node layer: uncropped
    final nodeWidgets = nodes.map((node) {
      final dx = widget.offset.dx +
          (node.position.dx - node.anchorPadding.left) * widget.scale;
      final dy = widget.offset.dy +
          (node.position.dy - node.anchorPadding.top) * widget.scale;
      return Positioned(
        left: dx,
        top: dy,
        child: Transform.scale(
          scale: widget.scale,
          alignment: Alignment.topLeft,
          transformHitTests: true,
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              widget.nodeWidgetFactory.createNodeWidget(node),
              // Example internal button
              Positioned(
                right: -16,
                top: -16,
                child: OverflowBox(
                  maxWidth: double.infinity,
                  maxHeight: double.infinity,
                  child: IconButton(
                    icon: const Icon(Icons.settings),
                    onPressed: () {
                      debugPrint('Node ${node.id} settings tapped');
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    });

    // 3) Edge button overlays: uncropped
    final edgeButtons = validEdges.map((edge) {
      final srcNode = nodes.firstWhereOrNull((n) => n.id == edge.sourceNodeId)!;
      final srcAnchor =
          srcNode.anchors!.firstWhere((a) => a.id == edge.sourceAnchorId);
      final srcWorld = computeAnchorWorldPosition(srcNode, srcAnchor, nodes) +
          Offset(srcAnchor.size.width / 2, srcAnchor.size.height / 2);
      final dstNode = nodes.firstWhereOrNull((n) => n.id == edge.targetNodeId)!;
      final dstAnchor =
          dstNode.anchors!.firstWhere((a) => a.id == edge.targetAnchorId);
      final dstWorld = computeAnchorWorldPosition(dstNode, dstAnchor, nodes) +
          Offset(dstAnchor.size.width / 2, dstAnchor.size.height / 2);
      final mid = Offset(
          (srcWorld.dx + dstWorld.dx) / 2, (srcWorld.dy + dstWorld.dy) / 2);
      const size = 24.0;
      final dx = widget.offset.dx + mid.dx * widget.scale;
      final dy = widget.offset.dy + mid.dy * widget.scale;
      return Positioned(
        left: dx - size / 2,
        top: dy - size / 2,
        child: Transform.scale(
          scale: widget.scale,
          alignment: Alignment.topLeft,
          transformHitTests: true,
          child: EdgeButtonOverlay(
            edgePoint: mid,
            size: size,
            onDeleteEdge: () => debugPrint('Delete edge ${edge.id}'),
          ),
        ),
      );
    });

    return Stack(
      clipBehavior: Clip.none,
      children: [
        canvasLayer,
        ...nodeWidgets,
        ...edgeButtons,
      ],
    );
  }
}
