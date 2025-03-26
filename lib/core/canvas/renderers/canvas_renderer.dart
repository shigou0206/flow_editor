// file: canvas_renderer.dart
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
import 'package:flow_editor/core/canvas/renderers/background_renderer.dart';
import 'package:flow_editor/core/edge/painter/edge_renderer.dart';
import 'package:flow_editor/core/edge/utils/edge_utils.dart';
import 'package:flow_editor/core/edge/models/edge_model.dart';
import 'package:flow_editor/core/types/position_enum.dart';

/// CanvasRenderer(改造版):
/// - 内部使用 Stack(clipBehavior: Clip.none)，各层独立处理平移/缩放
/// - 背景、边、节点的绘制与交互层分离
class CanvasRenderer extends StatelessWidget {
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
    // 获取当前 workflow 的节点与边数据
    final nodeList =
        nodeState.nodesByWorkflow.values.expand((m) => m.values).toList();
    final edgeList =
        edgeState.edgesByWorkflow.values.expand((m) => m.values).toList();

    final draggingEdgeId = edgeState.draggingEdgeId;
    final draggingEnd = edgeState.draggingEnd;

    // 优化：先过滤数据完整的边（实际场景中边数据更新频繁）
    final validEdges = edgeList
        .where((edge) =>
            edge.isConnected &&
            edge.sourceNodeId.isNotEmpty &&
            edge.sourceAnchorId.isNotEmpty &&
            edge.targetNodeId != null &&
            edge.targetAnchorId != null)
        .toList();

    // 构建边上按钮层
    final List<Widget> edgeOverlays = [];
    for (final edge in validEdges) {
      edgeOverlays.addAll(_buildEdgeOverlay(edge));
    }

    return Stack(
      clipBehavior: Clip.none,
      children: [
        // 整个画布在 Transform 下，包括背景、边、节点、以及 overlay
        Positioned.fill(
          child: Transform(
            transform: Matrix4.identity()
              ..translate(offset.dx, offset.dy)
              ..scale(scale),
            alignment: Alignment.topLeft,
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                // 背景 (基于逻辑坐标)
                Positioned.fill(
                  child: CustomPaint(
                    painter: BackgroundRenderer(
                      config: visualConfig,
                      offset: Offset.zero,
                      scale: 1.0,
                    ),
                  ),
                ),

                // Edge (基于逻辑坐标)
                Positioned.fill(
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

                // Node
                for (final node in nodeList) ...[
                  // 节点位置由 node.x,y 定位，依赖 Transform 转换
                  Positioned(
                    left: node.x - node.anchorPadding.left,
                    top: node.y - node.anchorPadding.top,
                    width: node.width +
                        node.anchorPadding.left +
                        node.anchorPadding.right,
                    height: node.height +
                        node.anchorPadding.top +
                        node.anchorPadding.bottom,
                    child: nodeWidgetFactory.createNodeWidget(node),
                  ),
                ],

                // Edge Overlay：按钮同样按逻辑坐标定位，由 Transform 统一转换
                ...edgeOverlays,
              ],
            ),
          ),
        ),
      ],
    );
  }

  /// 根据一条边计算其中点，并返回对应的删除按钮 Overlay 组件列表
  List<Widget> _buildEdgeOverlay(EdgeModel edge) {
    final (sourceWorld, sourcePos) =
        _getAnchorWorldInfo(edge.sourceNodeId, edge.sourceAnchorId);
    final (targetWorld, targetPos) =
        _getAnchorWorldInfo(edge.targetNodeId!, edge.targetAnchorId!);

    // 数据不完整则跳过
    if (sourceWorld == null || targetWorld == null) return [];
    if (sourcePos == null || targetPos == null) return [];

    // 使用逻辑坐标构建路径和中心点
    final result = buildEdgePathAndCenter(
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
    );
    final center = result.center;

    // 调试：打印中心点（生产环境可移除）
    // print('[Overlay] edge ${edge.id} center = $center');

    // 检查中心点是否有效：如果是 NaN、Offset.zero 或者极小值，则跳过 overlay
    if (center.dx.isNaN ||
        center.dy.isNaN ||
        (center.dx == 0 && center.dy == 0)) {
      return [];
    }

    const size = 24.0;
    return [
      Positioned(
        left: center.dx - size / 2,
        top: center.dy - size / 2,
        width: size,
        height: size,
        child: EdgeButtonOverlay(
          edgeCenter: const Offset(size / 2, size / 2), // 按钮内部居中
          onDeleteEdge: () {
            edgeBehavior?.onEdgeDelete(edge);
          },
          size: size,
        ),
      ),
    ];
  }

  /// 计算给定节点 anchor 在世界坐标中的位置及其方向
  /// 返回 Tuple: (Offset?, Position?)
  (Offset?, Position?) _getAnchorWorldInfo(String nodeId, String anchorId) {
    // 从 nodeState 中查找节点和对应的 anchor
    final node = nodeState.nodesByWorkflow.values
        .expand((m) => m.values)
        .firstWhereOrNull((n) => n.id == nodeId);
    final anchor = node?.anchors.firstWhereOrNull((a) => a.id == anchorId);
    if (node == null || anchor == null) return (null, null);

    // 计算世界坐标：使用节点数据和 anchor 的位置、尺寸计算
    final worldPos = computeAnchorWorldPosition(node, anchor) +
        Offset(anchor.width / 2, anchor.height / 2);
    return (worldPos, anchor.position);
  }
}
