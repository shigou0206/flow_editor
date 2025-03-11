// file: canvas_renderer.dart
import 'package:flutter/material.dart';

import 'package:flow_editor/core/node/behaviors/node_behavior.dart';
import 'package:flow_editor/core/anchor/behaviors/anchor_behavior.dart';
import 'package:flow_editor/core/canvas/behaviors/canvas_behavior.dart';
import 'package:flow_editor/core/edge/behaviors/edge_behavior.dart';
import 'package:flow_editor/core/anchor/utils/anchor_position_utils.dart';
import 'package:flow_editor/core/node/node_state/node_state.dart';
import 'package:flow_editor/core/edge/edge_state/edge_state.dart';
import 'package:flow_editor/core/edge/widgets/edge_button_overlay.dart';
import 'package:flow_editor/core/canvas/models/canvas_visual_config.dart';
import 'package:flow_editor/core/canvas/renderers/background_renderer.dart';
import 'package:flow_editor/core/edge/edge_renderer.dart';
import 'package:flow_editor/core/node/widgets/commons/node_widget.dart';
import 'package:flow_editor/core/edge/utils/edge_utils.dart';
import 'package:flow_editor/core/edge/models/edge_model.dart';
import 'package:flow_editor/core/types/position_enum.dart';

/// CanvasRenderer(改造版):
/// - 内部使用 Stack(clipBehavior: Clip.none)，各层独立处理平移/缩放
/// - 背景、边、节点的绘制与交互层分离
class CanvasRenderer extends StatelessWidget {
  final Offset offset; // 画布平移量
  final double scale; // 画布缩放因子

  final NodeState nodeState;
  final EdgeState edgeState;
  final CanvasVisualConfig visualConfig;

  final NodeBehavior? nodeBehavior;
  final AnchorBehavior? anchorBehavior;
  final EdgeBehavior? edgeBehavior;
  final CanvasBehavior? canvasBehavior;

  const CanvasRenderer({
    super.key,
    required this.offset,
    required this.scale,
    required this.nodeState,
    required this.edgeState,
    required this.visualConfig,
    this.nodeBehavior,
    this.anchorBehavior,
    this.edgeBehavior,
    this.canvasBehavior,
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

    // 构建边上按钮层：遍历每条已连接边，计算中点并生成删除按钮 Overlay
    final List<Widget> edgeOverlays = [];
    for (final edge in edgeList) {
      if (edge.isConnected &&
          edge.targetNodeId != null &&
          edge.targetAnchorId != null) {
        edgeOverlays.addAll(_buildEdgeOverlay(edge));
      }
    }

    return Stack(
      clipBehavior: Clip.none,
      children: [
        // 1) 背景绘制（网格）
        Positioned.fill(
          child: CustomPaint(
            painter: BackgroundRenderer(
              config: visualConfig,
              offset: offset,
              scale: scale,
            ),
          ),
        ),

        // 2) 边绘制：使用 Transform 包裹（逻辑坐标转换）
        Positioned.fill(
          child: Transform(
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
              ),
            ),
          ),
        ),

        // 4) 边交互层：在边上叠加删除按钮（EdgeButtonOverlay）
        ...edgeOverlays,

        // 3) 节点绘制
        for (final node in nodeList) ...[
          Positioned(
            left: offset.dx + (node.x - node.anchorPadding.left) * scale,
            top: offset.dy + (node.y - node.anchorPadding.top) * scale,
            width: (node.width +
                    node.anchorPadding.left +
                    node.anchorPadding.right) *
                scale,
            height: (node.height +
                    node.anchorPadding.top +
                    node.anchorPadding.bottom) *
                scale,
            child: Transform.scale(
              scale: scale,
              alignment: Alignment.topLeft,
              child: NodeWidget(
                node: node,
                behavior: nodeBehavior,
                anchorBehavior: anchorBehavior,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(6),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 4,
                        offset: const Offset(2, 2),
                      ),
                    ],
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    node.title,
                    style: const TextStyle(fontSize: 14, color: Colors.black87),
                  ),
                ),
              ),
            ),
          ),
        ],
      ],
    );
  }

  /// 根据一条边计算其中点，并返回对应的删除按钮 Overlay 组件列表
  List<Widget> _buildEdgeOverlay(EdgeModel edge) {
    // 获取源与目标的世界坐标及方向（已由 _getAnchorWorldInfo 实现）
    final (sourceWorld, sourcePos) =
        _getAnchorWorldInfo(edge.sourceNodeId, edge.sourceAnchorId);
    final (targetWorld, targetPos) =
        _getAnchorWorldInfo(edge.targetNodeId!, edge.targetAnchorId!);
    if (sourceWorld == null || targetWorld == null) return [];

    // 将世界坐标转换为屏幕坐标：屏幕坐标 = offset + (world * scale)
    final sourceScreen = Offset(
      offset.dx + sourceWorld.dx * scale,
      offset.dy + sourceWorld.dy * scale,
    );
    final targetScreen = Offset(
      offset.dx + targetWorld.dx * scale,
      offset.dy + targetWorld.dy * scale,
    );
    // 必须有方向信息
    if (sourcePos == null || targetPos == null) return [];

    // 计算边中点：调用工具函数 buildEdgePathAndCenter
    final result = buildEdgePathAndCenter(
      mode: edge.lineStyle.edgeMode,
      sourceX: sourceScreen.dx,
      sourceY: sourceScreen.dy,
      sourcePos: sourcePos,
      targetX: targetScreen.dx,
      targetY: targetScreen.dy,
      targetPos: targetPos,
      curvature: 0.25,
      hvOffset: 50.0,
      orthoDist: 40.0,
    );
    final center = result.center;

    return [
      EdgeButtonOverlay(
        edgeCenter: center,
        onDeleteEdge: () {
          // 点击按钮时调用父组件的 onEdgeDelete, 删除该边
          if (edgeBehavior != null) {
            edgeBehavior!.onEdgeDelete(edge);
          }
        },
        size: 24.0,
      ),
    ];
  }

  /// 该函数返回一个 Tuple：(Offset?, Position?)
  /// 计算给定节点 anchor 在世界坐标中的位置及其方向
  (Offset?, Position?) _getAnchorWorldInfo(String nodeId, String anchorId) {
    // 此处假设 nodeState 中存有完整节点数据
    final node = nodeState.nodesByWorkflow.values
        .expand((m) => m.values)
        .firstWhereOrNull((n) => n.id == nodeId);
    final anchor = node?.anchors.firstWhereOrNull((a) => a.id == anchorId);
    if (node == null || anchor == null) return (null, null);

    final worldPos = computeAnchorWorldPosition(node, anchor) +
        Offset(anchor.width / 2, anchor.height / 2);
    return (worldPos, anchor.position);
  }
}
