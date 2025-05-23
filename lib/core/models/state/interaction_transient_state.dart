import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/material.dart';
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

  // ✅ 完全修正后的 dragEdge
  const factory InteractionState.dragEdge({
    required String edgeId,
    required String sourceNodeId,
    required String sourceAnchorId, // 明确修正
    @OffsetConverter() required Offset startCanvas,
    @OffsetConverter() required Offset lastCanvas,
  }) = DragEdge;

  const factory InteractionState.dragWaypoint({
    required String edgeId,
    required int pointIndex,
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
    required String anchorId,
  }) = HoveringAnchor;

  const factory InteractionState.hoveringEdge({
    required String edgeId,
  }) = HoveringEdge;

  const factory InteractionState.contextMenuOpen({
    @OffsetConverter() required Offset globalPosition,
    String? targetId,
  }) = ContextMenuOpen;

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
        dragWaypoint: (_, __, startCanvas, lastCanvas) =>
            lastCanvas - startCanvas,
        orElse: () => Offset.zero,
      );

  Offset get deltaInsertNode => maybeWhen(
        insertingNode: (_, startCanvas, lastCanvas) => lastCanvas - startCanvas,
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
        hoveringAnchor: (id) => id,
        orElse: () => null,
      );

  String? get draggingTargetId => maybeWhen(
        dragNode: (nodeId, _, __) => nodeId,
        dragEdge: (edgeId, _, __, ___, ____) => edgeId,
        dragWaypoint: (edgeId, _, __, ___) => edgeId,
        resizingNode: (nodeId, _, __, ___) => nodeId,
        insertNodeToEdge: (edgeId, _, __) => edgeId,
        orElse: () => null,
      );

  bool get isSelectingArea => maybeMap(
        selectingArea: (_) => true,
        orElse: () => false,
      );

  Rect? get selectionBox => maybeWhen(
        selectingArea: (selectionBox) => selectionBox,
        orElse: () => null,
      );

  bool get isHoveringNode => maybeMap(
        hoveringNode: (_) => true,
        orElse: () => false,
      );

  bool get isHoveringEdge => maybeMap(
        hoveringEdge: (_) => true,
        orElse: () => false,
      );

  bool get isHoveringAnchor => maybeMap(
        hoveringAnchor: (_) => true,
        orElse: () => false,
      );

  bool get isHovering => isHoveringNode || isHoveringEdge || isHoveringAnchor;

  String? get hoveringNodeId => maybeWhen(
        hoveringNode: (id) => id,
        orElse: () => null,
      );

  String? get hoveringEdgeId => maybeWhen(
        hoveringEdge: (id) => id,
        orElse: () => null,
      );

  String? get hoveringAnchorId => maybeWhen(
        hoveringAnchor: (id) => id,
        orElse: () => null,
      );

  // ✅ 修正后的扩展方法获取拖拽边的起始节点 ID
  String? get draggingSourceNodeId => maybeWhen(
        dragEdge: (_, sourceNodeId, __, ___, ____) => sourceNodeId,
        orElse: () => null,
      );

  // ✅ 修正后的扩展方法获取拖拽边的起始锚点 ID
  String? get draggingSourceAnchorId => maybeWhen(
        dragEdge: (_, __, sourceAnchorId, ___, ____) => sourceAnchorId,
        orElse: () => null,
      );
}
