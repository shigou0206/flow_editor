import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:flow_editor/core/canvas/canvas_state/canvas_state.dart'; // 包含 CanvasState, MultiWorkflowCanvasState
import 'package:flow_editor/core/canvas/models/canvas_interaction_config.dart';
import 'package:flow_editor/core/canvas/models/canvas_visual_config.dart';
import 'package:flow_editor/core/node/node_state/node_state_provider.dart'; // NodeState
import 'package:flow_editor/core/node/models/node_model.dart';
import 'package:flow_editor/core/edge/models/edge_model.dart';
import 'package:flow_editor/core/edge/edge_state/edge_state_provider.dart';
import 'package:flow_editor/core/anchor/models/anchor_model.dart';
import 'package:flow_editor/core/anchor/utils/anchor_position_utils.dart';
import 'package:flow_editor/core/edge/utils/hit_test_utils.dart';
import 'package:flow_editor/core/edge/style/edge_style_resolver.dart';
import 'package:flow_editor/core/types/position_enum.dart';

/// 提供: 多工作流的画布状态（简化版：无模式切换，但支持节点拖拽、画布平移、以及从 anchor 拖出幽灵边）
/// 拖动过程中不进行自动吸附，仅在拖拽结束时检测目标 anchor 并 finalize。
final multiCanvasStateProvider =
    StateNotifierProvider<MultiCanvasStateNotifier, MultiWorkflowCanvasState>(
  (ref) => MultiCanvasStateNotifier(ref),
);

class MultiCanvasStateNotifier extends StateNotifier<MultiWorkflowCanvasState> {
  final Ref _ref;

  // 节点拖拽相关
  bool _isDraggingNode = false;
  String? _draggingNodeId; // 当前拖拽节点ID

  // 边（ghost edge）拖拽相关
  bool _isCreatingEdge = false;
  String? _creatingEdgeId; // 临时边的 ID
  Offset? _edgeDragCurrentCanvas; // 当前ghost edge拖拽时的画布坐标

  // 用于存储当前悬停的边ID
  String? _hoveredEdgeId;

  // 获取当前悬停的边ID
  String? get hoveredEdgeId => _hoveredEdgeId;

  MultiCanvasStateNotifier(
    this._ref, {
    CanvasInteractionConfig? interactionConfig,
  }) : super(
          MultiWorkflowCanvasState(
            activeWorkflowId: 'default',
            workflows: {
              'default': CanvasState(
                interactionConfig:
                    interactionConfig ?? const CanvasInteractionConfig(),
              ),
            },
          ),
        );

  //================== 切换 / 删除 workflow ==================//

  void switchWorkflow(String workflowId) {
    if (state.activeWorkflowId == workflowId) return;
    if (!state.workflows.containsKey(workflowId)) {
      final newCanvas = CanvasState(
        interactionConfig: state.activeState.interactionConfig,
        offset: state.activeState.offset,
        scale: state.activeState.scale,
        visualConfig: state.activeState.visualConfig,
      );
      state = state.copyWith(
        workflows: {
          ...state.workflows,
          workflowId: newCanvas,
        },
      );
    }
    state = state.copyWith(activeWorkflowId: workflowId);
  }

  void removeWorkflow(String workflowId) {
    if (workflowId == state.activeWorkflowId) return;
    final updated = {...state.workflows}..remove(workflowId);
    state = state.copyWith(workflows: updated);
  }

  //================== 事件入口 ==================//

  void startDrag(BuildContext context, Offset globalPos) {
    // 检测 anchor
    final hitAnchor = _hitTestAnchor(context, globalPos);
    if (hitAnchor != null) {
      _startEdgeDrag(context, globalPos, hitAnchor);
      return;
    }

    // 否则检测节点
    final canvasSt = state.activeState;
    final canvasPoint = _globalToCanvas(context, globalPos, canvasSt);

    final node = _hitTestNode(canvasPoint);
    if (node != null) {
      _isDraggingNode = true;
      _draggingNodeId = node.id;
    } else {
      _isDraggingNode = false;
      _draggingNodeId = null;
    }
  }

  /// 拖动更新时：
  /// 如果正在创建 ghost edge，则更新 ghost edge 终点；
  /// 如果正在拖拽节点，则更新节点位置；
  /// 否则，拖动画布平移。
  void updateDrag(Offset deltaGlobal) {
    if (_isCreatingEdge && _edgeDragCurrentCanvas != null) {
      _updateEdgeDrag(deltaGlobal);
      //===================== 移除/注释自动吸附调用 =====================
      // _checkAndSnapTargetAnchor(); // <-- 删除或注释此行
      //===========================================================
    } else {
      if (_isDraggingNode && _draggingNodeId != null) {
        _dragNodeBy(deltaGlobal);
      } else {
        _panCanvas(deltaGlobal);
      }
    }
  }

  /// 拖动结束时：
  void endDrag() {
    if (_isCreatingEdge) {
      // 在拖拽结束时检测目标 anchor，如果检测到 => finalize，否则取消
      final targetAnchor = _detectTargetAnchor();
      if (targetAnchor != null) {
        final targetNodeId = targetAnchor.nodeId;
        final targetAnchorId = targetAnchor.id;
        _ref
            .read(edgeStateProvider(state.activeWorkflowId).notifier)
            .finalizeEdge(
              edgeId: _creatingEdgeId!,
              targetNodeId: targetNodeId,
              targetAnchorId: targetAnchorId,
            );
      } else {
        _ref
            .read(edgeStateProvider(state.activeWorkflowId).notifier)
            .endEdgeDrag(
              canceled: true,
              targetNodeId: null,
              targetAnchorId: null,
            );
      }
      _isCreatingEdge = false;
      _edgeDragCurrentCanvas = null;
      _creatingEdgeId = null;
    } else {
      _isDraggingNode = false;
      _draggingNodeId = null;
    }
  }

  //================== 额外: 原本的自动吸附方法 (删除或注释) ===================
  // void _checkAndSnapTargetAnchor() {
  //   // 这里仅在拖动过程中自动吸附，但你已决定不需要，可删除或注释
  // }
  //=======================================================================

  //================== 内部: Ghost Edge 拖拽 ==================//

  void _startEdgeDrag(
      BuildContext context, Offset globalPos, AnchorModel anchor) {
    _isCreatingEdge = true;
    _creatingEdgeId = 'tempEdge-${DateTime.now().millisecondsSinceEpoch}';

    final canvasSt = state.activeState;
    final canvasPos = _globalToCanvas(context, globalPos, canvasSt);
    _edgeDragCurrentCanvas = canvasPos;

    // 创建 ghost edge
    final ghostEdge = EdgeModel(
      id: _creatingEdgeId!,
      sourceNodeId: anchor.nodeId,
      sourceAnchorId: anchor.id,
      targetNodeId: null,
      targetAnchorId: null,
      isConnected: false,
    );

    _ref
        .read(edgeStateProvider(state.activeWorkflowId).notifier)
        .startEdgeDrag(ghostEdge, canvasPos);
  }

  void _updateEdgeDrag(Offset deltaGlobal) {
    final canvasSt = state.activeState;
    final dx = deltaGlobal.dx / canvasSt.scale;
    final dy = deltaGlobal.dy / canvasSt.scale;
    _edgeDragCurrentCanvas = _edgeDragCurrentCanvas?.translate(dx, dy);
    if (_edgeDragCurrentCanvas != null) {
      _ref
          .read(edgeStateProvider(state.activeWorkflowId).notifier)
          .updateEdgeDrag(_edgeDragCurrentCanvas!);
    }
  }

  //================== 内部: 节点拖拽 ==================//

  void _dragNodeBy(Offset deltaGlobal) {
    final wfId = state.activeWorkflowId;
    final nodeNotifier = _ref.read(nodeStateProvider(wfId).notifier);
    final nid = _draggingNodeId;
    if (nid == null) return;
    final node = nodeNotifier.getNode(nid);
    if (node == null) return;
    final canvasSt = state.activeState;
    final dx = deltaGlobal.dx / canvasSt.scale;
    final dy = deltaGlobal.dy / canvasSt.scale;
    final updated = node.copyWith(x: node.x + dx, y: node.y + dy);
    nodeNotifier.upsertNode(updated);
  }

  //================== 内部: 画布平移 ==================//

  void _panCanvas(Offset deltaGlobal) {
    final canvasSt = state.activeState;
    if (!canvasSt.interactionConfig.allowPan) return;
    final oldOffset = canvasSt.offset;
    final newOffset = oldOffset + (deltaGlobal / canvasSt.scale);
    _updateActiveCanvas((c) => c.copyWith(offset: newOffset));
  }

  //================== 内部: 检测目标 anchor（结束时吸附） ==================//

  AnchorModel? _detectTargetAnchor() {
    const double snapThreshold = 20.0;
    final wfId = state.activeWorkflowId;
    final nodeSt = _ref.read(nodeStateProvider(wfId));
    if (_edgeDragCurrentCanvas == null) return null;
    for (final node in nodeSt.nodesOf(wfId).values) {
      for (final anchor in node.anchors) {
        final anchorGlobal = computeAnchorWorldPosition(node, anchor);
        final anchorCenter =
            anchorGlobal + Offset(anchor.width / 2, anchor.height / 2);
        if ((_edgeDragCurrentCanvas! - anchorCenter).distance < snapThreshold) {
          return anchor;
        }
      }
    }
    return null;
  }

  //================== 命中检测 ==================//

  NodeModel? _hitTestNode(Offset canvasPt) {
    final wfId = state.activeWorkflowId;
    final nodeSt = _ref.read(nodeStateProvider(wfId));
    for (final n in nodeSt.nodesOf(wfId).values) {
      final rect = Rect.fromLTWH(n.x, n.y, n.width, n.height);
      if (rect.contains(canvasPt)) {
        return n;
      }
    }
    return null;
  }

  AnchorModel? _hitTestAnchor(BuildContext context, Offset globalPos) {
    const double threshold = 20.0;
    final wfId = state.activeWorkflowId;
    final nodeSt = _ref.read(nodeStateProvider(wfId));

    final canvasPt = _globalToCanvas(context, globalPos, state.activeState);

    for (final node in nodeSt.nodesOf(wfId).values) {
      for (final anchor in node.anchors) {
        final anchorGlobal = computeAnchorWorldPosition(node, anchor);
        final anchorCenter =
            anchorGlobal + Offset(anchor.width / 2, anchor.height / 2);
        if ((canvasPt - anchorCenter).distance < threshold) {
          return anchor;
        }
      }
    }
    return null;
  }

  /// 检测点是否接近某条 Edge（用于 Hover）
  void _checkEdgeHit(Offset pointer) {
    String? hoveredEdgeId;
    double minDist = double.infinity;

    // 获取当前工作流的边
    final wfId = state.activeWorkflowId;
    final edges =
        _ref.read(edgeStateProvider(wfId)).edgesOf(wfId).values.toList();
    final styleResolver = EdgeStyleResolver();

    for (final edge in edges) {
      // 跳过未完全连接的边
      if (edge.targetNodeId == null || edge.targetAnchorId == null) continue;

      final (srcWorld, srcPos) =
          _getAnchorWorldInfo(edge.sourceNodeId, edge.sourceAnchorId);
      final (tarWorld, tarPos) =
          _getAnchorWorldInfo(edge.targetNodeId!, edge.targetAnchorId!);
      if (srcWorld == null || tarWorld == null) continue;

      final path = styleResolver.resolvePath(
        edge.lineStyle.edgeMode,
        srcWorld,
        srcPos,
        tarWorld,
        tarPos,
      );

      // 2) 计算距离
      final dist = distanceToPath(path, pointer);
      if (dist < minDist) {
        minDist = dist;
        hoveredEdgeId = edge.id;
      }
    }

    if (minDist < 6.0) {
      // 命中了 hoveredEdgeId
      _hoveredEdgeId = hoveredEdgeId;
      state = state.copyWith(hoveredEdgeId: hoveredEdgeId);
    } else {
      _hoveredEdgeId = null;
      state = state.copyWith(hoveredEdgeId: null);
    }
  }

  //================== 新增: onHover 方法 (鼠标移动时调用) ==================//
  /// 当鼠标在画布上移动时，可调用此方法进行 edge hover 检测
  /// （如果正在拖拽节点/边，则不会检测）
  void onHover(BuildContext context, Offset globalPos) {
    if (_isDraggingNode || _isCreatingEdge) {
      // 若正在拖拽，不做 Hover 检测
      return;
    }
    // 转换到画布坐标
    final pointerCanvasPos =
        _globalToCanvas(context, globalPos, state.activeState);

    // 调用我们已有的检测方法
    _checkEdgeHit(pointerCanvasPos);
  }
  //=======================================================================

  //================== 工具方法 ==================//

  Offset _globalToCanvas(
      BuildContext context, Offset globalPos, CanvasState cst) {
    final box = context.findRenderObject() as RenderBox?;
    if (box == null) return Offset.zero;
    final localPos = box.globalToLocal(globalPos);
    return (localPos - cst.offset) / cst.scale;
  }

  void _updateActiveCanvas(CanvasState Function(CanvasState) updater) {
    final activeId = state.activeWorkflowId;
    final current = state.activeState;
    final updated = updater(current);
    state = state.copyWith(
      workflows: {
        ...state.workflows,
        activeId: updated,
      },
    );
  }

  //================== 其它 ==================//

  void setOffset(Offset offset) {
    _updateActiveCanvas(
      (canvas) => canvas.interactionConfig.allowPan
          ? canvas.copyWith(offset: offset)
          : canvas,
    );
  }

  void panBy(double dx, double dy) {
    _updateActiveCanvas(
      (canvas) => canvas.interactionConfig.allowPan
          ? canvas.copyWith(offset: canvas.offset.translate(dx, dy))
          : canvas,
    );
  }

  void setScale(double scale) {
    _updateActiveCanvas((canvas) {
      if (!canvas.interactionConfig.allowZoom) return canvas;
      final clamped = scale.clamp(
        canvas.interactionConfig.minScale,
        canvas.interactionConfig.maxScale,
      );
      return canvas.copyWith(scale: clamped);
    });
  }

  void zoomAtPoint(double scaleFactor, Offset focalPoint) {
    _updateActiveCanvas((canvas) {
      if (!canvas.interactionConfig.allowZoom) return canvas;
      final oldScale = canvas.scale;
      final newScale = (oldScale * scaleFactor).clamp(
        canvas.interactionConfig.minScale,
        canvas.interactionConfig.maxScale,
      );
      final ratio = newScale / oldScale;
      final newOffset = (canvas.offset - focalPoint) * ratio + focalPoint;
      return canvas.copyWith(scale: newScale, offset: newOffset);
    });
  }

  void updateVisualConfig(CanvasVisualConfig Function(CanvasVisualConfig) fn) {
    _updateActiveCanvas(
        (canvas) => canvas.copyWith(visualConfig: fn(canvas.visualConfig)));
  }

  void toggleGrid() {
    _updateActiveCanvas(
      (canvas) => canvas.copyWith(
        visualConfig: canvas.visualConfig
            .copyWith(showGrid: !canvas.visualConfig.showGrid),
      ),
    );
  }

  void updateInteractionConfig(
      CanvasInteractionConfig Function(CanvasInteractionConfig) fn) {
    _updateActiveCanvas((canvas) =>
        canvas.copyWith(interactionConfig: fn(canvas.interactionConfig)));
  }

  void resetCanvas() {
    _updateActiveCanvas(
        (canvas) => CanvasState(interactionConfig: canvas.interactionConfig));
  }

  (Offset?, Position?) _getAnchorWorldInfo(String nodeId, String anchorId) {
    final wfId = state.activeWorkflowId;
    final nodeSt = _ref.read(nodeStateProvider(wfId));
    final node = nodeSt.nodesOf(wfId)[nodeId];
    AnchorModel? anchor;
    try {
      anchor = node?.anchors.firstWhere((a) => a.id == anchorId);
    } catch (_) {
      anchor = null;
    }
    if (node == null || anchor == null) return (null, null);

    final worldPos = computeAnchorWorldPosition(node, anchor) +
        Offset(anchor.width / 2, anchor.height / 2);
    return (worldPos, anchor.position);
  }

  void setState(void Function() fn) {
    fn();
    // 通知状态更新
    state = state.copyWith();
  }
}
