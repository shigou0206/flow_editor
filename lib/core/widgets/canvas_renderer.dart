import 'package:flutter/material.dart';
import 'package:flow_editor/del/behaviors/node_behavior.dart';
import 'package:flow_editor/del/behaviors/anchor_behavior.dart';
import 'package:flow_editor/del/behaviors/canvas_behavior.dart';
import 'package:flow_editor/del/behaviors/edge_behavior.dart';
import 'package:flow_editor/core/utils/anchor_position_utils.dart';
import 'package:flow_editor/core/models/state/node_state.dart';
import 'package:flow_editor/core/widgets/factories/node_widget_factory.dart';
import 'package:flow_editor/core/models/state/edge_state.dart';
import 'package:flow_editor/core/widgets/edge_button_overlay.dart';
import 'package:flow_editor/core/models/styles/canvas_visual_config.dart';
import 'package:flow_editor/core/painters/dotted_grid_painter.dart';
// import 'package:flow_editor/core/edge/painter/edge_renderer.dart';
import 'package:flow_editor/core/painters/edge_renderer.dart';
import 'package:flow_editor/core/utils/edge_utils.dart';
import 'package:flow_editor/core/models/enums/position_enum.dart';
import 'package:flow_editor/core/plugins/edge_overlay_plugin.dart';
import 'package:flow_editor/core/painters/path_generators/flexible_path_generator.dart';

extension CanvasRendererIterableExtension<T> on Iterable<T> {
  T? firstWhereOrNullSafe(bool Function(T) test) {
    for (final element in this) {
      if (test(element)) return element;
    }
    return null;
  }
}

/// CanvasRenderer 支持两种模式：
/// 1. 静态模式 (isAnimated = false): 在路径上固定 0.45 位置
/// 2. 动态模式 (isAnimated = true): 使用 AnimationController 把位置从 0.0 ~ 1.0 动画
class CanvasRenderer extends StatefulWidget {
  final String workflowId;
  final Offset offset; // 画布平移量
  final double scale; // 画布缩放因子

  final NodeWidgetFactory nodeWidgetFactory;
  final NodeState nodeState;
  final EdgeState edgeState;
  final CanvasVisualConfig visualConfig;

  final NodeBehavior? nodeBehavior;
  final AnchorBehavior? anchorBehavior;
  final EdgeBehavior? edgeBehavior;
  final CanvasBehavior? canvasBehavior;

  final String? hoveredEdgeId;

  final List<EdgeOverlayPlugin> edgePlugins;

  /// 是否开启动画
  final bool isAnimated;

  /// 动画总时长
  final Duration duration;

  const CanvasRenderer({
    super.key,
    required this.workflowId,
    required this.offset,
    required this.scale,
    required this.nodeWidgetFactory,
    required this.nodeState,
    required this.edgeState,
    required this.visualConfig,
    this.nodeBehavior,
    this.anchorBehavior,
    this.edgeBehavior,
    this.canvasBehavior,
    this.hoveredEdgeId,
    this.edgePlugins = const [],
    this.isAnimated = false, // 默认静态
    this.duration = const Duration(seconds: 60), // 默认3秒
  });

  @override
  State<CanvasRenderer> createState() => _CanvasRendererState();
}

class _CanvasRendererState extends State<CanvasRenderer>
    with SingleTickerProviderStateMixin {
  AnimationController? _controller;
  Animation<double>? _animation; // 0.0 ~ 1.0

  @override
  void initState() {
    super.initState();

    if (widget.isAnimated) {
      // 如果开启动画，则初始化 AnimationController
      _controller = AnimationController(
        vsync: this,
        duration: widget.duration,
      );
      _animation = Tween<double>(begin: 0.0, end: 1.0).animate(_controller!)
        ..addListener(() {
          setState(() {});
        });
      // 开始动画
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
    // 获取节点 / 边 数据
    final nodeList = widget.nodeState.nodesOf(widget.workflowId);
    final edgeList = widget.edgeState.edgesOf(widget.workflowId);

    final draggingEdgeId = widget.edgeState.draggingEdgeId;
    final draggingEnd = widget.edgeState.draggingEnd;

    debugPrint(
        'draggingEdgeId: $draggingEdgeId, draggingEnd: $draggingEnd, edgeList: $edgeList');

    debugPrint('CanvasRenderer: workflowId=${widget.workflowId}');

    // 只取 "完整连接" 边
    final validEdges = edgeList.where((edge) {
      return edge.isConnected &&
          edge.sourceNodeId?.isNotEmpty == true &&
          edge.sourceAnchorId?.isNotEmpty == true &&
          edge.targetNodeId?.isNotEmpty == true &&
          edge.targetAnchorId?.isNotEmpty == true;
    }).toList();

    return Stack(
      clipBehavior: Clip.none,
      children: [
        Positioned.fill(
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              // 1) 背景层
              Positioned.fill(
                child: CustomPaint(
                  painter: DottedGridPainter(
                    config: widget.visualConfig,
                    offset: widget.offset,
                    scale: widget.scale,
                    style: widget.visualConfig.backgroundStyle,
                    themeMode: Theme.of(context).brightness == Brightness.dark
                        ? ThemeMode.dark
                        : ThemeMode.light,
                  ),
                ),
              ),
              // 2) 边绘制层
              Transform(
                transform: Matrix4.identity()
                  ..translate(widget.offset.dx, widget.offset.dy)
                  ..scale(widget.scale),
                alignment: Alignment.topLeft,
                child: CustomPaint(
                  painter: EdgeRenderer(
                    nodes: nodeList,
                    edges: edgeList,
                    pathGenerator: FlexiblePathGenerator(nodeList),
                    draggingEdgeId: draggingEdgeId,
                    draggingEnd: draggingEnd,
                    hoveredEdgeId: widget.hoveredEdgeId,
                  ),
                ),
              ),
              // 3) 节点层
              ...nodeList.map((node) {
                return Positioned(
                  left: widget.offset.dx +
                      (node.position.dx - node.anchorPadding.left) *
                          widget.scale,
                  top: widget.offset.dy +
                      (node.position.dy - node.anchorPadding.top) *
                          widget.scale,
                  child: Transform.scale(
                    scale: widget.scale,
                    alignment: Alignment.topLeft,
                    transformHitTests: true,
                    child: widget.nodeWidgetFactory.createNodeWidget(node),
                  ),
                );
              }),
              // 4) 边上的 Overlay
              ...validEdges.map((edge) {
                final (sourceWorld, sourcePos) = _getAnchorWorldInfo(
                  edge.sourceNodeId ?? '',
                  edge.sourceAnchorId,
                );
                final (targetWorld, targetPos) = _getAnchorWorldInfo(
                  edge.targetNodeId ?? '',
                  edge.targetAnchorId,
                );
                if (sourceWorld == null ||
                    sourcePos == null ||
                    targetWorld == null ||
                    targetPos == null) {
                  return const SizedBox.shrink();
                }

                // 根据是否动画，决定 pathRatio
                double ratio;
                if (widget.isAnimated && _animation != null) {
                  ratio = _animation!.value; // 0.0 ~ 1.0
                } else {
                  ratio = 0.3; // 静态时就固定个值
                }

                final result = buildEdgePathAndPoint(
                  mode: edge.lineStyle.edgeMode,
                  sourceX: sourceWorld.dx,
                  sourceY: sourceWorld.dy,
                  sourcePos: sourcePos,
                  targetX: targetWorld.dx,
                  targetY: targetWorld.dy,
                  targetPos: targetPos,
                  curvature: 0.25,
                  hvOffset: 50.0,
                  orthoDist: 40.0,
                  pathRatio: ratio,
                );
                final point = result.point;

                const size = 24.0;
                return Positioned(
                  left: widget.offset.dx + (point.dx - size / 2) * widget.scale,
                  top: widget.offset.dy + (point.dy - size / 2) * widget.scale,
                  child: Transform.scale(
                    scale: widget.scale,
                    alignment: Alignment.topLeft,
                    transformHitTests: true,
                    child: EdgeButtonOverlay(
                      edgePoint: point,
                      size: size,
                      onDeleteEdge: () {
                        // do something
                      },
                    ),
                  ),
                );
              }),
            ],
          ),
        ),
      ],
    );
  }

  /// 获取锚点世界坐标
  (Offset?, Position?) _getAnchorWorldInfo(String nodeId, String? anchorId) {
    final node = widget.nodeState
        .nodesOf(widget.workflowId)
        .firstWhereOrNullSafe((n) => n.id == nodeId);
    if (node == null) return (null, null);
    if (anchorId == null) return (null, null);
    final anchor = node.anchors?.firstWhereOrNullSafe((a) => a.id == anchorId);
    if (anchor == null) return (null, null);

    final worldPos = computeAnchorWorldPosition(
            node, anchor, widget.nodeState.nodesOf(widget.workflowId)) +
        Offset(anchor.size.width / 2, anchor.size.height / 2);
    return (worldPos, anchor.position);
  }
}
