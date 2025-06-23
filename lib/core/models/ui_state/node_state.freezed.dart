// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'node_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

NodeState _$NodeStateFromJson(Map<String, dynamic> json) {
  return _NodeState.fromJson(json);
}

/// @nodoc
mixin _$NodeState {
  List<NodeModel> get nodes => throw _privateConstructorUsedError;
  int get version => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $NodeStateCopyWith<NodeState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $NodeStateCopyWith<$Res> {
  factory $NodeStateCopyWith(NodeState value, $Res Function(NodeState) then) =
      _$NodeStateCopyWithImpl<$Res, NodeState>;
  @useResult
  $Res call({List<NodeModel> nodes, int version});
}

/// @nodoc
class _$NodeStateCopyWithImpl<$Res, $Val extends NodeState>
    implements $NodeStateCopyWith<$Res> {
  _$NodeStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? nodes = null,
    Object? version = null,
  }) {
    return _then(_value.copyWith(
      nodes: null == nodes
          ? _value.nodes
          : nodes // ignore: cast_nullable_to_non_nullable
              as List<NodeModel>,
      version: null == version
          ? _value.version
          : version // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$NodeStateImplCopyWith<$Res>
    implements $NodeStateCopyWith<$Res> {
  factory _$$NodeStateImplCopyWith(
          _$NodeStateImpl value, $Res Function(_$NodeStateImpl) then) =
      __$$NodeStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({List<NodeModel> nodes, int version});
}

/// @nodoc
class __$$NodeStateImplCopyWithImpl<$Res>
    extends _$NodeStateCopyWithImpl<$Res, _$NodeStateImpl>
    implements _$$NodeStateImplCopyWith<$Res> {
  __$$NodeStateImplCopyWithImpl(
      _$NodeStateImpl _value, $Res Function(_$NodeStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? nodes = null,
    Object? version = null,
  }) {
    return _then(_$NodeStateImpl(
      nodes: null == nodes
          ? _value._nodes
          : nodes // ignore: cast_nullable_to_non_nullable
              as List<NodeModel>,
      version: null == version
          ? _value.version
          : version // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$NodeStateImpl extends _NodeState {
  const _$NodeStateImpl(
      {final List<NodeModel> nodes = const [], this.version = 1})
      : _nodes = nodes,
        super._();

  factory _$NodeStateImpl.fromJson(Map<String, dynamic> json) =>
      _$$NodeStateImplFromJson(json);

  final List<NodeModel> _nodes;
  @override
  @JsonKey()
  List<NodeModel> get nodes {
    if (_nodes is EqualUnmodifiableListView) return _nodes;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_nodes);
  }

  @override
  @JsonKey()
  final int version;

  @override
  String toString() {
    return 'NodeState(nodes: $nodes, version: $version)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$NodeStateImpl &&
            const DeepCollectionEquality().equals(other._nodes, _nodes) &&
            (identical(other.version, version) || other.version == version));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType, const DeepCollectionEquality().hash(_nodes), version);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$NodeStateImplCopyWith<_$NodeStateImpl> get copyWith =>
      __$$NodeStateImplCopyWithImpl<_$NodeStateImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$NodeStateImplToJson(
      this,
    );
  }
}

abstract class _NodeState extends NodeState {
  const factory _NodeState({final List<NodeModel> nodes, final int version}) =
      _$NodeStateImpl;
  const _NodeState._() : super._();

  factory _NodeState.fromJson(Map<String, dynamic> json) =
      _$NodeStateImpl.fromJson;

  @override
  List<NodeModel> get nodes;
  @override
  int get version;
  @override
  @JsonKey(ignore: true)
  _$$NodeStateImplCopyWith<_$NodeStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
