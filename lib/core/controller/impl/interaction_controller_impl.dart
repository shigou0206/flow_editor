// lib/core/controller/implementations/interaction_controller_impl.dart

import 'dart:ui';
import 'package:flow_editor/core/controller/interfaces/interaction_controller.dart';
import 'package:flow_editor/core/command/command_context.dart';
import 'package:flow_editor/core/models/state/editor_state.dart';
import 'package:flow_editor/core/models/state/interaction_transient_state.dart';
import 'package:flow_editor/core/models/anchor_model.dart';

class InteractionControllerImpl implements IInteractionController {
  final CommandContext ctx;

  InteractionControllerImpl({required this.ctx});

  EditorState get _st => ctx.getState();
  set _st(EditorState state) => ctx.updateState(state);

  // === 节点拖拽相关 ===

  @override
  void startNodeDrag(String nodeId) {
    _st = _st.copyWith(
      interaction: InteractionState.dragNode(
        nodeId: nodeId,
        startCanvas: Offset.zero,
        lastCanvas: Offset.zero,
      ),
    );
  }

  @override
  void updateNodeDrag(Offset delta) {
    final it = _st.interaction;
    if (it is DragNode) {
      _st = _st.copyWith(
        interaction: it.copyWith(lastCanvas: it.lastCanvas + delta),
      );
    }
  }

  @override
  Offset endNodeDrag() {
    final it = _st.interaction;
    if (it is DragNode) {
      final delta = it.lastCanvas;
      _st = _st.copyWith(interaction: const InteractionState.idle());
      return delta;
    }
    return Offset.zero;
  }

  @override
  void cancelNodeDrag() =>
      _st = _st.copyWith(interaction: const InteractionState.idle());

  // === 边拖拽相关 ===

  @override
  void startEdgeDrag(String anchorId) {
    final anchor = _findAnchorById(anchorId);
    final tempEdgeId = generateTempEdgeId(anchor);
    _st = _st.copyWith(
      interaction: InteractionState.dragEdge(
        edgeId: tempEdgeId,
        startCanvas: Offset.zero,
        lastCanvas: Offset.zero,
        sourceAnchor: anchor,
      ),
    );
  }

  @override
  void updateEdgeDrag(Offset canvasPos) {
    final it = _st.interaction;
    if (it is DragEdge) {
      _st = _st.copyWith(
        interaction: it.copyWith(lastCanvas: canvasPos),
      );
    }
  }

  @override
  AnchorModel endEdgeDrag({String? targetNodeId, String? targetAnchorId}) {
    final it = _st.interaction;
    if (it is DragEdge) {
      _st = _st.copyWith(interaction: const InteractionState.idle());
      return it.sourceAnchor;
    }
    throw StateError('Invalid interaction state for edge drag');
  }

  @override
  void cancelEdgeDrag() =>
      _st = _st.copyWith(interaction: const InteractionState.idle());

  @override
  String generateTempEdgeId(AnchorModel sourceAnchor) {
    final now = DateTime.now().millisecondsSinceEpoch;
    return 'temp_edge_${sourceAnchor.nodeId}_${sourceAnchor.id}_$now';
  }

  // === 框选操作 ===

  @override
  void marqueeSelect(Rect area) {
    _st = _st.copyWith(
      interaction: InteractionState.selectingArea(selectionBox: area),
    );
  }

  @override
  void cancelMarqueeSelection() =>
      _st = _st.copyWith(interaction: const InteractionState.idle());

  // === 其他临时交互（仅视觉效果） ===

  @override
  void copySelection() {}

  @override
  void pasteClipboard() {}

  @override
  void deleteSelection() {}

  // === 辅助方法 ===

  AnchorModel _findAnchorById(String anchorId) {
    for (var node in _st.nodeState.nodes) {
      for (var anchor in node.anchors) {
        if (anchor.id == anchorId) return anchor;
      }
    }
    throw StateError('Anchor not found: $anchorId');
  }
}

@override
  void panBy(Offset delta) {
    throw UnimplementedError('panBy is not yet implemented.');
  }

@override
  void panTo(Offset position) {
    throw UnimplementedError('panTo is not yet implemented.');
  }

@override
  void zoomAt(Offset focalPoint, double scaleDelta) {
    throw UnimplementedError('zoomAt is not yet implemented.');
  }

@override
  void zoomTo(double scale) {
    throw UnimplementedError('zoomTo is not yet implemented.');
  }

@override
  void focusOnNode(String nodeId) {
    throw UnimplementedError('focusOnNode is not yet implemented.');
  }

@override
  void cancelNodeDrag() {
    throw UnimplementedError('cancelNodeDrag is not yet implemented.');
  }

@override
  void cancelEdgeDrag() {
    throw UnimplementedError('cancelEdgeDrag is not yet implemented.');
  }

@override
  void cancelMarqueeSelection() {
    throw UnimplementedError('cancelMarqueeSelection is not yet implemented.');
  }
