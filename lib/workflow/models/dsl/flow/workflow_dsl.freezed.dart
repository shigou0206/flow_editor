// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'workflow_dsl.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

WorkflowDSL _$WorkflowDSLFromJson(Map<String, dynamic> json) {
  return _WorkflowDSL.fromJson(json);
}

/// @nodoc
mixin _$WorkflowDSL {
  String? get comment => throw _privateConstructorUsedError;
  String get version => throw _privateConstructorUsedError;
  String get startAt =>
      throw _privateConstructorUsedError; // ignore: invalid_annotation_target
  @JsonKey(includeIfNull: false)
  Map<String, dynamic>? get globalConfig =>
      throw _privateConstructorUsedError; // ignore: invalid_annotation_target
  @JsonKey(includeIfNull: false)
  Map<String, dynamic>? get errorHandling => throw _privateConstructorUsedError;
  Map<String, WorkflowState> get states => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $WorkflowDSLCopyWith<WorkflowDSL> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $WorkflowDSLCopyWith<$Res> {
  factory $WorkflowDSLCopyWith(
          WorkflowDSL value, $Res Function(WorkflowDSL) then) =
      _$WorkflowDSLCopyWithImpl<$Res, WorkflowDSL>;
  @useResult
  $Res call(
      {String? comment,
      String version,
      String startAt,
      @JsonKey(includeIfNull: false) Map<String, dynamic>? globalConfig,
      @JsonKey(includeIfNull: false) Map<String, dynamic>? errorHandling,
      Map<String, WorkflowState> states});
}

/// @nodoc
class _$WorkflowDSLCopyWithImpl<$Res, $Val extends WorkflowDSL>
    implements $WorkflowDSLCopyWith<$Res> {
  _$WorkflowDSLCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? comment = freezed,
    Object? version = null,
    Object? startAt = null,
    Object? globalConfig = freezed,
    Object? errorHandling = freezed,
    Object? states = null,
  }) {
    return _then(_value.copyWith(
      comment: freezed == comment
          ? _value.comment
          : comment // ignore: cast_nullable_to_non_nullable
              as String?,
      version: null == version
          ? _value.version
          : version // ignore: cast_nullable_to_non_nullable
              as String,
      startAt: null == startAt
          ? _value.startAt
          : startAt // ignore: cast_nullable_to_non_nullable
              as String,
      globalConfig: freezed == globalConfig
          ? _value.globalConfig
          : globalConfig // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
      errorHandling: freezed == errorHandling
          ? _value.errorHandling
          : errorHandling // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
      states: null == states
          ? _value.states
          : states // ignore: cast_nullable_to_non_nullable
              as Map<String, WorkflowState>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$WorkflowDSLImplCopyWith<$Res>
    implements $WorkflowDSLCopyWith<$Res> {
  factory _$$WorkflowDSLImplCopyWith(
          _$WorkflowDSLImpl value, $Res Function(_$WorkflowDSLImpl) then) =
      __$$WorkflowDSLImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? comment,
      String version,
      String startAt,
      @JsonKey(includeIfNull: false) Map<String, dynamic>? globalConfig,
      @JsonKey(includeIfNull: false) Map<String, dynamic>? errorHandling,
      Map<String, WorkflowState> states});
}

/// @nodoc
class __$$WorkflowDSLImplCopyWithImpl<$Res>
    extends _$WorkflowDSLCopyWithImpl<$Res, _$WorkflowDSLImpl>
    implements _$$WorkflowDSLImplCopyWith<$Res> {
  __$$WorkflowDSLImplCopyWithImpl(
      _$WorkflowDSLImpl _value, $Res Function(_$WorkflowDSLImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? comment = freezed,
    Object? version = null,
    Object? startAt = null,
    Object? globalConfig = freezed,
    Object? errorHandling = freezed,
    Object? states = null,
  }) {
    return _then(_$WorkflowDSLImpl(
      comment: freezed == comment
          ? _value.comment
          : comment // ignore: cast_nullable_to_non_nullable
              as String?,
      version: null == version
          ? _value.version
          : version // ignore: cast_nullable_to_non_nullable
              as String,
      startAt: null == startAt
          ? _value.startAt
          : startAt // ignore: cast_nullable_to_non_nullable
              as String,
      globalConfig: freezed == globalConfig
          ? _value._globalConfig
          : globalConfig // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
      errorHandling: freezed == errorHandling
          ? _value._errorHandling
          : errorHandling // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
      states: null == states
          ? _value._states
          : states // ignore: cast_nullable_to_non_nullable
              as Map<String, WorkflowState>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$WorkflowDSLImpl implements _WorkflowDSL {
  const _$WorkflowDSLImpl(
      {this.comment,
      this.version = '1.0.0',
      required this.startAt,
      @JsonKey(includeIfNull: false) final Map<String, dynamic>? globalConfig,
      @JsonKey(includeIfNull: false) final Map<String, dynamic>? errorHandling,
      required final Map<String, WorkflowState> states})
      : _globalConfig = globalConfig,
        _errorHandling = errorHandling,
        _states = states;

  factory _$WorkflowDSLImpl.fromJson(Map<String, dynamic> json) =>
      _$$WorkflowDSLImplFromJson(json);

  @override
  final String? comment;
  @override
  @JsonKey()
  final String version;
  @override
  final String startAt;
// ignore: invalid_annotation_target
  final Map<String, dynamic>? _globalConfig;
// ignore: invalid_annotation_target
  @override
  @JsonKey(includeIfNull: false)
  Map<String, dynamic>? get globalConfig {
    final value = _globalConfig;
    if (value == null) return null;
    if (_globalConfig is EqualUnmodifiableMapView) return _globalConfig;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

// ignore: invalid_annotation_target
  final Map<String, dynamic>? _errorHandling;
// ignore: invalid_annotation_target
  @override
  @JsonKey(includeIfNull: false)
  Map<String, dynamic>? get errorHandling {
    final value = _errorHandling;
    if (value == null) return null;
    if (_errorHandling is EqualUnmodifiableMapView) return _errorHandling;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

  final Map<String, WorkflowState> _states;
  @override
  Map<String, WorkflowState> get states {
    if (_states is EqualUnmodifiableMapView) return _states;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_states);
  }

  @override
  String toString() {
    return 'WorkflowDSL(comment: $comment, version: $version, startAt: $startAt, globalConfig: $globalConfig, errorHandling: $errorHandling, states: $states)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$WorkflowDSLImpl &&
            (identical(other.comment, comment) || other.comment == comment) &&
            (identical(other.version, version) || other.version == version) &&
            (identical(other.startAt, startAt) || other.startAt == startAt) &&
            const DeepCollectionEquality()
                .equals(other._globalConfig, _globalConfig) &&
            const DeepCollectionEquality()
                .equals(other._errorHandling, _errorHandling) &&
            const DeepCollectionEquality().equals(other._states, _states));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      comment,
      version,
      startAt,
      const DeepCollectionEquality().hash(_globalConfig),
      const DeepCollectionEquality().hash(_errorHandling),
      const DeepCollectionEquality().hash(_states));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$WorkflowDSLImplCopyWith<_$WorkflowDSLImpl> get copyWith =>
      __$$WorkflowDSLImplCopyWithImpl<_$WorkflowDSLImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$WorkflowDSLImplToJson(
      this,
    );
  }
}

abstract class _WorkflowDSL implements WorkflowDSL {
  const factory _WorkflowDSL(
      {final String? comment,
      final String version,
      required final String startAt,
      @JsonKey(includeIfNull: false) final Map<String, dynamic>? globalConfig,
      @JsonKey(includeIfNull: false) final Map<String, dynamic>? errorHandling,
      required final Map<String, WorkflowState> states}) = _$WorkflowDSLImpl;

  factory _WorkflowDSL.fromJson(Map<String, dynamic> json) =
      _$WorkflowDSLImpl.fromJson;

  @override
  String? get comment;
  @override
  String get version;
  @override
  String get startAt;
  @override // ignore: invalid_annotation_target
  @JsonKey(includeIfNull: false)
  Map<String, dynamic>? get globalConfig;
  @override // ignore: invalid_annotation_target
  @JsonKey(includeIfNull: false)
  Map<String, dynamic>? get errorHandling;
  @override
  Map<String, WorkflowState> get states;
  @override
  @JsonKey(ignore: true)
  _$$WorkflowDSLImplCopyWith<_$WorkflowDSLImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
