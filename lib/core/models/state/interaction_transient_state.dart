import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/material.dart';
import 'package:flow_editor/core/models/anchor_model.dart';
import 'package:flow_editor/core/models/converters/offset_size_converter.dart';
import 'package:flow_editor/core/models/converters/rect_converter.dart';

part 'interaction_transient_state.freezed.dart';
part 'interaction_transient_state.g.dart';

@Freezed(unionKey: 'type', unionValueCase: FreezedUnionCase.snake)
class InteractionState with _$InteractionState {
  const InteractionState._();

  const factory InteractionState.idle() = Idle;

  /// 拖节点：记录拖开始的画布坐标 startCanvas，和最新的 lastCanvas
  const factory InteractionState.dragNode({
    required String nodeId,
    @OffsetConverter() required Offset startCanvas,
    @OffsetConverter() required Offset lastCanvas,
  }) = DragNode;

  /// 拖边：同理记录起点，以及最新的临时终点
  const factory InteractionState.dragEdge({
    required String edgeId,
    @OffsetConverter() required Offset startCanvas,
    @OffsetConverter() required Offset lastCanvas,
    required AnchorModel sourceAnchor,
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
