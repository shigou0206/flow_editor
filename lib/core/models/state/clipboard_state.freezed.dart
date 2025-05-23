// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'clipboard_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

ClipboardState _$ClipboardStateFromJson(Map<String, dynamic> json) {
  return _ClipboardState.fromJson(json);
}

/// @nodoc
mixin _$ClipboardState {
  List<NodeModel> get nodes => throw _privateConstructorUsedError;
  List<EdgeModel> get edges => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ClipboardStateCopyWith<ClipboardState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ClipboardStateCopyWith<$Res> {
  factory $ClipboardStateCopyWith(
          ClipboardState value, $Res Function(ClipboardState) then) =
      _$ClipboardStateCopyWithImpl<$Res, ClipboardState>;
  @useResult
  $Res call({List<NodeModel> nodes, List<EdgeModel> edges});
}

/// @nodoc
class _$ClipboardStateCopyWithImpl<$Res, $Val extends ClipboardState>
    implements $ClipboardStateCopyWith<$Res> {
  _$ClipboardStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? nodes = null,
    Object? edges = null,
  }) {
    return _then(_value.copyWith(
      nodes: null == nodes
          ? _value.nodes
          : nodes // ignore: cast_nullable_to_non_nullable
              as List<NodeModel>,
      edges: null == edges
          ? _value.edges
          : edges // ignore: cast_nullable_to_non_nullable
              as List<EdgeModel>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ClipboardStateImplCopyWith<$Res>
    implements $ClipboardStateCopyWith<$Res> {
  factory _$$ClipboardStateImplCopyWith(_$ClipboardStateImpl value,
          $Res Function(_$ClipboardStateImpl) then) =
      __$$ClipboardStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({List<NodeModel> nodes, List<EdgeModel> edges});
}

/// @nodoc
class __$$ClipboardStateImplCopyWithImpl<$Res>
    extends _$ClipboardStateCopyWithImpl<$Res, _$ClipboardStateImpl>
    implements _$$ClipboardStateImplCopyWith<$Res> {
  __$$ClipboardStateImplCopyWithImpl(
      _$ClipboardStateImpl _value, $Res Function(_$ClipboardStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? nodes = null,
    Object? edges = null,
  }) {
    return _then(_$ClipboardStateImpl(
      nodes: null == nodes
          ? _value._nodes
          : nodes // ignore: cast_nullable_to_non_nullable
              as List<NodeModel>,
      edges: null == edges
          ? _value._edges
          : edges // ignore: cast_nullable_to_non_nullable
              as List<EdgeModel>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ClipboardStateImpl implements _ClipboardState {
  const _$ClipboardStateImpl(
      {final List<NodeModel> nodes = const [],
      final List<EdgeModel> edges = const []})
      : _nodes = nodes,
        _edges = edges;

  factory _$ClipboardStateImpl.fromJson(Map<String, dynamic> json) =>
      _$$ClipboardStateImplFromJson(json);

  final List<NodeModel> _nodes;
  @override
  @JsonKey()
  List<NodeModel> get nodes {
    if (_nodes is EqualUnmodifiableListView) return _nodes;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_nodes);
  }

  final List<EdgeModel> _edges;
  @override
  @JsonKey()
  List<EdgeModel> get edges {
    if (_edges is EqualUnmodifiableListView) return _edges;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_edges);
  }

  @override
  String toString() {
    return 'ClipboardState(nodes: $nodes, edges: $edges)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ClipboardStateImpl &&
            const DeepCollectionEquality().equals(other._nodes, _nodes) &&
            const DeepCollectionEquality().equals(other._edges, _edges));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_nodes),
      const DeepCollectionEquality().hash(_edges));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ClipboardStateImplCopyWith<_$ClipboardStateImpl> get copyWith =>
      __$$ClipboardStateImplCopyWithImpl<_$ClipboardStateImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ClipboardStateImplToJson(
      this,
    );
  }
}

abstract class _ClipboardState implements ClipboardState {
  const factory _ClipboardState(
      {final List<NodeModel> nodes,
      final List<EdgeModel> edges}) = _$ClipboardStateImpl;

  factory _ClipboardState.fromJson(Map<String, dynamic> json) =
      _$ClipboardStateImpl.fromJson;

  @override
  List<NodeModel> get nodes;
  @override
  List<EdgeModel> get edges;
  @override
  @JsonKey(ignore: true)
  _$$ClipboardStateImplCopyWith<_$ClipboardStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
