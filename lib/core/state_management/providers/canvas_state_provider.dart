import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flow_editor/core/models/state/canvas_state.dart';
import 'package:flow_editor/core/models/styles/canvas_interaction_config.dart';
import 'package:flow_editor/core/models/styles/canvas_visual_config.dart';
import 'package:flow_editor/core/state_management/providers/node_state_provider.dart';
import 'package:flow_editor/core/models/node_model.dart';
import 'package:flow_editor/core/models/edge_model.dart';
import 'package:flow_editor/core/state_management/providers/edge_state_provider.dart';
import 'package:flow_editor/core/models/anchor_model.dart';
import 'package:flow_editor/core/utils/anchor_position_utils.dart';
import 'package:flow_editor/core/utils/hit_test_utils.dart';
import 'package:flow_editor/core/painters/path_generators/flexible_path_generator.dart';
import 'package:flow_editor/core/models/enums/position_enum.dart';
import 'package:flow_editor/core/logic/strategy/workflow_mode.dart';
import 'package:flow_editor/core/logic/strategy/workflow_strategy.dart';
import 'package:flow_editor/core/logic/strategy/generic_flow_strategy.dart';
import 'package:flow_editor/core/logic/strategy/state_machine_strategy.dart';
import 'package:flow_editor/core/utils/canvas_utils.dart';
import 'package:flow_editor/core/layout/sugiyama_layout.dart';

final multiCanvasStateProvider =
    StateNotifierProvider<MultiCanvasStateNotifier, MultiWorkflowCanvasState>(
  (ref) => MultiCanvasStateNotifier(ref),
);

class MultiCanvasStateNotifier extends StateNotifier<MultiWorkflowCanvasState> {
  final Ref _ref;

  bool _isDraggingNode = false;
  String? _draggingNodeId;

  bool _isCreatingEdge = false;
  String? _creatingEdgeId;
  Offset? _edgeDragCurrentCanvas;

  String? _hoveredEdgeId;
  String? get hoveredEdgeId => _hoveredEdgeId;

  // ignore: unused_field
  EdgeModel? _potentialInsertEdge;

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
                workflowMode: WorkflowMode.generic,
                visualConfig: const CanvasVisualConfig(),
              ),
            },
          ),
        );

  /// 切换工作流（不在 activeWorkflowId 内新增的工作流会自动创建）
  void switchWorkflow(String workflowId) {
    if (state.activeWorkflowId == workflowId) return;
    if (!state.workflows.containsKey(workflowId)) {
      final newCanvas = CanvasState(
        interactionConfig: state.activeState.interactionConfig,
        offset: state.activeState.offset,
        scale: state.activeState.scale,
        visualConfig: state.activeState.visualConfig,
        workflowMode: state.activeState.workflowMode,
        interactionMode: state.activeState.interactionMode,
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

  void startDrag(BuildContext context, Offset globalPos) {
    final hitAnchor = _hitTestAnchor(context, globalPos);
    if (hitAnchor != null) {
      _startEdgeDrag(context, globalPos, hitAnchor);
      return;
    }

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

  void updateDrag(Offset deltaGlobal) {
    if (_isCreatingEdge && _edgeDragCurrentCanvas != null) {
      _updateEdgeDrag(deltaGlobal);
    } else {
      if (_isDraggingNode && _draggingNodeId != null) {
        _dragNodeBy(deltaGlobal);
      } else {
        _panCanvas(deltaGlobal);
      }
    }
  }

  void endDrag() {
    debugPrint('endDrag 被调用');
    if (_isCreatingEdge) {
      final targetAnchor = _detectTargetAnchor();
      final edgeNotifier =
          _ref.read(edgeStateProvider(state.activeWorkflowId).notifier);

      final workflowId = state.activeWorkflowId; // ⚠️ 确认这一行的值
      debugPrint('endDrag 当前workflowId: $workflowId');

      if (targetAnchor != null) {
        edgeNotifier.finalizeEdge(
          edgeId: _creatingEdgeId!,
          targetNodeId: targetAnchor.nodeId,
          targetAnchorId: targetAnchor.id,
        );
      }

      // 🚩 无论连接成功或失败，都明确调用 endEdgeDrag 清理状态
      edgeNotifier.endEdgeDrag(
        canceled: targetAnchor == null,
        targetNodeId: targetAnchor?.nodeId,
        targetAnchorId: targetAnchor?.id,
      );

      _isCreatingEdge = false;
      _edgeDragCurrentCanvas = null;
      _creatingEdgeId = null;
    } else {
      _isDraggingNode = false;
      _draggingNodeId = null;
    }
  }

  // 假设 multiCanvasStateNotifier 是 MultiCanvasStateNotifier 的实例
  void setWorkflowMode(String workflowId, WorkflowMode newMode) {
    final currentCanvas = state.workflows[workflowId];
    if (currentCanvas != null) {
      final updated = currentCanvas.copyWith(workflowMode: newMode);
      state = state.copyWith(workflows: {
        ...state.workflows,
        workflowId: updated,
      });
    }
  }

  //====================  以下为策略调用部分  ====================

  /// 策略工厂，根据当前 CanvasState.mode 返回对应策略
  WorkflowModeStrategy _createStrategy(String workflowId, WorkflowMode mode) {
    debugPrint('createStrategy wfId: $workflowId, mode: $mode');
    switch (mode) {
      case WorkflowMode.stateMachine:
        return StateMachineStrategy(workflowId: workflowId);
      case WorkflowMode.generic:
        return GenericFlowStrategy(workflowId: workflowId);
    }
  }

  /// 根据工作流模式删除节点，并自动处理上下游连接断裂情况
  void deleteNodeWithStrategy(String nodeId) {
    final wfId = state.activeWorkflowId;
    final nodeNotifier = _ref.read(nodeStateProvider(wfId).notifier);
    final edgeNotifier = _ref.read(edgeStateProvider(wfId).notifier);
    final canvas = state.workflows[wfId];

    final node = nodeNotifier.getNode(nodeId);
    if (node == null) return;

    // 获取所有相关边
    final allEdges = edgeNotifier.state.edgesOf(wfId);

    // 上游：所有指向该节点的节点
    final upstream = allEdges
        .where((e) => e.targetNodeId == nodeId)
        .map((e) => nodeNotifier.getNode(e.sourceNodeId ?? ''))
        .whereType<NodeModel>()
        .toList();

    // 下游：所有该节点指向的节点
    final downstream = allEdges
        .where((e) => e.sourceNodeId == nodeId)
        .map((e) => nodeNotifier.getNode(e.targetNodeId ?? ''))
        .whereType<NodeModel>()
        .toList();

    final strategy =
        _createStrategy(wfId, canvas?.workflowMode ?? WorkflowMode.generic);

    strategy.onNodeDeleted(
      deletedNode: node,
      upstreamNodes: upstream,
      downstreamNodes: downstream,
      edgeNotifier: edgeNotifier,
      nodeNotifier: nodeNotifier,
    );
  }

  /// 调用策略对整个工作流进行校验（例如 Start 节点、孤立节点等）
  void validateCanvas() {
    final wfId = state.activeWorkflowId;
    final nodeNotifier = _ref.read(nodeStateProvider(wfId).notifier);
    final edgeNotifier = _ref.read(edgeStateProvider(wfId).notifier);
    final canvas = state.workflows[wfId];
    final strategy =
        _createStrategy(wfId, canvas?.workflowMode ?? WorkflowMode.generic);

    debugPrint(
        'validateCanvas wfId: $wfId, strategy: ${strategy.runtimeType}, nodes: ${nodeNotifier.getNodes().map((e) => e.id).toList()}, edges: ${edgeNotifier.state.edgesOf(wfId).map((e) => e.id).toList()}');
    strategy.validate(
      nodes: nodeNotifier.getNodes(),
      edges: edgeNotifier.state.edgesOf(wfId),
      nodeNotifier: nodeNotifier,
    );
  }

  //====================  以下为原有功能  ====================

  void _startEdgeDrag(
      BuildContext context, Offset globalPos, AnchorModel anchor) {
    _isCreatingEdge = true;
    _creatingEdgeId = 'tempEdge-${DateTime.now().millisecondsSinceEpoch}';

    final canvasSt = state.activeState;
    final canvasPos = _globalToCanvas(context, globalPos, canvasSt);
    _edgeDragCurrentCanvas = canvasPos;

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
    final updatedPosition = node.position + Offset(dx, dy);

    final updatedNode = node.copyWith(position: updatedPosition);
    nodeNotifier.upsertNode(updatedNode);

    final nodeRect = updatedNode.rect; // 确保 NodeModel 提供了rect getter方法
    _potentialInsertEdge = findNearestEdgeToRect(nodeRect, 30.0);
  }

  void _panCanvas(Offset deltaGlobal) {
    final canvasSt = state.activeState;
    if (!canvasSt.interactionConfig.enablePan) return;
    final oldOffset = canvasSt.offset;
    final newOffset = oldOffset + (deltaGlobal / canvasSt.scale);
    _updateActiveCanvas((c) => c.copyWith(offset: newOffset));
  }

  AnchorModel? _detectTargetAnchor() {
    const double snapThreshold = 20.0;
    final wfId = state.activeWorkflowId;
    final nodeSt = _ref.read(nodeStateProvider(wfId));
    if (_edgeDragCurrentCanvas == null) return null;
    for (final node in nodeSt.nodesOf(wfId)) {
      for (final anchor in node.anchors ?? []) {
        final anchorGlobal =
            computeAnchorWorldPosition(node, anchor, nodeSt.nodesOf(wfId));
        final anchorCenter =
            anchorGlobal + Offset(anchor.width / 2, anchor.height / 2);
        if ((_edgeDragCurrentCanvas! - anchorCenter).distance < snapThreshold) {
          return anchor;
        }
      }
    }
    return null;
  }

  NodeModel? _hitTestNode(Offset canvasPt) {
    final wfId = state.activeWorkflowId;
    final nodeSt = _ref.read(nodeStateProvider(wfId));
    for (final n in nodeSt.nodesOf(wfId)) {
      final rect = Rect.fromLTWH(
        n.position.dx,
        n.position.dy,
        n.size.width,
        n.size.height,
      );
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

    for (final node in nodeSt.nodesOf(wfId)) {
      for (final anchor in node.anchors ?? []) {
        final anchorGlobal =
            computeAnchorWorldPosition(node, anchor, nodeSt.nodesOf(wfId));
        final anchorCenter =
            anchorGlobal + Offset(anchor.width / 2, anchor.height / 2);
        if ((canvasPt - anchorCenter).distance < threshold) {
          return anchor;
        }
      }
    }
    return null;
  }

  void _checkEdgeHit(Offset pointer) {
    String? hoveredEdgeId;
    double minDist = double.infinity;

    final wfId = state.activeWorkflowId;
    final edges = _ref.read(edgeStateProvider(wfId)).edgesOf(wfId);

    // 使用统一的 FlexiblePathGenerator
    final nodes = _ref.read(nodeStateProvider(wfId)).nodesOf(wfId);
    final pathGenerator = FlexiblePathGenerator(nodes);

    for (final edge in edges) {
      if (edge.targetNodeId == null || edge.targetAnchorId == null) continue;

      final pathResult =
          pathGenerator.generate(edge, type: edge.lineStyle.edgeMode);
      if (pathResult == null) continue;

      final path = pathResult.path;

      final dist = distanceToPath(path, pointer);
      if (dist < minDist) {
        minDist = dist;
        hoveredEdgeId = edge.id;
      }
    }

    if (minDist < 6.0) {
      _hoveredEdgeId = hoveredEdgeId;
      state = state.copyWith(hoveredEdgeId: hoveredEdgeId);
    } else {
      _hoveredEdgeId = null;
      state = state.copyWith(hoveredEdgeId: null);
    }
  }

  void onHover(BuildContext context, Offset globalPos) {
    if (_isDraggingNode || _isCreatingEdge) return;
    final pointerCanvasPos =
        _globalToCanvas(context, globalPos, state.activeState);
    _checkEdgeHit(pointerCanvasPos);
  }

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

  void setOffset(Offset offset) {
    _updateActiveCanvas(
      (canvas) => canvas.interactionConfig.enablePan
          ? canvas.copyWith(offset: offset)
          : canvas,
    );
  }

  void panBy(double dx, double dy) {
    _updateActiveCanvas(
      (canvas) => canvas.interactionConfig.enablePan
          ? canvas.copyWith(offset: canvas.offset.translate(dx, dy))
          : canvas,
    );
  }

  void setScale(double scale) {
    _updateActiveCanvas((canvas) {
      if (!canvas.interactionConfig.enableZoom) return canvas;
      final clamped = scale.clamp(
        canvas.interactionConfig.minScale,
        canvas.interactionConfig.maxScale,
      );
      return canvas.copyWith(scale: clamped);
    });
  }

  void zoomAtPoint(double scaleFactor, Offset focalPoint) {
    _updateActiveCanvas((canvas) {
      if (!canvas.interactionConfig.enableZoom) return canvas;
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

  (Offset?, Position?) _getAnchorWorldInfo(String nodeId, String? anchorId) {
    final wfId = state.activeWorkflowId;
    final nodeSt = _ref.read(nodeStateProvider(wfId));
    NodeModel? node;
    for (final n in nodeSt.nodesOf(wfId)) {
      if (n.id == nodeId) {
        node = n;
        break;
      }
    }
    AnchorModel? anchor;
    if (anchorId == null) return (null, null);
    if (node != null) {
      for (final a in node.anchors ?? []) {
        if (a.id == anchorId) {
          anchor = a;
          break;
        }
      }
    }
    if (node == null || anchor == null) return (null, null);

    final worldPos =
        computeAnchorWorldPosition(node, anchor, nodeSt.nodesOf(wfId)) +
            Offset(anchor.size.width / 2, anchor.size.height / 2);
    return (worldPos, anchor.position);
  }

  EdgeModel? findNearestEdgeToRect(Rect nodeRect, double threshold) {
    final wfId = state.activeWorkflowId;
    final edges = _ref.read(edgeStateProvider(wfId)).edgesOf(wfId);
    final nodes = _ref.read(nodeStateProvider(wfId)).nodesOf(wfId);
    final pathGenerator = FlexiblePathGenerator(nodes);

    EdgeModel? nearestEdge;
    double minDistance = threshold;

    for (final edge in edges) {
      if (edge.targetNodeId == null) continue;
      final pathResult =
          pathGenerator.generate(edge, type: edge.lineStyle.edgeMode);
      if (pathResult == null) continue;

      final dist = rectToPathDistance(nodeRect, pathResult.path);
      if (dist < minDistance) {
        nearestEdge = edge;
        minDistance = dist;
      }
    }

    return nearestEdge;
  }

  void _insertNodeIntoEdge(String nodeId, EdgeModel edge) {
    final wfId = state.activeWorkflowId;
    final edgeNotifier = _ref.read(edgeStateProvider(wfId).notifier);

    // 删除原边
    edgeNotifier.removeEdge(edge.id);

    // 创建两条新边连接插入节点 (不显式指定 anchorId 和 edgeId)
    final newEdge1 = EdgeModel(
      sourceNodeId: edge.sourceNodeId,
      targetNodeId: nodeId,
      isConnected: true,
    );

    final newEdge2 = EdgeModel(
      sourceNodeId: nodeId,
      targetNodeId: edge.targetNodeId,
      isConnected: true,
    );

    edgeNotifier.addEdges([newEdge1, newEdge2]);

    // 调用自动布局算法重新布局
    _performAutoLayout();
  }

  void _performAutoLayout() {
    final wfId = state.activeWorkflowId;

    final nodeNotifier = _ref.read(nodeStateProvider(wfId).notifier);
    final edgeNotifier = _ref.read(edgeStateProvider(wfId).notifier);

    final nodes = nodeNotifier.getNodes();
    final edges = edgeNotifier.state.edgesOf(wfId);

    // 调用布局算法 (假设它直接修改了 nodes 和 edges 的状态)
    _performLayout(nodes, edges);

    // 更新布局后的节点状态
    for (var node in nodes) {
      nodeNotifier.upsertNode(node);
    }

    // 更新布局后的边状态
    edgeNotifier.updateEdges(edges);
  }

  void _performLayout(List<NodeModel> nodes, List<EdgeModel> edges) {
    final layout = SugiyamaLayoutStrategy();
    layout.performLayout(nodes, edges);
  }

  void setState(void Function() fn) {
    fn();
    state = state.copyWith();
  }
}
