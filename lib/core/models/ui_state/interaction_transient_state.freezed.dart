// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'interaction_transient_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

InteractionState _$InteractionStateFromJson(Map<String, dynamic> json) {
  switch (json['type']) {
    case 'idle':
      return Idle.fromJson(json);
    case 'drag_node':
      return DragNode.fromJson(json);
    case 'drag_edge':
      return DragEdge.fromJson(json);
    case 'drag_waypoint':
      return DragWaypoint.fromJson(json);
    case 'pan_canvas':
      return PanCanvas.fromJson(json);
    case 'selecting_area':
      return SelectingArea.fromJson(json);
    case 'inserting_node':
      return InsertingNode.fromJson(json);
    case 'insert_node_to_edge':
      return InsertNodeToEdge.fromJson(json);
    case 'resizing_node':
      return ResizingNode.fromJson(json);
    case 'hovering_node':
      return HoveringNode.fromJson(json);
    case 'hovering_anchor':
      return HoveringAnchor.fromJson(json);
    case 'hovering_edge':
      return HoveringEdge.fromJson(json);
    case 'context_menu_open':
      return ContextMenuOpen.fromJson(json);
    case 'inserting_node_preview':
      return InsertingNodePreview.fromJson(json);
    case 'inserting_group_preview':
      return InsertingGroupPreview.fromJson(json);

    default:
      throw CheckedFromJsonException(json, 'type', 'InteractionState',
          'Invalid union type "${json['type']}"!');
  }
}

/// @nodoc
mixin _$InteractionState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() idle,
    required TResult Function(
            String nodeId,
            @OffsetConverter() Offset startCanvas,
            @OffsetConverter() Offset lastCanvas)
        dragNode,
    required TResult Function(
            String edgeId,
            String sourceNodeId,
            String sourceAnchorId,
            @OffsetConverter() Offset startCanvas,
            @OffsetConverter() Offset lastCanvas)
        dragEdge,
    required TResult Function(
            String edgeId,
            int pointIndex,
            @OffsetConverter() Offset originalPoint,
            @OffsetConverter() Offset startCanvas,
            @OffsetConverter() Offset lastCanvas)
        dragWaypoint,
    required TResult Function(@OffsetConverter() Offset startGlobal,
            @OffsetConverter() Offset lastGlobal)
        panCanvas,
    required TResult Function(@RectConverter() Rect selectionBox) selectingArea,
    required TResult Function(
            String nodeType,
            @OffsetConverter() Offset startCanvas,
            @OffsetConverter() Offset lastCanvas)
        insertingNode,
    required TResult Function(
            String nodeType,
            String edgeId,
            @OffsetConverter() Offset startCanvas,
            @OffsetConverter() Offset lastCanvas)
        insertNodeToEdge,
    required TResult Function(
            String nodeId,
            @OffsetConverter() Offset handlePosition,
            @OffsetConverter() Offset startCanvas,
            @OffsetConverter() Offset lastCanvas)
        resizingNode,
    required TResult Function(String nodeId) hoveringNode,
    required TResult Function(String nodeId, String anchorId) hoveringAnchor,
    required TResult Function(String edgeId) hoveringEdge,
    required TResult Function(
            @OffsetConverter() Offset globalPosition, String? targetId)
        contextMenuOpen,
    required TResult Function(NodeModel node,
            @OffsetConverter() Offset canvasPos, String? highlightedEdgeId)
        insertingNodePreview,
    required TResult Function(CanvasInsertElement groupElement,
            @OffsetConverter() Offset canvasPos, String? highlightedEdgeId)
        insertingGroupPreview,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? idle,
    TResult? Function(String nodeId, @OffsetConverter() Offset startCanvas,
            @OffsetConverter() Offset lastCanvas)?
        dragNode,
    TResult? Function(
            String edgeId,
            String sourceNodeId,
            String sourceAnchorId,
            @OffsetConverter() Offset startCanvas,
            @OffsetConverter() Offset lastCanvas)?
        dragEdge,
    TResult? Function(
            String edgeId,
            int pointIndex,
            @OffsetConverter() Offset originalPoint,
            @OffsetConverter() Offset startCanvas,
            @OffsetConverter() Offset lastCanvas)?
        dragWaypoint,
    TResult? Function(@OffsetConverter() Offset startGlobal,
            @OffsetConverter() Offset lastGlobal)?
        panCanvas,
    TResult? Function(@RectConverter() Rect selectionBox)? selectingArea,
    TResult? Function(String nodeType, @OffsetConverter() Offset startCanvas,
            @OffsetConverter() Offset lastCanvas)?
        insertingNode,
    TResult? Function(
            String nodeType,
            String edgeId,
            @OffsetConverter() Offset startCanvas,
            @OffsetConverter() Offset lastCanvas)?
        insertNodeToEdge,
    TResult? Function(
            String nodeId,
            @OffsetConverter() Offset handlePosition,
            @OffsetConverter() Offset startCanvas,
            @OffsetConverter() Offset lastCanvas)?
        resizingNode,
    TResult? Function(String nodeId)? hoveringNode,
    TResult? Function(String nodeId, String anchorId)? hoveringAnchor,
    TResult? Function(String edgeId)? hoveringEdge,
    TResult? Function(
            @OffsetConverter() Offset globalPosition, String? targetId)?
        contextMenuOpen,
    TResult? Function(NodeModel node, @OffsetConverter() Offset canvasPos,
            String? highlightedEdgeId)?
        insertingNodePreview,
    TResult? Function(CanvasInsertElement groupElement,
            @OffsetConverter() Offset canvasPos, String? highlightedEdgeId)?
        insertingGroupPreview,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? idle,
    TResult Function(String nodeId, @OffsetConverter() Offset startCanvas,
            @OffsetConverter() Offset lastCanvas)?
        dragNode,
    TResult Function(
            String edgeId,
            String sourceNodeId,
            String sourceAnchorId,
            @OffsetConverter() Offset startCanvas,
            @OffsetConverter() Offset lastCanvas)?
        dragEdge,
    TResult Function(
            String edgeId,
            int pointIndex,
            @OffsetConverter() Offset originalPoint,
            @OffsetConverter() Offset startCanvas,
            @OffsetConverter() Offset lastCanvas)?
        dragWaypoint,
    TResult Function(@OffsetConverter() Offset startGlobal,
            @OffsetConverter() Offset lastGlobal)?
        panCanvas,
    TResult Function(@RectConverter() Rect selectionBox)? selectingArea,
    TResult Function(String nodeType, @OffsetConverter() Offset startCanvas,
            @OffsetConverter() Offset lastCanvas)?
        insertingNode,
    TResult Function(
            String nodeType,
            String edgeId,
            @OffsetConverter() Offset startCanvas,
            @OffsetConverter() Offset lastCanvas)?
        insertNodeToEdge,
    TResult Function(
            String nodeId,
            @OffsetConverter() Offset handlePosition,
            @OffsetConverter() Offset startCanvas,
            @OffsetConverter() Offset lastCanvas)?
        resizingNode,
    TResult Function(String nodeId)? hoveringNode,
    TResult Function(String nodeId, String anchorId)? hoveringAnchor,
    TResult Function(String edgeId)? hoveringEdge,
    TResult Function(
            @OffsetConverter() Offset globalPosition, String? targetId)?
        contextMenuOpen,
    TResult Function(NodeModel node, @OffsetConverter() Offset canvasPos,
            String? highlightedEdgeId)?
        insertingNodePreview,
    TResult Function(CanvasInsertElement groupElement,
            @OffsetConverter() Offset canvasPos, String? highlightedEdgeId)?
        insertingGroupPreview,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(Idle value) idle,
    required TResult Function(DragNode value) dragNode,
    required TResult Function(DragEdge value) dragEdge,
    required TResult Function(DragWaypoint value) dragWaypoint,
    required TResult Function(PanCanvas value) panCanvas,
    required TResult Function(SelectingArea value) selectingArea,
    required TResult Function(InsertingNode value) insertingNode,
    required TResult Function(InsertNodeToEdge value) insertNodeToEdge,
    required TResult Function(ResizingNode value) resizingNode,
    required TResult Function(HoveringNode value) hoveringNode,
    required TResult Function(HoveringAnchor value) hoveringAnchor,
    required TResult Function(HoveringEdge value) hoveringEdge,
    required TResult Function(ContextMenuOpen value) contextMenuOpen,
    required TResult Function(InsertingNodePreview value) insertingNodePreview,
    required TResult Function(InsertingGroupPreview value)
        insertingGroupPreview,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(Idle value)? idle,
    TResult? Function(DragNode value)? dragNode,
    TResult? Function(DragEdge value)? dragEdge,
    TResult? Function(DragWaypoint value)? dragWaypoint,
    TResult? Function(PanCanvas value)? panCanvas,
    TResult? Function(SelectingArea value)? selectingArea,
    TResult? Function(InsertingNode value)? insertingNode,
    TResult? Function(InsertNodeToEdge value)? insertNodeToEdge,
    TResult? Function(ResizingNode value)? resizingNode,
    TResult? Function(HoveringNode value)? hoveringNode,
    TResult? Function(HoveringAnchor value)? hoveringAnchor,
    TResult? Function(HoveringEdge value)? hoveringEdge,
    TResult? Function(ContextMenuOpen value)? contextMenuOpen,
    TResult? Function(InsertingNodePreview value)? insertingNodePreview,
    TResult? Function(InsertingGroupPreview value)? insertingGroupPreview,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(Idle value)? idle,
    TResult Function(DragNode value)? dragNode,
    TResult Function(DragEdge value)? dragEdge,
    TResult Function(DragWaypoint value)? dragWaypoint,
    TResult Function(PanCanvas value)? panCanvas,
    TResult Function(SelectingArea value)? selectingArea,
    TResult Function(InsertingNode value)? insertingNode,
    TResult Function(InsertNodeToEdge value)? insertNodeToEdge,
    TResult Function(ResizingNode value)? resizingNode,
    TResult Function(HoveringNode value)? hoveringNode,
    TResult Function(HoveringAnchor value)? hoveringAnchor,
    TResult Function(HoveringEdge value)? hoveringEdge,
    TResult Function(ContextMenuOpen value)? contextMenuOpen,
    TResult Function(InsertingNodePreview value)? insertingNodePreview,
    TResult Function(InsertingGroupPreview value)? insertingGroupPreview,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $InteractionStateCopyWith<$Res> {
  factory $InteractionStateCopyWith(
          InteractionState value, $Res Function(InteractionState) then) =
      _$InteractionStateCopyWithImpl<$Res, InteractionState>;
}

/// @nodoc
class _$InteractionStateCopyWithImpl<$Res, $Val extends InteractionState>
    implements $InteractionStateCopyWith<$Res> {
  _$InteractionStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;
}

/// @nodoc
abstract class _$$IdleImplCopyWith<$Res> {
  factory _$$IdleImplCopyWith(
          _$IdleImpl value, $Res Function(_$IdleImpl) then) =
      __$$IdleImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$IdleImplCopyWithImpl<$Res>
    extends _$InteractionStateCopyWithImpl<$Res, _$IdleImpl>
    implements _$$IdleImplCopyWith<$Res> {
  __$$IdleImplCopyWithImpl(_$IdleImpl _value, $Res Function(_$IdleImpl) _then)
      : super(_value, _then);
}

/// @nodoc
@JsonSerializable()
class _$IdleImpl extends Idle {
  const _$IdleImpl({final String? $type})
      : $type = $type ?? 'idle',
        super._();

  factory _$IdleImpl.fromJson(Map<String, dynamic> json) =>
      _$$IdleImplFromJson(json);

  @JsonKey(name: 'type')
  final String $type;

  @override
  String toString() {
    return 'InteractionState.idle()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$IdleImpl);
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() idle,
    required TResult Function(
            String nodeId,
            @OffsetConverter() Offset startCanvas,
            @OffsetConverter() Offset lastCanvas)
        dragNode,
    required TResult Function(
            String edgeId,
            String sourceNodeId,
            String sourceAnchorId,
            @OffsetConverter() Offset startCanvas,
            @OffsetConverter() Offset lastCanvas)
        dragEdge,
    required TResult Function(
            String edgeId,
            int pointIndex,
            @OffsetConverter() Offset originalPoint,
            @OffsetConverter() Offset startCanvas,
            @OffsetConverter() Offset lastCanvas)
        dragWaypoint,
    required TResult Function(@OffsetConverter() Offset startGlobal,
            @OffsetConverter() Offset lastGlobal)
        panCanvas,
    required TResult Function(@RectConverter() Rect selectionBox) selectingArea,
    required TResult Function(
            String nodeType,
            @OffsetConverter() Offset startCanvas,
            @OffsetConverter() Offset lastCanvas)
        insertingNode,
    required TResult Function(
            String nodeType,
            String edgeId,
            @OffsetConverter() Offset startCanvas,
            @OffsetConverter() Offset lastCanvas)
        insertNodeToEdge,
    required TResult Function(
            String nodeId,
            @OffsetConverter() Offset handlePosition,
            @OffsetConverter() Offset startCanvas,
            @OffsetConverter() Offset lastCanvas)
        resizingNode,
    required TResult Function(String nodeId) hoveringNode,
    required TResult Function(String nodeId, String anchorId) hoveringAnchor,
    required TResult Function(String edgeId) hoveringEdge,
    required TResult Function(
            @OffsetConverter() Offset globalPosition, String? targetId)
        contextMenuOpen,
    required TResult Function(NodeModel node,
            @OffsetConverter() Offset canvasPos, String? highlightedEdgeId)
        insertingNodePreview,
    required TResult Function(CanvasInsertElement groupElement,
            @OffsetConverter() Offset canvasPos, String? highlightedEdgeId)
        insertingGroupPreview,
  }) {
    return idle();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? idle,
    TResult? Function(String nodeId, @OffsetConverter() Offset startCanvas,
            @OffsetConverter() Offset lastCanvas)?
        dragNode,
    TResult? Function(
            String edgeId,
            String sourceNodeId,
            String sourceAnchorId,
            @OffsetConverter() Offset startCanvas,
            @OffsetConverter() Offset lastCanvas)?
        dragEdge,
    TResult? Function(
            String edgeId,
            int pointIndex,
            @OffsetConverter() Offset originalPoint,
            @OffsetConverter() Offset startCanvas,
            @OffsetConverter() Offset lastCanvas)?
        dragWaypoint,
    TResult? Function(@OffsetConverter() Offset startGlobal,
            @OffsetConverter() Offset lastGlobal)?
        panCanvas,
    TResult? Function(@RectConverter() Rect selectionBox)? selectingArea,
    TResult? Function(String nodeType, @OffsetConverter() Offset startCanvas,
            @OffsetConverter() Offset lastCanvas)?
        insertingNode,
    TResult? Function(
            String nodeType,
            String edgeId,
            @OffsetConverter() Offset startCanvas,
            @OffsetConverter() Offset lastCanvas)?
        insertNodeToEdge,
    TResult? Function(
            String nodeId,
            @OffsetConverter() Offset handlePosition,
            @OffsetConverter() Offset startCanvas,
            @OffsetConverter() Offset lastCanvas)?
        resizingNode,
    TResult? Function(String nodeId)? hoveringNode,
    TResult? Function(String nodeId, String anchorId)? hoveringAnchor,
    TResult? Function(String edgeId)? hoveringEdge,
    TResult? Function(
            @OffsetConverter() Offset globalPosition, String? targetId)?
        contextMenuOpen,
    TResult? Function(NodeModel node, @OffsetConverter() Offset canvasPos,
            String? highlightedEdgeId)?
        insertingNodePreview,
    TResult? Function(CanvasInsertElement groupElement,
            @OffsetConverter() Offset canvasPos, String? highlightedEdgeId)?
        insertingGroupPreview,
  }) {
    return idle?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? idle,
    TResult Function(String nodeId, @OffsetConverter() Offset startCanvas,
            @OffsetConverter() Offset lastCanvas)?
        dragNode,
    TResult Function(
            String edgeId,
            String sourceNodeId,
            String sourceAnchorId,
            @OffsetConverter() Offset startCanvas,
            @OffsetConverter() Offset lastCanvas)?
        dragEdge,
    TResult Function(
            String edgeId,
            int pointIndex,
            @OffsetConverter() Offset originalPoint,
            @OffsetConverter() Offset startCanvas,
            @OffsetConverter() Offset lastCanvas)?
        dragWaypoint,
    TResult Function(@OffsetConverter() Offset startGlobal,
            @OffsetConverter() Offset lastGlobal)?
        panCanvas,
    TResult Function(@RectConverter() Rect selectionBox)? selectingArea,
    TResult Function(String nodeType, @OffsetConverter() Offset startCanvas,
            @OffsetConverter() Offset lastCanvas)?
        insertingNode,
    TResult Function(
            String nodeType,
            String edgeId,
            @OffsetConverter() Offset startCanvas,
            @OffsetConverter() Offset lastCanvas)?
        insertNodeToEdge,
    TResult Function(
            String nodeId,
            @OffsetConverter() Offset handlePosition,
            @OffsetConverter() Offset startCanvas,
            @OffsetConverter() Offset lastCanvas)?
        resizingNode,
    TResult Function(String nodeId)? hoveringNode,
    TResult Function(String nodeId, String anchorId)? hoveringAnchor,
    TResult Function(String edgeId)? hoveringEdge,
    TResult Function(
            @OffsetConverter() Offset globalPosition, String? targetId)?
        contextMenuOpen,
    TResult Function(NodeModel node, @OffsetConverter() Offset canvasPos,
            String? highlightedEdgeId)?
        insertingNodePreview,
    TResult Function(CanvasInsertElement groupElement,
            @OffsetConverter() Offset canvasPos, String? highlightedEdgeId)?
        insertingGroupPreview,
    required TResult orElse(),
  }) {
    if (idle != null) {
      return idle();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(Idle value) idle,
    required TResult Function(DragNode value) dragNode,
    required TResult Function(DragEdge value) dragEdge,
    required TResult Function(DragWaypoint value) dragWaypoint,
    required TResult Function(PanCanvas value) panCanvas,
    required TResult Function(SelectingArea value) selectingArea,
    required TResult Function(InsertingNode value) insertingNode,
    required TResult Function(InsertNodeToEdge value) insertNodeToEdge,
    required TResult Function(ResizingNode value) resizingNode,
    required TResult Function(HoveringNode value) hoveringNode,
    required TResult Function(HoveringAnchor value) hoveringAnchor,
    required TResult Function(HoveringEdge value) hoveringEdge,
    required TResult Function(ContextMenuOpen value) contextMenuOpen,
    required TResult Function(InsertingNodePreview value) insertingNodePreview,
    required TResult Function(InsertingGroupPreview value)
        insertingGroupPreview,
  }) {
    return idle(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(Idle value)? idle,
    TResult? Function(DragNode value)? dragNode,
    TResult? Function(DragEdge value)? dragEdge,
    TResult? Function(DragWaypoint value)? dragWaypoint,
    TResult? Function(PanCanvas value)? panCanvas,
    TResult? Function(SelectingArea value)? selectingArea,
    TResult? Function(InsertingNode value)? insertingNode,
    TResult? Function(InsertNodeToEdge value)? insertNodeToEdge,
    TResult? Function(ResizingNode value)? resizingNode,
    TResult? Function(HoveringNode value)? hoveringNode,
    TResult? Function(HoveringAnchor value)? hoveringAnchor,
    TResult? Function(HoveringEdge value)? hoveringEdge,
    TResult? Function(ContextMenuOpen value)? contextMenuOpen,
    TResult? Function(InsertingNodePreview value)? insertingNodePreview,
    TResult? Function(InsertingGroupPreview value)? insertingGroupPreview,
  }) {
    return idle?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(Idle value)? idle,
    TResult Function(DragNode value)? dragNode,
    TResult Function(DragEdge value)? dragEdge,
    TResult Function(DragWaypoint value)? dragWaypoint,
    TResult Function(PanCanvas value)? panCanvas,
    TResult Function(SelectingArea value)? selectingArea,
    TResult Function(InsertingNode value)? insertingNode,
    TResult Function(InsertNodeToEdge value)? insertNodeToEdge,
    TResult Function(ResizingNode value)? resizingNode,
    TResult Function(HoveringNode value)? hoveringNode,
    TResult Function(HoveringAnchor value)? hoveringAnchor,
    TResult Function(HoveringEdge value)? hoveringEdge,
    TResult Function(ContextMenuOpen value)? contextMenuOpen,
    TResult Function(InsertingNodePreview value)? insertingNodePreview,
    TResult Function(InsertingGroupPreview value)? insertingGroupPreview,
    required TResult orElse(),
  }) {
    if (idle != null) {
      return idle(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$IdleImplToJson(
      this,
    );
  }
}

abstract class Idle extends InteractionState {
  const factory Idle() = _$IdleImpl;
  const Idle._() : super._();

  factory Idle.fromJson(Map<String, dynamic> json) = _$IdleImpl.fromJson;
}

/// @nodoc
abstract class _$$DragNodeImplCopyWith<$Res> {
  factory _$$DragNodeImplCopyWith(
          _$DragNodeImpl value, $Res Function(_$DragNodeImpl) then) =
      __$$DragNodeImplCopyWithImpl<$Res>;
  @useResult
  $Res call(
      {String nodeId,
      @OffsetConverter() Offset startCanvas,
      @OffsetConverter() Offset lastCanvas});
}

/// @nodoc
class __$$DragNodeImplCopyWithImpl<$Res>
    extends _$InteractionStateCopyWithImpl<$Res, _$DragNodeImpl>
    implements _$$DragNodeImplCopyWith<$Res> {
  __$$DragNodeImplCopyWithImpl(
      _$DragNodeImpl _value, $Res Function(_$DragNodeImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? nodeId = null,
    Object? startCanvas = null,
    Object? lastCanvas = null,
  }) {
    return _then(_$DragNodeImpl(
      nodeId: null == nodeId
          ? _value.nodeId
          : nodeId // ignore: cast_nullable_to_non_nullable
              as String,
      startCanvas: null == startCanvas
          ? _value.startCanvas
          : startCanvas // ignore: cast_nullable_to_non_nullable
              as Offset,
      lastCanvas: null == lastCanvas
          ? _value.lastCanvas
          : lastCanvas // ignore: cast_nullable_to_non_nullable
              as Offset,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$DragNodeImpl extends DragNode {
  const _$DragNodeImpl(
      {required this.nodeId,
      @OffsetConverter() required this.startCanvas,
      @OffsetConverter() required this.lastCanvas,
      final String? $type})
      : $type = $type ?? 'drag_node',
        super._();

  factory _$DragNodeImpl.fromJson(Map<String, dynamic> json) =>
      _$$DragNodeImplFromJson(json);

  @override
  final String nodeId;
  @override
  @OffsetConverter()
  final Offset startCanvas;
  @override
  @OffsetConverter()
  final Offset lastCanvas;

  @JsonKey(name: 'type')
  final String $type;

  @override
  String toString() {
    return 'InteractionState.dragNode(nodeId: $nodeId, startCanvas: $startCanvas, lastCanvas: $lastCanvas)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DragNodeImpl &&
            (identical(other.nodeId, nodeId) || other.nodeId == nodeId) &&
            (identical(other.startCanvas, startCanvas) ||
                other.startCanvas == startCanvas) &&
            (identical(other.lastCanvas, lastCanvas) ||
                other.lastCanvas == lastCanvas));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, nodeId, startCanvas, lastCanvas);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$DragNodeImplCopyWith<_$DragNodeImpl> get copyWith =>
      __$$DragNodeImplCopyWithImpl<_$DragNodeImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() idle,
    required TResult Function(
            String nodeId,
            @OffsetConverter() Offset startCanvas,
            @OffsetConverter() Offset lastCanvas)
        dragNode,
    required TResult Function(
            String edgeId,
            String sourceNodeId,
            String sourceAnchorId,
            @OffsetConverter() Offset startCanvas,
            @OffsetConverter() Offset lastCanvas)
        dragEdge,
    required TResult Function(
            String edgeId,
            int pointIndex,
            @OffsetConverter() Offset originalPoint,
            @OffsetConverter() Offset startCanvas,
            @OffsetConverter() Offset lastCanvas)
        dragWaypoint,
    required TResult Function(@OffsetConverter() Offset startGlobal,
            @OffsetConverter() Offset lastGlobal)
        panCanvas,
    required TResult Function(@RectConverter() Rect selectionBox) selectingArea,
    required TResult Function(
            String nodeType,
            @OffsetConverter() Offset startCanvas,
            @OffsetConverter() Offset lastCanvas)
        insertingNode,
    required TResult Function(
            String nodeType,
            String edgeId,
            @OffsetConverter() Offset startCanvas,
            @OffsetConverter() Offset lastCanvas)
        insertNodeToEdge,
    required TResult Function(
            String nodeId,
            @OffsetConverter() Offset handlePosition,
            @OffsetConverter() Offset startCanvas,
            @OffsetConverter() Offset lastCanvas)
        resizingNode,
    required TResult Function(String nodeId) hoveringNode,
    required TResult Function(String nodeId, String anchorId) hoveringAnchor,
    required TResult Function(String edgeId) hoveringEdge,
    required TResult Function(
            @OffsetConverter() Offset globalPosition, String? targetId)
        contextMenuOpen,
    required TResult Function(NodeModel node,
            @OffsetConverter() Offset canvasPos, String? highlightedEdgeId)
        insertingNodePreview,
    required TResult Function(CanvasInsertElement groupElement,
            @OffsetConverter() Offset canvasPos, String? highlightedEdgeId)
        insertingGroupPreview,
  }) {
    return dragNode(nodeId, startCanvas, lastCanvas);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? idle,
    TResult? Function(String nodeId, @OffsetConverter() Offset startCanvas,
            @OffsetConverter() Offset lastCanvas)?
        dragNode,
    TResult? Function(
            String edgeId,
            String sourceNodeId,
            String sourceAnchorId,
            @OffsetConverter() Offset startCanvas,
            @OffsetConverter() Offset lastCanvas)?
        dragEdge,
    TResult? Function(
            String edgeId,
            int pointIndex,
            @OffsetConverter() Offset originalPoint,
            @OffsetConverter() Offset startCanvas,
            @OffsetConverter() Offset lastCanvas)?
        dragWaypoint,
    TResult? Function(@OffsetConverter() Offset startGlobal,
            @OffsetConverter() Offset lastGlobal)?
        panCanvas,
    TResult? Function(@RectConverter() Rect selectionBox)? selectingArea,
    TResult? Function(String nodeType, @OffsetConverter() Offset startCanvas,
            @OffsetConverter() Offset lastCanvas)?
        insertingNode,
    TResult? Function(
            String nodeType,
            String edgeId,
            @OffsetConverter() Offset startCanvas,
            @OffsetConverter() Offset lastCanvas)?
        insertNodeToEdge,
    TResult? Function(
            String nodeId,
            @OffsetConverter() Offset handlePosition,
            @OffsetConverter() Offset startCanvas,
            @OffsetConverter() Offset lastCanvas)?
        resizingNode,
    TResult? Function(String nodeId)? hoveringNode,
    TResult? Function(String nodeId, String anchorId)? hoveringAnchor,
    TResult? Function(String edgeId)? hoveringEdge,
    TResult? Function(
            @OffsetConverter() Offset globalPosition, String? targetId)?
        contextMenuOpen,
    TResult? Function(NodeModel node, @OffsetConverter() Offset canvasPos,
            String? highlightedEdgeId)?
        insertingNodePreview,
    TResult? Function(CanvasInsertElement groupElement,
            @OffsetConverter() Offset canvasPos, String? highlightedEdgeId)?
        insertingGroupPreview,
  }) {
    return dragNode?.call(nodeId, startCanvas, lastCanvas);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? idle,
    TResult Function(String nodeId, @OffsetConverter() Offset startCanvas,
            @OffsetConverter() Offset lastCanvas)?
        dragNode,
    TResult Function(
            String edgeId,
            String sourceNodeId,
            String sourceAnchorId,
            @OffsetConverter() Offset startCanvas,
            @OffsetConverter() Offset lastCanvas)?
        dragEdge,
    TResult Function(
            String edgeId,
            int pointIndex,
            @OffsetConverter() Offset originalPoint,
            @OffsetConverter() Offset startCanvas,
            @OffsetConverter() Offset lastCanvas)?
        dragWaypoint,
    TResult Function(@OffsetConverter() Offset startGlobal,
            @OffsetConverter() Offset lastGlobal)?
        panCanvas,
    TResult Function(@RectConverter() Rect selectionBox)? selectingArea,
    TResult Function(String nodeType, @OffsetConverter() Offset startCanvas,
            @OffsetConverter() Offset lastCanvas)?
        insertingNode,
    TResult Function(
            String nodeType,
            String edgeId,
            @OffsetConverter() Offset startCanvas,
            @OffsetConverter() Offset lastCanvas)?
        insertNodeToEdge,
    TResult Function(
            String nodeId,
            @OffsetConverter() Offset handlePosition,
            @OffsetConverter() Offset startCanvas,
            @OffsetConverter() Offset lastCanvas)?
        resizingNode,
    TResult Function(String nodeId)? hoveringNode,
    TResult Function(String nodeId, String anchorId)? hoveringAnchor,
    TResult Function(String edgeId)? hoveringEdge,
    TResult Function(
            @OffsetConverter() Offset globalPosition, String? targetId)?
        contextMenuOpen,
    TResult Function(NodeModel node, @OffsetConverter() Offset canvasPos,
            String? highlightedEdgeId)?
        insertingNodePreview,
    TResult Function(CanvasInsertElement groupElement,
            @OffsetConverter() Offset canvasPos, String? highlightedEdgeId)?
        insertingGroupPreview,
    required TResult orElse(),
  }) {
    if (dragNode != null) {
      return dragNode(nodeId, startCanvas, lastCanvas);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(Idle value) idle,
    required TResult Function(DragNode value) dragNode,
    required TResult Function(DragEdge value) dragEdge,
    required TResult Function(DragWaypoint value) dragWaypoint,
    required TResult Function(PanCanvas value) panCanvas,
    required TResult Function(SelectingArea value) selectingArea,
    required TResult Function(InsertingNode value) insertingNode,
    required TResult Function(InsertNodeToEdge value) insertNodeToEdge,
    required TResult Function(ResizingNode value) resizingNode,
    required TResult Function(HoveringNode value) hoveringNode,
    required TResult Function(HoveringAnchor value) hoveringAnchor,
    required TResult Function(HoveringEdge value) hoveringEdge,
    required TResult Function(ContextMenuOpen value) contextMenuOpen,
    required TResult Function(InsertingNodePreview value) insertingNodePreview,
    required TResult Function(InsertingGroupPreview value)
        insertingGroupPreview,
  }) {
    return dragNode(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(Idle value)? idle,
    TResult? Function(DragNode value)? dragNode,
    TResult? Function(DragEdge value)? dragEdge,
    TResult? Function(DragWaypoint value)? dragWaypoint,
    TResult? Function(PanCanvas value)? panCanvas,
    TResult? Function(SelectingArea value)? selectingArea,
    TResult? Function(InsertingNode value)? insertingNode,
    TResult? Function(InsertNodeToEdge value)? insertNodeToEdge,
    TResult? Function(ResizingNode value)? resizingNode,
    TResult? Function(HoveringNode value)? hoveringNode,
    TResult? Function(HoveringAnchor value)? hoveringAnchor,
    TResult? Function(HoveringEdge value)? hoveringEdge,
    TResult? Function(ContextMenuOpen value)? contextMenuOpen,
    TResult? Function(InsertingNodePreview value)? insertingNodePreview,
    TResult? Function(InsertingGroupPreview value)? insertingGroupPreview,
  }) {
    return dragNode?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(Idle value)? idle,
    TResult Function(DragNode value)? dragNode,
    TResult Function(DragEdge value)? dragEdge,
    TResult Function(DragWaypoint value)? dragWaypoint,
    TResult Function(PanCanvas value)? panCanvas,
    TResult Function(SelectingArea value)? selectingArea,
    TResult Function(InsertingNode value)? insertingNode,
    TResult Function(InsertNodeToEdge value)? insertNodeToEdge,
    TResult Function(ResizingNode value)? resizingNode,
    TResult Function(HoveringNode value)? hoveringNode,
    TResult Function(HoveringAnchor value)? hoveringAnchor,
    TResult Function(HoveringEdge value)? hoveringEdge,
    TResult Function(ContextMenuOpen value)? contextMenuOpen,
    TResult Function(InsertingNodePreview value)? insertingNodePreview,
    TResult Function(InsertingGroupPreview value)? insertingGroupPreview,
    required TResult orElse(),
  }) {
    if (dragNode != null) {
      return dragNode(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$DragNodeImplToJson(
      this,
    );
  }
}

abstract class DragNode extends InteractionState {
  const factory DragNode(
      {required final String nodeId,
      @OffsetConverter() required final Offset startCanvas,
      @OffsetConverter() required final Offset lastCanvas}) = _$DragNodeImpl;
  const DragNode._() : super._();

  factory DragNode.fromJson(Map<String, dynamic> json) =
      _$DragNodeImpl.fromJson;

  String get nodeId;
  @OffsetConverter()
  Offset get startCanvas;
  @OffsetConverter()
  Offset get lastCanvas;
  @JsonKey(ignore: true)
  _$$DragNodeImplCopyWith<_$DragNodeImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$DragEdgeImplCopyWith<$Res> {
  factory _$$DragEdgeImplCopyWith(
          _$DragEdgeImpl value, $Res Function(_$DragEdgeImpl) then) =
      __$$DragEdgeImplCopyWithImpl<$Res>;
  @useResult
  $Res call(
      {String edgeId,
      String sourceNodeId,
      String sourceAnchorId,
      @OffsetConverter() Offset startCanvas,
      @OffsetConverter() Offset lastCanvas});
}

/// @nodoc
class __$$DragEdgeImplCopyWithImpl<$Res>
    extends _$InteractionStateCopyWithImpl<$Res, _$DragEdgeImpl>
    implements _$$DragEdgeImplCopyWith<$Res> {
  __$$DragEdgeImplCopyWithImpl(
      _$DragEdgeImpl _value, $Res Function(_$DragEdgeImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? edgeId = null,
    Object? sourceNodeId = null,
    Object? sourceAnchorId = null,
    Object? startCanvas = null,
    Object? lastCanvas = null,
  }) {
    return _then(_$DragEdgeImpl(
      edgeId: null == edgeId
          ? _value.edgeId
          : edgeId // ignore: cast_nullable_to_non_nullable
              as String,
      sourceNodeId: null == sourceNodeId
          ? _value.sourceNodeId
          : sourceNodeId // ignore: cast_nullable_to_non_nullable
              as String,
      sourceAnchorId: null == sourceAnchorId
          ? _value.sourceAnchorId
          : sourceAnchorId // ignore: cast_nullable_to_non_nullable
              as String,
      startCanvas: null == startCanvas
          ? _value.startCanvas
          : startCanvas // ignore: cast_nullable_to_non_nullable
              as Offset,
      lastCanvas: null == lastCanvas
          ? _value.lastCanvas
          : lastCanvas // ignore: cast_nullable_to_non_nullable
              as Offset,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$DragEdgeImpl extends DragEdge {
  const _$DragEdgeImpl(
      {required this.edgeId,
      required this.sourceNodeId,
      required this.sourceAnchorId,
      @OffsetConverter() required this.startCanvas,
      @OffsetConverter() required this.lastCanvas,
      final String? $type})
      : $type = $type ?? 'drag_edge',
        super._();

  factory _$DragEdgeImpl.fromJson(Map<String, dynamic> json) =>
      _$$DragEdgeImplFromJson(json);

  @override
  final String edgeId;
  @override
  final String sourceNodeId;
  @override
  final String sourceAnchorId;
  @override
  @OffsetConverter()
  final Offset startCanvas;
  @override
  @OffsetConverter()
  final Offset lastCanvas;

  @JsonKey(name: 'type')
  final String $type;

  @override
  String toString() {
    return 'InteractionState.dragEdge(edgeId: $edgeId, sourceNodeId: $sourceNodeId, sourceAnchorId: $sourceAnchorId, startCanvas: $startCanvas, lastCanvas: $lastCanvas)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DragEdgeImpl &&
            (identical(other.edgeId, edgeId) || other.edgeId == edgeId) &&
            (identical(other.sourceNodeId, sourceNodeId) ||
                other.sourceNodeId == sourceNodeId) &&
            (identical(other.sourceAnchorId, sourceAnchorId) ||
                other.sourceAnchorId == sourceAnchorId) &&
            (identical(other.startCanvas, startCanvas) ||
                other.startCanvas == startCanvas) &&
            (identical(other.lastCanvas, lastCanvas) ||
                other.lastCanvas == lastCanvas));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, edgeId, sourceNodeId,
      sourceAnchorId, startCanvas, lastCanvas);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$DragEdgeImplCopyWith<_$DragEdgeImpl> get copyWith =>
      __$$DragEdgeImplCopyWithImpl<_$DragEdgeImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() idle,
    required TResult Function(
            String nodeId,
            @OffsetConverter() Offset startCanvas,
            @OffsetConverter() Offset lastCanvas)
        dragNode,
    required TResult Function(
            String edgeId,
            String sourceNodeId,
            String sourceAnchorId,
            @OffsetConverter() Offset startCanvas,
            @OffsetConverter() Offset lastCanvas)
        dragEdge,
    required TResult Function(
            String edgeId,
            int pointIndex,
            @OffsetConverter() Offset originalPoint,
            @OffsetConverter() Offset startCanvas,
            @OffsetConverter() Offset lastCanvas)
        dragWaypoint,
    required TResult Function(@OffsetConverter() Offset startGlobal,
            @OffsetConverter() Offset lastGlobal)
        panCanvas,
    required TResult Function(@RectConverter() Rect selectionBox) selectingArea,
    required TResult Function(
            String nodeType,
            @OffsetConverter() Offset startCanvas,
            @OffsetConverter() Offset lastCanvas)
        insertingNode,
    required TResult Function(
            String nodeType,
            String edgeId,
            @OffsetConverter() Offset startCanvas,
            @OffsetConverter() Offset lastCanvas)
        insertNodeToEdge,
    required TResult Function(
            String nodeId,
            @OffsetConverter() Offset handlePosition,
            @OffsetConverter() Offset startCanvas,
            @OffsetConverter() Offset lastCanvas)
        resizingNode,
    required TResult Function(String nodeId) hoveringNode,
    required TResult Function(String nodeId, String anchorId) hoveringAnchor,
    required TResult Function(String edgeId) hoveringEdge,
    required TResult Function(
            @OffsetConverter() Offset globalPosition, String? targetId)
        contextMenuOpen,
    required TResult Function(NodeModel node,
            @OffsetConverter() Offset canvasPos, String? highlightedEdgeId)
        insertingNodePreview,
    required TResult Function(CanvasInsertElement groupElement,
            @OffsetConverter() Offset canvasPos, String? highlightedEdgeId)
        insertingGroupPreview,
  }) {
    return dragEdge(
        edgeId, sourceNodeId, sourceAnchorId, startCanvas, lastCanvas);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? idle,
    TResult? Function(String nodeId, @OffsetConverter() Offset startCanvas,
            @OffsetConverter() Offset lastCanvas)?
        dragNode,
    TResult? Function(
            String edgeId,
            String sourceNodeId,
            String sourceAnchorId,
            @OffsetConverter() Offset startCanvas,
            @OffsetConverter() Offset lastCanvas)?
        dragEdge,
    TResult? Function(
            String edgeId,
            int pointIndex,
            @OffsetConverter() Offset originalPoint,
            @OffsetConverter() Offset startCanvas,
            @OffsetConverter() Offset lastCanvas)?
        dragWaypoint,
    TResult? Function(@OffsetConverter() Offset startGlobal,
            @OffsetConverter() Offset lastGlobal)?
        panCanvas,
    TResult? Function(@RectConverter() Rect selectionBox)? selectingArea,
    TResult? Function(String nodeType, @OffsetConverter() Offset startCanvas,
            @OffsetConverter() Offset lastCanvas)?
        insertingNode,
    TResult? Function(
            String nodeType,
            String edgeId,
            @OffsetConverter() Offset startCanvas,
            @OffsetConverter() Offset lastCanvas)?
        insertNodeToEdge,
    TResult? Function(
            String nodeId,
            @OffsetConverter() Offset handlePosition,
            @OffsetConverter() Offset startCanvas,
            @OffsetConverter() Offset lastCanvas)?
        resizingNode,
    TResult? Function(String nodeId)? hoveringNode,
    TResult? Function(String nodeId, String anchorId)? hoveringAnchor,
    TResult? Function(String edgeId)? hoveringEdge,
    TResult? Function(
            @OffsetConverter() Offset globalPosition, String? targetId)?
        contextMenuOpen,
    TResult? Function(NodeModel node, @OffsetConverter() Offset canvasPos,
            String? highlightedEdgeId)?
        insertingNodePreview,
    TResult? Function(CanvasInsertElement groupElement,
            @OffsetConverter() Offset canvasPos, String? highlightedEdgeId)?
        insertingGroupPreview,
  }) {
    return dragEdge?.call(
        edgeId, sourceNodeId, sourceAnchorId, startCanvas, lastCanvas);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? idle,
    TResult Function(String nodeId, @OffsetConverter() Offset startCanvas,
            @OffsetConverter() Offset lastCanvas)?
        dragNode,
    TResult Function(
            String edgeId,
            String sourceNodeId,
            String sourceAnchorId,
            @OffsetConverter() Offset startCanvas,
            @OffsetConverter() Offset lastCanvas)?
        dragEdge,
    TResult Function(
            String edgeId,
            int pointIndex,
            @OffsetConverter() Offset originalPoint,
            @OffsetConverter() Offset startCanvas,
            @OffsetConverter() Offset lastCanvas)?
        dragWaypoint,
    TResult Function(@OffsetConverter() Offset startGlobal,
            @OffsetConverter() Offset lastGlobal)?
        panCanvas,
    TResult Function(@RectConverter() Rect selectionBox)? selectingArea,
    TResult Function(String nodeType, @OffsetConverter() Offset startCanvas,
            @OffsetConverter() Offset lastCanvas)?
        insertingNode,
    TResult Function(
            String nodeType,
            String edgeId,
            @OffsetConverter() Offset startCanvas,
            @OffsetConverter() Offset lastCanvas)?
        insertNodeToEdge,
    TResult Function(
            String nodeId,
            @OffsetConverter() Offset handlePosition,
            @OffsetConverter() Offset startCanvas,
            @OffsetConverter() Offset lastCanvas)?
        resizingNode,
    TResult Function(String nodeId)? hoveringNode,
    TResult Function(String nodeId, String anchorId)? hoveringAnchor,
    TResult Function(String edgeId)? hoveringEdge,
    TResult Function(
            @OffsetConverter() Offset globalPosition, String? targetId)?
        contextMenuOpen,
    TResult Function(NodeModel node, @OffsetConverter() Offset canvasPos,
            String? highlightedEdgeId)?
        insertingNodePreview,
    TResult Function(CanvasInsertElement groupElement,
            @OffsetConverter() Offset canvasPos, String? highlightedEdgeId)?
        insertingGroupPreview,
    required TResult orElse(),
  }) {
    if (dragEdge != null) {
      return dragEdge(
          edgeId, sourceNodeId, sourceAnchorId, startCanvas, lastCanvas);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(Idle value) idle,
    required TResult Function(DragNode value) dragNode,
    required TResult Function(DragEdge value) dragEdge,
    required TResult Function(DragWaypoint value) dragWaypoint,
    required TResult Function(PanCanvas value) panCanvas,
    required TResult Function(SelectingArea value) selectingArea,
    required TResult Function(InsertingNode value) insertingNode,
    required TResult Function(InsertNodeToEdge value) insertNodeToEdge,
    required TResult Function(ResizingNode value) resizingNode,
    required TResult Function(HoveringNode value) hoveringNode,
    required TResult Function(HoveringAnchor value) hoveringAnchor,
    required TResult Function(HoveringEdge value) hoveringEdge,
    required TResult Function(ContextMenuOpen value) contextMenuOpen,
    required TResult Function(InsertingNodePreview value) insertingNodePreview,
    required TResult Function(InsertingGroupPreview value)
        insertingGroupPreview,
  }) {
    return dragEdge(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(Idle value)? idle,
    TResult? Function(DragNode value)? dragNode,
    TResult? Function(DragEdge value)? dragEdge,
    TResult? Function(DragWaypoint value)? dragWaypoint,
    TResult? Function(PanCanvas value)? panCanvas,
    TResult? Function(SelectingArea value)? selectingArea,
    TResult? Function(InsertingNode value)? insertingNode,
    TResult? Function(InsertNodeToEdge value)? insertNodeToEdge,
    TResult? Function(ResizingNode value)? resizingNode,
    TResult? Function(HoveringNode value)? hoveringNode,
    TResult? Function(HoveringAnchor value)? hoveringAnchor,
    TResult? Function(HoveringEdge value)? hoveringEdge,
    TResult? Function(ContextMenuOpen value)? contextMenuOpen,
    TResult? Function(InsertingNodePreview value)? insertingNodePreview,
    TResult? Function(InsertingGroupPreview value)? insertingGroupPreview,
  }) {
    return dragEdge?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(Idle value)? idle,
    TResult Function(DragNode value)? dragNode,
    TResult Function(DragEdge value)? dragEdge,
    TResult Function(DragWaypoint value)? dragWaypoint,
    TResult Function(PanCanvas value)? panCanvas,
    TResult Function(SelectingArea value)? selectingArea,
    TResult Function(InsertingNode value)? insertingNode,
    TResult Function(InsertNodeToEdge value)? insertNodeToEdge,
    TResult Function(ResizingNode value)? resizingNode,
    TResult Function(HoveringNode value)? hoveringNode,
    TResult Function(HoveringAnchor value)? hoveringAnchor,
    TResult Function(HoveringEdge value)? hoveringEdge,
    TResult Function(ContextMenuOpen value)? contextMenuOpen,
    TResult Function(InsertingNodePreview value)? insertingNodePreview,
    TResult Function(InsertingGroupPreview value)? insertingGroupPreview,
    required TResult orElse(),
  }) {
    if (dragEdge != null) {
      return dragEdge(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$DragEdgeImplToJson(
      this,
    );
  }
}

abstract class DragEdge extends InteractionState {
  const factory DragEdge(
      {required final String edgeId,
      required final String sourceNodeId,
      required final String sourceAnchorId,
      @OffsetConverter() required final Offset startCanvas,
      @OffsetConverter() required final Offset lastCanvas}) = _$DragEdgeImpl;
  const DragEdge._() : super._();

  factory DragEdge.fromJson(Map<String, dynamic> json) =
      _$DragEdgeImpl.fromJson;

  String get edgeId;
  String get sourceNodeId;
  String get sourceAnchorId;
  @OffsetConverter()
  Offset get startCanvas;
  @OffsetConverter()
  Offset get lastCanvas;
  @JsonKey(ignore: true)
  _$$DragEdgeImplCopyWith<_$DragEdgeImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$DragWaypointImplCopyWith<$Res> {
  factory _$$DragWaypointImplCopyWith(
          _$DragWaypointImpl value, $Res Function(_$DragWaypointImpl) then) =
      __$$DragWaypointImplCopyWithImpl<$Res>;
  @useResult
  $Res call(
      {String edgeId,
      int pointIndex,
      @OffsetConverter() Offset originalPoint,
      @OffsetConverter() Offset startCanvas,
      @OffsetConverter() Offset lastCanvas});
}

/// @nodoc
class __$$DragWaypointImplCopyWithImpl<$Res>
    extends _$InteractionStateCopyWithImpl<$Res, _$DragWaypointImpl>
    implements _$$DragWaypointImplCopyWith<$Res> {
  __$$DragWaypointImplCopyWithImpl(
      _$DragWaypointImpl _value, $Res Function(_$DragWaypointImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? edgeId = null,
    Object? pointIndex = null,
    Object? originalPoint = null,
    Object? startCanvas = null,
    Object? lastCanvas = null,
  }) {
    return _then(_$DragWaypointImpl(
      edgeId: null == edgeId
          ? _value.edgeId
          : edgeId // ignore: cast_nullable_to_non_nullable
              as String,
      pointIndex: null == pointIndex
          ? _value.pointIndex
          : pointIndex // ignore: cast_nullable_to_non_nullable
              as int,
      originalPoint: null == originalPoint
          ? _value.originalPoint
          : originalPoint // ignore: cast_nullable_to_non_nullable
              as Offset,
      startCanvas: null == startCanvas
          ? _value.startCanvas
          : startCanvas // ignore: cast_nullable_to_non_nullable
              as Offset,
      lastCanvas: null == lastCanvas
          ? _value.lastCanvas
          : lastCanvas // ignore: cast_nullable_to_non_nullable
              as Offset,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$DragWaypointImpl extends DragWaypoint {
  const _$DragWaypointImpl(
      {required this.edgeId,
      required this.pointIndex,
      @OffsetConverter() required this.originalPoint,
      @OffsetConverter() required this.startCanvas,
      @OffsetConverter() required this.lastCanvas,
      final String? $type})
      : $type = $type ?? 'drag_waypoint',
        super._();

  factory _$DragWaypointImpl.fromJson(Map<String, dynamic> json) =>
      _$$DragWaypointImplFromJson(json);

  @override
  final String edgeId;
  @override
  final int pointIndex;
  @override
  @OffsetConverter()
  final Offset originalPoint;
  @override
  @OffsetConverter()
  final Offset startCanvas;
  @override
  @OffsetConverter()
  final Offset lastCanvas;

  @JsonKey(name: 'type')
  final String $type;

  @override
  String toString() {
    return 'InteractionState.dragWaypoint(edgeId: $edgeId, pointIndex: $pointIndex, originalPoint: $originalPoint, startCanvas: $startCanvas, lastCanvas: $lastCanvas)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DragWaypointImpl &&
            (identical(other.edgeId, edgeId) || other.edgeId == edgeId) &&
            (identical(other.pointIndex, pointIndex) ||
                other.pointIndex == pointIndex) &&
            (identical(other.originalPoint, originalPoint) ||
                other.originalPoint == originalPoint) &&
            (identical(other.startCanvas, startCanvas) ||
                other.startCanvas == startCanvas) &&
            (identical(other.lastCanvas, lastCanvas) ||
                other.lastCanvas == lastCanvas));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType, edgeId, pointIndex, originalPoint, startCanvas, lastCanvas);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$DragWaypointImplCopyWith<_$DragWaypointImpl> get copyWith =>
      __$$DragWaypointImplCopyWithImpl<_$DragWaypointImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() idle,
    required TResult Function(
            String nodeId,
            @OffsetConverter() Offset startCanvas,
            @OffsetConverter() Offset lastCanvas)
        dragNode,
    required TResult Function(
            String edgeId,
            String sourceNodeId,
            String sourceAnchorId,
            @OffsetConverter() Offset startCanvas,
            @OffsetConverter() Offset lastCanvas)
        dragEdge,
    required TResult Function(
            String edgeId,
            int pointIndex,
            @OffsetConverter() Offset originalPoint,
            @OffsetConverter() Offset startCanvas,
            @OffsetConverter() Offset lastCanvas)
        dragWaypoint,
    required TResult Function(@OffsetConverter() Offset startGlobal,
            @OffsetConverter() Offset lastGlobal)
        panCanvas,
    required TResult Function(@RectConverter() Rect selectionBox) selectingArea,
    required TResult Function(
            String nodeType,
            @OffsetConverter() Offset startCanvas,
            @OffsetConverter() Offset lastCanvas)
        insertingNode,
    required TResult Function(
            String nodeType,
            String edgeId,
            @OffsetConverter() Offset startCanvas,
            @OffsetConverter() Offset lastCanvas)
        insertNodeToEdge,
    required TResult Function(
            String nodeId,
            @OffsetConverter() Offset handlePosition,
            @OffsetConverter() Offset startCanvas,
            @OffsetConverter() Offset lastCanvas)
        resizingNode,
    required TResult Function(String nodeId) hoveringNode,
    required TResult Function(String nodeId, String anchorId) hoveringAnchor,
    required TResult Function(String edgeId) hoveringEdge,
    required TResult Function(
            @OffsetConverter() Offset globalPosition, String? targetId)
        contextMenuOpen,
    required TResult Function(NodeModel node,
            @OffsetConverter() Offset canvasPos, String? highlightedEdgeId)
        insertingNodePreview,
    required TResult Function(CanvasInsertElement groupElement,
            @OffsetConverter() Offset canvasPos, String? highlightedEdgeId)
        insertingGroupPreview,
  }) {
    return dragWaypoint(
        edgeId, pointIndex, originalPoint, startCanvas, lastCanvas);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? idle,
    TResult? Function(String nodeId, @OffsetConverter() Offset startCanvas,
            @OffsetConverter() Offset lastCanvas)?
        dragNode,
    TResult? Function(
            String edgeId,
            String sourceNodeId,
            String sourceAnchorId,
            @OffsetConverter() Offset startCanvas,
            @OffsetConverter() Offset lastCanvas)?
        dragEdge,
    TResult? Function(
            String edgeId,
            int pointIndex,
            @OffsetConverter() Offset originalPoint,
            @OffsetConverter() Offset startCanvas,
            @OffsetConverter() Offset lastCanvas)?
        dragWaypoint,
    TResult? Function(@OffsetConverter() Offset startGlobal,
            @OffsetConverter() Offset lastGlobal)?
        panCanvas,
    TResult? Function(@RectConverter() Rect selectionBox)? selectingArea,
    TResult? Function(String nodeType, @OffsetConverter() Offset startCanvas,
            @OffsetConverter() Offset lastCanvas)?
        insertingNode,
    TResult? Function(
            String nodeType,
            String edgeId,
            @OffsetConverter() Offset startCanvas,
            @OffsetConverter() Offset lastCanvas)?
        insertNodeToEdge,
    TResult? Function(
            String nodeId,
            @OffsetConverter() Offset handlePosition,
            @OffsetConverter() Offset startCanvas,
            @OffsetConverter() Offset lastCanvas)?
        resizingNode,
    TResult? Function(String nodeId)? hoveringNode,
    TResult? Function(String nodeId, String anchorId)? hoveringAnchor,
    TResult? Function(String edgeId)? hoveringEdge,
    TResult? Function(
            @OffsetConverter() Offset globalPosition, String? targetId)?
        contextMenuOpen,
    TResult? Function(NodeModel node, @OffsetConverter() Offset canvasPos,
            String? highlightedEdgeId)?
        insertingNodePreview,
    TResult? Function(CanvasInsertElement groupElement,
            @OffsetConverter() Offset canvasPos, String? highlightedEdgeId)?
        insertingGroupPreview,
  }) {
    return dragWaypoint?.call(
        edgeId, pointIndex, originalPoint, startCanvas, lastCanvas);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? idle,
    TResult Function(String nodeId, @OffsetConverter() Offset startCanvas,
            @OffsetConverter() Offset lastCanvas)?
        dragNode,
    TResult Function(
            String edgeId,
            String sourceNodeId,
            String sourceAnchorId,
            @OffsetConverter() Offset startCanvas,
            @OffsetConverter() Offset lastCanvas)?
        dragEdge,
    TResult Function(
            String edgeId,
            int pointIndex,
            @OffsetConverter() Offset originalPoint,
            @OffsetConverter() Offset startCanvas,
            @OffsetConverter() Offset lastCanvas)?
        dragWaypoint,
    TResult Function(@OffsetConverter() Offset startGlobal,
            @OffsetConverter() Offset lastGlobal)?
        panCanvas,
    TResult Function(@RectConverter() Rect selectionBox)? selectingArea,
    TResult Function(String nodeType, @OffsetConverter() Offset startCanvas,
            @OffsetConverter() Offset lastCanvas)?
        insertingNode,
    TResult Function(
            String nodeType,
            String edgeId,
            @OffsetConverter() Offset startCanvas,
            @OffsetConverter() Offset lastCanvas)?
        insertNodeToEdge,
    TResult Function(
            String nodeId,
            @OffsetConverter() Offset handlePosition,
            @OffsetConverter() Offset startCanvas,
            @OffsetConverter() Offset lastCanvas)?
        resizingNode,
    TResult Function(String nodeId)? hoveringNode,
    TResult Function(String nodeId, String anchorId)? hoveringAnchor,
    TResult Function(String edgeId)? hoveringEdge,
    TResult Function(
            @OffsetConverter() Offset globalPosition, String? targetId)?
        contextMenuOpen,
    TResult Function(NodeModel node, @OffsetConverter() Offset canvasPos,
            String? highlightedEdgeId)?
        insertingNodePreview,
    TResult Function(CanvasInsertElement groupElement,
            @OffsetConverter() Offset canvasPos, String? highlightedEdgeId)?
        insertingGroupPreview,
    required TResult orElse(),
  }) {
    if (dragWaypoint != null) {
      return dragWaypoint(
          edgeId, pointIndex, originalPoint, startCanvas, lastCanvas);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(Idle value) idle,
    required TResult Function(DragNode value) dragNode,
    required TResult Function(DragEdge value) dragEdge,
    required TResult Function(DragWaypoint value) dragWaypoint,
    required TResult Function(PanCanvas value) panCanvas,
    required TResult Function(SelectingArea value) selectingArea,
    required TResult Function(InsertingNode value) insertingNode,
    required TResult Function(InsertNodeToEdge value) insertNodeToEdge,
    required TResult Function(ResizingNode value) resizingNode,
    required TResult Function(HoveringNode value) hoveringNode,
    required TResult Function(HoveringAnchor value) hoveringAnchor,
    required TResult Function(HoveringEdge value) hoveringEdge,
    required TResult Function(ContextMenuOpen value) contextMenuOpen,
    required TResult Function(InsertingNodePreview value) insertingNodePreview,
    required TResult Function(InsertingGroupPreview value)
        insertingGroupPreview,
  }) {
    return dragWaypoint(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(Idle value)? idle,
    TResult? Function(DragNode value)? dragNode,
    TResult? Function(DragEdge value)? dragEdge,
    TResult? Function(DragWaypoint value)? dragWaypoint,
    TResult? Function(PanCanvas value)? panCanvas,
    TResult? Function(SelectingArea value)? selectingArea,
    TResult? Function(InsertingNode value)? insertingNode,
    TResult? Function(InsertNodeToEdge value)? insertNodeToEdge,
    TResult? Function(ResizingNode value)? resizingNode,
    TResult? Function(HoveringNode value)? hoveringNode,
    TResult? Function(HoveringAnchor value)? hoveringAnchor,
    TResult? Function(HoveringEdge value)? hoveringEdge,
    TResult? Function(ContextMenuOpen value)? contextMenuOpen,
    TResult? Function(InsertingNodePreview value)? insertingNodePreview,
    TResult? Function(InsertingGroupPreview value)? insertingGroupPreview,
  }) {
    return dragWaypoint?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(Idle value)? idle,
    TResult Function(DragNode value)? dragNode,
    TResult Function(DragEdge value)? dragEdge,
    TResult Function(DragWaypoint value)? dragWaypoint,
    TResult Function(PanCanvas value)? panCanvas,
    TResult Function(SelectingArea value)? selectingArea,
    TResult Function(InsertingNode value)? insertingNode,
    TResult Function(InsertNodeToEdge value)? insertNodeToEdge,
    TResult Function(ResizingNode value)? resizingNode,
    TResult Function(HoveringNode value)? hoveringNode,
    TResult Function(HoveringAnchor value)? hoveringAnchor,
    TResult Function(HoveringEdge value)? hoveringEdge,
    TResult Function(ContextMenuOpen value)? contextMenuOpen,
    TResult Function(InsertingNodePreview value)? insertingNodePreview,
    TResult Function(InsertingGroupPreview value)? insertingGroupPreview,
    required TResult orElse(),
  }) {
    if (dragWaypoint != null) {
      return dragWaypoint(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$DragWaypointImplToJson(
      this,
    );
  }
}

abstract class DragWaypoint extends InteractionState {
  const factory DragWaypoint(
          {required final String edgeId,
          required final int pointIndex,
          @OffsetConverter() required final Offset originalPoint,
          @OffsetConverter() required final Offset startCanvas,
          @OffsetConverter() required final Offset lastCanvas}) =
      _$DragWaypointImpl;
  const DragWaypoint._() : super._();

  factory DragWaypoint.fromJson(Map<String, dynamic> json) =
      _$DragWaypointImpl.fromJson;

  String get edgeId;
  int get pointIndex;
  @OffsetConverter()
  Offset get originalPoint;
  @OffsetConverter()
  Offset get startCanvas;
  @OffsetConverter()
  Offset get lastCanvas;
  @JsonKey(ignore: true)
  _$$DragWaypointImplCopyWith<_$DragWaypointImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$PanCanvasImplCopyWith<$Res> {
  factory _$$PanCanvasImplCopyWith(
          _$PanCanvasImpl value, $Res Function(_$PanCanvasImpl) then) =
      __$$PanCanvasImplCopyWithImpl<$Res>;
  @useResult
  $Res call(
      {@OffsetConverter() Offset startGlobal,
      @OffsetConverter() Offset lastGlobal});
}

/// @nodoc
class __$$PanCanvasImplCopyWithImpl<$Res>
    extends _$InteractionStateCopyWithImpl<$Res, _$PanCanvasImpl>
    implements _$$PanCanvasImplCopyWith<$Res> {
  __$$PanCanvasImplCopyWithImpl(
      _$PanCanvasImpl _value, $Res Function(_$PanCanvasImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? startGlobal = null,
    Object? lastGlobal = null,
  }) {
    return _then(_$PanCanvasImpl(
      startGlobal: null == startGlobal
          ? _value.startGlobal
          : startGlobal // ignore: cast_nullable_to_non_nullable
              as Offset,
      lastGlobal: null == lastGlobal
          ? _value.lastGlobal
          : lastGlobal // ignore: cast_nullable_to_non_nullable
              as Offset,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$PanCanvasImpl extends PanCanvas {
  const _$PanCanvasImpl(
      {@OffsetConverter() required this.startGlobal,
      @OffsetConverter() required this.lastGlobal,
      final String? $type})
      : $type = $type ?? 'pan_canvas',
        super._();

  factory _$PanCanvasImpl.fromJson(Map<String, dynamic> json) =>
      _$$PanCanvasImplFromJson(json);

  @override
  @OffsetConverter()
  final Offset startGlobal;
  @override
  @OffsetConverter()
  final Offset lastGlobal;

  @JsonKey(name: 'type')
  final String $type;

  @override
  String toString() {
    return 'InteractionState.panCanvas(startGlobal: $startGlobal, lastGlobal: $lastGlobal)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PanCanvasImpl &&
            (identical(other.startGlobal, startGlobal) ||
                other.startGlobal == startGlobal) &&
            (identical(other.lastGlobal, lastGlobal) ||
                other.lastGlobal == lastGlobal));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, startGlobal, lastGlobal);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$PanCanvasImplCopyWith<_$PanCanvasImpl> get copyWith =>
      __$$PanCanvasImplCopyWithImpl<_$PanCanvasImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() idle,
    required TResult Function(
            String nodeId,
            @OffsetConverter() Offset startCanvas,
            @OffsetConverter() Offset lastCanvas)
        dragNode,
    required TResult Function(
            String edgeId,
            String sourceNodeId,
            String sourceAnchorId,
            @OffsetConverter() Offset startCanvas,
            @OffsetConverter() Offset lastCanvas)
        dragEdge,
    required TResult Function(
            String edgeId,
            int pointIndex,
            @OffsetConverter() Offset originalPoint,
            @OffsetConverter() Offset startCanvas,
            @OffsetConverter() Offset lastCanvas)
        dragWaypoint,
    required TResult Function(@OffsetConverter() Offset startGlobal,
            @OffsetConverter() Offset lastGlobal)
        panCanvas,
    required TResult Function(@RectConverter() Rect selectionBox) selectingArea,
    required TResult Function(
            String nodeType,
            @OffsetConverter() Offset startCanvas,
            @OffsetConverter() Offset lastCanvas)
        insertingNode,
    required TResult Function(
            String nodeType,
            String edgeId,
            @OffsetConverter() Offset startCanvas,
            @OffsetConverter() Offset lastCanvas)
        insertNodeToEdge,
    required TResult Function(
            String nodeId,
            @OffsetConverter() Offset handlePosition,
            @OffsetConverter() Offset startCanvas,
            @OffsetConverter() Offset lastCanvas)
        resizingNode,
    required TResult Function(String nodeId) hoveringNode,
    required TResult Function(String nodeId, String anchorId) hoveringAnchor,
    required TResult Function(String edgeId) hoveringEdge,
    required TResult Function(
            @OffsetConverter() Offset globalPosition, String? targetId)
        contextMenuOpen,
    required TResult Function(NodeModel node,
            @OffsetConverter() Offset canvasPos, String? highlightedEdgeId)
        insertingNodePreview,
    required TResult Function(CanvasInsertElement groupElement,
            @OffsetConverter() Offset canvasPos, String? highlightedEdgeId)
        insertingGroupPreview,
  }) {
    return panCanvas(startGlobal, lastGlobal);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? idle,
    TResult? Function(String nodeId, @OffsetConverter() Offset startCanvas,
            @OffsetConverter() Offset lastCanvas)?
        dragNode,
    TResult? Function(
            String edgeId,
            String sourceNodeId,
            String sourceAnchorId,
            @OffsetConverter() Offset startCanvas,
            @OffsetConverter() Offset lastCanvas)?
        dragEdge,
    TResult? Function(
            String edgeId,
            int pointIndex,
            @OffsetConverter() Offset originalPoint,
            @OffsetConverter() Offset startCanvas,
            @OffsetConverter() Offset lastCanvas)?
        dragWaypoint,
    TResult? Function(@OffsetConverter() Offset startGlobal,
            @OffsetConverter() Offset lastGlobal)?
        panCanvas,
    TResult? Function(@RectConverter() Rect selectionBox)? selectingArea,
    TResult? Function(String nodeType, @OffsetConverter() Offset startCanvas,
            @OffsetConverter() Offset lastCanvas)?
        insertingNode,
    TResult? Function(
            String nodeType,
            String edgeId,
            @OffsetConverter() Offset startCanvas,
            @OffsetConverter() Offset lastCanvas)?
        insertNodeToEdge,
    TResult? Function(
            String nodeId,
            @OffsetConverter() Offset handlePosition,
            @OffsetConverter() Offset startCanvas,
            @OffsetConverter() Offset lastCanvas)?
        resizingNode,
    TResult? Function(String nodeId)? hoveringNode,
    TResult? Function(String nodeId, String anchorId)? hoveringAnchor,
    TResult? Function(String edgeId)? hoveringEdge,
    TResult? Function(
            @OffsetConverter() Offset globalPosition, String? targetId)?
        contextMenuOpen,
    TResult? Function(NodeModel node, @OffsetConverter() Offset canvasPos,
            String? highlightedEdgeId)?
        insertingNodePreview,
    TResult? Function(CanvasInsertElement groupElement,
            @OffsetConverter() Offset canvasPos, String? highlightedEdgeId)?
        insertingGroupPreview,
  }) {
    return panCanvas?.call(startGlobal, lastGlobal);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? idle,
    TResult Function(String nodeId, @OffsetConverter() Offset startCanvas,
            @OffsetConverter() Offset lastCanvas)?
        dragNode,
    TResult Function(
            String edgeId,
            String sourceNodeId,
            String sourceAnchorId,
            @OffsetConverter() Offset startCanvas,
            @OffsetConverter() Offset lastCanvas)?
        dragEdge,
    TResult Function(
            String edgeId,
            int pointIndex,
            @OffsetConverter() Offset originalPoint,
            @OffsetConverter() Offset startCanvas,
            @OffsetConverter() Offset lastCanvas)?
        dragWaypoint,
    TResult Function(@OffsetConverter() Offset startGlobal,
            @OffsetConverter() Offset lastGlobal)?
        panCanvas,
    TResult Function(@RectConverter() Rect selectionBox)? selectingArea,
    TResult Function(String nodeType, @OffsetConverter() Offset startCanvas,
            @OffsetConverter() Offset lastCanvas)?
        insertingNode,
    TResult Function(
            String nodeType,
            String edgeId,
            @OffsetConverter() Offset startCanvas,
            @OffsetConverter() Offset lastCanvas)?
        insertNodeToEdge,
    TResult Function(
            String nodeId,
            @OffsetConverter() Offset handlePosition,
            @OffsetConverter() Offset startCanvas,
            @OffsetConverter() Offset lastCanvas)?
        resizingNode,
    TResult Function(String nodeId)? hoveringNode,
    TResult Function(String nodeId, String anchorId)? hoveringAnchor,
    TResult Function(String edgeId)? hoveringEdge,
    TResult Function(
            @OffsetConverter() Offset globalPosition, String? targetId)?
        contextMenuOpen,
    TResult Function(NodeModel node, @OffsetConverter() Offset canvasPos,
            String? highlightedEdgeId)?
        insertingNodePreview,
    TResult Function(CanvasInsertElement groupElement,
            @OffsetConverter() Offset canvasPos, String? highlightedEdgeId)?
        insertingGroupPreview,
    required TResult orElse(),
  }) {
    if (panCanvas != null) {
      return panCanvas(startGlobal, lastGlobal);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(Idle value) idle,
    required TResult Function(DragNode value) dragNode,
    required TResult Function(DragEdge value) dragEdge,
    required TResult Function(DragWaypoint value) dragWaypoint,
    required TResult Function(PanCanvas value) panCanvas,
    required TResult Function(SelectingArea value) selectingArea,
    required TResult Function(InsertingNode value) insertingNode,
    required TResult Function(InsertNodeToEdge value) insertNodeToEdge,
    required TResult Function(ResizingNode value) resizingNode,
    required TResult Function(HoveringNode value) hoveringNode,
    required TResult Function(HoveringAnchor value) hoveringAnchor,
    required TResult Function(HoveringEdge value) hoveringEdge,
    required TResult Function(ContextMenuOpen value) contextMenuOpen,
    required TResult Function(InsertingNodePreview value) insertingNodePreview,
    required TResult Function(InsertingGroupPreview value)
        insertingGroupPreview,
  }) {
    return panCanvas(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(Idle value)? idle,
    TResult? Function(DragNode value)? dragNode,
    TResult? Function(DragEdge value)? dragEdge,
    TResult? Function(DragWaypoint value)? dragWaypoint,
    TResult? Function(PanCanvas value)? panCanvas,
    TResult? Function(SelectingArea value)? selectingArea,
    TResult? Function(InsertingNode value)? insertingNode,
    TResult? Function(InsertNodeToEdge value)? insertNodeToEdge,
    TResult? Function(ResizingNode value)? resizingNode,
    TResult? Function(HoveringNode value)? hoveringNode,
    TResult? Function(HoveringAnchor value)? hoveringAnchor,
    TResult? Function(HoveringEdge value)? hoveringEdge,
    TResult? Function(ContextMenuOpen value)? contextMenuOpen,
    TResult? Function(InsertingNodePreview value)? insertingNodePreview,
    TResult? Function(InsertingGroupPreview value)? insertingGroupPreview,
  }) {
    return panCanvas?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(Idle value)? idle,
    TResult Function(DragNode value)? dragNode,
    TResult Function(DragEdge value)? dragEdge,
    TResult Function(DragWaypoint value)? dragWaypoint,
    TResult Function(PanCanvas value)? panCanvas,
    TResult Function(SelectingArea value)? selectingArea,
    TResult Function(InsertingNode value)? insertingNode,
    TResult Function(InsertNodeToEdge value)? insertNodeToEdge,
    TResult Function(ResizingNode value)? resizingNode,
    TResult Function(HoveringNode value)? hoveringNode,
    TResult Function(HoveringAnchor value)? hoveringAnchor,
    TResult Function(HoveringEdge value)? hoveringEdge,
    TResult Function(ContextMenuOpen value)? contextMenuOpen,
    TResult Function(InsertingNodePreview value)? insertingNodePreview,
    TResult Function(InsertingGroupPreview value)? insertingGroupPreview,
    required TResult orElse(),
  }) {
    if (panCanvas != null) {
      return panCanvas(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$PanCanvasImplToJson(
      this,
    );
  }
}

abstract class PanCanvas extends InteractionState {
  const factory PanCanvas(
      {@OffsetConverter() required final Offset startGlobal,
      @OffsetConverter() required final Offset lastGlobal}) = _$PanCanvasImpl;
  const PanCanvas._() : super._();

  factory PanCanvas.fromJson(Map<String, dynamic> json) =
      _$PanCanvasImpl.fromJson;

  @OffsetConverter()
  Offset get startGlobal;
  @OffsetConverter()
  Offset get lastGlobal;
  @JsonKey(ignore: true)
  _$$PanCanvasImplCopyWith<_$PanCanvasImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$SelectingAreaImplCopyWith<$Res> {
  factory _$$SelectingAreaImplCopyWith(
          _$SelectingAreaImpl value, $Res Function(_$SelectingAreaImpl) then) =
      __$$SelectingAreaImplCopyWithImpl<$Res>;
  @useResult
  $Res call({@RectConverter() Rect selectionBox});
}

/// @nodoc
class __$$SelectingAreaImplCopyWithImpl<$Res>
    extends _$InteractionStateCopyWithImpl<$Res, _$SelectingAreaImpl>
    implements _$$SelectingAreaImplCopyWith<$Res> {
  __$$SelectingAreaImplCopyWithImpl(
      _$SelectingAreaImpl _value, $Res Function(_$SelectingAreaImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? selectionBox = null,
  }) {
    return _then(_$SelectingAreaImpl(
      selectionBox: null == selectionBox
          ? _value.selectionBox
          : selectionBox // ignore: cast_nullable_to_non_nullable
              as Rect,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$SelectingAreaImpl extends SelectingArea {
  const _$SelectingAreaImpl(
      {@RectConverter() required this.selectionBox, final String? $type})
      : $type = $type ?? 'selecting_area',
        super._();

  factory _$SelectingAreaImpl.fromJson(Map<String, dynamic> json) =>
      _$$SelectingAreaImplFromJson(json);

  @override
  @RectConverter()
  final Rect selectionBox;

  @JsonKey(name: 'type')
  final String $type;

  @override
  String toString() {
    return 'InteractionState.selectingArea(selectionBox: $selectionBox)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SelectingAreaImpl &&
            (identical(other.selectionBox, selectionBox) ||
                other.selectionBox == selectionBox));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, selectionBox);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$SelectingAreaImplCopyWith<_$SelectingAreaImpl> get copyWith =>
      __$$SelectingAreaImplCopyWithImpl<_$SelectingAreaImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() idle,
    required TResult Function(
            String nodeId,
            @OffsetConverter() Offset startCanvas,
            @OffsetConverter() Offset lastCanvas)
        dragNode,
    required TResult Function(
            String edgeId,
            String sourceNodeId,
            String sourceAnchorId,
            @OffsetConverter() Offset startCanvas,
            @OffsetConverter() Offset lastCanvas)
        dragEdge,
    required TResult Function(
            String edgeId,
            int pointIndex,
            @OffsetConverter() Offset originalPoint,
            @OffsetConverter() Offset startCanvas,
            @OffsetConverter() Offset lastCanvas)
        dragWaypoint,
    required TResult Function(@OffsetConverter() Offset startGlobal,
            @OffsetConverter() Offset lastGlobal)
        panCanvas,
    required TResult Function(@RectConverter() Rect selectionBox) selectingArea,
    required TResult Function(
            String nodeType,
            @OffsetConverter() Offset startCanvas,
            @OffsetConverter() Offset lastCanvas)
        insertingNode,
    required TResult Function(
            String nodeType,
            String edgeId,
            @OffsetConverter() Offset startCanvas,
            @OffsetConverter() Offset lastCanvas)
        insertNodeToEdge,
    required TResult Function(
            String nodeId,
            @OffsetConverter() Offset handlePosition,
            @OffsetConverter() Offset startCanvas,
            @OffsetConverter() Offset lastCanvas)
        resizingNode,
    required TResult Function(String nodeId) hoveringNode,
    required TResult Function(String nodeId, String anchorId) hoveringAnchor,
    required TResult Function(String edgeId) hoveringEdge,
    required TResult Function(
            @OffsetConverter() Offset globalPosition, String? targetId)
        contextMenuOpen,
    required TResult Function(NodeModel node,
            @OffsetConverter() Offset canvasPos, String? highlightedEdgeId)
        insertingNodePreview,
    required TResult Function(CanvasInsertElement groupElement,
            @OffsetConverter() Offset canvasPos, String? highlightedEdgeId)
        insertingGroupPreview,
  }) {
    return selectingArea(selectionBox);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? idle,
    TResult? Function(String nodeId, @OffsetConverter() Offset startCanvas,
            @OffsetConverter() Offset lastCanvas)?
        dragNode,
    TResult? Function(
            String edgeId,
            String sourceNodeId,
            String sourceAnchorId,
            @OffsetConverter() Offset startCanvas,
            @OffsetConverter() Offset lastCanvas)?
        dragEdge,
    TResult? Function(
            String edgeId,
            int pointIndex,
            @OffsetConverter() Offset originalPoint,
            @OffsetConverter() Offset startCanvas,
            @OffsetConverter() Offset lastCanvas)?
        dragWaypoint,
    TResult? Function(@OffsetConverter() Offset startGlobal,
            @OffsetConverter() Offset lastGlobal)?
        panCanvas,
    TResult? Function(@RectConverter() Rect selectionBox)? selectingArea,
    TResult? Function(String nodeType, @OffsetConverter() Offset startCanvas,
            @OffsetConverter() Offset lastCanvas)?
        insertingNode,
    TResult? Function(
            String nodeType,
            String edgeId,
            @OffsetConverter() Offset startCanvas,
            @OffsetConverter() Offset lastCanvas)?
        insertNodeToEdge,
    TResult? Function(
            String nodeId,
            @OffsetConverter() Offset handlePosition,
            @OffsetConverter() Offset startCanvas,
            @OffsetConverter() Offset lastCanvas)?
        resizingNode,
    TResult? Function(String nodeId)? hoveringNode,
    TResult? Function(String nodeId, String anchorId)? hoveringAnchor,
    TResult? Function(String edgeId)? hoveringEdge,
    TResult? Function(
            @OffsetConverter() Offset globalPosition, String? targetId)?
        contextMenuOpen,
    TResult? Function(NodeModel node, @OffsetConverter() Offset canvasPos,
            String? highlightedEdgeId)?
        insertingNodePreview,
    TResult? Function(CanvasInsertElement groupElement,
            @OffsetConverter() Offset canvasPos, String? highlightedEdgeId)?
        insertingGroupPreview,
  }) {
    return selectingArea?.call(selectionBox);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? idle,
    TResult Function(String nodeId, @OffsetConverter() Offset startCanvas,
            @OffsetConverter() Offset lastCanvas)?
        dragNode,
    TResult Function(
            String edgeId,
            String sourceNodeId,
            String sourceAnchorId,
            @OffsetConverter() Offset startCanvas,
            @OffsetConverter() Offset lastCanvas)?
        dragEdge,
    TResult Function(
            String edgeId,
            int pointIndex,
            @OffsetConverter() Offset originalPoint,
            @OffsetConverter() Offset startCanvas,
            @OffsetConverter() Offset lastCanvas)?
        dragWaypoint,
    TResult Function(@OffsetConverter() Offset startGlobal,
            @OffsetConverter() Offset lastGlobal)?
        panCanvas,
    TResult Function(@RectConverter() Rect selectionBox)? selectingArea,
    TResult Function(String nodeType, @OffsetConverter() Offset startCanvas,
            @OffsetConverter() Offset lastCanvas)?
        insertingNode,
    TResult Function(
            String nodeType,
            String edgeId,
            @OffsetConverter() Offset startCanvas,
            @OffsetConverter() Offset lastCanvas)?
        insertNodeToEdge,
    TResult Function(
            String nodeId,
            @OffsetConverter() Offset handlePosition,
            @OffsetConverter() Offset startCanvas,
            @OffsetConverter() Offset lastCanvas)?
        resizingNode,
    TResult Function(String nodeId)? hoveringNode,
    TResult Function(String nodeId, String anchorId)? hoveringAnchor,
    TResult Function(String edgeId)? hoveringEdge,
    TResult Function(
            @OffsetConverter() Offset globalPosition, String? targetId)?
        contextMenuOpen,
    TResult Function(NodeModel node, @OffsetConverter() Offset canvasPos,
            String? highlightedEdgeId)?
        insertingNodePreview,
    TResult Function(CanvasInsertElement groupElement,
            @OffsetConverter() Offset canvasPos, String? highlightedEdgeId)?
        insertingGroupPreview,
    required TResult orElse(),
  }) {
    if (selectingArea != null) {
      return selectingArea(selectionBox);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(Idle value) idle,
    required TResult Function(DragNode value) dragNode,
    required TResult Function(DragEdge value) dragEdge,
    required TResult Function(DragWaypoint value) dragWaypoint,
    required TResult Function(PanCanvas value) panCanvas,
    required TResult Function(SelectingArea value) selectingArea,
    required TResult Function(InsertingNode value) insertingNode,
    required TResult Function(InsertNodeToEdge value) insertNodeToEdge,
    required TResult Function(ResizingNode value) resizingNode,
    required TResult Function(HoveringNode value) hoveringNode,
    required TResult Function(HoveringAnchor value) hoveringAnchor,
    required TResult Function(HoveringEdge value) hoveringEdge,
    required TResult Function(ContextMenuOpen value) contextMenuOpen,
    required TResult Function(InsertingNodePreview value) insertingNodePreview,
    required TResult Function(InsertingGroupPreview value)
        insertingGroupPreview,
  }) {
    return selectingArea(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(Idle value)? idle,
    TResult? Function(DragNode value)? dragNode,
    TResult? Function(DragEdge value)? dragEdge,
    TResult? Function(DragWaypoint value)? dragWaypoint,
    TResult? Function(PanCanvas value)? panCanvas,
    TResult? Function(SelectingArea value)? selectingArea,
    TResult? Function(InsertingNode value)? insertingNode,
    TResult? Function(InsertNodeToEdge value)? insertNodeToEdge,
    TResult? Function(ResizingNode value)? resizingNode,
    TResult? Function(HoveringNode value)? hoveringNode,
    TResult? Function(HoveringAnchor value)? hoveringAnchor,
    TResult? Function(HoveringEdge value)? hoveringEdge,
    TResult? Function(ContextMenuOpen value)? contextMenuOpen,
    TResult? Function(InsertingNodePreview value)? insertingNodePreview,
    TResult? Function(InsertingGroupPreview value)? insertingGroupPreview,
  }) {
    return selectingArea?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(Idle value)? idle,
    TResult Function(DragNode value)? dragNode,
    TResult Function(DragEdge value)? dragEdge,
    TResult Function(DragWaypoint value)? dragWaypoint,
    TResult Function(PanCanvas value)? panCanvas,
    TResult Function(SelectingArea value)? selectingArea,
    TResult Function(InsertingNode value)? insertingNode,
    TResult Function(InsertNodeToEdge value)? insertNodeToEdge,
    TResult Function(ResizingNode value)? resizingNode,
    TResult Function(HoveringNode value)? hoveringNode,
    TResult Function(HoveringAnchor value)? hoveringAnchor,
    TResult Function(HoveringEdge value)? hoveringEdge,
    TResult Function(ContextMenuOpen value)? contextMenuOpen,
    TResult Function(InsertingNodePreview value)? insertingNodePreview,
    TResult Function(InsertingGroupPreview value)? insertingGroupPreview,
    required TResult orElse(),
  }) {
    if (selectingArea != null) {
      return selectingArea(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$SelectingAreaImplToJson(
      this,
    );
  }
}

abstract class SelectingArea extends InteractionState {
  const factory SelectingArea(
          {@RectConverter() required final Rect selectionBox}) =
      _$SelectingAreaImpl;
  const SelectingArea._() : super._();

  factory SelectingArea.fromJson(Map<String, dynamic> json) =
      _$SelectingAreaImpl.fromJson;

  @RectConverter()
  Rect get selectionBox;
  @JsonKey(ignore: true)
  _$$SelectingAreaImplCopyWith<_$SelectingAreaImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$InsertingNodeImplCopyWith<$Res> {
  factory _$$InsertingNodeImplCopyWith(
          _$InsertingNodeImpl value, $Res Function(_$InsertingNodeImpl) then) =
      __$$InsertingNodeImplCopyWithImpl<$Res>;
  @useResult
  $Res call(
      {String nodeType,
      @OffsetConverter() Offset startCanvas,
      @OffsetConverter() Offset lastCanvas});
}

/// @nodoc
class __$$InsertingNodeImplCopyWithImpl<$Res>
    extends _$InteractionStateCopyWithImpl<$Res, _$InsertingNodeImpl>
    implements _$$InsertingNodeImplCopyWith<$Res> {
  __$$InsertingNodeImplCopyWithImpl(
      _$InsertingNodeImpl _value, $Res Function(_$InsertingNodeImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? nodeType = null,
    Object? startCanvas = null,
    Object? lastCanvas = null,
  }) {
    return _then(_$InsertingNodeImpl(
      nodeType: null == nodeType
          ? _value.nodeType
          : nodeType // ignore: cast_nullable_to_non_nullable
              as String,
      startCanvas: null == startCanvas
          ? _value.startCanvas
          : startCanvas // ignore: cast_nullable_to_non_nullable
              as Offset,
      lastCanvas: null == lastCanvas
          ? _value.lastCanvas
          : lastCanvas // ignore: cast_nullable_to_non_nullable
              as Offset,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$InsertingNodeImpl extends InsertingNode {
  const _$InsertingNodeImpl(
      {required this.nodeType,
      @OffsetConverter() required this.startCanvas,
      @OffsetConverter() required this.lastCanvas,
      final String? $type})
      : $type = $type ?? 'inserting_node',
        super._();

  factory _$InsertingNodeImpl.fromJson(Map<String, dynamic> json) =>
      _$$InsertingNodeImplFromJson(json);

  @override
  final String nodeType;
  @override
  @OffsetConverter()
  final Offset startCanvas;
  @override
  @OffsetConverter()
  final Offset lastCanvas;

  @JsonKey(name: 'type')
  final String $type;

  @override
  String toString() {
    return 'InteractionState.insertingNode(nodeType: $nodeType, startCanvas: $startCanvas, lastCanvas: $lastCanvas)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$InsertingNodeImpl &&
            (identical(other.nodeType, nodeType) ||
                other.nodeType == nodeType) &&
            (identical(other.startCanvas, startCanvas) ||
                other.startCanvas == startCanvas) &&
            (identical(other.lastCanvas, lastCanvas) ||
                other.lastCanvas == lastCanvas));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, nodeType, startCanvas, lastCanvas);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$InsertingNodeImplCopyWith<_$InsertingNodeImpl> get copyWith =>
      __$$InsertingNodeImplCopyWithImpl<_$InsertingNodeImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() idle,
    required TResult Function(
            String nodeId,
            @OffsetConverter() Offset startCanvas,
            @OffsetConverter() Offset lastCanvas)
        dragNode,
    required TResult Function(
            String edgeId,
            String sourceNodeId,
            String sourceAnchorId,
            @OffsetConverter() Offset startCanvas,
            @OffsetConverter() Offset lastCanvas)
        dragEdge,
    required TResult Function(
            String edgeId,
            int pointIndex,
            @OffsetConverter() Offset originalPoint,
            @OffsetConverter() Offset startCanvas,
            @OffsetConverter() Offset lastCanvas)
        dragWaypoint,
    required TResult Function(@OffsetConverter() Offset startGlobal,
            @OffsetConverter() Offset lastGlobal)
        panCanvas,
    required TResult Function(@RectConverter() Rect selectionBox) selectingArea,
    required TResult Function(
            String nodeType,
            @OffsetConverter() Offset startCanvas,
            @OffsetConverter() Offset lastCanvas)
        insertingNode,
    required TResult Function(
            String nodeType,
            String edgeId,
            @OffsetConverter() Offset startCanvas,
            @OffsetConverter() Offset lastCanvas)
        insertNodeToEdge,
    required TResult Function(
            String nodeId,
            @OffsetConverter() Offset handlePosition,
            @OffsetConverter() Offset startCanvas,
            @OffsetConverter() Offset lastCanvas)
        resizingNode,
    required TResult Function(String nodeId) hoveringNode,
    required TResult Function(String nodeId, String anchorId) hoveringAnchor,
    required TResult Function(String edgeId) hoveringEdge,
    required TResult Function(
            @OffsetConverter() Offset globalPosition, String? targetId)
        contextMenuOpen,
    required TResult Function(NodeModel node,
            @OffsetConverter() Offset canvasPos, String? highlightedEdgeId)
        insertingNodePreview,
    required TResult Function(CanvasInsertElement groupElement,
            @OffsetConverter() Offset canvasPos, String? highlightedEdgeId)
        insertingGroupPreview,
  }) {
    return insertingNode(nodeType, startCanvas, lastCanvas);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? idle,
    TResult? Function(String nodeId, @OffsetConverter() Offset startCanvas,
            @OffsetConverter() Offset lastCanvas)?
        dragNode,
    TResult? Function(
            String edgeId,
            String sourceNodeId,
            String sourceAnchorId,
            @OffsetConverter() Offset startCanvas,
            @OffsetConverter() Offset lastCanvas)?
        dragEdge,
    TResult? Function(
            String edgeId,
            int pointIndex,
            @OffsetConverter() Offset originalPoint,
            @OffsetConverter() Offset startCanvas,
            @OffsetConverter() Offset lastCanvas)?
        dragWaypoint,
    TResult? Function(@OffsetConverter() Offset startGlobal,
            @OffsetConverter() Offset lastGlobal)?
        panCanvas,
    TResult? Function(@RectConverter() Rect selectionBox)? selectingArea,
    TResult? Function(String nodeType, @OffsetConverter() Offset startCanvas,
            @OffsetConverter() Offset lastCanvas)?
        insertingNode,
    TResult? Function(
            String nodeType,
            String edgeId,
            @OffsetConverter() Offset startCanvas,
            @OffsetConverter() Offset lastCanvas)?
        insertNodeToEdge,
    TResult? Function(
            String nodeId,
            @OffsetConverter() Offset handlePosition,
            @OffsetConverter() Offset startCanvas,
            @OffsetConverter() Offset lastCanvas)?
        resizingNode,
    TResult? Function(String nodeId)? hoveringNode,
    TResult? Function(String nodeId, String anchorId)? hoveringAnchor,
    TResult? Function(String edgeId)? hoveringEdge,
    TResult? Function(
            @OffsetConverter() Offset globalPosition, String? targetId)?
        contextMenuOpen,
    TResult? Function(NodeModel node, @OffsetConverter() Offset canvasPos,
            String? highlightedEdgeId)?
        insertingNodePreview,
    TResult? Function(CanvasInsertElement groupElement,
            @OffsetConverter() Offset canvasPos, String? highlightedEdgeId)?
        insertingGroupPreview,
  }) {
    return insertingNode?.call(nodeType, startCanvas, lastCanvas);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? idle,
    TResult Function(String nodeId, @OffsetConverter() Offset startCanvas,
            @OffsetConverter() Offset lastCanvas)?
        dragNode,
    TResult Function(
            String edgeId,
            String sourceNodeId,
            String sourceAnchorId,
            @OffsetConverter() Offset startCanvas,
            @OffsetConverter() Offset lastCanvas)?
        dragEdge,
    TResult Function(
            String edgeId,
            int pointIndex,
            @OffsetConverter() Offset originalPoint,
            @OffsetConverter() Offset startCanvas,
            @OffsetConverter() Offset lastCanvas)?
        dragWaypoint,
    TResult Function(@OffsetConverter() Offset startGlobal,
            @OffsetConverter() Offset lastGlobal)?
        panCanvas,
    TResult Function(@RectConverter() Rect selectionBox)? selectingArea,
    TResult Function(String nodeType, @OffsetConverter() Offset startCanvas,
            @OffsetConverter() Offset lastCanvas)?
        insertingNode,
    TResult Function(
            String nodeType,
            String edgeId,
            @OffsetConverter() Offset startCanvas,
            @OffsetConverter() Offset lastCanvas)?
        insertNodeToEdge,
    TResult Function(
            String nodeId,
            @OffsetConverter() Offset handlePosition,
            @OffsetConverter() Offset startCanvas,
            @OffsetConverter() Offset lastCanvas)?
        resizingNode,
    TResult Function(String nodeId)? hoveringNode,
    TResult Function(String nodeId, String anchorId)? hoveringAnchor,
    TResult Function(String edgeId)? hoveringEdge,
    TResult Function(
            @OffsetConverter() Offset globalPosition, String? targetId)?
        contextMenuOpen,
    TResult Function(NodeModel node, @OffsetConverter() Offset canvasPos,
            String? highlightedEdgeId)?
        insertingNodePreview,
    TResult Function(CanvasInsertElement groupElement,
            @OffsetConverter() Offset canvasPos, String? highlightedEdgeId)?
        insertingGroupPreview,
    required TResult orElse(),
  }) {
    if (insertingNode != null) {
      return insertingNode(nodeType, startCanvas, lastCanvas);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(Idle value) idle,
    required TResult Function(DragNode value) dragNode,
    required TResult Function(DragEdge value) dragEdge,
    required TResult Function(DragWaypoint value) dragWaypoint,
    required TResult Function(PanCanvas value) panCanvas,
    required TResult Function(SelectingArea value) selectingArea,
    required TResult Function(InsertingNode value) insertingNode,
    required TResult Function(InsertNodeToEdge value) insertNodeToEdge,
    required TResult Function(ResizingNode value) resizingNode,
    required TResult Function(HoveringNode value) hoveringNode,
    required TResult Function(HoveringAnchor value) hoveringAnchor,
    required TResult Function(HoveringEdge value) hoveringEdge,
    required TResult Function(ContextMenuOpen value) contextMenuOpen,
    required TResult Function(InsertingNodePreview value) insertingNodePreview,
    required TResult Function(InsertingGroupPreview value)
        insertingGroupPreview,
  }) {
    return insertingNode(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(Idle value)? idle,
    TResult? Function(DragNode value)? dragNode,
    TResult? Function(DragEdge value)? dragEdge,
    TResult? Function(DragWaypoint value)? dragWaypoint,
    TResult? Function(PanCanvas value)? panCanvas,
    TResult? Function(SelectingArea value)? selectingArea,
    TResult? Function(InsertingNode value)? insertingNode,
    TResult? Function(InsertNodeToEdge value)? insertNodeToEdge,
    TResult? Function(ResizingNode value)? resizingNode,
    TResult? Function(HoveringNode value)? hoveringNode,
    TResult? Function(HoveringAnchor value)? hoveringAnchor,
    TResult? Function(HoveringEdge value)? hoveringEdge,
    TResult? Function(ContextMenuOpen value)? contextMenuOpen,
    TResult? Function(InsertingNodePreview value)? insertingNodePreview,
    TResult? Function(InsertingGroupPreview value)? insertingGroupPreview,
  }) {
    return insertingNode?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(Idle value)? idle,
    TResult Function(DragNode value)? dragNode,
    TResult Function(DragEdge value)? dragEdge,
    TResult Function(DragWaypoint value)? dragWaypoint,
    TResult Function(PanCanvas value)? panCanvas,
    TResult Function(SelectingArea value)? selectingArea,
    TResult Function(InsertingNode value)? insertingNode,
    TResult Function(InsertNodeToEdge value)? insertNodeToEdge,
    TResult Function(ResizingNode value)? resizingNode,
    TResult Function(HoveringNode value)? hoveringNode,
    TResult Function(HoveringAnchor value)? hoveringAnchor,
    TResult Function(HoveringEdge value)? hoveringEdge,
    TResult Function(ContextMenuOpen value)? contextMenuOpen,
    TResult Function(InsertingNodePreview value)? insertingNodePreview,
    TResult Function(InsertingGroupPreview value)? insertingGroupPreview,
    required TResult orElse(),
  }) {
    if (insertingNode != null) {
      return insertingNode(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$InsertingNodeImplToJson(
      this,
    );
  }
}

abstract class InsertingNode extends InteractionState {
  const factory InsertingNode(
          {required final String nodeType,
          @OffsetConverter() required final Offset startCanvas,
          @OffsetConverter() required final Offset lastCanvas}) =
      _$InsertingNodeImpl;
  const InsertingNode._() : super._();

  factory InsertingNode.fromJson(Map<String, dynamic> json) =
      _$InsertingNodeImpl.fromJson;

  String get nodeType;
  @OffsetConverter()
  Offset get startCanvas;
  @OffsetConverter()
  Offset get lastCanvas;
  @JsonKey(ignore: true)
  _$$InsertingNodeImplCopyWith<_$InsertingNodeImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$InsertNodeToEdgeImplCopyWith<$Res> {
  factory _$$InsertNodeToEdgeImplCopyWith(_$InsertNodeToEdgeImpl value,
          $Res Function(_$InsertNodeToEdgeImpl) then) =
      __$$InsertNodeToEdgeImplCopyWithImpl<$Res>;
  @useResult
  $Res call(
      {String nodeType,
      String edgeId,
      @OffsetConverter() Offset startCanvas,
      @OffsetConverter() Offset lastCanvas});
}

/// @nodoc
class __$$InsertNodeToEdgeImplCopyWithImpl<$Res>
    extends _$InteractionStateCopyWithImpl<$Res, _$InsertNodeToEdgeImpl>
    implements _$$InsertNodeToEdgeImplCopyWith<$Res> {
  __$$InsertNodeToEdgeImplCopyWithImpl(_$InsertNodeToEdgeImpl _value,
      $Res Function(_$InsertNodeToEdgeImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? nodeType = null,
    Object? edgeId = null,
    Object? startCanvas = null,
    Object? lastCanvas = null,
  }) {
    return _then(_$InsertNodeToEdgeImpl(
      nodeType: null == nodeType
          ? _value.nodeType
          : nodeType // ignore: cast_nullable_to_non_nullable
              as String,
      edgeId: null == edgeId
          ? _value.edgeId
          : edgeId // ignore: cast_nullable_to_non_nullable
              as String,
      startCanvas: null == startCanvas
          ? _value.startCanvas
          : startCanvas // ignore: cast_nullable_to_non_nullable
              as Offset,
      lastCanvas: null == lastCanvas
          ? _value.lastCanvas
          : lastCanvas // ignore: cast_nullable_to_non_nullable
              as Offset,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$InsertNodeToEdgeImpl extends InsertNodeToEdge {
  const _$InsertNodeToEdgeImpl(
      {required this.nodeType,
      required this.edgeId,
      @OffsetConverter() required this.startCanvas,
      @OffsetConverter() required this.lastCanvas,
      final String? $type})
      : $type = $type ?? 'insert_node_to_edge',
        super._();

  factory _$InsertNodeToEdgeImpl.fromJson(Map<String, dynamic> json) =>
      _$$InsertNodeToEdgeImplFromJson(json);

  @override
  final String nodeType;
  @override
  final String edgeId;
  @override
  @OffsetConverter()
  final Offset startCanvas;
  @override
  @OffsetConverter()
  final Offset lastCanvas;

  @JsonKey(name: 'type')
  final String $type;

  @override
  String toString() {
    return 'InteractionState.insertNodeToEdge(nodeType: $nodeType, edgeId: $edgeId, startCanvas: $startCanvas, lastCanvas: $lastCanvas)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$InsertNodeToEdgeImpl &&
            (identical(other.nodeType, nodeType) ||
                other.nodeType == nodeType) &&
            (identical(other.edgeId, edgeId) || other.edgeId == edgeId) &&
            (identical(other.startCanvas, startCanvas) ||
                other.startCanvas == startCanvas) &&
            (identical(other.lastCanvas, lastCanvas) ||
                other.lastCanvas == lastCanvas));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, nodeType, edgeId, startCanvas, lastCanvas);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$InsertNodeToEdgeImplCopyWith<_$InsertNodeToEdgeImpl> get copyWith =>
      __$$InsertNodeToEdgeImplCopyWithImpl<_$InsertNodeToEdgeImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() idle,
    required TResult Function(
            String nodeId,
            @OffsetConverter() Offset startCanvas,
            @OffsetConverter() Offset lastCanvas)
        dragNode,
    required TResult Function(
            String edgeId,
            String sourceNodeId,
            String sourceAnchorId,
            @OffsetConverter() Offset startCanvas,
            @OffsetConverter() Offset lastCanvas)
        dragEdge,
    required TResult Function(
            String edgeId,
            int pointIndex,
            @OffsetConverter() Offset originalPoint,
            @OffsetConverter() Offset startCanvas,
            @OffsetConverter() Offset lastCanvas)
        dragWaypoint,
    required TResult Function(@OffsetConverter() Offset startGlobal,
            @OffsetConverter() Offset lastGlobal)
        panCanvas,
    required TResult Function(@RectConverter() Rect selectionBox) selectingArea,
    required TResult Function(
            String nodeType,
            @OffsetConverter() Offset startCanvas,
            @OffsetConverter() Offset lastCanvas)
        insertingNode,
    required TResult Function(
            String nodeType,
            String edgeId,
            @OffsetConverter() Offset startCanvas,
            @OffsetConverter() Offset lastCanvas)
        insertNodeToEdge,
    required TResult Function(
            String nodeId,
            @OffsetConverter() Offset handlePosition,
            @OffsetConverter() Offset startCanvas,
            @OffsetConverter() Offset lastCanvas)
        resizingNode,
    required TResult Function(String nodeId) hoveringNode,
    required TResult Function(String nodeId, String anchorId) hoveringAnchor,
    required TResult Function(String edgeId) hoveringEdge,
    required TResult Function(
            @OffsetConverter() Offset globalPosition, String? targetId)
        contextMenuOpen,
    required TResult Function(NodeModel node,
            @OffsetConverter() Offset canvasPos, String? highlightedEdgeId)
        insertingNodePreview,
    required TResult Function(CanvasInsertElement groupElement,
            @OffsetConverter() Offset canvasPos, String? highlightedEdgeId)
        insertingGroupPreview,
  }) {
    return insertNodeToEdge(nodeType, edgeId, startCanvas, lastCanvas);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? idle,
    TResult? Function(String nodeId, @OffsetConverter() Offset startCanvas,
            @OffsetConverter() Offset lastCanvas)?
        dragNode,
    TResult? Function(
            String edgeId,
            String sourceNodeId,
            String sourceAnchorId,
            @OffsetConverter() Offset startCanvas,
            @OffsetConverter() Offset lastCanvas)?
        dragEdge,
    TResult? Function(
            String edgeId,
            int pointIndex,
            @OffsetConverter() Offset originalPoint,
            @OffsetConverter() Offset startCanvas,
            @OffsetConverter() Offset lastCanvas)?
        dragWaypoint,
    TResult? Function(@OffsetConverter() Offset startGlobal,
            @OffsetConverter() Offset lastGlobal)?
        panCanvas,
    TResult? Function(@RectConverter() Rect selectionBox)? selectingArea,
    TResult? Function(String nodeType, @OffsetConverter() Offset startCanvas,
            @OffsetConverter() Offset lastCanvas)?
        insertingNode,
    TResult? Function(
            String nodeType,
            String edgeId,
            @OffsetConverter() Offset startCanvas,
            @OffsetConverter() Offset lastCanvas)?
        insertNodeToEdge,
    TResult? Function(
            String nodeId,
            @OffsetConverter() Offset handlePosition,
            @OffsetConverter() Offset startCanvas,
            @OffsetConverter() Offset lastCanvas)?
        resizingNode,
    TResult? Function(String nodeId)? hoveringNode,
    TResult? Function(String nodeId, String anchorId)? hoveringAnchor,
    TResult? Function(String edgeId)? hoveringEdge,
    TResult? Function(
            @OffsetConverter() Offset globalPosition, String? targetId)?
        contextMenuOpen,
    TResult? Function(NodeModel node, @OffsetConverter() Offset canvasPos,
            String? highlightedEdgeId)?
        insertingNodePreview,
    TResult? Function(CanvasInsertElement groupElement,
            @OffsetConverter() Offset canvasPos, String? highlightedEdgeId)?
        insertingGroupPreview,
  }) {
    return insertNodeToEdge?.call(nodeType, edgeId, startCanvas, lastCanvas);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? idle,
    TResult Function(String nodeId, @OffsetConverter() Offset startCanvas,
            @OffsetConverter() Offset lastCanvas)?
        dragNode,
    TResult Function(
            String edgeId,
            String sourceNodeId,
            String sourceAnchorId,
            @OffsetConverter() Offset startCanvas,
            @OffsetConverter() Offset lastCanvas)?
        dragEdge,
    TResult Function(
            String edgeId,
            int pointIndex,
            @OffsetConverter() Offset originalPoint,
            @OffsetConverter() Offset startCanvas,
            @OffsetConverter() Offset lastCanvas)?
        dragWaypoint,
    TResult Function(@OffsetConverter() Offset startGlobal,
            @OffsetConverter() Offset lastGlobal)?
        panCanvas,
    TResult Function(@RectConverter() Rect selectionBox)? selectingArea,
    TResult Function(String nodeType, @OffsetConverter() Offset startCanvas,
            @OffsetConverter() Offset lastCanvas)?
        insertingNode,
    TResult Function(
            String nodeType,
            String edgeId,
            @OffsetConverter() Offset startCanvas,
            @OffsetConverter() Offset lastCanvas)?
        insertNodeToEdge,
    TResult Function(
            String nodeId,
            @OffsetConverter() Offset handlePosition,
            @OffsetConverter() Offset startCanvas,
            @OffsetConverter() Offset lastCanvas)?
        resizingNode,
    TResult Function(String nodeId)? hoveringNode,
    TResult Function(String nodeId, String anchorId)? hoveringAnchor,
    TResult Function(String edgeId)? hoveringEdge,
    TResult Function(
            @OffsetConverter() Offset globalPosition, String? targetId)?
        contextMenuOpen,
    TResult Function(NodeModel node, @OffsetConverter() Offset canvasPos,
            String? highlightedEdgeId)?
        insertingNodePreview,
    TResult Function(CanvasInsertElement groupElement,
            @OffsetConverter() Offset canvasPos, String? highlightedEdgeId)?
        insertingGroupPreview,
    required TResult orElse(),
  }) {
    if (insertNodeToEdge != null) {
      return insertNodeToEdge(nodeType, edgeId, startCanvas, lastCanvas);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(Idle value) idle,
    required TResult Function(DragNode value) dragNode,
    required TResult Function(DragEdge value) dragEdge,
    required TResult Function(DragWaypoint value) dragWaypoint,
    required TResult Function(PanCanvas value) panCanvas,
    required TResult Function(SelectingArea value) selectingArea,
    required TResult Function(InsertingNode value) insertingNode,
    required TResult Function(InsertNodeToEdge value) insertNodeToEdge,
    required TResult Function(ResizingNode value) resizingNode,
    required TResult Function(HoveringNode value) hoveringNode,
    required TResult Function(HoveringAnchor value) hoveringAnchor,
    required TResult Function(HoveringEdge value) hoveringEdge,
    required TResult Function(ContextMenuOpen value) contextMenuOpen,
    required TResult Function(InsertingNodePreview value) insertingNodePreview,
    required TResult Function(InsertingGroupPreview value)
        insertingGroupPreview,
  }) {
    return insertNodeToEdge(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(Idle value)? idle,
    TResult? Function(DragNode value)? dragNode,
    TResult? Function(DragEdge value)? dragEdge,
    TResult? Function(DragWaypoint value)? dragWaypoint,
    TResult? Function(PanCanvas value)? panCanvas,
    TResult? Function(SelectingArea value)? selectingArea,
    TResult? Function(InsertingNode value)? insertingNode,
    TResult? Function(InsertNodeToEdge value)? insertNodeToEdge,
    TResult? Function(ResizingNode value)? resizingNode,
    TResult? Function(HoveringNode value)? hoveringNode,
    TResult? Function(HoveringAnchor value)? hoveringAnchor,
    TResult? Function(HoveringEdge value)? hoveringEdge,
    TResult? Function(ContextMenuOpen value)? contextMenuOpen,
    TResult? Function(InsertingNodePreview value)? insertingNodePreview,
    TResult? Function(InsertingGroupPreview value)? insertingGroupPreview,
  }) {
    return insertNodeToEdge?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(Idle value)? idle,
    TResult Function(DragNode value)? dragNode,
    TResult Function(DragEdge value)? dragEdge,
    TResult Function(DragWaypoint value)? dragWaypoint,
    TResult Function(PanCanvas value)? panCanvas,
    TResult Function(SelectingArea value)? selectingArea,
    TResult Function(InsertingNode value)? insertingNode,
    TResult Function(InsertNodeToEdge value)? insertNodeToEdge,
    TResult Function(ResizingNode value)? resizingNode,
    TResult Function(HoveringNode value)? hoveringNode,
    TResult Function(HoveringAnchor value)? hoveringAnchor,
    TResult Function(HoveringEdge value)? hoveringEdge,
    TResult Function(ContextMenuOpen value)? contextMenuOpen,
    TResult Function(InsertingNodePreview value)? insertingNodePreview,
    TResult Function(InsertingGroupPreview value)? insertingGroupPreview,
    required TResult orElse(),
  }) {
    if (insertNodeToEdge != null) {
      return insertNodeToEdge(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$InsertNodeToEdgeImplToJson(
      this,
    );
  }
}

abstract class InsertNodeToEdge extends InteractionState {
  const factory InsertNodeToEdge(
          {required final String nodeType,
          required final String edgeId,
          @OffsetConverter() required final Offset startCanvas,
          @OffsetConverter() required final Offset lastCanvas}) =
      _$InsertNodeToEdgeImpl;
  const InsertNodeToEdge._() : super._();

  factory InsertNodeToEdge.fromJson(Map<String, dynamic> json) =
      _$InsertNodeToEdgeImpl.fromJson;

  String get nodeType;
  String get edgeId;
  @OffsetConverter()
  Offset get startCanvas;
  @OffsetConverter()
  Offset get lastCanvas;
  @JsonKey(ignore: true)
  _$$InsertNodeToEdgeImplCopyWith<_$InsertNodeToEdgeImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ResizingNodeImplCopyWith<$Res> {
  factory _$$ResizingNodeImplCopyWith(
          _$ResizingNodeImpl value, $Res Function(_$ResizingNodeImpl) then) =
      __$$ResizingNodeImplCopyWithImpl<$Res>;
  @useResult
  $Res call(
      {String nodeId,
      @OffsetConverter() Offset handlePosition,
      @OffsetConverter() Offset startCanvas,
      @OffsetConverter() Offset lastCanvas});
}

/// @nodoc
class __$$ResizingNodeImplCopyWithImpl<$Res>
    extends _$InteractionStateCopyWithImpl<$Res, _$ResizingNodeImpl>
    implements _$$ResizingNodeImplCopyWith<$Res> {
  __$$ResizingNodeImplCopyWithImpl(
      _$ResizingNodeImpl _value, $Res Function(_$ResizingNodeImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? nodeId = null,
    Object? handlePosition = null,
    Object? startCanvas = null,
    Object? lastCanvas = null,
  }) {
    return _then(_$ResizingNodeImpl(
      nodeId: null == nodeId
          ? _value.nodeId
          : nodeId // ignore: cast_nullable_to_non_nullable
              as String,
      handlePosition: null == handlePosition
          ? _value.handlePosition
          : handlePosition // ignore: cast_nullable_to_non_nullable
              as Offset,
      startCanvas: null == startCanvas
          ? _value.startCanvas
          : startCanvas // ignore: cast_nullable_to_non_nullable
              as Offset,
      lastCanvas: null == lastCanvas
          ? _value.lastCanvas
          : lastCanvas // ignore: cast_nullable_to_non_nullable
              as Offset,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ResizingNodeImpl extends ResizingNode {
  const _$ResizingNodeImpl(
      {required this.nodeId,
      @OffsetConverter() required this.handlePosition,
      @OffsetConverter() required this.startCanvas,
      @OffsetConverter() required this.lastCanvas,
      final String? $type})
      : $type = $type ?? 'resizing_node',
        super._();

  factory _$ResizingNodeImpl.fromJson(Map<String, dynamic> json) =>
      _$$ResizingNodeImplFromJson(json);

  @override
  final String nodeId;
  @override
  @OffsetConverter()
  final Offset handlePosition;
  @override
  @OffsetConverter()
  final Offset startCanvas;
  @override
  @OffsetConverter()
  final Offset lastCanvas;

  @JsonKey(name: 'type')
  final String $type;

  @override
  String toString() {
    return 'InteractionState.resizingNode(nodeId: $nodeId, handlePosition: $handlePosition, startCanvas: $startCanvas, lastCanvas: $lastCanvas)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ResizingNodeImpl &&
            (identical(other.nodeId, nodeId) || other.nodeId == nodeId) &&
            (identical(other.handlePosition, handlePosition) ||
                other.handlePosition == handlePosition) &&
            (identical(other.startCanvas, startCanvas) ||
                other.startCanvas == startCanvas) &&
            (identical(other.lastCanvas, lastCanvas) ||
                other.lastCanvas == lastCanvas));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, nodeId, handlePosition, startCanvas, lastCanvas);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ResizingNodeImplCopyWith<_$ResizingNodeImpl> get copyWith =>
      __$$ResizingNodeImplCopyWithImpl<_$ResizingNodeImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() idle,
    required TResult Function(
            String nodeId,
            @OffsetConverter() Offset startCanvas,
            @OffsetConverter() Offset lastCanvas)
        dragNode,
    required TResult Function(
            String edgeId,
            String sourceNodeId,
            String sourceAnchorId,
            @OffsetConverter() Offset startCanvas,
            @OffsetConverter() Offset lastCanvas)
        dragEdge,
    required TResult Function(
            String edgeId,
            int pointIndex,
            @OffsetConverter() Offset originalPoint,
            @OffsetConverter() Offset startCanvas,
            @OffsetConverter() Offset lastCanvas)
        dragWaypoint,
    required TResult Function(@OffsetConverter() Offset startGlobal,
            @OffsetConverter() Offset lastGlobal)
        panCanvas,
    required TResult Function(@RectConverter() Rect selectionBox) selectingArea,
    required TResult Function(
            String nodeType,
            @OffsetConverter() Offset startCanvas,
            @OffsetConverter() Offset lastCanvas)
        insertingNode,
    required TResult Function(
            String nodeType,
            String edgeId,
            @OffsetConverter() Offset startCanvas,
            @OffsetConverter() Offset lastCanvas)
        insertNodeToEdge,
    required TResult Function(
            String nodeId,
            @OffsetConverter() Offset handlePosition,
            @OffsetConverter() Offset startCanvas,
            @OffsetConverter() Offset lastCanvas)
        resizingNode,
    required TResult Function(String nodeId) hoveringNode,
    required TResult Function(String nodeId, String anchorId) hoveringAnchor,
    required TResult Function(String edgeId) hoveringEdge,
    required TResult Function(
            @OffsetConverter() Offset globalPosition, String? targetId)
        contextMenuOpen,
    required TResult Function(NodeModel node,
            @OffsetConverter() Offset canvasPos, String? highlightedEdgeId)
        insertingNodePreview,
    required TResult Function(CanvasInsertElement groupElement,
            @OffsetConverter() Offset canvasPos, String? highlightedEdgeId)
        insertingGroupPreview,
  }) {
    return resizingNode(nodeId, handlePosition, startCanvas, lastCanvas);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? idle,
    TResult? Function(String nodeId, @OffsetConverter() Offset startCanvas,
            @OffsetConverter() Offset lastCanvas)?
        dragNode,
    TResult? Function(
            String edgeId,
            String sourceNodeId,
            String sourceAnchorId,
            @OffsetConverter() Offset startCanvas,
            @OffsetConverter() Offset lastCanvas)?
        dragEdge,
    TResult? Function(
            String edgeId,
            int pointIndex,
            @OffsetConverter() Offset originalPoint,
            @OffsetConverter() Offset startCanvas,
            @OffsetConverter() Offset lastCanvas)?
        dragWaypoint,
    TResult? Function(@OffsetConverter() Offset startGlobal,
            @OffsetConverter() Offset lastGlobal)?
        panCanvas,
    TResult? Function(@RectConverter() Rect selectionBox)? selectingArea,
    TResult? Function(String nodeType, @OffsetConverter() Offset startCanvas,
            @OffsetConverter() Offset lastCanvas)?
        insertingNode,
    TResult? Function(
            String nodeType,
            String edgeId,
            @OffsetConverter() Offset startCanvas,
            @OffsetConverter() Offset lastCanvas)?
        insertNodeToEdge,
    TResult? Function(
            String nodeId,
            @OffsetConverter() Offset handlePosition,
            @OffsetConverter() Offset startCanvas,
            @OffsetConverter() Offset lastCanvas)?
        resizingNode,
    TResult? Function(String nodeId)? hoveringNode,
    TResult? Function(String nodeId, String anchorId)? hoveringAnchor,
    TResult? Function(String edgeId)? hoveringEdge,
    TResult? Function(
            @OffsetConverter() Offset globalPosition, String? targetId)?
        contextMenuOpen,
    TResult? Function(NodeModel node, @OffsetConverter() Offset canvasPos,
            String? highlightedEdgeId)?
        insertingNodePreview,
    TResult? Function(CanvasInsertElement groupElement,
            @OffsetConverter() Offset canvasPos, String? highlightedEdgeId)?
        insertingGroupPreview,
  }) {
    return resizingNode?.call(nodeId, handlePosition, startCanvas, lastCanvas);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? idle,
    TResult Function(String nodeId, @OffsetConverter() Offset startCanvas,
            @OffsetConverter() Offset lastCanvas)?
        dragNode,
    TResult Function(
            String edgeId,
            String sourceNodeId,
            String sourceAnchorId,
            @OffsetConverter() Offset startCanvas,
            @OffsetConverter() Offset lastCanvas)?
        dragEdge,
    TResult Function(
            String edgeId,
            int pointIndex,
            @OffsetConverter() Offset originalPoint,
            @OffsetConverter() Offset startCanvas,
            @OffsetConverter() Offset lastCanvas)?
        dragWaypoint,
    TResult Function(@OffsetConverter() Offset startGlobal,
            @OffsetConverter() Offset lastGlobal)?
        panCanvas,
    TResult Function(@RectConverter() Rect selectionBox)? selectingArea,
    TResult Function(String nodeType, @OffsetConverter() Offset startCanvas,
            @OffsetConverter() Offset lastCanvas)?
        insertingNode,
    TResult Function(
            String nodeType,
            String edgeId,
            @OffsetConverter() Offset startCanvas,
            @OffsetConverter() Offset lastCanvas)?
        insertNodeToEdge,
    TResult Function(
            String nodeId,
            @OffsetConverter() Offset handlePosition,
            @OffsetConverter() Offset startCanvas,
            @OffsetConverter() Offset lastCanvas)?
        resizingNode,
    TResult Function(String nodeId)? hoveringNode,
    TResult Function(String nodeId, String anchorId)? hoveringAnchor,
    TResult Function(String edgeId)? hoveringEdge,
    TResult Function(
            @OffsetConverter() Offset globalPosition, String? targetId)?
        contextMenuOpen,
    TResult Function(NodeModel node, @OffsetConverter() Offset canvasPos,
            String? highlightedEdgeId)?
        insertingNodePreview,
    TResult Function(CanvasInsertElement groupElement,
            @OffsetConverter() Offset canvasPos, String? highlightedEdgeId)?
        insertingGroupPreview,
    required TResult orElse(),
  }) {
    if (resizingNode != null) {
      return resizingNode(nodeId, handlePosition, startCanvas, lastCanvas);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(Idle value) idle,
    required TResult Function(DragNode value) dragNode,
    required TResult Function(DragEdge value) dragEdge,
    required TResult Function(DragWaypoint value) dragWaypoint,
    required TResult Function(PanCanvas value) panCanvas,
    required TResult Function(SelectingArea value) selectingArea,
    required TResult Function(InsertingNode value) insertingNode,
    required TResult Function(InsertNodeToEdge value) insertNodeToEdge,
    required TResult Function(ResizingNode value) resizingNode,
    required TResult Function(HoveringNode value) hoveringNode,
    required TResult Function(HoveringAnchor value) hoveringAnchor,
    required TResult Function(HoveringEdge value) hoveringEdge,
    required TResult Function(ContextMenuOpen value) contextMenuOpen,
    required TResult Function(InsertingNodePreview value) insertingNodePreview,
    required TResult Function(InsertingGroupPreview value)
        insertingGroupPreview,
  }) {
    return resizingNode(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(Idle value)? idle,
    TResult? Function(DragNode value)? dragNode,
    TResult? Function(DragEdge value)? dragEdge,
    TResult? Function(DragWaypoint value)? dragWaypoint,
    TResult? Function(PanCanvas value)? panCanvas,
    TResult? Function(SelectingArea value)? selectingArea,
    TResult? Function(InsertingNode value)? insertingNode,
    TResult? Function(InsertNodeToEdge value)? insertNodeToEdge,
    TResult? Function(ResizingNode value)? resizingNode,
    TResult? Function(HoveringNode value)? hoveringNode,
    TResult? Function(HoveringAnchor value)? hoveringAnchor,
    TResult? Function(HoveringEdge value)? hoveringEdge,
    TResult? Function(ContextMenuOpen value)? contextMenuOpen,
    TResult? Function(InsertingNodePreview value)? insertingNodePreview,
    TResult? Function(InsertingGroupPreview value)? insertingGroupPreview,
  }) {
    return resizingNode?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(Idle value)? idle,
    TResult Function(DragNode value)? dragNode,
    TResult Function(DragEdge value)? dragEdge,
    TResult Function(DragWaypoint value)? dragWaypoint,
    TResult Function(PanCanvas value)? panCanvas,
    TResult Function(SelectingArea value)? selectingArea,
    TResult Function(InsertingNode value)? insertingNode,
    TResult Function(InsertNodeToEdge value)? insertNodeToEdge,
    TResult Function(ResizingNode value)? resizingNode,
    TResult Function(HoveringNode value)? hoveringNode,
    TResult Function(HoveringAnchor value)? hoveringAnchor,
    TResult Function(HoveringEdge value)? hoveringEdge,
    TResult Function(ContextMenuOpen value)? contextMenuOpen,
    TResult Function(InsertingNodePreview value)? insertingNodePreview,
    TResult Function(InsertingGroupPreview value)? insertingGroupPreview,
    required TResult orElse(),
  }) {
    if (resizingNode != null) {
      return resizingNode(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$ResizingNodeImplToJson(
      this,
    );
  }
}

abstract class ResizingNode extends InteractionState {
  const factory ResizingNode(
          {required final String nodeId,
          @OffsetConverter() required final Offset handlePosition,
          @OffsetConverter() required final Offset startCanvas,
          @OffsetConverter() required final Offset lastCanvas}) =
      _$ResizingNodeImpl;
  const ResizingNode._() : super._();

  factory ResizingNode.fromJson(Map<String, dynamic> json) =
      _$ResizingNodeImpl.fromJson;

  String get nodeId;
  @OffsetConverter()
  Offset get handlePosition;
  @OffsetConverter()
  Offset get startCanvas;
  @OffsetConverter()
  Offset get lastCanvas;
  @JsonKey(ignore: true)
  _$$ResizingNodeImplCopyWith<_$ResizingNodeImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$HoveringNodeImplCopyWith<$Res> {
  factory _$$HoveringNodeImplCopyWith(
          _$HoveringNodeImpl value, $Res Function(_$HoveringNodeImpl) then) =
      __$$HoveringNodeImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String nodeId});
}

/// @nodoc
class __$$HoveringNodeImplCopyWithImpl<$Res>
    extends _$InteractionStateCopyWithImpl<$Res, _$HoveringNodeImpl>
    implements _$$HoveringNodeImplCopyWith<$Res> {
  __$$HoveringNodeImplCopyWithImpl(
      _$HoveringNodeImpl _value, $Res Function(_$HoveringNodeImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? nodeId = null,
  }) {
    return _then(_$HoveringNodeImpl(
      nodeId: null == nodeId
          ? _value.nodeId
          : nodeId // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$HoveringNodeImpl extends HoveringNode {
  const _$HoveringNodeImpl({required this.nodeId, final String? $type})
      : $type = $type ?? 'hovering_node',
        super._();

  factory _$HoveringNodeImpl.fromJson(Map<String, dynamic> json) =>
      _$$HoveringNodeImplFromJson(json);

  @override
  final String nodeId;

  @JsonKey(name: 'type')
  final String $type;

  @override
  String toString() {
    return 'InteractionState.hoveringNode(nodeId: $nodeId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$HoveringNodeImpl &&
            (identical(other.nodeId, nodeId) || other.nodeId == nodeId));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, nodeId);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$HoveringNodeImplCopyWith<_$HoveringNodeImpl> get copyWith =>
      __$$HoveringNodeImplCopyWithImpl<_$HoveringNodeImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() idle,
    required TResult Function(
            String nodeId,
            @OffsetConverter() Offset startCanvas,
            @OffsetConverter() Offset lastCanvas)
        dragNode,
    required TResult Function(
            String edgeId,
            String sourceNodeId,
            String sourceAnchorId,
            @OffsetConverter() Offset startCanvas,
            @OffsetConverter() Offset lastCanvas)
        dragEdge,
    required TResult Function(
            String edgeId,
            int pointIndex,
            @OffsetConverter() Offset originalPoint,
            @OffsetConverter() Offset startCanvas,
            @OffsetConverter() Offset lastCanvas)
        dragWaypoint,
    required TResult Function(@OffsetConverter() Offset startGlobal,
            @OffsetConverter() Offset lastGlobal)
        panCanvas,
    required TResult Function(@RectConverter() Rect selectionBox) selectingArea,
    required TResult Function(
            String nodeType,
            @OffsetConverter() Offset startCanvas,
            @OffsetConverter() Offset lastCanvas)
        insertingNode,
    required TResult Function(
            String nodeType,
            String edgeId,
            @OffsetConverter() Offset startCanvas,
            @OffsetConverter() Offset lastCanvas)
        insertNodeToEdge,
    required TResult Function(
            String nodeId,
            @OffsetConverter() Offset handlePosition,
            @OffsetConverter() Offset startCanvas,
            @OffsetConverter() Offset lastCanvas)
        resizingNode,
    required TResult Function(String nodeId) hoveringNode,
    required TResult Function(String nodeId, String anchorId) hoveringAnchor,
    required TResult Function(String edgeId) hoveringEdge,
    required TResult Function(
            @OffsetConverter() Offset globalPosition, String? targetId)
        contextMenuOpen,
    required TResult Function(NodeModel node,
            @OffsetConverter() Offset canvasPos, String? highlightedEdgeId)
        insertingNodePreview,
    required TResult Function(CanvasInsertElement groupElement,
            @OffsetConverter() Offset canvasPos, String? highlightedEdgeId)
        insertingGroupPreview,
  }) {
    return hoveringNode(nodeId);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? idle,
    TResult? Function(String nodeId, @OffsetConverter() Offset startCanvas,
            @OffsetConverter() Offset lastCanvas)?
        dragNode,
    TResult? Function(
            String edgeId,
            String sourceNodeId,
            String sourceAnchorId,
            @OffsetConverter() Offset startCanvas,
            @OffsetConverter() Offset lastCanvas)?
        dragEdge,
    TResult? Function(
            String edgeId,
            int pointIndex,
            @OffsetConverter() Offset originalPoint,
            @OffsetConverter() Offset startCanvas,
            @OffsetConverter() Offset lastCanvas)?
        dragWaypoint,
    TResult? Function(@OffsetConverter() Offset startGlobal,
            @OffsetConverter() Offset lastGlobal)?
        panCanvas,
    TResult? Function(@RectConverter() Rect selectionBox)? selectingArea,
    TResult? Function(String nodeType, @OffsetConverter() Offset startCanvas,
            @OffsetConverter() Offset lastCanvas)?
        insertingNode,
    TResult? Function(
            String nodeType,
            String edgeId,
            @OffsetConverter() Offset startCanvas,
            @OffsetConverter() Offset lastCanvas)?
        insertNodeToEdge,
    TResult? Function(
            String nodeId,
            @OffsetConverter() Offset handlePosition,
            @OffsetConverter() Offset startCanvas,
            @OffsetConverter() Offset lastCanvas)?
        resizingNode,
    TResult? Function(String nodeId)? hoveringNode,
    TResult? Function(String nodeId, String anchorId)? hoveringAnchor,
    TResult? Function(String edgeId)? hoveringEdge,
    TResult? Function(
            @OffsetConverter() Offset globalPosition, String? targetId)?
        contextMenuOpen,
    TResult? Function(NodeModel node, @OffsetConverter() Offset canvasPos,
            String? highlightedEdgeId)?
        insertingNodePreview,
    TResult? Function(CanvasInsertElement groupElement,
            @OffsetConverter() Offset canvasPos, String? highlightedEdgeId)?
        insertingGroupPreview,
  }) {
    return hoveringNode?.call(nodeId);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? idle,
    TResult Function(String nodeId, @OffsetConverter() Offset startCanvas,
            @OffsetConverter() Offset lastCanvas)?
        dragNode,
    TResult Function(
            String edgeId,
            String sourceNodeId,
            String sourceAnchorId,
            @OffsetConverter() Offset startCanvas,
            @OffsetConverter() Offset lastCanvas)?
        dragEdge,
    TResult Function(
            String edgeId,
            int pointIndex,
            @OffsetConverter() Offset originalPoint,
            @OffsetConverter() Offset startCanvas,
            @OffsetConverter() Offset lastCanvas)?
        dragWaypoint,
    TResult Function(@OffsetConverter() Offset startGlobal,
            @OffsetConverter() Offset lastGlobal)?
        panCanvas,
    TResult Function(@RectConverter() Rect selectionBox)? selectingArea,
    TResult Function(String nodeType, @OffsetConverter() Offset startCanvas,
            @OffsetConverter() Offset lastCanvas)?
        insertingNode,
    TResult Function(
            String nodeType,
            String edgeId,
            @OffsetConverter() Offset startCanvas,
            @OffsetConverter() Offset lastCanvas)?
        insertNodeToEdge,
    TResult Function(
            String nodeId,
            @OffsetConverter() Offset handlePosition,
            @OffsetConverter() Offset startCanvas,
            @OffsetConverter() Offset lastCanvas)?
        resizingNode,
    TResult Function(String nodeId)? hoveringNode,
    TResult Function(String nodeId, String anchorId)? hoveringAnchor,
    TResult Function(String edgeId)? hoveringEdge,
    TResult Function(
            @OffsetConverter() Offset globalPosition, String? targetId)?
        contextMenuOpen,
    TResult Function(NodeModel node, @OffsetConverter() Offset canvasPos,
            String? highlightedEdgeId)?
        insertingNodePreview,
    TResult Function(CanvasInsertElement groupElement,
            @OffsetConverter() Offset canvasPos, String? highlightedEdgeId)?
        insertingGroupPreview,
    required TResult orElse(),
  }) {
    if (hoveringNode != null) {
      return hoveringNode(nodeId);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(Idle value) idle,
    required TResult Function(DragNode value) dragNode,
    required TResult Function(DragEdge value) dragEdge,
    required TResult Function(DragWaypoint value) dragWaypoint,
    required TResult Function(PanCanvas value) panCanvas,
    required TResult Function(SelectingArea value) selectingArea,
    required TResult Function(InsertingNode value) insertingNode,
    required TResult Function(InsertNodeToEdge value) insertNodeToEdge,
    required TResult Function(ResizingNode value) resizingNode,
    required TResult Function(HoveringNode value) hoveringNode,
    required TResult Function(HoveringAnchor value) hoveringAnchor,
    required TResult Function(HoveringEdge value) hoveringEdge,
    required TResult Function(ContextMenuOpen value) contextMenuOpen,
    required TResult Function(InsertingNodePreview value) insertingNodePreview,
    required TResult Function(InsertingGroupPreview value)
        insertingGroupPreview,
  }) {
    return hoveringNode(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(Idle value)? idle,
    TResult? Function(DragNode value)? dragNode,
    TResult? Function(DragEdge value)? dragEdge,
    TResult? Function(DragWaypoint value)? dragWaypoint,
    TResult? Function(PanCanvas value)? panCanvas,
    TResult? Function(SelectingArea value)? selectingArea,
    TResult? Function(InsertingNode value)? insertingNode,
    TResult? Function(InsertNodeToEdge value)? insertNodeToEdge,
    TResult? Function(ResizingNode value)? resizingNode,
    TResult? Function(HoveringNode value)? hoveringNode,
    TResult? Function(HoveringAnchor value)? hoveringAnchor,
    TResult? Function(HoveringEdge value)? hoveringEdge,
    TResult? Function(ContextMenuOpen value)? contextMenuOpen,
    TResult? Function(InsertingNodePreview value)? insertingNodePreview,
    TResult? Function(InsertingGroupPreview value)? insertingGroupPreview,
  }) {
    return hoveringNode?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(Idle value)? idle,
    TResult Function(DragNode value)? dragNode,
    TResult Function(DragEdge value)? dragEdge,
    TResult Function(DragWaypoint value)? dragWaypoint,
    TResult Function(PanCanvas value)? panCanvas,
    TResult Function(SelectingArea value)? selectingArea,
    TResult Function(InsertingNode value)? insertingNode,
    TResult Function(InsertNodeToEdge value)? insertNodeToEdge,
    TResult Function(ResizingNode value)? resizingNode,
    TResult Function(HoveringNode value)? hoveringNode,
    TResult Function(HoveringAnchor value)? hoveringAnchor,
    TResult Function(HoveringEdge value)? hoveringEdge,
    TResult Function(ContextMenuOpen value)? contextMenuOpen,
    TResult Function(InsertingNodePreview value)? insertingNodePreview,
    TResult Function(InsertingGroupPreview value)? insertingGroupPreview,
    required TResult orElse(),
  }) {
    if (hoveringNode != null) {
      return hoveringNode(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$HoveringNodeImplToJson(
      this,
    );
  }
}

abstract class HoveringNode extends InteractionState {
  const factory HoveringNode({required final String nodeId}) =
      _$HoveringNodeImpl;
  const HoveringNode._() : super._();

  factory HoveringNode.fromJson(Map<String, dynamic> json) =
      _$HoveringNodeImpl.fromJson;

  String get nodeId;
  @JsonKey(ignore: true)
  _$$HoveringNodeImplCopyWith<_$HoveringNodeImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$HoveringAnchorImplCopyWith<$Res> {
  factory _$$HoveringAnchorImplCopyWith(_$HoveringAnchorImpl value,
          $Res Function(_$HoveringAnchorImpl) then) =
      __$$HoveringAnchorImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String nodeId, String anchorId});
}

/// @nodoc
class __$$HoveringAnchorImplCopyWithImpl<$Res>
    extends _$InteractionStateCopyWithImpl<$Res, _$HoveringAnchorImpl>
    implements _$$HoveringAnchorImplCopyWith<$Res> {
  __$$HoveringAnchorImplCopyWithImpl(
      _$HoveringAnchorImpl _value, $Res Function(_$HoveringAnchorImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? nodeId = null,
    Object? anchorId = null,
  }) {
    return _then(_$HoveringAnchorImpl(
      nodeId: null == nodeId
          ? _value.nodeId
          : nodeId // ignore: cast_nullable_to_non_nullable
              as String,
      anchorId: null == anchorId
          ? _value.anchorId
          : anchorId // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$HoveringAnchorImpl extends HoveringAnchor {
  const _$HoveringAnchorImpl(
      {required this.nodeId, required this.anchorId, final String? $type})
      : $type = $type ?? 'hovering_anchor',
        super._();

  factory _$HoveringAnchorImpl.fromJson(Map<String, dynamic> json) =>
      _$$HoveringAnchorImplFromJson(json);

  @override
  final String nodeId;
  @override
  final String anchorId;

  @JsonKey(name: 'type')
  final String $type;

  @override
  String toString() {
    return 'InteractionState.hoveringAnchor(nodeId: $nodeId, anchorId: $anchorId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$HoveringAnchorImpl &&
            (identical(other.nodeId, nodeId) || other.nodeId == nodeId) &&
            (identical(other.anchorId, anchorId) ||
                other.anchorId == anchorId));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, nodeId, anchorId);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$HoveringAnchorImplCopyWith<_$HoveringAnchorImpl> get copyWith =>
      __$$HoveringAnchorImplCopyWithImpl<_$HoveringAnchorImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() idle,
    required TResult Function(
            String nodeId,
            @OffsetConverter() Offset startCanvas,
            @OffsetConverter() Offset lastCanvas)
        dragNode,
    required TResult Function(
            String edgeId,
            String sourceNodeId,
            String sourceAnchorId,
            @OffsetConverter() Offset startCanvas,
            @OffsetConverter() Offset lastCanvas)
        dragEdge,
    required TResult Function(
            String edgeId,
            int pointIndex,
            @OffsetConverter() Offset originalPoint,
            @OffsetConverter() Offset startCanvas,
            @OffsetConverter() Offset lastCanvas)
        dragWaypoint,
    required TResult Function(@OffsetConverter() Offset startGlobal,
            @OffsetConverter() Offset lastGlobal)
        panCanvas,
    required TResult Function(@RectConverter() Rect selectionBox) selectingArea,
    required TResult Function(
            String nodeType,
            @OffsetConverter() Offset startCanvas,
            @OffsetConverter() Offset lastCanvas)
        insertingNode,
    required TResult Function(
            String nodeType,
            String edgeId,
            @OffsetConverter() Offset startCanvas,
            @OffsetConverter() Offset lastCanvas)
        insertNodeToEdge,
    required TResult Function(
            String nodeId,
            @OffsetConverter() Offset handlePosition,
            @OffsetConverter() Offset startCanvas,
            @OffsetConverter() Offset lastCanvas)
        resizingNode,
    required TResult Function(String nodeId) hoveringNode,
    required TResult Function(String nodeId, String anchorId) hoveringAnchor,
    required TResult Function(String edgeId) hoveringEdge,
    required TResult Function(
            @OffsetConverter() Offset globalPosition, String? targetId)
        contextMenuOpen,
    required TResult Function(NodeModel node,
            @OffsetConverter() Offset canvasPos, String? highlightedEdgeId)
        insertingNodePreview,
    required TResult Function(CanvasInsertElement groupElement,
            @OffsetConverter() Offset canvasPos, String? highlightedEdgeId)
        insertingGroupPreview,
  }) {
    return hoveringAnchor(nodeId, anchorId);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? idle,
    TResult? Function(String nodeId, @OffsetConverter() Offset startCanvas,
            @OffsetConverter() Offset lastCanvas)?
        dragNode,
    TResult? Function(
            String edgeId,
            String sourceNodeId,
            String sourceAnchorId,
            @OffsetConverter() Offset startCanvas,
            @OffsetConverter() Offset lastCanvas)?
        dragEdge,
    TResult? Function(
            String edgeId,
            int pointIndex,
            @OffsetConverter() Offset originalPoint,
            @OffsetConverter() Offset startCanvas,
            @OffsetConverter() Offset lastCanvas)?
        dragWaypoint,
    TResult? Function(@OffsetConverter() Offset startGlobal,
            @OffsetConverter() Offset lastGlobal)?
        panCanvas,
    TResult? Function(@RectConverter() Rect selectionBox)? selectingArea,
    TResult? Function(String nodeType, @OffsetConverter() Offset startCanvas,
            @OffsetConverter() Offset lastCanvas)?
        insertingNode,
    TResult? Function(
            String nodeType,
            String edgeId,
            @OffsetConverter() Offset startCanvas,
            @OffsetConverter() Offset lastCanvas)?
        insertNodeToEdge,
    TResult? Function(
            String nodeId,
            @OffsetConverter() Offset handlePosition,
            @OffsetConverter() Offset startCanvas,
            @OffsetConverter() Offset lastCanvas)?
        resizingNode,
    TResult? Function(String nodeId)? hoveringNode,
    TResult? Function(String nodeId, String anchorId)? hoveringAnchor,
    TResult? Function(String edgeId)? hoveringEdge,
    TResult? Function(
            @OffsetConverter() Offset globalPosition, String? targetId)?
        contextMenuOpen,
    TResult? Function(NodeModel node, @OffsetConverter() Offset canvasPos,
            String? highlightedEdgeId)?
        insertingNodePreview,
    TResult? Function(CanvasInsertElement groupElement,
            @OffsetConverter() Offset canvasPos, String? highlightedEdgeId)?
        insertingGroupPreview,
  }) {
    return hoveringAnchor?.call(nodeId, anchorId);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? idle,
    TResult Function(String nodeId, @OffsetConverter() Offset startCanvas,
            @OffsetConverter() Offset lastCanvas)?
        dragNode,
    TResult Function(
            String edgeId,
            String sourceNodeId,
            String sourceAnchorId,
            @OffsetConverter() Offset startCanvas,
            @OffsetConverter() Offset lastCanvas)?
        dragEdge,
    TResult Function(
            String edgeId,
            int pointIndex,
            @OffsetConverter() Offset originalPoint,
            @OffsetConverter() Offset startCanvas,
            @OffsetConverter() Offset lastCanvas)?
        dragWaypoint,
    TResult Function(@OffsetConverter() Offset startGlobal,
            @OffsetConverter() Offset lastGlobal)?
        panCanvas,
    TResult Function(@RectConverter() Rect selectionBox)? selectingArea,
    TResult Function(String nodeType, @OffsetConverter() Offset startCanvas,
            @OffsetConverter() Offset lastCanvas)?
        insertingNode,
    TResult Function(
            String nodeType,
            String edgeId,
            @OffsetConverter() Offset startCanvas,
            @OffsetConverter() Offset lastCanvas)?
        insertNodeToEdge,
    TResult Function(
            String nodeId,
            @OffsetConverter() Offset handlePosition,
            @OffsetConverter() Offset startCanvas,
            @OffsetConverter() Offset lastCanvas)?
        resizingNode,
    TResult Function(String nodeId)? hoveringNode,
    TResult Function(String nodeId, String anchorId)? hoveringAnchor,
    TResult Function(String edgeId)? hoveringEdge,
    TResult Function(
            @OffsetConverter() Offset globalPosition, String? targetId)?
        contextMenuOpen,
    TResult Function(NodeModel node, @OffsetConverter() Offset canvasPos,
            String? highlightedEdgeId)?
        insertingNodePreview,
    TResult Function(CanvasInsertElement groupElement,
            @OffsetConverter() Offset canvasPos, String? highlightedEdgeId)?
        insertingGroupPreview,
    required TResult orElse(),
  }) {
    if (hoveringAnchor != null) {
      return hoveringAnchor(nodeId, anchorId);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(Idle value) idle,
    required TResult Function(DragNode value) dragNode,
    required TResult Function(DragEdge value) dragEdge,
    required TResult Function(DragWaypoint value) dragWaypoint,
    required TResult Function(PanCanvas value) panCanvas,
    required TResult Function(SelectingArea value) selectingArea,
    required TResult Function(InsertingNode value) insertingNode,
    required TResult Function(InsertNodeToEdge value) insertNodeToEdge,
    required TResult Function(ResizingNode value) resizingNode,
    required TResult Function(HoveringNode value) hoveringNode,
    required TResult Function(HoveringAnchor value) hoveringAnchor,
    required TResult Function(HoveringEdge value) hoveringEdge,
    required TResult Function(ContextMenuOpen value) contextMenuOpen,
    required TResult Function(InsertingNodePreview value) insertingNodePreview,
    required TResult Function(InsertingGroupPreview value)
        insertingGroupPreview,
  }) {
    return hoveringAnchor(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(Idle value)? idle,
    TResult? Function(DragNode value)? dragNode,
    TResult? Function(DragEdge value)? dragEdge,
    TResult? Function(DragWaypoint value)? dragWaypoint,
    TResult? Function(PanCanvas value)? panCanvas,
    TResult? Function(SelectingArea value)? selectingArea,
    TResult? Function(InsertingNode value)? insertingNode,
    TResult? Function(InsertNodeToEdge value)? insertNodeToEdge,
    TResult? Function(ResizingNode value)? resizingNode,
    TResult? Function(HoveringNode value)? hoveringNode,
    TResult? Function(HoveringAnchor value)? hoveringAnchor,
    TResult? Function(HoveringEdge value)? hoveringEdge,
    TResult? Function(ContextMenuOpen value)? contextMenuOpen,
    TResult? Function(InsertingNodePreview value)? insertingNodePreview,
    TResult? Function(InsertingGroupPreview value)? insertingGroupPreview,
  }) {
    return hoveringAnchor?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(Idle value)? idle,
    TResult Function(DragNode value)? dragNode,
    TResult Function(DragEdge value)? dragEdge,
    TResult Function(DragWaypoint value)? dragWaypoint,
    TResult Function(PanCanvas value)? panCanvas,
    TResult Function(SelectingArea value)? selectingArea,
    TResult Function(InsertingNode value)? insertingNode,
    TResult Function(InsertNodeToEdge value)? insertNodeToEdge,
    TResult Function(ResizingNode value)? resizingNode,
    TResult Function(HoveringNode value)? hoveringNode,
    TResult Function(HoveringAnchor value)? hoveringAnchor,
    TResult Function(HoveringEdge value)? hoveringEdge,
    TResult Function(ContextMenuOpen value)? contextMenuOpen,
    TResult Function(InsertingNodePreview value)? insertingNodePreview,
    TResult Function(InsertingGroupPreview value)? insertingGroupPreview,
    required TResult orElse(),
  }) {
    if (hoveringAnchor != null) {
      return hoveringAnchor(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$HoveringAnchorImplToJson(
      this,
    );
  }
}

abstract class HoveringAnchor extends InteractionState {
  const factory HoveringAnchor(
      {required final String nodeId,
      required final String anchorId}) = _$HoveringAnchorImpl;
  const HoveringAnchor._() : super._();

  factory HoveringAnchor.fromJson(Map<String, dynamic> json) =
      _$HoveringAnchorImpl.fromJson;

  String get nodeId;
  String get anchorId;
  @JsonKey(ignore: true)
  _$$HoveringAnchorImplCopyWith<_$HoveringAnchorImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$HoveringEdgeImplCopyWith<$Res> {
  factory _$$HoveringEdgeImplCopyWith(
          _$HoveringEdgeImpl value, $Res Function(_$HoveringEdgeImpl) then) =
      __$$HoveringEdgeImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String edgeId});
}

/// @nodoc
class __$$HoveringEdgeImplCopyWithImpl<$Res>
    extends _$InteractionStateCopyWithImpl<$Res, _$HoveringEdgeImpl>
    implements _$$HoveringEdgeImplCopyWith<$Res> {
  __$$HoveringEdgeImplCopyWithImpl(
      _$HoveringEdgeImpl _value, $Res Function(_$HoveringEdgeImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? edgeId = null,
  }) {
    return _then(_$HoveringEdgeImpl(
      edgeId: null == edgeId
          ? _value.edgeId
          : edgeId // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$HoveringEdgeImpl extends HoveringEdge {
  const _$HoveringEdgeImpl({required this.edgeId, final String? $type})
      : $type = $type ?? 'hovering_edge',
        super._();

  factory _$HoveringEdgeImpl.fromJson(Map<String, dynamic> json) =>
      _$$HoveringEdgeImplFromJson(json);

  @override
  final String edgeId;

  @JsonKey(name: 'type')
  final String $type;

  @override
  String toString() {
    return 'InteractionState.hoveringEdge(edgeId: $edgeId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$HoveringEdgeImpl &&
            (identical(other.edgeId, edgeId) || other.edgeId == edgeId));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, edgeId);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$HoveringEdgeImplCopyWith<_$HoveringEdgeImpl> get copyWith =>
      __$$HoveringEdgeImplCopyWithImpl<_$HoveringEdgeImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() idle,
    required TResult Function(
            String nodeId,
            @OffsetConverter() Offset startCanvas,
            @OffsetConverter() Offset lastCanvas)
        dragNode,
    required TResult Function(
            String edgeId,
            String sourceNodeId,
            String sourceAnchorId,
            @OffsetConverter() Offset startCanvas,
            @OffsetConverter() Offset lastCanvas)
        dragEdge,
    required TResult Function(
            String edgeId,
            int pointIndex,
            @OffsetConverter() Offset originalPoint,
            @OffsetConverter() Offset startCanvas,
            @OffsetConverter() Offset lastCanvas)
        dragWaypoint,
    required TResult Function(@OffsetConverter() Offset startGlobal,
            @OffsetConverter() Offset lastGlobal)
        panCanvas,
    required TResult Function(@RectConverter() Rect selectionBox) selectingArea,
    required TResult Function(
            String nodeType,
            @OffsetConverter() Offset startCanvas,
            @OffsetConverter() Offset lastCanvas)
        insertingNode,
    required TResult Function(
            String nodeType,
            String edgeId,
            @OffsetConverter() Offset startCanvas,
            @OffsetConverter() Offset lastCanvas)
        insertNodeToEdge,
    required TResult Function(
            String nodeId,
            @OffsetConverter() Offset handlePosition,
            @OffsetConverter() Offset startCanvas,
            @OffsetConverter() Offset lastCanvas)
        resizingNode,
    required TResult Function(String nodeId) hoveringNode,
    required TResult Function(String nodeId, String anchorId) hoveringAnchor,
    required TResult Function(String edgeId) hoveringEdge,
    required TResult Function(
            @OffsetConverter() Offset globalPosition, String? targetId)
        contextMenuOpen,
    required TResult Function(NodeModel node,
            @OffsetConverter() Offset canvasPos, String? highlightedEdgeId)
        insertingNodePreview,
    required TResult Function(CanvasInsertElement groupElement,
            @OffsetConverter() Offset canvasPos, String? highlightedEdgeId)
        insertingGroupPreview,
  }) {
    return hoveringEdge(edgeId);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? idle,
    TResult? Function(String nodeId, @OffsetConverter() Offset startCanvas,
            @OffsetConverter() Offset lastCanvas)?
        dragNode,
    TResult? Function(
            String edgeId,
            String sourceNodeId,
            String sourceAnchorId,
            @OffsetConverter() Offset startCanvas,
            @OffsetConverter() Offset lastCanvas)?
        dragEdge,
    TResult? Function(
            String edgeId,
            int pointIndex,
            @OffsetConverter() Offset originalPoint,
            @OffsetConverter() Offset startCanvas,
            @OffsetConverter() Offset lastCanvas)?
        dragWaypoint,
    TResult? Function(@OffsetConverter() Offset startGlobal,
            @OffsetConverter() Offset lastGlobal)?
        panCanvas,
    TResult? Function(@RectConverter() Rect selectionBox)? selectingArea,
    TResult? Function(String nodeType, @OffsetConverter() Offset startCanvas,
            @OffsetConverter() Offset lastCanvas)?
        insertingNode,
    TResult? Function(
            String nodeType,
            String edgeId,
            @OffsetConverter() Offset startCanvas,
            @OffsetConverter() Offset lastCanvas)?
        insertNodeToEdge,
    TResult? Function(
            String nodeId,
            @OffsetConverter() Offset handlePosition,
            @OffsetConverter() Offset startCanvas,
            @OffsetConverter() Offset lastCanvas)?
        resizingNode,
    TResult? Function(String nodeId)? hoveringNode,
    TResult? Function(String nodeId, String anchorId)? hoveringAnchor,
    TResult? Function(String edgeId)? hoveringEdge,
    TResult? Function(
            @OffsetConverter() Offset globalPosition, String? targetId)?
        contextMenuOpen,
    TResult? Function(NodeModel node, @OffsetConverter() Offset canvasPos,
            String? highlightedEdgeId)?
        insertingNodePreview,
    TResult? Function(CanvasInsertElement groupElement,
            @OffsetConverter() Offset canvasPos, String? highlightedEdgeId)?
        insertingGroupPreview,
  }) {
    return hoveringEdge?.call(edgeId);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? idle,
    TResult Function(String nodeId, @OffsetConverter() Offset startCanvas,
            @OffsetConverter() Offset lastCanvas)?
        dragNode,
    TResult Function(
            String edgeId,
            String sourceNodeId,
            String sourceAnchorId,
            @OffsetConverter() Offset startCanvas,
            @OffsetConverter() Offset lastCanvas)?
        dragEdge,
    TResult Function(
            String edgeId,
            int pointIndex,
            @OffsetConverter() Offset originalPoint,
            @OffsetConverter() Offset startCanvas,
            @OffsetConverter() Offset lastCanvas)?
        dragWaypoint,
    TResult Function(@OffsetConverter() Offset startGlobal,
            @OffsetConverter() Offset lastGlobal)?
        panCanvas,
    TResult Function(@RectConverter() Rect selectionBox)? selectingArea,
    TResult Function(String nodeType, @OffsetConverter() Offset startCanvas,
            @OffsetConverter() Offset lastCanvas)?
        insertingNode,
    TResult Function(
            String nodeType,
            String edgeId,
            @OffsetConverter() Offset startCanvas,
            @OffsetConverter() Offset lastCanvas)?
        insertNodeToEdge,
    TResult Function(
            String nodeId,
            @OffsetConverter() Offset handlePosition,
            @OffsetConverter() Offset startCanvas,
            @OffsetConverter() Offset lastCanvas)?
        resizingNode,
    TResult Function(String nodeId)? hoveringNode,
    TResult Function(String nodeId, String anchorId)? hoveringAnchor,
    TResult Function(String edgeId)? hoveringEdge,
    TResult Function(
            @OffsetConverter() Offset globalPosition, String? targetId)?
        contextMenuOpen,
    TResult Function(NodeModel node, @OffsetConverter() Offset canvasPos,
            String? highlightedEdgeId)?
        insertingNodePreview,
    TResult Function(CanvasInsertElement groupElement,
            @OffsetConverter() Offset canvasPos, String? highlightedEdgeId)?
        insertingGroupPreview,
    required TResult orElse(),
  }) {
    if (hoveringEdge != null) {
      return hoveringEdge(edgeId);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(Idle value) idle,
    required TResult Function(DragNode value) dragNode,
    required TResult Function(DragEdge value) dragEdge,
    required TResult Function(DragWaypoint value) dragWaypoint,
    required TResult Function(PanCanvas value) panCanvas,
    required TResult Function(SelectingArea value) selectingArea,
    required TResult Function(InsertingNode value) insertingNode,
    required TResult Function(InsertNodeToEdge value) insertNodeToEdge,
    required TResult Function(ResizingNode value) resizingNode,
    required TResult Function(HoveringNode value) hoveringNode,
    required TResult Function(HoveringAnchor value) hoveringAnchor,
    required TResult Function(HoveringEdge value) hoveringEdge,
    required TResult Function(ContextMenuOpen value) contextMenuOpen,
    required TResult Function(InsertingNodePreview value) insertingNodePreview,
    required TResult Function(InsertingGroupPreview value)
        insertingGroupPreview,
  }) {
    return hoveringEdge(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(Idle value)? idle,
    TResult? Function(DragNode value)? dragNode,
    TResult? Function(DragEdge value)? dragEdge,
    TResult? Function(DragWaypoint value)? dragWaypoint,
    TResult? Function(PanCanvas value)? panCanvas,
    TResult? Function(SelectingArea value)? selectingArea,
    TResult? Function(InsertingNode value)? insertingNode,
    TResult? Function(InsertNodeToEdge value)? insertNodeToEdge,
    TResult? Function(ResizingNode value)? resizingNode,
    TResult? Function(HoveringNode value)? hoveringNode,
    TResult? Function(HoveringAnchor value)? hoveringAnchor,
    TResult? Function(HoveringEdge value)? hoveringEdge,
    TResult? Function(ContextMenuOpen value)? contextMenuOpen,
    TResult? Function(InsertingNodePreview value)? insertingNodePreview,
    TResult? Function(InsertingGroupPreview value)? insertingGroupPreview,
  }) {
    return hoveringEdge?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(Idle value)? idle,
    TResult Function(DragNode value)? dragNode,
    TResult Function(DragEdge value)? dragEdge,
    TResult Function(DragWaypoint value)? dragWaypoint,
    TResult Function(PanCanvas value)? panCanvas,
    TResult Function(SelectingArea value)? selectingArea,
    TResult Function(InsertingNode value)? insertingNode,
    TResult Function(InsertNodeToEdge value)? insertNodeToEdge,
    TResult Function(ResizingNode value)? resizingNode,
    TResult Function(HoveringNode value)? hoveringNode,
    TResult Function(HoveringAnchor value)? hoveringAnchor,
    TResult Function(HoveringEdge value)? hoveringEdge,
    TResult Function(ContextMenuOpen value)? contextMenuOpen,
    TResult Function(InsertingNodePreview value)? insertingNodePreview,
    TResult Function(InsertingGroupPreview value)? insertingGroupPreview,
    required TResult orElse(),
  }) {
    if (hoveringEdge != null) {
      return hoveringEdge(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$HoveringEdgeImplToJson(
      this,
    );
  }
}

abstract class HoveringEdge extends InteractionState {
  const factory HoveringEdge({required final String edgeId}) =
      _$HoveringEdgeImpl;
  const HoveringEdge._() : super._();

  factory HoveringEdge.fromJson(Map<String, dynamic> json) =
      _$HoveringEdgeImpl.fromJson;

  String get edgeId;
  @JsonKey(ignore: true)
  _$$HoveringEdgeImplCopyWith<_$HoveringEdgeImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ContextMenuOpenImplCopyWith<$Res> {
  factory _$$ContextMenuOpenImplCopyWith(_$ContextMenuOpenImpl value,
          $Res Function(_$ContextMenuOpenImpl) then) =
      __$$ContextMenuOpenImplCopyWithImpl<$Res>;
  @useResult
  $Res call({@OffsetConverter() Offset globalPosition, String? targetId});
}

/// @nodoc
class __$$ContextMenuOpenImplCopyWithImpl<$Res>
    extends _$InteractionStateCopyWithImpl<$Res, _$ContextMenuOpenImpl>
    implements _$$ContextMenuOpenImplCopyWith<$Res> {
  __$$ContextMenuOpenImplCopyWithImpl(
      _$ContextMenuOpenImpl _value, $Res Function(_$ContextMenuOpenImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? globalPosition = null,
    Object? targetId = freezed,
  }) {
    return _then(_$ContextMenuOpenImpl(
      globalPosition: null == globalPosition
          ? _value.globalPosition
          : globalPosition // ignore: cast_nullable_to_non_nullable
              as Offset,
      targetId: freezed == targetId
          ? _value.targetId
          : targetId // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ContextMenuOpenImpl extends ContextMenuOpen {
  const _$ContextMenuOpenImpl(
      {@OffsetConverter() required this.globalPosition,
      this.targetId,
      final String? $type})
      : $type = $type ?? 'context_menu_open',
        super._();

  factory _$ContextMenuOpenImpl.fromJson(Map<String, dynamic> json) =>
      _$$ContextMenuOpenImplFromJson(json);

  @override
  @OffsetConverter()
  final Offset globalPosition;
  @override
  final String? targetId;

  @JsonKey(name: 'type')
  final String $type;

  @override
  String toString() {
    return 'InteractionState.contextMenuOpen(globalPosition: $globalPosition, targetId: $targetId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ContextMenuOpenImpl &&
            (identical(other.globalPosition, globalPosition) ||
                other.globalPosition == globalPosition) &&
            (identical(other.targetId, targetId) ||
                other.targetId == targetId));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, globalPosition, targetId);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ContextMenuOpenImplCopyWith<_$ContextMenuOpenImpl> get copyWith =>
      __$$ContextMenuOpenImplCopyWithImpl<_$ContextMenuOpenImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() idle,
    required TResult Function(
            String nodeId,
            @OffsetConverter() Offset startCanvas,
            @OffsetConverter() Offset lastCanvas)
        dragNode,
    required TResult Function(
            String edgeId,
            String sourceNodeId,
            String sourceAnchorId,
            @OffsetConverter() Offset startCanvas,
            @OffsetConverter() Offset lastCanvas)
        dragEdge,
    required TResult Function(
            String edgeId,
            int pointIndex,
            @OffsetConverter() Offset originalPoint,
            @OffsetConverter() Offset startCanvas,
            @OffsetConverter() Offset lastCanvas)
        dragWaypoint,
    required TResult Function(@OffsetConverter() Offset startGlobal,
            @OffsetConverter() Offset lastGlobal)
        panCanvas,
    required TResult Function(@RectConverter() Rect selectionBox) selectingArea,
    required TResult Function(
            String nodeType,
            @OffsetConverter() Offset startCanvas,
            @OffsetConverter() Offset lastCanvas)
        insertingNode,
    required TResult Function(
            String nodeType,
            String edgeId,
            @OffsetConverter() Offset startCanvas,
            @OffsetConverter() Offset lastCanvas)
        insertNodeToEdge,
    required TResult Function(
            String nodeId,
            @OffsetConverter() Offset handlePosition,
            @OffsetConverter() Offset startCanvas,
            @OffsetConverter() Offset lastCanvas)
        resizingNode,
    required TResult Function(String nodeId) hoveringNode,
    required TResult Function(String nodeId, String anchorId) hoveringAnchor,
    required TResult Function(String edgeId) hoveringEdge,
    required TResult Function(
            @OffsetConverter() Offset globalPosition, String? targetId)
        contextMenuOpen,
    required TResult Function(NodeModel node,
            @OffsetConverter() Offset canvasPos, String? highlightedEdgeId)
        insertingNodePreview,
    required TResult Function(CanvasInsertElement groupElement,
            @OffsetConverter() Offset canvasPos, String? highlightedEdgeId)
        insertingGroupPreview,
  }) {
    return contextMenuOpen(globalPosition, targetId);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? idle,
    TResult? Function(String nodeId, @OffsetConverter() Offset startCanvas,
            @OffsetConverter() Offset lastCanvas)?
        dragNode,
    TResult? Function(
            String edgeId,
            String sourceNodeId,
            String sourceAnchorId,
            @OffsetConverter() Offset startCanvas,
            @OffsetConverter() Offset lastCanvas)?
        dragEdge,
    TResult? Function(
            String edgeId,
            int pointIndex,
            @OffsetConverter() Offset originalPoint,
            @OffsetConverter() Offset startCanvas,
            @OffsetConverter() Offset lastCanvas)?
        dragWaypoint,
    TResult? Function(@OffsetConverter() Offset startGlobal,
            @OffsetConverter() Offset lastGlobal)?
        panCanvas,
    TResult? Function(@RectConverter() Rect selectionBox)? selectingArea,
    TResult? Function(String nodeType, @OffsetConverter() Offset startCanvas,
            @OffsetConverter() Offset lastCanvas)?
        insertingNode,
    TResult? Function(
            String nodeType,
            String edgeId,
            @OffsetConverter() Offset startCanvas,
            @OffsetConverter() Offset lastCanvas)?
        insertNodeToEdge,
    TResult? Function(
            String nodeId,
            @OffsetConverter() Offset handlePosition,
            @OffsetConverter() Offset startCanvas,
            @OffsetConverter() Offset lastCanvas)?
        resizingNode,
    TResult? Function(String nodeId)? hoveringNode,
    TResult? Function(String nodeId, String anchorId)? hoveringAnchor,
    TResult? Function(String edgeId)? hoveringEdge,
    TResult? Function(
            @OffsetConverter() Offset globalPosition, String? targetId)?
        contextMenuOpen,
    TResult? Function(NodeModel node, @OffsetConverter() Offset canvasPos,
            String? highlightedEdgeId)?
        insertingNodePreview,
    TResult? Function(CanvasInsertElement groupElement,
            @OffsetConverter() Offset canvasPos, String? highlightedEdgeId)?
        insertingGroupPreview,
  }) {
    return contextMenuOpen?.call(globalPosition, targetId);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? idle,
    TResult Function(String nodeId, @OffsetConverter() Offset startCanvas,
            @OffsetConverter() Offset lastCanvas)?
        dragNode,
    TResult Function(
            String edgeId,
            String sourceNodeId,
            String sourceAnchorId,
            @OffsetConverter() Offset startCanvas,
            @OffsetConverter() Offset lastCanvas)?
        dragEdge,
    TResult Function(
            String edgeId,
            int pointIndex,
            @OffsetConverter() Offset originalPoint,
            @OffsetConverter() Offset startCanvas,
            @OffsetConverter() Offset lastCanvas)?
        dragWaypoint,
    TResult Function(@OffsetConverter() Offset startGlobal,
            @OffsetConverter() Offset lastGlobal)?
        panCanvas,
    TResult Function(@RectConverter() Rect selectionBox)? selectingArea,
    TResult Function(String nodeType, @OffsetConverter() Offset startCanvas,
            @OffsetConverter() Offset lastCanvas)?
        insertingNode,
    TResult Function(
            String nodeType,
            String edgeId,
            @OffsetConverter() Offset startCanvas,
            @OffsetConverter() Offset lastCanvas)?
        insertNodeToEdge,
    TResult Function(
            String nodeId,
            @OffsetConverter() Offset handlePosition,
            @OffsetConverter() Offset startCanvas,
            @OffsetConverter() Offset lastCanvas)?
        resizingNode,
    TResult Function(String nodeId)? hoveringNode,
    TResult Function(String nodeId, String anchorId)? hoveringAnchor,
    TResult Function(String edgeId)? hoveringEdge,
    TResult Function(
            @OffsetConverter() Offset globalPosition, String? targetId)?
        contextMenuOpen,
    TResult Function(NodeModel node, @OffsetConverter() Offset canvasPos,
            String? highlightedEdgeId)?
        insertingNodePreview,
    TResult Function(CanvasInsertElement groupElement,
            @OffsetConverter() Offset canvasPos, String? highlightedEdgeId)?
        insertingGroupPreview,
    required TResult orElse(),
  }) {
    if (contextMenuOpen != null) {
      return contextMenuOpen(globalPosition, targetId);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(Idle value) idle,
    required TResult Function(DragNode value) dragNode,
    required TResult Function(DragEdge value) dragEdge,
    required TResult Function(DragWaypoint value) dragWaypoint,
    required TResult Function(PanCanvas value) panCanvas,
    required TResult Function(SelectingArea value) selectingArea,
    required TResult Function(InsertingNode value) insertingNode,
    required TResult Function(InsertNodeToEdge value) insertNodeToEdge,
    required TResult Function(ResizingNode value) resizingNode,
    required TResult Function(HoveringNode value) hoveringNode,
    required TResult Function(HoveringAnchor value) hoveringAnchor,
    required TResult Function(HoveringEdge value) hoveringEdge,
    required TResult Function(ContextMenuOpen value) contextMenuOpen,
    required TResult Function(InsertingNodePreview value) insertingNodePreview,
    required TResult Function(InsertingGroupPreview value)
        insertingGroupPreview,
  }) {
    return contextMenuOpen(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(Idle value)? idle,
    TResult? Function(DragNode value)? dragNode,
    TResult? Function(DragEdge value)? dragEdge,
    TResult? Function(DragWaypoint value)? dragWaypoint,
    TResult? Function(PanCanvas value)? panCanvas,
    TResult? Function(SelectingArea value)? selectingArea,
    TResult? Function(InsertingNode value)? insertingNode,
    TResult? Function(InsertNodeToEdge value)? insertNodeToEdge,
    TResult? Function(ResizingNode value)? resizingNode,
    TResult? Function(HoveringNode value)? hoveringNode,
    TResult? Function(HoveringAnchor value)? hoveringAnchor,
    TResult? Function(HoveringEdge value)? hoveringEdge,
    TResult? Function(ContextMenuOpen value)? contextMenuOpen,
    TResult? Function(InsertingNodePreview value)? insertingNodePreview,
    TResult? Function(InsertingGroupPreview value)? insertingGroupPreview,
  }) {
    return contextMenuOpen?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(Idle value)? idle,
    TResult Function(DragNode value)? dragNode,
    TResult Function(DragEdge value)? dragEdge,
    TResult Function(DragWaypoint value)? dragWaypoint,
    TResult Function(PanCanvas value)? panCanvas,
    TResult Function(SelectingArea value)? selectingArea,
    TResult Function(InsertingNode value)? insertingNode,
    TResult Function(InsertNodeToEdge value)? insertNodeToEdge,
    TResult Function(ResizingNode value)? resizingNode,
    TResult Function(HoveringNode value)? hoveringNode,
    TResult Function(HoveringAnchor value)? hoveringAnchor,
    TResult Function(HoveringEdge value)? hoveringEdge,
    TResult Function(ContextMenuOpen value)? contextMenuOpen,
    TResult Function(InsertingNodePreview value)? insertingNodePreview,
    TResult Function(InsertingGroupPreview value)? insertingGroupPreview,
    required TResult orElse(),
  }) {
    if (contextMenuOpen != null) {
      return contextMenuOpen(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$ContextMenuOpenImplToJson(
      this,
    );
  }
}

abstract class ContextMenuOpen extends InteractionState {
  const factory ContextMenuOpen(
      {@OffsetConverter() required final Offset globalPosition,
      final String? targetId}) = _$ContextMenuOpenImpl;
  const ContextMenuOpen._() : super._();

  factory ContextMenuOpen.fromJson(Map<String, dynamic> json) =
      _$ContextMenuOpenImpl.fromJson;

  @OffsetConverter()
  Offset get globalPosition;
  String? get targetId;
  @JsonKey(ignore: true)
  _$$ContextMenuOpenImplCopyWith<_$ContextMenuOpenImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$InsertingNodePreviewImplCopyWith<$Res> {
  factory _$$InsertingNodePreviewImplCopyWith(_$InsertingNodePreviewImpl value,
          $Res Function(_$InsertingNodePreviewImpl) then) =
      __$$InsertingNodePreviewImplCopyWithImpl<$Res>;
  @useResult
  $Res call(
      {NodeModel node,
      @OffsetConverter() Offset canvasPos,
      String? highlightedEdgeId});

  $NodeModelCopyWith<$Res> get node;
}

/// @nodoc
class __$$InsertingNodePreviewImplCopyWithImpl<$Res>
    extends _$InteractionStateCopyWithImpl<$Res, _$InsertingNodePreviewImpl>
    implements _$$InsertingNodePreviewImplCopyWith<$Res> {
  __$$InsertingNodePreviewImplCopyWithImpl(_$InsertingNodePreviewImpl _value,
      $Res Function(_$InsertingNodePreviewImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? node = null,
    Object? canvasPos = null,
    Object? highlightedEdgeId = freezed,
  }) {
    return _then(_$InsertingNodePreviewImpl(
      node: null == node
          ? _value.node
          : node // ignore: cast_nullable_to_non_nullable
              as NodeModel,
      canvasPos: null == canvasPos
          ? _value.canvasPos
          : canvasPos // ignore: cast_nullable_to_non_nullable
              as Offset,
      highlightedEdgeId: freezed == highlightedEdgeId
          ? _value.highlightedEdgeId
          : highlightedEdgeId // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }

  @override
  @pragma('vm:prefer-inline')
  $NodeModelCopyWith<$Res> get node {
    return $NodeModelCopyWith<$Res>(_value.node, (value) {
      return _then(_value.copyWith(node: value));
    });
  }
}

/// @nodoc
@JsonSerializable()
class _$InsertingNodePreviewImpl extends InsertingNodePreview {
  const _$InsertingNodePreviewImpl(
      {required this.node,
      @OffsetConverter() required this.canvasPos,
      this.highlightedEdgeId,
      final String? $type})
      : $type = $type ?? 'inserting_node_preview',
        super._();

  factory _$InsertingNodePreviewImpl.fromJson(Map<String, dynamic> json) =>
      _$$InsertingNodePreviewImplFromJson(json);

  @override
  final NodeModel node;
  @override
  @OffsetConverter()
  final Offset canvasPos;
  @override
  final String? highlightedEdgeId;

  @JsonKey(name: 'type')
  final String $type;

  @override
  String toString() {
    return 'InteractionState.insertingNodePreview(node: $node, canvasPos: $canvasPos, highlightedEdgeId: $highlightedEdgeId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$InsertingNodePreviewImpl &&
            (identical(other.node, node) || other.node == node) &&
            (identical(other.canvasPos, canvasPos) ||
                other.canvasPos == canvasPos) &&
            (identical(other.highlightedEdgeId, highlightedEdgeId) ||
                other.highlightedEdgeId == highlightedEdgeId));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, node, canvasPos, highlightedEdgeId);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$InsertingNodePreviewImplCopyWith<_$InsertingNodePreviewImpl>
      get copyWith =>
          __$$InsertingNodePreviewImplCopyWithImpl<_$InsertingNodePreviewImpl>(
              this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() idle,
    required TResult Function(
            String nodeId,
            @OffsetConverter() Offset startCanvas,
            @OffsetConverter() Offset lastCanvas)
        dragNode,
    required TResult Function(
            String edgeId,
            String sourceNodeId,
            String sourceAnchorId,
            @OffsetConverter() Offset startCanvas,
            @OffsetConverter() Offset lastCanvas)
        dragEdge,
    required TResult Function(
            String edgeId,
            int pointIndex,
            @OffsetConverter() Offset originalPoint,
            @OffsetConverter() Offset startCanvas,
            @OffsetConverter() Offset lastCanvas)
        dragWaypoint,
    required TResult Function(@OffsetConverter() Offset startGlobal,
            @OffsetConverter() Offset lastGlobal)
        panCanvas,
    required TResult Function(@RectConverter() Rect selectionBox) selectingArea,
    required TResult Function(
            String nodeType,
            @OffsetConverter() Offset startCanvas,
            @OffsetConverter() Offset lastCanvas)
        insertingNode,
    required TResult Function(
            String nodeType,
            String edgeId,
            @OffsetConverter() Offset startCanvas,
            @OffsetConverter() Offset lastCanvas)
        insertNodeToEdge,
    required TResult Function(
            String nodeId,
            @OffsetConverter() Offset handlePosition,
            @OffsetConverter() Offset startCanvas,
            @OffsetConverter() Offset lastCanvas)
        resizingNode,
    required TResult Function(String nodeId) hoveringNode,
    required TResult Function(String nodeId, String anchorId) hoveringAnchor,
    required TResult Function(String edgeId) hoveringEdge,
    required TResult Function(
            @OffsetConverter() Offset globalPosition, String? targetId)
        contextMenuOpen,
    required TResult Function(NodeModel node,
            @OffsetConverter() Offset canvasPos, String? highlightedEdgeId)
        insertingNodePreview,
    required TResult Function(CanvasInsertElement groupElement,
            @OffsetConverter() Offset canvasPos, String? highlightedEdgeId)
        insertingGroupPreview,
  }) {
    return insertingNodePreview(node, canvasPos, highlightedEdgeId);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? idle,
    TResult? Function(String nodeId, @OffsetConverter() Offset startCanvas,
            @OffsetConverter() Offset lastCanvas)?
        dragNode,
    TResult? Function(
            String edgeId,
            String sourceNodeId,
            String sourceAnchorId,
            @OffsetConverter() Offset startCanvas,
            @OffsetConverter() Offset lastCanvas)?
        dragEdge,
    TResult? Function(
            String edgeId,
            int pointIndex,
            @OffsetConverter() Offset originalPoint,
            @OffsetConverter() Offset startCanvas,
            @OffsetConverter() Offset lastCanvas)?
        dragWaypoint,
    TResult? Function(@OffsetConverter() Offset startGlobal,
            @OffsetConverter() Offset lastGlobal)?
        panCanvas,
    TResult? Function(@RectConverter() Rect selectionBox)? selectingArea,
    TResult? Function(String nodeType, @OffsetConverter() Offset startCanvas,
            @OffsetConverter() Offset lastCanvas)?
        insertingNode,
    TResult? Function(
            String nodeType,
            String edgeId,
            @OffsetConverter() Offset startCanvas,
            @OffsetConverter() Offset lastCanvas)?
        insertNodeToEdge,
    TResult? Function(
            String nodeId,
            @OffsetConverter() Offset handlePosition,
            @OffsetConverter() Offset startCanvas,
            @OffsetConverter() Offset lastCanvas)?
        resizingNode,
    TResult? Function(String nodeId)? hoveringNode,
    TResult? Function(String nodeId, String anchorId)? hoveringAnchor,
    TResult? Function(String edgeId)? hoveringEdge,
    TResult? Function(
            @OffsetConverter() Offset globalPosition, String? targetId)?
        contextMenuOpen,
    TResult? Function(NodeModel node, @OffsetConverter() Offset canvasPos,
            String? highlightedEdgeId)?
        insertingNodePreview,
    TResult? Function(CanvasInsertElement groupElement,
            @OffsetConverter() Offset canvasPos, String? highlightedEdgeId)?
        insertingGroupPreview,
  }) {
    return insertingNodePreview?.call(node, canvasPos, highlightedEdgeId);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? idle,
    TResult Function(String nodeId, @OffsetConverter() Offset startCanvas,
            @OffsetConverter() Offset lastCanvas)?
        dragNode,
    TResult Function(
            String edgeId,
            String sourceNodeId,
            String sourceAnchorId,
            @OffsetConverter() Offset startCanvas,
            @OffsetConverter() Offset lastCanvas)?
        dragEdge,
    TResult Function(
            String edgeId,
            int pointIndex,
            @OffsetConverter() Offset originalPoint,
            @OffsetConverter() Offset startCanvas,
            @OffsetConverter() Offset lastCanvas)?
        dragWaypoint,
    TResult Function(@OffsetConverter() Offset startGlobal,
            @OffsetConverter() Offset lastGlobal)?
        panCanvas,
    TResult Function(@RectConverter() Rect selectionBox)? selectingArea,
    TResult Function(String nodeType, @OffsetConverter() Offset startCanvas,
            @OffsetConverter() Offset lastCanvas)?
        insertingNode,
    TResult Function(
            String nodeType,
            String edgeId,
            @OffsetConverter() Offset startCanvas,
            @OffsetConverter() Offset lastCanvas)?
        insertNodeToEdge,
    TResult Function(
            String nodeId,
            @OffsetConverter() Offset handlePosition,
            @OffsetConverter() Offset startCanvas,
            @OffsetConverter() Offset lastCanvas)?
        resizingNode,
    TResult Function(String nodeId)? hoveringNode,
    TResult Function(String nodeId, String anchorId)? hoveringAnchor,
    TResult Function(String edgeId)? hoveringEdge,
    TResult Function(
            @OffsetConverter() Offset globalPosition, String? targetId)?
        contextMenuOpen,
    TResult Function(NodeModel node, @OffsetConverter() Offset canvasPos,
            String? highlightedEdgeId)?
        insertingNodePreview,
    TResult Function(CanvasInsertElement groupElement,
            @OffsetConverter() Offset canvasPos, String? highlightedEdgeId)?
        insertingGroupPreview,
    required TResult orElse(),
  }) {
    if (insertingNodePreview != null) {
      return insertingNodePreview(node, canvasPos, highlightedEdgeId);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(Idle value) idle,
    required TResult Function(DragNode value) dragNode,
    required TResult Function(DragEdge value) dragEdge,
    required TResult Function(DragWaypoint value) dragWaypoint,
    required TResult Function(PanCanvas value) panCanvas,
    required TResult Function(SelectingArea value) selectingArea,
    required TResult Function(InsertingNode value) insertingNode,
    required TResult Function(InsertNodeToEdge value) insertNodeToEdge,
    required TResult Function(ResizingNode value) resizingNode,
    required TResult Function(HoveringNode value) hoveringNode,
    required TResult Function(HoveringAnchor value) hoveringAnchor,
    required TResult Function(HoveringEdge value) hoveringEdge,
    required TResult Function(ContextMenuOpen value) contextMenuOpen,
    required TResult Function(InsertingNodePreview value) insertingNodePreview,
    required TResult Function(InsertingGroupPreview value)
        insertingGroupPreview,
  }) {
    return insertingNodePreview(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(Idle value)? idle,
    TResult? Function(DragNode value)? dragNode,
    TResult? Function(DragEdge value)? dragEdge,
    TResult? Function(DragWaypoint value)? dragWaypoint,
    TResult? Function(PanCanvas value)? panCanvas,
    TResult? Function(SelectingArea value)? selectingArea,
    TResult? Function(InsertingNode value)? insertingNode,
    TResult? Function(InsertNodeToEdge value)? insertNodeToEdge,
    TResult? Function(ResizingNode value)? resizingNode,
    TResult? Function(HoveringNode value)? hoveringNode,
    TResult? Function(HoveringAnchor value)? hoveringAnchor,
    TResult? Function(HoveringEdge value)? hoveringEdge,
    TResult? Function(ContextMenuOpen value)? contextMenuOpen,
    TResult? Function(InsertingNodePreview value)? insertingNodePreview,
    TResult? Function(InsertingGroupPreview value)? insertingGroupPreview,
  }) {
    return insertingNodePreview?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(Idle value)? idle,
    TResult Function(DragNode value)? dragNode,
    TResult Function(DragEdge value)? dragEdge,
    TResult Function(DragWaypoint value)? dragWaypoint,
    TResult Function(PanCanvas value)? panCanvas,
    TResult Function(SelectingArea value)? selectingArea,
    TResult Function(InsertingNode value)? insertingNode,
    TResult Function(InsertNodeToEdge value)? insertNodeToEdge,
    TResult Function(ResizingNode value)? resizingNode,
    TResult Function(HoveringNode value)? hoveringNode,
    TResult Function(HoveringAnchor value)? hoveringAnchor,
    TResult Function(HoveringEdge value)? hoveringEdge,
    TResult Function(ContextMenuOpen value)? contextMenuOpen,
    TResult Function(InsertingNodePreview value)? insertingNodePreview,
    TResult Function(InsertingGroupPreview value)? insertingGroupPreview,
    required TResult orElse(),
  }) {
    if (insertingNodePreview != null) {
      return insertingNodePreview(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$InsertingNodePreviewImplToJson(
      this,
    );
  }
}

abstract class InsertingNodePreview extends InteractionState {
  const factory InsertingNodePreview(
      {required final NodeModel node,
      @OffsetConverter() required final Offset canvasPos,
      final String? highlightedEdgeId}) = _$InsertingNodePreviewImpl;
  const InsertingNodePreview._() : super._();

  factory InsertingNodePreview.fromJson(Map<String, dynamic> json) =
      _$InsertingNodePreviewImpl.fromJson;

  NodeModel get node;
  @OffsetConverter()
  Offset get canvasPos;
  String? get highlightedEdgeId;
  @JsonKey(ignore: true)
  _$$InsertingNodePreviewImplCopyWith<_$InsertingNodePreviewImpl>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$InsertingGroupPreviewImplCopyWith<$Res> {
  factory _$$InsertingGroupPreviewImplCopyWith(
          _$InsertingGroupPreviewImpl value,
          $Res Function(_$InsertingGroupPreviewImpl) then) =
      __$$InsertingGroupPreviewImplCopyWithImpl<$Res>;
  @useResult
  $Res call(
      {CanvasInsertElement groupElement,
      @OffsetConverter() Offset canvasPos,
      String? highlightedEdgeId});

  $CanvasInsertElementCopyWith<$Res> get groupElement;
}

/// @nodoc
class __$$InsertingGroupPreviewImplCopyWithImpl<$Res>
    extends _$InteractionStateCopyWithImpl<$Res, _$InsertingGroupPreviewImpl>
    implements _$$InsertingGroupPreviewImplCopyWith<$Res> {
  __$$InsertingGroupPreviewImplCopyWithImpl(_$InsertingGroupPreviewImpl _value,
      $Res Function(_$InsertingGroupPreviewImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? groupElement = null,
    Object? canvasPos = null,
    Object? highlightedEdgeId = freezed,
  }) {
    return _then(_$InsertingGroupPreviewImpl(
      groupElement: null == groupElement
          ? _value.groupElement
          : groupElement // ignore: cast_nullable_to_non_nullable
              as CanvasInsertElement,
      canvasPos: null == canvasPos
          ? _value.canvasPos
          : canvasPos // ignore: cast_nullable_to_non_nullable
              as Offset,
      highlightedEdgeId: freezed == highlightedEdgeId
          ? _value.highlightedEdgeId
          : highlightedEdgeId // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }

  @override
  @pragma('vm:prefer-inline')
  $CanvasInsertElementCopyWith<$Res> get groupElement {
    return $CanvasInsertElementCopyWith<$Res>(_value.groupElement, (value) {
      return _then(_value.copyWith(groupElement: value));
    });
  }
}

/// @nodoc
@JsonSerializable()
class _$InsertingGroupPreviewImpl extends InsertingGroupPreview {
  const _$InsertingGroupPreviewImpl(
      {required this.groupElement,
      @OffsetConverter() required this.canvasPos,
      this.highlightedEdgeId,
      final String? $type})
      : $type = $type ?? 'inserting_group_preview',
        super._();

  factory _$InsertingGroupPreviewImpl.fromJson(Map<String, dynamic> json) =>
      _$$InsertingGroupPreviewImplFromJson(json);

  @override
  final CanvasInsertElement groupElement;
  @override
  @OffsetConverter()
  final Offset canvasPos;
  @override
  final String? highlightedEdgeId;

  @JsonKey(name: 'type')
  final String $type;

  @override
  String toString() {
    return 'InteractionState.insertingGroupPreview(groupElement: $groupElement, canvasPos: $canvasPos, highlightedEdgeId: $highlightedEdgeId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$InsertingGroupPreviewImpl &&
            (identical(other.groupElement, groupElement) ||
                other.groupElement == groupElement) &&
            (identical(other.canvasPos, canvasPos) ||
                other.canvasPos == canvasPos) &&
            (identical(other.highlightedEdgeId, highlightedEdgeId) ||
                other.highlightedEdgeId == highlightedEdgeId));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, groupElement, canvasPos, highlightedEdgeId);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$InsertingGroupPreviewImplCopyWith<_$InsertingGroupPreviewImpl>
      get copyWith => __$$InsertingGroupPreviewImplCopyWithImpl<
          _$InsertingGroupPreviewImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() idle,
    required TResult Function(
            String nodeId,
            @OffsetConverter() Offset startCanvas,
            @OffsetConverter() Offset lastCanvas)
        dragNode,
    required TResult Function(
            String edgeId,
            String sourceNodeId,
            String sourceAnchorId,
            @OffsetConverter() Offset startCanvas,
            @OffsetConverter() Offset lastCanvas)
        dragEdge,
    required TResult Function(
            String edgeId,
            int pointIndex,
            @OffsetConverter() Offset originalPoint,
            @OffsetConverter() Offset startCanvas,
            @OffsetConverter() Offset lastCanvas)
        dragWaypoint,
    required TResult Function(@OffsetConverter() Offset startGlobal,
            @OffsetConverter() Offset lastGlobal)
        panCanvas,
    required TResult Function(@RectConverter() Rect selectionBox) selectingArea,
    required TResult Function(
            String nodeType,
            @OffsetConverter() Offset startCanvas,
            @OffsetConverter() Offset lastCanvas)
        insertingNode,
    required TResult Function(
            String nodeType,
            String edgeId,
            @OffsetConverter() Offset startCanvas,
            @OffsetConverter() Offset lastCanvas)
        insertNodeToEdge,
    required TResult Function(
            String nodeId,
            @OffsetConverter() Offset handlePosition,
            @OffsetConverter() Offset startCanvas,
            @OffsetConverter() Offset lastCanvas)
        resizingNode,
    required TResult Function(String nodeId) hoveringNode,
    required TResult Function(String nodeId, String anchorId) hoveringAnchor,
    required TResult Function(String edgeId) hoveringEdge,
    required TResult Function(
            @OffsetConverter() Offset globalPosition, String? targetId)
        contextMenuOpen,
    required TResult Function(NodeModel node,
            @OffsetConverter() Offset canvasPos, String? highlightedEdgeId)
        insertingNodePreview,
    required TResult Function(CanvasInsertElement groupElement,
            @OffsetConverter() Offset canvasPos, String? highlightedEdgeId)
        insertingGroupPreview,
  }) {
    return insertingGroupPreview(groupElement, canvasPos, highlightedEdgeId);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? idle,
    TResult? Function(String nodeId, @OffsetConverter() Offset startCanvas,
            @OffsetConverter() Offset lastCanvas)?
        dragNode,
    TResult? Function(
            String edgeId,
            String sourceNodeId,
            String sourceAnchorId,
            @OffsetConverter() Offset startCanvas,
            @OffsetConverter() Offset lastCanvas)?
        dragEdge,
    TResult? Function(
            String edgeId,
            int pointIndex,
            @OffsetConverter() Offset originalPoint,
            @OffsetConverter() Offset startCanvas,
            @OffsetConverter() Offset lastCanvas)?
        dragWaypoint,
    TResult? Function(@OffsetConverter() Offset startGlobal,
            @OffsetConverter() Offset lastGlobal)?
        panCanvas,
    TResult? Function(@RectConverter() Rect selectionBox)? selectingArea,
    TResult? Function(String nodeType, @OffsetConverter() Offset startCanvas,
            @OffsetConverter() Offset lastCanvas)?
        insertingNode,
    TResult? Function(
            String nodeType,
            String edgeId,
            @OffsetConverter() Offset startCanvas,
            @OffsetConverter() Offset lastCanvas)?
        insertNodeToEdge,
    TResult? Function(
            String nodeId,
            @OffsetConverter() Offset handlePosition,
            @OffsetConverter() Offset startCanvas,
            @OffsetConverter() Offset lastCanvas)?
        resizingNode,
    TResult? Function(String nodeId)? hoveringNode,
    TResult? Function(String nodeId, String anchorId)? hoveringAnchor,
    TResult? Function(String edgeId)? hoveringEdge,
    TResult? Function(
            @OffsetConverter() Offset globalPosition, String? targetId)?
        contextMenuOpen,
    TResult? Function(NodeModel node, @OffsetConverter() Offset canvasPos,
            String? highlightedEdgeId)?
        insertingNodePreview,
    TResult? Function(CanvasInsertElement groupElement,
            @OffsetConverter() Offset canvasPos, String? highlightedEdgeId)?
        insertingGroupPreview,
  }) {
    return insertingGroupPreview?.call(
        groupElement, canvasPos, highlightedEdgeId);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? idle,
    TResult Function(String nodeId, @OffsetConverter() Offset startCanvas,
            @OffsetConverter() Offset lastCanvas)?
        dragNode,
    TResult Function(
            String edgeId,
            String sourceNodeId,
            String sourceAnchorId,
            @OffsetConverter() Offset startCanvas,
            @OffsetConverter() Offset lastCanvas)?
        dragEdge,
    TResult Function(
            String edgeId,
            int pointIndex,
            @OffsetConverter() Offset originalPoint,
            @OffsetConverter() Offset startCanvas,
            @OffsetConverter() Offset lastCanvas)?
        dragWaypoint,
    TResult Function(@OffsetConverter() Offset startGlobal,
            @OffsetConverter() Offset lastGlobal)?
        panCanvas,
    TResult Function(@RectConverter() Rect selectionBox)? selectingArea,
    TResult Function(String nodeType, @OffsetConverter() Offset startCanvas,
            @OffsetConverter() Offset lastCanvas)?
        insertingNode,
    TResult Function(
            String nodeType,
            String edgeId,
            @OffsetConverter() Offset startCanvas,
            @OffsetConverter() Offset lastCanvas)?
        insertNodeToEdge,
    TResult Function(
            String nodeId,
            @OffsetConverter() Offset handlePosition,
            @OffsetConverter() Offset startCanvas,
            @OffsetConverter() Offset lastCanvas)?
        resizingNode,
    TResult Function(String nodeId)? hoveringNode,
    TResult Function(String nodeId, String anchorId)? hoveringAnchor,
    TResult Function(String edgeId)? hoveringEdge,
    TResult Function(
            @OffsetConverter() Offset globalPosition, String? targetId)?
        contextMenuOpen,
    TResult Function(NodeModel node, @OffsetConverter() Offset canvasPos,
            String? highlightedEdgeId)?
        insertingNodePreview,
    TResult Function(CanvasInsertElement groupElement,
            @OffsetConverter() Offset canvasPos, String? highlightedEdgeId)?
        insertingGroupPreview,
    required TResult orElse(),
  }) {
    if (insertingGroupPreview != null) {
      return insertingGroupPreview(groupElement, canvasPos, highlightedEdgeId);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(Idle value) idle,
    required TResult Function(DragNode value) dragNode,
    required TResult Function(DragEdge value) dragEdge,
    required TResult Function(DragWaypoint value) dragWaypoint,
    required TResult Function(PanCanvas value) panCanvas,
    required TResult Function(SelectingArea value) selectingArea,
    required TResult Function(InsertingNode value) insertingNode,
    required TResult Function(InsertNodeToEdge value) insertNodeToEdge,
    required TResult Function(ResizingNode value) resizingNode,
    required TResult Function(HoveringNode value) hoveringNode,
    required TResult Function(HoveringAnchor value) hoveringAnchor,
    required TResult Function(HoveringEdge value) hoveringEdge,
    required TResult Function(ContextMenuOpen value) contextMenuOpen,
    required TResult Function(InsertingNodePreview value) insertingNodePreview,
    required TResult Function(InsertingGroupPreview value)
        insertingGroupPreview,
  }) {
    return insertingGroupPreview(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(Idle value)? idle,
    TResult? Function(DragNode value)? dragNode,
    TResult? Function(DragEdge value)? dragEdge,
    TResult? Function(DragWaypoint value)? dragWaypoint,
    TResult? Function(PanCanvas value)? panCanvas,
    TResult? Function(SelectingArea value)? selectingArea,
    TResult? Function(InsertingNode value)? insertingNode,
    TResult? Function(InsertNodeToEdge value)? insertNodeToEdge,
    TResult? Function(ResizingNode value)? resizingNode,
    TResult? Function(HoveringNode value)? hoveringNode,
    TResult? Function(HoveringAnchor value)? hoveringAnchor,
    TResult? Function(HoveringEdge value)? hoveringEdge,
    TResult? Function(ContextMenuOpen value)? contextMenuOpen,
    TResult? Function(InsertingNodePreview value)? insertingNodePreview,
    TResult? Function(InsertingGroupPreview value)? insertingGroupPreview,
  }) {
    return insertingGroupPreview?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(Idle value)? idle,
    TResult Function(DragNode value)? dragNode,
    TResult Function(DragEdge value)? dragEdge,
    TResult Function(DragWaypoint value)? dragWaypoint,
    TResult Function(PanCanvas value)? panCanvas,
    TResult Function(SelectingArea value)? selectingArea,
    TResult Function(InsertingNode value)? insertingNode,
    TResult Function(InsertNodeToEdge value)? insertNodeToEdge,
    TResult Function(ResizingNode value)? resizingNode,
    TResult Function(HoveringNode value)? hoveringNode,
    TResult Function(HoveringAnchor value)? hoveringAnchor,
    TResult Function(HoveringEdge value)? hoveringEdge,
    TResult Function(ContextMenuOpen value)? contextMenuOpen,
    TResult Function(InsertingNodePreview value)? insertingNodePreview,
    TResult Function(InsertingGroupPreview value)? insertingGroupPreview,
    required TResult orElse(),
  }) {
    if (insertingGroupPreview != null) {
      return insertingGroupPreview(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$InsertingGroupPreviewImplToJson(
      this,
    );
  }
}

abstract class InsertingGroupPreview extends InteractionState {
  const factory InsertingGroupPreview(
      {required final CanvasInsertElement groupElement,
      @OffsetConverter() required final Offset canvasPos,
      final String? highlightedEdgeId}) = _$InsertingGroupPreviewImpl;
  const InsertingGroupPreview._() : super._();

  factory InsertingGroupPreview.fromJson(Map<String, dynamic> json) =
      _$InsertingGroupPreviewImpl.fromJson;

  CanvasInsertElement get groupElement;
  @OffsetConverter()
  Offset get canvasPos;
  String? get highlightedEdgeId;
  @JsonKey(ignore: true)
  _$$InsertingGroupPreviewImplCopyWith<_$InsertingGroupPreviewImpl>
      get copyWith => throw _privateConstructorUsedError;
}
