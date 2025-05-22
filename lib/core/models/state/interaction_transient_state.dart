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

extension InteractionStateX on InteractionState {
  // 是否处于拖动（拖节点、边、中点、插入节点等）中
  bool get isDragging => maybeWhen(
        dragNode: (_, __, ___) => true,
        dragEdge: (_, __, ___, ____) => true,
        dragWaypoint: (_, __, ___, ____) => true,
        insertingNode: (_, __, ___) => true,
        insertNodeToEdge: (_, __, ___) => true,
        resizingNode: (_, __, ___, ____) => true,
        orElse: () => false,
      );

  // 是否正在拖拽节点
  bool get isDraggingNode => maybeWhen(
        dragNode: (_, __, ___) => true,
        orElse: () => false,
      );

  // 是否正在拖拽边
  bool get isDraggingEdge => maybeWhen(
        dragEdge: (_, __, ___, ____) => true,
        orElse: () => false,
      );

  // 是否正在拖拽中点（waypoint）
  bool get isDraggingWaypoint => maybeWhen(
        dragWaypoint: (_, __, ___, ____) => true,
        orElse: () => false,
      );

  // 是否正在拖动画布
  bool get isPanning => maybeWhen(
        panCanvas: (_, __) => true,
        orElse: () => false,
      );

  // 当前拖动状态的 delta
  Offset? get deltaPan => maybeWhen(
        dragNode: (_, start, last) => last - start,
        dragEdge: (_, start, last, __) => last - start,
        dragWaypoint: (_, __, start, last) => last - start,
        insertingNode: (_, start, last) => last - start,
        insertNodeToEdge: (_, start, last) => last - start,
        resizingNode: (_, __, start, last) => last - start,
        panCanvas: (start, last) => last - start,
        orElse: () => null,
      );

  // 当前拖拽中涉及的目标 ID（可能是 nodeId / edgeId）
  String? get draggingTargetId => maybeWhen(
        dragNode: (nodeId, __, ___) => nodeId,
        dragEdge: (edgeId, __, ___, ____) => edgeId,
        dragWaypoint: (edgeId, __, ___, ____) => edgeId,
        resizingNode: (nodeId, __, ___, ____) => nodeId,
        orElse: () => null,
      );

  // 是否为悬停状态
  bool get isHovering => maybeWhen(
        hoveringNode: (_) => true,
        hoveringEdge: (_) => true,
        hoveringAnchor: (_) => true,
        orElse: () => false,
      );

  // 是否处于打开菜单状态
  bool get isContextMenuOpen => maybeWhen(
        contextMenuOpen: (_, __) => true,
        orElse: () => false,
      );

  // 当前悬停目标 ID（node/anchor/edge）
  String? get hoveringTargetId => maybeWhen(
        hoveringNode: (id) => id,
        hoveringEdge: (id) => id,
        hoveringAnchor: (id) => id,
        orElse: () => null,
      );

  // 是否是正在框选
  bool get isSelectingArea => maybeWhen(
        selectingArea: (_) => true,
        orElse: () => false,
      );

  // 框选区域
  Rect? get selectionBox => maybeWhen(
        selectingArea: (box) => box,
        orElse: () => null,
      );
}
