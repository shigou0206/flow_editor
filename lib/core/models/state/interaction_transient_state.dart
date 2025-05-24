import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/material.dart';
import 'package:flow_editor/core/models/node_model.dart';
import 'package:flow_editor/core/models/converters/offset_size_converter.dart';
import 'package:flow_editor/core/models/converters/rect_converter.dart';

part 'interaction_transient_state.freezed.dart';
part 'interaction_transient_state.g.dart';

@Freezed(unionKey: 'type', unionValueCase: FreezedUnionCase.snake)
class InteractionState with _$InteractionState {
  const InteractionState._();

  const factory InteractionState.idle() = Idle;

  const factory InteractionState.dragNode({
    required String nodeId,
    @OffsetConverter() required Offset startCanvas,
    @OffsetConverter() required Offset lastCanvas,
  }) = DragNode;

  const factory InteractionState.dragEdge({
    required String edgeId,
    required String sourceNodeId,
    required String sourceAnchorId,
    @OffsetConverter() required Offset startCanvas,
    @OffsetConverter() required Offset lastCanvas,
  }) = DragEdge;

  const factory InteractionState.dragWaypoint({
    required String edgeId,
    required int pointIndex,
    @OffsetConverter() required Offset originalPoint,
    @OffsetConverter() required Offset startCanvas,
    @OffsetConverter() required Offset lastCanvas,
  }) = DragWaypoint;

  const factory InteractionState.panCanvas({
    @OffsetConverter() required Offset startGlobal,
    @OffsetConverter() required Offset lastGlobal,
  }) = PanCanvas;

  const factory InteractionState.selectingArea({
    @RectConverter() required Rect selectionBox,
  }) = SelectingArea;

  const factory InteractionState.insertingNode({
    required String nodeType,
    @OffsetConverter() required Offset startCanvas,
    @OffsetConverter() required Offset lastCanvas,
  }) = InsertingNode;

  const factory InteractionState.insertNodeToEdge({
    required String nodeType,
    required String edgeId,
    @OffsetConverter() required Offset startCanvas,
    @OffsetConverter() required Offset lastCanvas,
  }) = InsertNodeToEdge;

  const factory InteractionState.resizingNode({
    required String nodeId,
    @OffsetConverter() required Offset handlePosition,
    @OffsetConverter() required Offset startCanvas,
    @OffsetConverter() required Offset lastCanvas,
  }) = ResizingNode;

  const factory InteractionState.hoveringNode({
    required String nodeId,
  }) = HoveringNode;

  const factory InteractionState.hoveringAnchor({
    required String nodeId,
    required String anchorId,
  }) = HoveringAnchor;

  const factory InteractionState.hoveringEdge({
    required String edgeId,
  }) = HoveringEdge;

  const factory InteractionState.contextMenuOpen({
    @OffsetConverter() required Offset globalPosition,
    String? targetId,
  }) = ContextMenuOpen;

  const factory InteractionState.insertingNodePreview({
    required NodeModel node,
    @OffsetConverter() required Offset canvasPos,
    String? highlightedEdgeId,
  }) = InsertingNodePreview;

  factory InteractionState.fromJson(Map<String, dynamic> json) =>
      _$InteractionStateFromJson(json);
}

extension InteractionStateX on InteractionState {
  bool get isDragging => maybeMap(
        dragNode: (_) => true,
        dragEdge: (_) => true,
        dragWaypoint: (_) => true,
        insertingNode: (_) => true,
        insertNodeToEdge: (_) => true,
        resizingNode: (_) => true,
        orElse: () => false,
      );

  bool get isPanning => maybeMap(
        panCanvas: (_) => true,
        orElse: () => false,
      );

  Offset get deltaPan => maybeWhen(
        panCanvas: (startGlobal, lastGlobal) => lastGlobal - startGlobal,
        orElse: () => Offset.zero,
      );

  Offset get deltaNodeDrag => maybeWhen(
        dragNode: (_, startCanvas, lastCanvas) => lastCanvas - startCanvas,
        orElse: () => Offset.zero,
      );

  Offset dragOffsetForNode(String nodeId) => maybeMap(
        dragNode: (s) =>
            s.nodeId == nodeId ? s.lastCanvas - s.startCanvas : Offset.zero,
        orElse: () => Offset.zero,
      );

  Offset get deltaEdgeDrag => maybeWhen(
        dragEdge: (_, __, ___, startCanvas, lastCanvas) =>
            lastCanvas - startCanvas,
        orElse: () => Offset.zero,
      );

  Offset get deltaWaypointDrag => maybeWhen(
        dragWaypoint: (_, __, ___, startCanvas, lastCanvas) =>
            lastCanvas - startCanvas,
        orElse: () => Offset.zero,
      );

  Offset get deltaInsertNode => maybeWhen(
        insertingNode: (_, startCanvas, lastCanvas) => lastCanvas - startCanvas,
        orElse: () => Offset.zero,
      );

  Offset get deltaInsertNodeToEdge => maybeWhen(
        insertNodeToEdge: (_, __, startCanvas, lastCanvas) =>
            lastCanvas - startCanvas,
        orElse: () => Offset.zero,
      );

  Offset get deltaResizeNode => maybeWhen(
        resizingNode: (_, __, startCanvas, lastCanvas) =>
            lastCanvas - startCanvas,
        orElse: () => Offset.zero,
      );

  String? get hoveringTargetId => maybeWhen(
        hoveringNode: (id) => id,
        hoveringEdge: (id) => id,
        hoveringAnchor: (_, id) => id,
        orElse: () => null,
      );

  String? get draggingTargetId => maybeWhen(
        dragNode: (nodeId, _, __) => nodeId,
        dragEdge: (edgeId, _, __, ___, ____) => edgeId,
        dragWaypoint: (edgeId, _, __, ___, ____) => edgeId,
        resizingNode: (nodeId, _, __, ___) => nodeId,
        insertNodeToEdge: (_, edgeId, __, ___) => edgeId,
        orElse: () => null,
      );

  String? get insertingNodeType => maybeWhen(
        insertingNode: (nodeType, _, __) => nodeType,
        insertNodeToEdge: (nodeType, _, __, ___) => nodeType,
        insertingNodePreview: (node, _, __) => node.type,
        orElse: () => null,
      );

  bool get isInsertingNodePreview => maybeMap(
        insertingNodePreview: (_) => true,
        orElse: () => false,
      );

  Offset? get insertingPreviewPos => maybeWhen(
        insertingNodePreview: (_, pos, __) => pos,
        orElse: () => null,
      );

  Size? get insertingPreviewSize => maybeWhen(
        insertingNodePreview: (node, _, __) => node.size,
        orElse: () => null,
      );

  String? get insertingHighlightedEdgeId => maybeWhen(
        insertingNodePreview: (_, __, edgeId) => edgeId,
        orElse: () => null,
      );

  bool get isSelectingArea =>
      maybeMap(selectingArea: (_) => true, orElse: () => false);
  Rect? get selectionBox =>
      maybeWhen(selectingArea: (box) => box, orElse: () => null);

  bool get isHoveringNode =>
      maybeMap(hoveringNode: (_) => true, orElse: () => false);
  bool get isHoveringEdge =>
      maybeMap(hoveringEdge: (_) => true, orElse: () => false);
  bool get isHoveringAnchor =>
      maybeMap(hoveringAnchor: (_) => true, orElse: () => false);
  bool get isHovering => isHoveringNode || isHoveringEdge || isHoveringAnchor;

  String? get hoveringNodeId =>
      maybeWhen(hoveringNode: (id) => id, orElse: () => null);
  String? get hoveringEdgeId =>
      maybeWhen(hoveringEdge: (id) => id, orElse: () => null);
  String? get hoveringAnchorId =>
      maybeWhen(hoveringAnchor: (_, anchorId) => anchorId, orElse: () => null);
  String? get hoveringAnchorNodeId =>
      maybeWhen(hoveringAnchor: (nodeId, _) => nodeId, orElse: () => null);

  String? get draggingSourceNodeId => maybeWhen(
      dragEdge: (_, sourceNodeId, __, ___, ____) => sourceNodeId,
      orElse: () => null);
  String? get draggingSourceAnchorId => maybeWhen(
      dragEdge: (_, __, sourceAnchorId, ___, ____) => sourceAnchorId,
      orElse: () => null);

  int? get draggingWaypointIndex => maybeWhen(
      dragWaypoint: (_, index, ___, ____, _____) => index, orElse: () => null);
  Offset? get draggingWaypointOriginalPoint => maybeWhen(
      dragWaypoint: (_, __, originalPoint, ___, ____) => originalPoint,
      orElse: () => null);
}
