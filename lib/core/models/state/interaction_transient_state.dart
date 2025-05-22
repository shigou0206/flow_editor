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

  const factory InteractionState.dragNode({
    required String nodeId,
    @OffsetConverter() required Offset startCanvas,
    @OffsetConverter() required Offset lastCanvas,
  }) = DragNode;

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
  /// 是否处于拖动状态
  bool get isDragging => maybeMap(
        dragNode: (_) => true,
        dragEdge: (_) => true,
        dragWaypoint: (_) => true,
        insertingNode: (_) => true,
        insertNodeToEdge: (_) => true,
        resizingNode: (_) => true,
        orElse: () => false,
      );

  /// 是否处于画布拖动
  bool get isPanning => maybeMap(
        panCanvas: (_) => true,
        orElse: () => false,
      );

  /// 当前拖动画布时的偏移
  Offset get deltaPan => maybeWhen(
        panCanvas: (startGlobal, lastGlobal) => lastGlobal - startGlobal,
        orElse: () => Offset.zero,
      );

  /// 当前拖动节点的偏移
  Offset get deltaNodeDrag => maybeWhen(
        dragNode: (_, startCanvas, lastCanvas) => lastCanvas - startCanvas,
        orElse: () => Offset.zero,
      );

  Offset dragOffsetForNode(String nodeId) => maybeMap(
        dragNode: (s) =>
            s.nodeId == nodeId ? s.lastCanvas - s.startCanvas : Offset.zero,
        orElse: () => Offset.zero,
      );

  /// 当前拖动边的偏移
  Offset get deltaEdgeDrag => maybeWhen(
        dragEdge: (_, startCanvas, lastCanvas, __) => lastCanvas - startCanvas,
        orElse: () => Offset.zero,
      );

  /// 👉 当前拖动Waypoint的偏移
  Offset get deltaWaypointDrag => maybeWhen(
        dragWaypoint: (_, __, startCanvas, lastCanvas) =>
            lastCanvas - startCanvas,
        orElse: () => Offset.zero,
      );

  /// 👉 当前插入节点的偏移
  Offset get deltaInsertNode => maybeWhen(
        insertingNode: (_, startCanvas, lastCanvas) => lastCanvas - startCanvas,
        orElse: () => Offset.zero,
      );

  /// 👉 当前节点resize的偏移
  Offset get deltaResizeNode => maybeWhen(
        resizingNode: (_, __, startCanvas, lastCanvas) =>
            lastCanvas - startCanvas,
        orElse: () => Offset.zero,
      );

  /// 当前hover的目标 ID
  String? get hoveringTargetId => maybeWhen(
        hoveringNode: (id) => id,
        hoveringEdge: (id) => id,
        hoveringAnchor: (id) => id,
        orElse: () => null,
      );

  /// 当前拖动目标 ID（Node/Edge）
  String? get draggingTargetId => maybeWhen(
        dragNode: (nodeId, _, __) => nodeId,
        dragEdge: (edgeId, _, __, ___) => edgeId,
        dragWaypoint: (edgeId, _, __, ___) => edgeId,
        resizingNode: (nodeId, _, __, ___) => nodeId,
        insertNodeToEdge: (edgeId, _, __) => edgeId,
        orElse: () => null,
      );

  /// 是否正在框选
  bool get isSelectingArea => maybeMap(
        selectingArea: (_) => true,
        orElse: () => false,
      );

  /// 框选区域
  Rect? get selectionBox => maybeWhen(
        selectingArea: (selectionBox) => selectionBox,
        orElse: () => null,
      );

  /// 当前是否正在悬停节点
  bool get isHoveringNode => maybeMap(
        hoveringNode: (_) => true,
        orElse: () => false,
      );

  /// 当前是否正在悬停边
  bool get isHoveringEdge => maybeMap(
        hoveringEdge: (_) => true,
        orElse: () => false,
      );

  /// 当前是否正在悬停锚点
  bool get isHoveringAnchor => maybeMap(
        hoveringAnchor: (_) => true,
        orElse: () => false,
      );

  /// 当前是否有任何悬停（节点、边或锚点）
  bool get isHovering => isHoveringNode || isHoveringEdge || isHoveringAnchor;

  /// 当前悬停的节点 ID（如果存在）
  String? get hoveringNodeId => maybeWhen(
        hoveringNode: (id) => id,
        orElse: () => null,
      );

  /// 当前悬停的边 ID（如果存在）
  String? get hoveringEdgeId => maybeWhen(
        hoveringEdge: (id) => id,
        orElse: () => null,
      );

  /// 当前悬停的锚点 ID（如果存在）
  String? get hoveringAnchorId => maybeWhen(
        hoveringAnchor: (id) => id,
        orElse: () => null,
      );
}
