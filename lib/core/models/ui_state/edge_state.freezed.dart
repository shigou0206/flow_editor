// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'edge_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

EdgeState _$EdgeStateFromJson(Map<String, dynamic> json) {
  return _EdgeState.fromJson(json);
}

/// @nodoc
mixin _$EdgeState {
  List<EdgeModel> get edges => throw _privateConstructorUsedError;
  Map<String, Set<String>> get edgeIdsByType =>
      throw _privateConstructorUsedError;
  int get version => throw _privateConstructorUsedError;
  Set<String> get selectedEdgeIds => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $EdgeStateCopyWith<EdgeState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $EdgeStateCopyWith<$Res> {
  factory $EdgeStateCopyWith(EdgeState value, $Res Function(EdgeState) then) =
      _$EdgeStateCopyWithImpl<$Res, EdgeState>;
  @useResult
  $Res call(
      {List<EdgeModel> edges,
      Map<String, Set<String>> edgeIdsByType,
      int version,
      Set<String> selectedEdgeIds});
}

/// @nodoc
class _$EdgeStateCopyWithImpl<$Res, $Val extends EdgeState>
    implements $EdgeStateCopyWith<$Res> {
  _$EdgeStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? edges = null,
    Object? edgeIdsByType = null,
    Object? version = null,
    Object? selectedEdgeIds = null,
  }) {
    return _then(_value.copyWith(
      edges: null == edges
          ? _value.edges
          : edges // ignore: cast_nullable_to_non_nullable
              as List<EdgeModel>,
      edgeIdsByType: null == edgeIdsByType
          ? _value.edgeIdsByType
          : edgeIdsByType // ignore: cast_nullable_to_non_nullable
              as Map<String, Set<String>>,
      version: null == version
          ? _value.version
          : version // ignore: cast_nullable_to_non_nullable
              as int,
      selectedEdgeIds: null == selectedEdgeIds
          ? _value.selectedEdgeIds
          : selectedEdgeIds // ignore: cast_nullable_to_non_nullable
              as Set<String>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$EdgeStateImplCopyWith<$Res>
    implements $EdgeStateCopyWith<$Res> {
  factory _$$EdgeStateImplCopyWith(
          _$EdgeStateImpl value, $Res Function(_$EdgeStateImpl) then) =
      __$$EdgeStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {List<EdgeModel> edges,
      Map<String, Set<String>> edgeIdsByType,
      int version,
      Set<String> selectedEdgeIds});
}

/// @nodoc
class __$$EdgeStateImplCopyWithImpl<$Res>
    extends _$EdgeStateCopyWithImpl<$Res, _$EdgeStateImpl>
    implements _$$EdgeStateImplCopyWith<$Res> {
  __$$EdgeStateImplCopyWithImpl(
      _$EdgeStateImpl _value, $Res Function(_$EdgeStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? edges = null,
    Object? edgeIdsByType = null,
    Object? version = null,
    Object? selectedEdgeIds = null,
  }) {
    return _then(_$EdgeStateImpl(
      edges: null == edges
          ? _value._edges
          : edges // ignore: cast_nullable_to_non_nullable
              as List<EdgeModel>,
      edgeIdsByType: null == edgeIdsByType
          ? _value._edgeIdsByType
          : edgeIdsByType // ignore: cast_nullable_to_non_nullable
              as Map<String, Set<String>>,
      version: null == version
          ? _value.version
          : version // ignore: cast_nullable_to_non_nullable
              as int,
      selectedEdgeIds: null == selectedEdgeIds
          ? _value._selectedEdgeIds
          : selectedEdgeIds // ignore: cast_nullable_to_non_nullable
              as Set<String>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$EdgeStateImpl extends _EdgeState {
  const _$EdgeStateImpl(
      {final List<EdgeModel> edges = const [],
      final Map<String, Set<String>> edgeIdsByType = const {},
      this.version = 1,
      final Set<String> selectedEdgeIds = const {}})
      : _edges = edges,
        _edgeIdsByType = edgeIdsByType,
        _selectedEdgeIds = selectedEdgeIds,
        super._();

  factory _$EdgeStateImpl.fromJson(Map<String, dynamic> json) =>
      _$$EdgeStateImplFromJson(json);

  final List<EdgeModel> _edges;
  @override
  @JsonKey()
  List<EdgeModel> get edges {
    if (_edges is EqualUnmodifiableListView) return _edges;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_edges);
  }

  final Map<String, Set<String>> _edgeIdsByType;
  @override
  @JsonKey()
  Map<String, Set<String>> get edgeIdsByType {
    if (_edgeIdsByType is EqualUnmodifiableMapView) return _edgeIdsByType;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_edgeIdsByType);
  }

  @override
  @JsonKey()
  final int version;
  final Set<String> _selectedEdgeIds;
  @override
  @JsonKey()
  Set<String> get selectedEdgeIds {
    if (_selectedEdgeIds is EqualUnmodifiableSetView) return _selectedEdgeIds;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableSetView(_selectedEdgeIds);
  }

  @override
  String toString() {
    return 'EdgeState(edges: $edges, edgeIdsByType: $edgeIdsByType, version: $version, selectedEdgeIds: $selectedEdgeIds)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$EdgeStateImpl &&
            const DeepCollectionEquality().equals(other._edges, _edges) &&
            const DeepCollectionEquality()
                .equals(other._edgeIdsByType, _edgeIdsByType) &&
            (identical(other.version, version) || other.version == version) &&
            const DeepCollectionEquality()
                .equals(other._selectedEdgeIds, _selectedEdgeIds));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_edges),
      const DeepCollectionEquality().hash(_edgeIdsByType),
      version,
      const DeepCollectionEquality().hash(_selectedEdgeIds));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$EdgeStateImplCopyWith<_$EdgeStateImpl> get copyWith =>
      __$$EdgeStateImplCopyWithImpl<_$EdgeStateImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$EdgeStateImplToJson(
      this,
    );
  }
}

abstract class _EdgeState extends EdgeState {
  const factory _EdgeState(
      {final List<EdgeModel> edges,
      final Map<String, Set<String>> edgeIdsByType,
      final int version,
      final Set<String> selectedEdgeIds}) = _$EdgeStateImpl;
  const _EdgeState._() : super._();

  factory _EdgeState.fromJson(Map<String, dynamic> json) =
      _$EdgeStateImpl.fromJson;

  @override
  List<EdgeModel> get edges;
  @override
  Map<String, Set<String>> get edgeIdsByType;
  @override
  int get version;
  @override
  Set<String> get selectedEdgeIds;
  @override
  @JsonKey(ignore: true)
  _$$EdgeStateImplCopyWith<_$EdgeStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
