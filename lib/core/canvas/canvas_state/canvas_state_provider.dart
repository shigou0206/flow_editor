import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dart:math';

import 'canvas_state.dart'; // 包含 CanvasState, MultiWorkflowCanvasState
import '../models/canvas_interaction_config.dart';
import '../models/canvas_visual_config.dart';
import '../../node/node_state/node_state_provider.dart'; // NodeState
import '../../node/models/node_model.dart';
import '../../edge/models/edge_model.dart';
import '../../edge/edge_state/edge_state_provider.dart';
import '../../anchor/models/anchor_model.dart';
import '../../anchor/utils/anchor_position_utils.dart';

/// 提供: 多工作流的画布状态（简化版：无模式切换，但支持节点拖拽、画布平移、以及从 anchor 拖出幽灵边）
final multiCanvasStateProvider =
    StateNotifierProvider<MultiCanvasStateNotifier, MultiWorkflowCanvasState>(
  (ref) => MultiCanvasStateNotifier(ref),
);

class MultiCanvasStateNotifier extends StateNotifier<MultiWorkflowCanvasState> {
  final Ref _ref;

  // 节点拖拽相关
  bool _isDraggingNode = false;
  String? _draggingNodeId; // 当前拖拽节点的ID

  // 边（ghost edge）拖拽相关
  bool _isCreatingEdge = false;
  String? _creatingEdgeId; // 临时边的 ID
  Offset? _edgeDragCurrentCanvas; // 当前拖拽时的画布坐标

  MultiCanvasStateNotifier(
    this._ref, {
    CanvasInteractionConfig? interactionConfig,
  }) : super(
          // 初始化 workflow 'default'
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

  /// 开始拖动时：
  /// 1. 先尝试检测是否点击在 anchor 上（用于拉出幽灵边）。
  /// 2. 如果没有，则检测是否点击在节点区域（用于拖拽节点）。
  /// 3. 否则视为拖动画布。
  void startDrag(BuildContext context, Offset globalPos) {
    debugPrint("startDrag invoked, globalPos: $globalPos");

    // 尝试先检测 anchor 命中
    final hitAnchor = _hitTestAnchor(context, globalPos);
    debugPrint("hitAnchor: ${hitAnchor?.id ?? 'none'}");

    if (hitAnchor != null) {
      debugPrint("Anchor hit detected, starting ghost edge drag");
      _startEdgeDrag(context, globalPos, hitAnchor);
      return;
    }

    // 如果没命中 anchor，则检测节点区域
    final canvasSt = state.activeState;
    final canvasPoint = _globalToCanvas(context, globalPos, canvasSt);
    debugPrint("Converted globalPos to canvasPoint: $canvasPoint");

    final node = _hitTestNode(canvasPoint);
    if (node != null) {
      debugPrint("Node hit detected: ${node.id}");
      _isDraggingNode = true;
      _draggingNodeId = node.id;
    } else {
      debugPrint("No node hit detected.");
      _isDraggingNode = false;
      _draggingNodeId = null;
    }
  }

  /// 拖动更新时：
  /// 如果正在创建边（ghost edge），更新边的终点。
  /// 如果正在拖拽节点，则更新节点位置。
  /// 否则，拖动画布平移。
  void updateDrag(Offset deltaGlobal) {
    debugPrint("updateDrag invoked, deltaGlobal: $deltaGlobal");
    if (_isCreatingEdge && _edgeDragCurrentCanvas != null) {
      debugPrint("Updating ghost edge drag");
      _updateEdgeDrag(deltaGlobal);
      // 增加实时检测 anchor 吸附效果
      _checkAndSnapTargetAnchor();
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
      // 在拖拽结束前再检测一次目标 anchor，如果检测到，则 finalize ghost edge，
      // 否则取消 ghost edge
      final targetAnchor = _detectTargetAnchor();
      if (targetAnchor != null) {
        // finalize ghost edge（此处需要传入目标节点和 anchor ID）
        // 假设 computeAnchorGlobalPosition 计算出的目标 anchor 逻辑位置正确
        final targetNodeId = targetAnchor.nodeId; // 直接从 anchor 获取
        final targetAnchorId = targetAnchor.id;
        _ref
            .read(edgeStateProvider(state.activeWorkflowId).notifier)
            .finalizeEdge(
              edgeId: _creatingEdgeId!,
              targetNodeId: targetNodeId,
              targetAnchorId: targetAnchorId,
            );
        debugPrint(
            "Finalized ghost edge: edgeId=$_creatingEdgeId, targetAnchorId=$targetAnchorId");
      } else {
        // 未连接到目标，取消 ghost edge
        _ref
            .read(edgeStateProvider(state.activeWorkflowId).notifier)
            .endEdgeDrag(
              canceled: true,
              targetNodeId: null,
              targetAnchorId: null,
            );
        debugPrint("Cancelled ghost edge: edgeId=$_creatingEdgeId");
      }
      _isCreatingEdge = false;
      _edgeDragCurrentCanvas = null;
      _creatingEdgeId = null;
    } else {
      _isDraggingNode = false;
      _draggingNodeId = null;
    }
  }

  /// 在 updateDrag 中实时检测当前 ghost edge 的终点是否接近某个 anchor，并吸附
  void _checkAndSnapTargetAnchor() {
    const double snapThreshold = 20.0;
    final wfId = state.activeWorkflowId;
    final nodeSt = _ref.read(nodeStateProvider(wfId));

    // 遍历所有节点的所有 anchor
    for (final node in nodeSt.nodesOf(wfId).values) {
      for (final anchor in node.anchors) {
        // 计算 anchor 的逻辑位置（使用 computeAnchorWorldPosition，返回左上角）
        final anchorGlobal = computeAnchorWorldPosition(node, anchor);
        // 计算 anchor 中心
        final anchorCenter =
            anchorGlobal + Offset(anchor.width / 2, anchor.height / 2);
        if ((_edgeDragCurrentCanvas! - anchorGlobal).distance < snapThreshold) {
          debugPrint(
              "Snapping ghost edge to anchor: nodeId=${node.id}, anchorId=${anchor.id}");
          // 直接吸附：将 ghost edge 终点调整为 anchorCenter
          _edgeDragCurrentCanvas = anchorCenter;
          // 同步更新状态，使 EdgeRenderer 能绘制出吸附后的连线
          _ref
              .read(edgeStateProvider(state.activeWorkflowId).notifier)
              .updateEdgeDrag(anchorCenter);
          // 如果检测到一个目标 anchor，直接退出检测（可以根据需要改为多候选逻辑）
          return;
        }
      }
    }
  }

  /// 单独检测拖拽结束时是否有目标 anchor命中
  AnchorModel? _detectTargetAnchor() {
    const double snapThreshold = 20.0;
    final wfId = state.activeWorkflowId;
    final nodeSt = _ref.read(nodeStateProvider(wfId));
    // 使用 _edgeDragCurrentCanvas 作为 ghost edge 终点逻辑坐标
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
    // 使用加号保证拖动方向与手势一致
    final newOffset = oldOffset + (deltaGlobal / canvasSt.scale);
    _updateActiveCanvas((c) => c.copyWith(offset: newOffset));
  }

  //================== 内部: 连线创建（Ghost Edge 拖拽） ==================//

  /// 当检测到点击在 anchor 上时，开始 ghost edge 拖拽。
  void _startEdgeDrag(
      BuildContext context, Offset globalPos, AnchorModel anchor) {
    _isCreatingEdge = true;
    _creatingEdgeId = 'tempEdge-${DateTime.now().millisecondsSinceEpoch}';
    debugPrint(
        'Starting edge drag: anchorId=${anchor.id}, edgeId=$_creatingEdgeId');

    final canvasSt = state.activeState;
    final canvasPos = _globalToCanvas(context, globalPos, canvasSt);
    debugPrint('Edge drag started at: $canvasPos');
    _edgeDragCurrentCanvas = canvasPos;

    // 直接使用 anchor.nodeId，因为 AnchorModel 已经包含了所属节点的 ID
    final ghostEdge = EdgeModel(
      id: _creatingEdgeId!,
      sourceNodeId: anchor.nodeId, // 直接从 anchor 中获取
      sourceAnchorId: anchor.id,
      targetNodeId: null,
      targetAnchorId: null,
      isConnected: false,
      // 根据需要设置其他字段
    );

    // 将 ghost edge 插入到边状态中，EdgeRenderer 会基于此绘制幽灵边
    debugPrint('workflowId: ${state.activeWorkflowId}, ghostEdge: $ghostEdge');
    _ref
        .read(edgeStateProvider(state.activeWorkflowId).notifier)
        .startEdgeDrag(ghostEdge, canvasPos);
  }

  /// 更新 ghost edge 的终点位置
  void _updateEdgeDrag(Offset deltaGlobal) {
    final canvasSt = state.activeState;
    final dx = deltaGlobal.dx / canvasSt.scale;
    final dy = deltaGlobal.dy / canvasSt.scale;
    debugPrint('Updating ghost edge: dx=$dx, dy=$dy');
    _edgeDragCurrentCanvas = _edgeDragCurrentCanvas?.translate(dx, dy);

    if (_edgeDragCurrentCanvas != null) {
      _ref
          .read(edgeStateProvider(state.activeWorkflowId).notifier)
          .updateEdgeDrag(_edgeDragCurrentCanvas!);
    }
  }

  /// 结束 ghost edge 拖拽
  void _endEdgeDrag() {
    final edgeId = _creatingEdgeId;
    if (edgeId == null) return;

    // 这里你可以根据 _edgeDragCurrentCanvas 判断是否连接到了目标锚点，
    // 若没有，则视为取消 ghost edge；否则调用 finalizeEdge 将 ghost edge 变为正式边。
    // 下面示例默认取消 ghost edge
    _ref.read(edgeStateProvider(state.activeWorkflowId).notifier).endEdgeDrag(
          canceled: true,
          targetNodeId: null,
          targetAnchorId: null,
        );

    _isCreatingEdge = false;
    _edgeDragCurrentCanvas = null;
    _creatingEdgeId = null;
  }

  //================== 工具方法 ==================//

  /// 命中检测节点区域（以逻辑坐标下 Rect.fromLTWH(node.x, node.y, node.width, node.height)）
  NodeModel? _hitTestNode(Offset canvasPt) {
    final wfId = state.activeWorkflowId;
    final nodeSt = _ref.read(nodeStateProvider(wfId));
    NodeModel? found;
    for (final n in nodeSt.nodesOf(wfId).values) {
      final rect = Rect.fromLTWH(n.x, n.y, n.width, n.height);
      if (rect.contains(canvasPt)) {
        found = n;
        break;
      }
    }
    return found;
  }

  /// 命中检测 Anchor 区域：
  /// 遍历所有节点和它们的 anchors，计算锚点全局位置，
  /// 如果 globalPos 距离某个 anchor 小于阈值，则认为命中该 anchor。
  AnchorModel? _hitTestAnchor(BuildContext context, Offset globalPos) {
    const double threshold = 20.0; // 可调整的命中阈值
    final wfId = state.activeWorkflowId;
    final nodeSt = _ref.read(nodeStateProvider(wfId));
    debugPrint('Hit test anchor: workflowId=$wfId, globalPos=$globalPos');

    // 将 globalPos 转换为画布逻辑坐标（与 _hitTestNode 使用相同转换）
    final canvasPt = _globalToCanvas(context, globalPos, state.activeState);
    debugPrint('Converted globalPos to canvas coordinate: $canvasPt');

    // 遍历所有节点
    for (final node in nodeSt.nodesOf(wfId).values) {
      for (final anchor in node.anchors) {
        // 计算锚点在画布逻辑坐标下的位置（返回的是锚点 widget 的左上角）
        final anchorGlobal = computeAnchorWorldPosition(node, anchor);
        // 计算锚点的中心位置
        final anchorCenter =
            anchorGlobal + Offset(anchor.width / 2, anchor.height / 2);
        debugPrint(
            'Checking anchor: nodeId=${node.id}, anchorId=${anchor.id}, anchorCenter=$anchorCenter');
        if ((canvasPt - anchorCenter).distance < threshold) {
          debugPrint('Anchor hit: nodeId=${node.id}, anchorId=${anchor.id}');
          return anchor;
        }
      }
    }
    debugPrint('No anchor hit');
    return null;
  }

  /// 这里我们使用传入 context 的 RenderBox，将 globalPos 转换为当前 Widget 的局部逻辑坐标，
  /// 并再做 "减去画布 offset，再除以 scale"。
  Offset _globalToCanvas(
      BuildContext context, Offset globalPos, CanvasState cst) {
    final box = context.findRenderObject() as RenderBox?;
    if (box == null) return Offset.zero;
    final localPos = box.globalToLocal(globalPos);
    return (localPos - cst.offset) / cst.scale;
  }

  /// 更新当前 active Canvas 状态
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

  //================== 其它操作 ==================//

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
}
