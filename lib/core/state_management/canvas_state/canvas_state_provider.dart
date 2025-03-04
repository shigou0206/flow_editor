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

  GlobalKey? stackKey;

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

    debugPrint('[MultiCanvasStateNotifier] switchWorkflow => $workflowId');
    state = state.copyWith(activeWorkflowId: workflowId);
  }

  void removeWorkflow(String workflowId) {
    if (workflowId == state.activeWorkflowId) return;

    final updated = {...state.workflows}..remove(workflowId);
    debugPrint('[MultiCanvasStateNotifier] removeWorkflow => $workflowId');
    state = state.copyWith(workflows: updated);
  }

  //================== 事件入口: PointerDown/Move/Up => startDrag/updateDrag/endDrag ==================//

  /// 当 pointerDown: 判断当前 mode => createEdge or normal
  /// - if createEdge => _startEdgeDrag
  /// - else => 命中测试节点 => 拖拽节点
  void startDrag(Offset globalPos) {
    final canvasSt = state.activeState;
    final mode = canvasSt.mode;

    debugPrint('[startDrag] mode=$mode, globalPos=$globalPos');
    debugPrint(
      '[startDrag] canvasState.offset=${canvasSt.offset}, scale=${canvasSt.scale}',
    );

    if (mode == CanvasInteractionMode.createEdge) {
      debugPrint('[startDrag] => createEdge mode, go _startEdgeDrag');
      _startEdgeDrag(globalPos);
    } else {
      // 普通节点拖拽
      final canvasPoint = _globalToCanvas(globalPos, canvasSt);
      debugPrint('[startDrag] => canvasPoint=$canvasPoint (after transform)');

      final node = _hitTestNode(canvasPoint);
      if (node != null) {
        debugPrint('[startDrag] => HIT NODE: ${node.id}');
        _isDraggingNode = true;
        _draggingNodeId = node.id;
      } else {
        debugPrint('[startDrag] => NO node hit, default to drag canvas');
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

    debugPrint('[updateDrag] mode=$mode, deltaGlobal=$deltaGlobal');

    if (mode == CanvasInteractionMode.createEdge && _isCreatingEdge) {
      debugPrint('[updateDrag] => updating edge drag...');
      _updateEdgeDrag(deltaGlobal);
    } else {
      if (_isDraggingNode && _draggingNodeId != null) {
        debugPrint('[updateDrag] => dragging node: $_draggingNodeId');
        _dragNodeBy(deltaGlobal);
      } else {
        debugPrint('[updateDrag] => panning canvas');
        _panCanvas(deltaGlobal);
      }
    }
  }

  /// 当 pointerUp: 如果 createEdge => _endEdgeDrag; 否则 endNodeDrag
  void endDrag() {
    final mode = state.activeState.mode;
    debugPrint(
      '[endDrag] mode=$mode, _isCreatingEdge=$_isCreatingEdge, _isDraggingNode=$_isDraggingNode',
    );

    if (mode == CanvasInteractionMode.createEdge && _isCreatingEdge) {
      debugPrint('[endDrag] => endEdgeDrag');
      _endEdgeDrag();
    } else {
      debugPrint('[endDrag] => stop dragging node');
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
    if (nid == null) {
      debugPrint('[_dragNodeBy] => no draggingNodeId, return');
      return;
    }

    final node = nodeNotifier.getNode(nid);
    if (node == null) {
      debugPrint('[_dragNodeBy] => node $nid not found in nodeNotifier, return');
      return;
    }

    final canvasSt = state.activeState;
    final dx = deltaGlobal.dx / canvasSt.scale;
    final dy = deltaGlobal.dy / canvasSt.scale;

    final updatedX = node.x + dx;
    final updatedY = node.y + dy;

    debugPrint(
      '[_dragNodeBy] nodeId=$nid, old=(${node.x}, ${node.y}), delta=($dx, $dy), new=($updatedX, $updatedY)',
    );

    final updated = node.copyWith(x: updatedX, y: updatedY);
    nodeNotifier.upsertNode(updated);
  }

  //================== 内部: 画布平移 ==================//

  void _panCanvas(Offset deltaGlobal) {
    final canvasSt = state.activeState;
    if (!canvasSt.interactionConfig.allowPan) {
      debugPrint('[_panCanvas] => pan not allowed, return');
      return;
    }

    final oldOffset = canvasSt.offset;
    final newOffset = oldOffset - (deltaGlobal / canvasSt.scale);

    debugPrint(
      '[_panCanvas] oldOffset=$oldOffset, deltaGlobal=$deltaGlobal => newOffset=$newOffset',
    );

    _updateActiveCanvas((c) => c.copyWith(offset: newOffset));
  }

  //================== 内部: 连线创建 (Edge Drag) ==================//

  /// 开始边缘拖拽 - 供外部调用
  String? startEdgeDrag(Offset globalPos) {
    debugPrint('[Public] startEdgeDrag => globalPos=$globalPos');
    _startEdgeDrag(globalPos);
    return _creatingEdgeId;
  }

  /// 更新边缘拖拽 - 供外部调用
  void updateEdgeDrag(String edgeId, Offset globalPos) {
    debugPrint('[Public] updateEdgeDrag => edgeId=$edgeId, globalPos=$globalPos');
    if (_creatingEdgeId != edgeId || !_isCreatingEdge) {
      debugPrint('[Public] updateEdgeDrag => mismatch edgeId or not creating edge');
      return;
    }

    final canvasSt = state.activeState;
    final canvasPos = _globalToCanvas(globalPos, canvasSt);
    _edgeDragCurrentCanvas = canvasPos;
    debugPrint(
      '[Public] updateEdgeDrag => canvasPos=$canvasPos, _edgeDragCurrentCanvas=$_edgeDragCurrentCanvas',
    );

    // 这里可以添加更新半连接边的逻辑
  }

  /// 结束边缘拖拽 - 供外部调用
  void endEdgeDrag(String edgeId, Offset globalPos) {
    debugPrint('[Public] endEdgeDrag => edgeId=$edgeId, globalPos=$globalPos');
    if (_creatingEdgeId != edgeId || !_isCreatingEdge) {
      debugPrint('[Public] endEdgeDrag => mismatch edgeId or not creating edge');
      return;
    }

    final canvasSt = state.activeState;
    final canvasPos = _globalToCanvas(globalPos, canvasSt);
    _edgeDragCurrentCanvas = canvasPos;
    debugPrint(
      '[Public] endEdgeDrag => canvasPos=$canvasPos',
    );

    _endEdgeDrag();
  }

  /// 1) startEdgeDrag
  void _startEdgeDrag(Offset globalPos) {
    _isCreatingEdge = true;
    _creatingEdgeId = null; // or generate a new ID (e.g. 'tempEdge123')
    final canvasSt = state.activeState;

    final canvasPos = _globalToCanvas(globalPos, canvasSt);
    _edgeDragStartCanvas = canvasPos;
    _edgeDragCurrentCanvas = canvasPos;

    debugPrint(
      '[_startEdgeDrag] => _isCreatingEdge=$_isCreatingEdge, _creatingEdgeId=$_creatingEdgeId, start=$canvasPos',
    );

    // 可选：插入半连接EdgeModel到edgeNotifier...
  }

  /// 2) updateEdgeDrag
  void _updateEdgeDrag(Offset deltaGlobal) {
    if (!_isCreatingEdge || _edgeDragCurrentCanvas == null) {
      debugPrint('[_updateEdgeDrag] => not creating edge or currentCanvas null');
      return;
    }

    final canvasSt = state.activeState;
    final dx = deltaGlobal.dx / canvasSt.scale;
    final dy = deltaGlobal.dy / canvasSt.scale;
    _edgeDragCurrentCanvas = _edgeDragCurrentCanvas!.translate(dx, dy);

    debugPrint(
      '[_updateEdgeDrag] => dx=$dx, dy=$dy, _edgeDragCurrentCanvas=$_edgeDragCurrentCanvas',
    );
  }

  /// 3) endEdgeDrag
  void _endEdgeDrag() {
    debugPrint('[_endEdgeDrag] => finishing edge creation');
    _isCreatingEdge = false;
    _edgeDragStartCanvas = null;
    _edgeDragCurrentCanvas = null;
    // _creatingEdgeId = null; // 如果你想重置ID

    // 也可进行 anchor hitTest => finalize or remove edge
  }

  //================== 工具方法 ==================//

  /// 命中检测 node
  NodeModel? _hitTestNode(Offset canvasPt) {
    final wfId = state.activeWorkflowId;
    final nodeSt = _ref.read(nodeStateProvider(wfId));

    NodeModel? found;
    for (final n in nodeSt.nodesOf(wfId).values) {
      final rect = Rect.fromLTWH(n.x, n.y, n.width, n.height);
      // 这里也可加打印每个节点的 rect
      debugPrint('[_hitTestNode] check node:${n.id}, rect=$rect');
      if (rect.contains(canvasPt)) {
        found = n;
        break;
      }
    }

    // 若想看最终命中的节点
    debugPrint('[_hitTestNode] => canvasPt=$canvasPt, foundNode=${found?.id}');
    return found;
  }

  // Offset _globalToCanvas(Offset globalPos, CanvasState cst) {
  //   final result = (globalPos - cst.offset) / cst.scale;
  //   // 也可在此加打印:
  //   // debugPrint('[_globalToCanvas] => globalPos=$globalPos => $result');
  //   return result;
  // }
  Offset _globalToCanvas(Offset globalPos, CanvasState cst) {
    // 1. 如果 stackKey 没设置或还没渲染完成，就返回 (0,0)
    if (stackKey == null) return Offset.zero;
    final renderObject = stackKey!.currentContext?.findRenderObject() as RenderBox?;
    if (renderObject == null) return Offset.zero;

    // 2. 全局坐标 => stack 局部坐标
    final localPos = renderObject.globalToLocal(globalPos);

    // 3. 再做 “减 offset，再除以 scale”，对应外层 Transform 顺序
    final result = (localPos - cst.offset) / cst.scale;
    debugPrint('[_globalToCanvas] => globalPos=$globalPos => localPos=$localPos => result=$result');
    return result;
  }


  /// 更新active Canvas
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

  //================== 其它基础操作 (平移/缩放/模式/配置等) ==================//

  void setOffset(Offset offset) {
    debugPrint('[setOffset] => $offset');
    _updateActiveCanvas(
      (canvas) => canvas.interactionConfig.allowPan
          ? canvas.copyWith(offset: offset)
          : canvas,
    );
  }

  void panBy(double dx, double dy) {
    debugPrint('[panBy] => dx=$dx, dy=$dy');
    _updateActiveCanvas(
      (canvas) => canvas.interactionConfig.allowPan
          ? canvas.copyWith(offset: canvas.offset.translate(dx, dy))
          : canvas,
    );
  }

  void setScale(double scale) {
    debugPrint('[setScale] => scale=$scale');
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
    debugPrint('[zoomAtPoint] => factor=$scaleFactor, focal=$focalPoint');
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
    debugPrint('[setInteractionMode] => $mode');
    _updateActiveCanvas((canvas) => canvas.copyWith(mode: mode));
  }

  void updateVisualConfig(CanvasVisualConfig Function(CanvasVisualConfig) fn) {
    _updateActiveCanvas(
      (canvas) => canvas.copyWith(visualConfig: fn(canvas.visualConfig)),
    );
  }

  void toggleGrid() {
    debugPrint('[toggleGrid]');
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
    debugPrint('[updateInteractionConfig]');
    _updateActiveCanvas(
      (canvas) =>
          canvas.copyWith(interactionConfig: fn(canvas.interactionConfig)),
    );
  }

  void resetCanvas() {
    debugPrint('[resetCanvas]');
    _updateActiveCanvas(
      (canvas) => CanvasState(
        interactionConfig: canvas.interactionConfig,
      ),
    );
  }
}