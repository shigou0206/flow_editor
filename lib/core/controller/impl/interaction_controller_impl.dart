import 'dart:ui';
import 'package:flow_editor/core/controller/interfaces/interaction_controller.dart';
import 'package:flow_editor/core/command/command_context.dart';
import 'package:flow_editor/core/models/state/editor_state.dart';
import 'package:flow_editor/core/models/state/interaction_transient_state.dart';
import 'package:flow_editor/core/models/node_model.dart';
import 'package:flow_editor/core/models/edge_model.dart';
import 'package:flow_editor/core/models/canvas_insert_element.dart';
import 'package:flutter/material.dart';

class InteractionControllerImpl implements IInteractionController {
  final CommandContext ctx;

  InteractionControllerImpl({required this.ctx});

  EditorState get _st => ctx.getState();
  set _st(EditorState state) => ctx.updateState(state);

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

  @override
  void startEdgeDrag(String sourceNodeId, String sourceAnchorId) {
    final tempEdgeId = generateTempEdgeId(sourceNodeId, sourceAnchorId);
    _st = _st.copyWith(
      interaction: InteractionState.dragEdge(
        edgeId: tempEdgeId,
        sourceNodeId: sourceNodeId,
        sourceAnchorId: sourceAnchorId,
        startCanvas: Offset.zero,
        lastCanvas: Offset.zero,
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
  void endEdgeDrag() {
    final it = _st.interaction;
    if (it is DragEdge) {
      _st = _st.copyWith(interaction: const InteractionState.idle());
    } else {
      throw StateError('Invalid interaction state for edge drag');
    }
  }

  @override
  void cancelEdgeDrag() =>
      _st = _st.copyWith(interaction: const InteractionState.idle());

  @override
  String generateTempEdgeId(String sourceNodeId, String sourceAnchorId) {
    final now = DateTime.now().millisecondsSinceEpoch;
    return 'temp_edge_${sourceNodeId}_${sourceAnchorId}_$now';
  }

  @override
  void marqueeSelect(Rect area) {
    _st = _st.copyWith(
      interaction: InteractionState.selectingArea(selectionBox: area),
    );
  }

  @override
  void cancelMarqueeSelection() =>
      _st = _st.copyWith(interaction: const InteractionState.idle());

  @override
  void copySelection() {}

  @override
  void pasteClipboard() {}

  @override
  void deleteSelection() {}

  @override
  void hoverNode(String nodeId) {
    _st = _st.copyWith(
      interaction: InteractionState.hoveringNode(nodeId: nodeId),
    );
  }

  @override
  void hoverAnchor(String nodeId, String anchorId) {
    _st = _st.copyWith(
      interaction: InteractionState.hoveringAnchor(
        nodeId: nodeId,
        anchorId: anchorId,
      ),
    );
  }

  @override
  void hoverEdge(String edgeId) {
    _st = _st.copyWith(
      interaction: InteractionState.hoveringEdge(edgeId: edgeId),
    );
  }

  @override
  void clearHover() {
    _st = _st.copyWith(interaction: const InteractionState.idle());
  }

  @override
  void startInsertingNodePreview(NodeModel node, Offset canvasPos) {
    _st = _st.copyWith(
      interaction: InteractionState.insertingNodePreview(
        node: node,
        canvasPos: canvasPos,
        highlightedEdgeId: null,
      ),
    );
  }

  @override
  void updateInsertingNodePreview(Offset canvasPos, String? highlightedEdgeId) {
    final interaction = _st.interaction;
    if (interaction is InsertingNodePreview) {
      _st = _st.copyWith(
        interaction: interaction.copyWith(
          canvasPos: canvasPos,
          highlightedEdgeId: highlightedEdgeId,
        ),
      );
    } else {
      debugPrint('🚨 Interaction 状态异常: 当前并非插入预览状态');
    }
  }

  @override
  void endInsertingNodePreview() {
    _st = _st.copyWith(interaction: const InteractionState.idle());
  }

  @override
  void startInsertingGroupPreview(NodeModel groupNode, List<NodeModel> children,
      List<EdgeModel> edges, Offset canvasPos) {
    _st = _st.copyWith(
      interaction: InteractionState.insertingGroupPreview(
        groupElement: CanvasInsertElement.group(
            groupNode: groupNode, children: children, edges: edges),
        canvasPos: canvasPos,
        highlightedEdgeId: null,
      ),
    );
  }

  @override
  void updateInsertingGroupPreview(
      Offset canvasPos, String? highlightedEdgeId) {
    final interaction = _st.interaction;
    if (interaction is InsertingGroupPreview) {
      _st = _st.copyWith(
        interaction: interaction.copyWith(
          canvasPos: canvasPos,
          highlightedEdgeId: highlightedEdgeId,
        ),
      );
    } else {
      debugPrint('🚨 Interaction 状态异常: 当前并非Group插入预览状态');
    }
  }

  @override
  void endInsertingGroupPreview() {
    _st = _st.copyWith(interaction: const InteractionState.idle());
  }
}
