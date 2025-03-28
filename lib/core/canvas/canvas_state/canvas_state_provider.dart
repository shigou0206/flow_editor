import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:flow_editor/core/canvas/canvas_state/canvas_state.dart';
import 'package:flow_editor/core/canvas/models/canvas_interaction_config.dart';
import 'package:flow_editor/core/canvas/models/canvas_visual_config.dart';
import 'package:flow_editor/core/node/node_state/node_state_provider.dart';
import 'package:flow_editor/core/node/models/node_model.dart';
import 'package:flow_editor/core/edge/models/edge_model.dart';
import 'package:flow_editor/core/edge/edge_state/edge_state_provider.dart';
import 'package:flow_editor/core/anchor/models/anchor_model.dart';
import 'package:flow_editor/core/anchor/utils/anchor_position_utils.dart';
import 'package:flow_editor/core/edge/utils/hit_test_utils.dart';
import 'package:flow_editor/core/edge/style/edge_style_resolver.dart';
import 'package:flow_editor/core/types/position_enum.dart';

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
    if (_isCreatingEdge) {
      final targetAnchor = _detectTargetAnchor();
      if (targetAnchor != null) {
        _ref
            .read(edgeStateProvider(state.activeWorkflowId).notifier)
            .finalizeEdge(
              edgeId: _creatingEdgeId!,
              targetNodeId: targetAnchor.nodeId,
              targetAnchorId: targetAnchor.id,
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
    final updated = node.copyWith(x: node.x + dx, y: node.y + dy);
    nodeNotifier.upsertNode(updated);
  }

  void _panCanvas(Offset deltaGlobal) {
    final canvasSt = state.activeState;
    if (!canvasSt.interactionConfig.allowPan) return;
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

  NodeModel? _hitTestNode(Offset canvasPt) {
    final wfId = state.activeWorkflowId;
    final nodeSt = _ref.read(nodeStateProvider(wfId));
    for (final n in nodeSt.nodesOf(wfId)) {
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

    for (final node in nodeSt.nodesOf(wfId)) {
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

  void _checkEdgeHit(Offset pointer) {
    String? hoveredEdgeId;
    double minDist = double.infinity;

    final wfId = state.activeWorkflowId;
    final edges = _ref.read(edgeStateProvider(wfId)).edgesOf(wfId);
    const styleResolver = EdgeStyleResolver();

    for (final edge in edges) {
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
    NodeModel? node;
    for (final n in nodeSt.nodesOf(wfId)) {
      if (n.id == nodeId) {
        node = n;
        break;
      }
    }
    AnchorModel? anchor;
    if (node != null) {
      for (final a in node.anchors) {
        if (a.id == anchorId) {
          anchor = a;
          break;
        }
      }
    }
    if (node == null || anchor == null) return (null, null);

    final worldPos = computeAnchorWorldPosition(node, anchor) +
        Offset(anchor.width / 2, anchor.height / 2);
    return (worldPos, anchor.position);
  }

  void setState(void Function() fn) {
    fn();
    state = state.copyWith();
  }
}
