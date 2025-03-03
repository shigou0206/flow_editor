import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// 以下import根据您的实际项目结构和命名修正
import 'canvas_state.dart'; // 内含 CanvasState, MultiWorkflowCanvasState
import '../../canvas/models/canvas_interaction_mode.dart';
import '../../canvas/models/canvas_interaction_config.dart';
import '../../canvas/models/canvas_visual_config.dart';

import '../../state_management/node_state/node_state_provider.dart'; // NodeState
import '../../../core/node/models/node_model.dart';

/// 提供: 多工作流的画布状态
final multiCanvasStateProvider =
    StateNotifierProvider<MultiCanvasStateNotifier, MultiWorkflowCanvasState>(
  (ref) => MultiCanvasStateNotifier(ref),
);

class MultiCanvasStateNotifier extends StateNotifier<MultiWorkflowCanvasState> {
  final Ref _ref;

  //======================== 节点拖拽用字段 ========================//
  bool _isDraggingNode = false;
  String? _draggingNodeId; // 当前拖拽的节点ID

  //======================== 连线创建/拖拽用字段 ========================//
  bool _isCreatingEdge = false;
  String? _creatingEdgeId; // 这个可自定义, half-connected Edge 的 ID
  Offset? _edgeDragStartCanvas; // 起始点(画布坐标)
  Offset? _edgeDragCurrentCanvas; // 当前拖拽点(画布坐标)

  MultiCanvasStateNotifier(
    this._ref, {
    CanvasInteractionConfig? interactionConfig,
  }) : super(
          // 初始化workflow 'default'
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

  //================== 切换 / 删除workflow ==================//

  void switchWorkflow(String workflowId) {
    if (state.activeWorkflowId == workflowId) return;

    if (!state.workflows.containsKey(workflowId)) {
      // 新建 CanvasState,可复制 offset/scale/interactionConfig
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

  //================== 事件入口: PointerDown/Move/Up => startDrag/updateDrag/endDrag ==================//

  /// 当 pointerDown: 判断当前 mode => createEdge or normal
  /// - if createEdge => _startEdgeDrag
  /// - else => 命中测试节点 => 拖拽节点
  void startDrag(Offset globalPos) {
    final canvasSt = state.activeState;
    final mode = canvasSt.mode;

    if (mode == CanvasInteractionMode.createEdge) {
      _startEdgeDrag(globalPos);
    } else {
      // 普通节点拖拽
      final canvasPoint = _globalToCanvas(globalPos, canvasSt);
      final node = _hitTestNode(canvasPoint);
      if (node != null) {
        _isDraggingNode = true;
        _draggingNodeId = node.id;
      } else {
        _isDraggingNode = false;
        _draggingNodeId = null;
      }
    }
  }

  /// 当 pointerMove: 如果 createEdge && _isCreatingEdge => _updateEdgeDrag
  /// 否则 => 如果拖节点 => _dragNodeBy; 否则 => 平移画布
  void updateDrag(Offset deltaGlobal) {
    final canvasSt = state.activeState;
    final mode = canvasSt.mode;

    if (mode == CanvasInteractionMode.createEdge && _isCreatingEdge) {
      _updateEdgeDrag(deltaGlobal);
    } else {
      if (_isDraggingNode && _draggingNodeId != null) {
        _dragNodeBy(deltaGlobal);
      } else {
        _panCanvas(deltaGlobal);
      }
    }
  }

  /// 当 pointerUp: 如果 createEdge => _endEdgeDrag; 否则 endNodeDrag
  void endDrag() {
    final mode = state.activeState.mode;
    if (mode == CanvasInteractionMode.createEdge && _isCreatingEdge) {
      _endEdgeDrag();
    } else {
      _isDraggingNode = false;
      _draggingNodeId = null;
    }
  }

  //================== 内部: 节点拖拽 ==================//

  /// _dragNodeBy: 将 deltaGlobal 转成 canvas下的 delta
  /// 然后更新 node.x,y
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

    final newOffset = canvasSt.offset - (deltaGlobal / canvasSt.scale);
    _updateActiveCanvas((c) => c.copyWith(offset: newOffset));
  }

  //================== 内部: 连线创建 (Edge Drag) ==================//

  /// 开始边缘拖拽 - 供外部调用
  String? startEdgeDrag(Offset globalPos) {
    _startEdgeDrag(globalPos);
    return _creatingEdgeId;
  }

  /// 更新边缘拖拽 - 供外部调用
  void updateEdgeDrag(String edgeId, Offset globalPos) {
    if (_creatingEdgeId != edgeId || !_isCreatingEdge) return;

    final canvasSt = state.activeState;
    final canvasPos = _globalToCanvas(globalPos, canvasSt);
    _edgeDragCurrentCanvas = canvasPos;

    // 这里可以添加更新半连接边的逻辑
  }

  /// 结束边缘拖拽 - 供外部调用
  void endEdgeDrag(String edgeId, Offset globalPos) {
    if (_creatingEdgeId != edgeId || !_isCreatingEdge) return;

    final canvasSt = state.activeState;
    final canvasPos = _globalToCanvas(globalPos, canvasSt);
    _edgeDragCurrentCanvas = canvasPos;

    _endEdgeDrag();
  }

  /// 1) startEdgeDrag
  ///   - 标记 _isCreatingEdge=true
  ///   - 记录 _edgeDragStartCanvas, _edgeDragCurrentCanvas
  void _startEdgeDrag(Offset globalPos) {
    _isCreatingEdge = true;
    _creatingEdgeId = null; // or generate a new ID (e.g. 'tempEdge123')
    final canvasSt = state.activeState;

    _edgeDragStartCanvas = _globalToCanvas(globalPos, canvasSt);
    _edgeDragCurrentCanvas = _edgeDragStartCanvas;

    // 可选：在EdgeState里插入半连接EdgeModel:
    // final workflowId = state.activeWorkflowId;
    // final edgeNotifier = _ref.read(edgeStateProvider.notifier);
    // final edgeId = 'tempEdge_${DateTime.now().millisecondsSinceEpoch}';
    // final newEdge = EdgeModel(
    //   id: edgeId,
    //   sourceNodeId: 'someNodeId', // 需要hitTest anchor?
    //   targetNodeId: null,
    //   isConnected: false,
    //   lineStyle: EdgeLineStyle(...),
    // );
    // edgeNotifier.upsertEdge(workflowId, newEdge);
    // _creatingEdgeId = edgeId;
  }

  /// 2) updateEdgeDrag
  ///   - 每次 pointerMove, 更新 _edgeDragCurrentCanvas, => ghost line
  ///   - 如果 EdgeState 里也有 halfEdge, 也可更新 targetX=xxx
  void _updateEdgeDrag(Offset deltaGlobal) {
    if (!_isCreatingEdge || _edgeDragCurrentCanvas == null) return;

    final canvasSt = state.activeState;
    final dx = deltaGlobal.dx / canvasSt.scale;
    final dy = deltaGlobal.dy / canvasSt.scale;

    _edgeDragCurrentCanvas = _edgeDragCurrentCanvas!.translate(dx, dy);

    // 若要更新EdgeState half-edge:
    // if (_creatingEdgeId != null) {
    //   final edgeNotifier = _ref.read(edgeStateProvider.notifier);
    //   final halfEdge = edgeNotifier.getEdgeById(_creatingEdgeId!);
    //   if (halfEdge != null) {
    //     final newEdge = halfEdge.copyWith(
    //       targetX: someDouble?, // or your approach
    //       targetY: ...
    //     );
    //     edgeNotifier.upsertEdge(workflowId, newEdge);
    //   }
    // }
  }

  /// 3) endEdgeDrag
  ///   - pointerUp => 命中测试 anchor => if found => finalize edge => isConnected=true
  ///   - else => remove halfEdge or keep
  void _endEdgeDrag() {
    _isCreatingEdge = false;
    // _creatingEdgeId = null;
    _edgeDragStartCanvas = null;
    _edgeDragCurrentCanvas = null;

    // 也可进行 anchor hitTest => finalize or remove edge
  }

  //================== 工具方法 ==================//

  /// 命中检测 node
  NodeModel? _hitTestNode(Offset canvasPt) {
    final wfId = state.activeWorkflowId;
    final nodeSt = _ref.read(nodeStateProvider(wfId));
    for (final n in nodeSt.nodesOf(wfId).values) {
      final rect = Rect.fromLTWH(n.x, n.y, n.width, n.height);
      if (rect.contains(canvasPt)) return n;
    }
    return null;
  }

  Offset _globalToCanvas(Offset globalPos, CanvasState cst) {
    return (globalPos / cst.scale) + cst.offset;
  }

  /// 更新active Canvas
  void _updateActiveCanvas(CanvasState Function(CanvasState) updater) {
    final activeId = state.activeWorkflowId;
    final current = state.activeState;
    state = state.copyWith(
      workflows: {
        ...state.workflows,
        activeId: updater(current),
      },
    );
  }

  //================== 其它基础操作 (平移/缩放/模式/配置等) ==================//

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

  void setInteractionMode(CanvasInteractionMode mode) {
    _updateActiveCanvas((canvas) => canvas.copyWith(mode: mode));
  }

  void updateVisualConfig(CanvasVisualConfig Function(CanvasVisualConfig) fn) {
    _updateActiveCanvas(
      (canvas) => canvas.copyWith(visualConfig: fn(canvas.visualConfig)),
    );
  }

  void toggleGrid() {
    _updateActiveCanvas(
      (canvas) => canvas.copyWith(
        visualConfig: canvas.visualConfig.copyWith(
          showGrid: !canvas.visualConfig.showGrid,
        ),
      ),
    );
  }

  void updateInteractionConfig(
      CanvasInteractionConfig Function(CanvasInteractionConfig) fn) {
    _updateActiveCanvas(
      (canvas) =>
          canvas.copyWith(interactionConfig: fn(canvas.interactionConfig)),
    );
  }

  void resetCanvas() {
    _updateActiveCanvas(
      (canvas) => CanvasState(interactionConfig: canvas.interactionConfig),
    );
  }
}
