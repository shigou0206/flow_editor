import 'package:flutter/material.dart';
import 'package:flow_editor/core/node/behaviors/node_behavior.dart';
import 'package:flow_editor/core/anchor/behaviors/anchor_behavior.dart';
import 'package:flow_editor/core/canvas/behaviors/canvas_behavior.dart';
import 'package:flow_editor/core/edge/behaviors/edge_behavior.dart';
import 'package:flow_editor/core/anchor/utils/anchor_position_utils.dart';
import 'package:flow_editor/core/node/node_state/node_state.dart';
import 'package:flow_editor/core/node/factories/node_widget_factory.dart';
import 'package:flow_editor/core/edge/edge_state/edge_state.dart';
import 'package:flow_editor/core/edge/widgets/edge_button_overlay.dart';
import 'package:flow_editor/core/canvas/models/canvas_visual_config.dart';
import 'package:flow_editor/core/canvas/renderers/dotted_grid_painter.dart';
import 'package:flow_editor/core/edge/painter/edge_renderer.dart';
import 'package:flow_editor/core/edge/utils/edge_utils.dart';
import 'package:flow_editor/core/edge/models/edge_model.dart';
import 'package:flow_editor/core/types/position_enum.dart';

// 使用 collection 包的 IterableExtension 扩展
extension CanvasRendererIterableExtension<T> on Iterable<T> {
  T? firstWhereOrNullSafe(bool Function(T) test) {
    for (final element in this) {
      if (test(element)) return element;
    }
    return null;
  }
}

class CanvasRenderer extends StatelessWidget {
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
  });

  @override
  Widget build(BuildContext context) {
    // 1. 获取节点 / 边 数据
    final nodeList = nodeState.nodesOf(workflowId);
    final edgeList = edgeState.edgesOf(workflowId);

    final draggingEdgeId = edgeState.draggingEdgeId;
    final draggingEnd = edgeState.draggingEnd;

    // 2. 过滤出"完整连接"的边
    final validEdges = edgeList.where((edge) {
      return edge.isConnected &&
          edge.sourceNodeId.isNotEmpty &&
          edge.sourceAnchorId.isNotEmpty &&
          edge.targetNodeId != null &&
          edge.targetAnchorId != null;
    }).toList();

    // 3. 构建边上的按钮 Overlay（包含删除和插入按钮）
    // final List<Widget> edgeOverlays = [];
    // for (final edge in validEdges) {
    //   edgeOverlays.addAll(_buildEdgeOverlay(edge));
    // }

    return Stack(
      clipBehavior: Clip.none, // 允许越界绘制
      children: [
        Positioned.fill(
          // 外层视窗
          child: Stack(
            clipBehavior: Clip.none, // 不裁剪
            children: [
              // ======= 1) 背景层 =======
              Positioned.fill(
                child: CustomPaint(
                  painter: DottedGridPainter(
                    config: visualConfig,
                    offset: offset,
                    scale: scale,
                    style: visualConfig.backgroundStyle,
                    themeMode: Theme.of(context).brightness == Brightness.dark
                        ? ThemeMode.dark
                        : ThemeMode.light,
                  ),
                ),
              ),
              // ======= 2) 边（Edges）层 =======
              Transform(
                transform: Matrix4.identity()
                  ..translate(offset.dx, offset.dy)
                  ..scale(scale),
                alignment: Alignment.topLeft,
                child: CustomPaint(
                  painter: EdgeRenderer(
                    nodes: nodeList,
                    edges: edgeList,
                    draggingEdgeId: draggingEdgeId,
                    draggingEnd: draggingEnd,
                    hoveredEdgeId: hoveredEdgeId,
                  ),
                ),
              ),
              // ======= 3) 节点层 =======
              ...nodeList.map((node) {
                return Positioned(
                  left: offset.dx + (node.x - node.anchorPadding.left) * scale,
                  top: offset.dy + (node.y - node.anchorPadding.top) * scale,
                  child: Transform.scale(
                    scale: scale,
                    alignment: Alignment.topLeft,
                    transformHitTests: true,
                    child: nodeWidgetFactory.createNodeWidget(node),
                  ),
                );
              }),
              // ======= 4) 边上的 Overlay（删除、插入按钮） =======
              ...validEdges.map((edge) {
                final (sourceWorld, sourcePos) =
                    _getAnchorWorldInfo(edge.sourceNodeId, edge.sourceAnchorId);
                final (targetWorld, targetPos) = _getAnchorWorldInfo(
                    edge.targetNodeId!, edge.targetAnchorId!);
                final result = buildEdgePathAndCenter(
                  mode: edge.lineStyle.edgeMode,
                  sourceX: sourceWorld!.dx,
                  sourceY: sourceWorld.dy,
                  sourcePos: sourcePos!,
                  targetX: targetWorld!.dx,
                  targetY: targetWorld.dy,
                  targetPos: targetPos!,
                  curvature: 0.25,
                  hvOffset: 50.0,
                  orthoDist: 40.0,
                );
                final center = result.center;

                const size = 24.0;
                return Positioned(
                  left: offset.dx + (center.dx - size / 2) * scale,
                  top: offset.dy + (center.dy - size / 2) * scale,
                  child: Transform.scale(
                    scale: scale,
                    alignment: Alignment.topLeft,
                    transformHitTests: true,
                    child: EdgeButtonOverlay(
                      edgeCenter: center,
                      onDeleteEdge: () {},
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

  /// 根据节点ID和anchorID获取锚点的世界坐标和位置
  (Offset?, Position?) _getAnchorWorldInfo(String nodeId, String anchorId) {
    final node = nodeState
        .nodesOf(workflowId)
        .firstWhereOrNullSafe((n) => n.id == nodeId);
    if (node == null) return (null, null);
    final anchor = node.anchors.firstWhereOrNullSafe((a) => a.id == anchorId);
    if (anchor == null) return (null, null);

    final worldPos = computeAnchorWorldPosition(node, anchor) +
        Offset(anchor.width / 2, anchor.height / 2);
    return (worldPos, anchor.position);
  }
}
