// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'editor_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

EditorState _$EditorStateFromJson(Map<String, dynamic> json) {
  return _EditorState.fromJson(json);
}

/// @nodoc
mixin _$EditorState {
  Map<String, CanvasState> get canvases => throw _privateConstructorUsedError;
  String get activeWorkflowId => throw _privateConstructorUsedError;
  NodeState get nodes => throw _privateConstructorUsedError;
  EdgeState get edges => throw _privateConstructorUsedError;
  CanvasViewportState get viewport => throw _privateConstructorUsedError;
  SelectionState get selection => throw _privateConstructorUsedError;
  InteractionState get interaction => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $EditorStateCopyWith<EditorState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $EditorStateCopyWith<$Res> {
  factory $EditorStateCopyWith(
          EditorState value, $Res Function(EditorState) then) =
      _$EditorStateCopyWithImpl<$Res, EditorState>;
  @useResult
  $Res call(
      {Map<String, CanvasState> canvases,
      String activeWorkflowId,
      NodeState nodes,
      EdgeState edges,
      CanvasViewportState viewport,
      SelectionState selection,
      InteractionState interaction});

  $NodeStateCopyWith<$Res> get nodes;
  $EdgeStateCopyWith<$Res> get edges;
  $CanvasViewportStateCopyWith<$Res> get viewport;
  $InteractionStateCopyWith<$Res> get interaction;
}

/// @nodoc
class _$EditorStateCopyWithImpl<$Res, $Val extends EditorState>
    implements $EditorStateCopyWith<$Res> {
  _$EditorStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? canvases = null,
    Object? activeWorkflowId = null,
    Object? nodes = null,
    Object? edges = null,
    Object? viewport = null,
    Object? selection = null,
    Object? interaction = null,
  }) {
    return _then(_value.copyWith(
      canvases: null == canvases
          ? _value.canvases
          : canvases // ignore: cast_nullable_to_non_nullable
              as Map<String, CanvasState>,
      activeWorkflowId: null == activeWorkflowId
          ? _value.activeWorkflowId
          : activeWorkflowId // ignore: cast_nullable_to_non_nullable
              as String,
      nodes: null == nodes
          ? _value.nodes
          : nodes // ignore: cast_nullable_to_non_nullable
              as NodeState,
      edges: null == edges
          ? _value.edges
          : edges // ignore: cast_nullable_to_non_nullable
              as EdgeState,
      viewport: null == viewport
          ? _value.viewport
          : viewport // ignore: cast_nullable_to_non_nullable
              as CanvasViewportState,
      selection: null == selection
          ? _value.selection
          : selection // ignore: cast_nullable_to_non_nullable
              as SelectionState,
      interaction: null == interaction
          ? _value.interaction
          : interaction // ignore: cast_nullable_to_non_nullable
              as InteractionState,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $NodeStateCopyWith<$Res> get nodes {
    return $NodeStateCopyWith<$Res>(_value.nodes, (value) {
      return _then(_value.copyWith(nodes: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $EdgeStateCopyWith<$Res> get edges {
    return $EdgeStateCopyWith<$Res>(_value.edges, (value) {
      return _then(_value.copyWith(edges: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $CanvasViewportStateCopyWith<$Res> get viewport {
    return $CanvasViewportStateCopyWith<$Res>(_value.viewport, (value) {
      return _then(_value.copyWith(viewport: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $InteractionStateCopyWith<$Res> get interaction {
    return $InteractionStateCopyWith<$Res>(_value.interaction, (value) {
      return _then(_value.copyWith(interaction: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$EditorStateImplCopyWith<$Res>
    implements $EditorStateCopyWith<$Res> {
  factory _$$EditorStateImplCopyWith(
          _$EditorStateImpl value, $Res Function(_$EditorStateImpl) then) =
      __$$EditorStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {Map<String, CanvasState> canvases,
      String activeWorkflowId,
      NodeState nodes,
      EdgeState edges,
      CanvasViewportState viewport,
      SelectionState selection,
      InteractionState interaction});

  @override
  $NodeStateCopyWith<$Res> get nodes;
  @override
  $EdgeStateCopyWith<$Res> get edges;
  @override
  $CanvasViewportStateCopyWith<$Res> get viewport;
  @override
  $InteractionStateCopyWith<$Res> get interaction;
}

/// @nodoc
class __$$EditorStateImplCopyWithImpl<$Res>
    extends _$EditorStateCopyWithImpl<$Res, _$EditorStateImpl>
    implements _$$EditorStateImplCopyWith<$Res> {
  __$$EditorStateImplCopyWithImpl(
      _$EditorStateImpl _value, $Res Function(_$EditorStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? canvases = null,
    Object? activeWorkflowId = null,
    Object? nodes = null,
    Object? edges = null,
    Object? viewport = null,
    Object? selection = null,
    Object? interaction = null,
  }) {
    return _then(_$EditorStateImpl(
      canvases: null == canvases
          ? _value._canvases
          : canvases // ignore: cast_nullable_to_non_nullable
              as Map<String, CanvasState>,
      activeWorkflowId: null == activeWorkflowId
          ? _value.activeWorkflowId
          : activeWorkflowId // ignore: cast_nullable_to_non_nullable
              as String,
      nodes: null == nodes
          ? _value.nodes
          : nodes // ignore: cast_nullable_to_non_nullable
              as NodeState,
      edges: null == edges
          ? _value.edges
          : edges // ignore: cast_nullable_to_non_nullable
              as EdgeState,
      viewport: null == viewport
          ? _value.viewport
          : viewport // ignore: cast_nullable_to_non_nullable
              as CanvasViewportState,
      selection: null == selection
          ? _value.selection
          : selection // ignore: cast_nullable_to_non_nullable
              as SelectionState,
      interaction: null == interaction
          ? _value.interaction
          : interaction // ignore: cast_nullable_to_non_nullable
              as InteractionState,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$EditorStateImpl extends _EditorState {
  const _$EditorStateImpl(
      {required final Map<String, CanvasState> canvases,
      required this.activeWorkflowId,
      required this.nodes,
      required this.edges,
      this.viewport = const CanvasViewportState(),
      this.selection = const SelectionState(),
      this.interaction = const InteractionState.idle()})
      : _canvases = canvases,
        super._();

  factory _$EditorStateImpl.fromJson(Map<String, dynamic> json) =>
      _$$EditorStateImplFromJson(json);

  final Map<String, CanvasState> _canvases;
  @override
  Map<String, CanvasState> get canvases {
    if (_canvases is EqualUnmodifiableMapView) return _canvases;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_canvases);
  }

  @override
  final String activeWorkflowId;
  @override
  final NodeState nodes;
  @override
  final EdgeState edges;
  @override
  @JsonKey()
  final CanvasViewportState viewport;
  @override
  @JsonKey()
  final SelectionState selection;
  @override
  @JsonKey()
  final InteractionState interaction;

  @override
  String toString() {
    return 'EditorState(canvases: $canvases, activeWorkflowId: $activeWorkflowId, nodes: $nodes, edges: $edges, viewport: $viewport, selection: $selection, interaction: $interaction)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$EditorStateImpl &&
            const DeepCollectionEquality().equals(other._canvases, _canvases) &&
            (identical(other.activeWorkflowId, activeWorkflowId) ||
                other.activeWorkflowId == activeWorkflowId) &&
            (identical(other.nodes, nodes) || other.nodes == nodes) &&
            (identical(other.edges, edges) || other.edges == edges) &&
            (identical(other.viewport, viewport) ||
                other.viewport == viewport) &&
            (identical(other.selection, selection) ||
                other.selection == selection) &&
            (identical(other.interaction, interaction) ||
                other.interaction == interaction));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_canvases),
      activeWorkflowId,
      nodes,
      edges,
      viewport,
      selection,
      interaction);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$EditorStateImplCopyWith<_$EditorStateImpl> get copyWith =>
      __$$EditorStateImplCopyWithImpl<_$EditorStateImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$EditorStateImplToJson(
      this,
    );
  }
}

abstract class _EditorState extends EditorState {
  const factory _EditorState(
      {required final Map<String, CanvasState> canvases,
      required final String activeWorkflowId,
      required final NodeState nodes,
      required final EdgeState edges,
      final CanvasViewportState viewport,
      final SelectionState selection,
      final InteractionState interaction}) = _$EditorStateImpl;
  const _EditorState._() : super._();

  factory _EditorState.fromJson(Map<String, dynamic> json) =
      _$EditorStateImpl.fromJson;

  @override
  Map<String, CanvasState> get canvases;
  @override
  String get activeWorkflowId;
  @override
  NodeState get nodes;
  @override
  EdgeState get edges;
  @override
  CanvasViewportState get viewport;
  @override
  SelectionState get selection;
  @override
  InteractionState get interaction;
  @override
  @JsonKey(ignore: true)
  _$$EditorStateImplCopyWith<_$EditorStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
