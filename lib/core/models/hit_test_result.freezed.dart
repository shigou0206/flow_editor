// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'hit_test_result.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

ResizeHitResult _$ResizeHitResultFromJson(Map<String, dynamic> json) {
  return _ResizeHitResult.fromJson(json);
}

/// @nodoc
mixin _$ResizeHitResult {
  String get nodeId => throw _privateConstructorUsedError;
  ResizeHandlePosition get handle => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ResizeHitResultCopyWith<ResizeHitResult> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ResizeHitResultCopyWith<$Res> {
  factory $ResizeHitResultCopyWith(
          ResizeHitResult value, $Res Function(ResizeHitResult) then) =
      _$ResizeHitResultCopyWithImpl<$Res, ResizeHitResult>;
  @useResult
  $Res call({String nodeId, ResizeHandlePosition handle});
}

/// @nodoc
class _$ResizeHitResultCopyWithImpl<$Res, $Val extends ResizeHitResult>
    implements $ResizeHitResultCopyWith<$Res> {
  _$ResizeHitResultCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? nodeId = null,
    Object? handle = null,
  }) {
    return _then(_value.copyWith(
      nodeId: null == nodeId
          ? _value.nodeId
          : nodeId // ignore: cast_nullable_to_non_nullable
              as String,
      handle: null == handle
          ? _value.handle
          : handle // ignore: cast_nullable_to_non_nullable
              as ResizeHandlePosition,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ResizeHitResultImplCopyWith<$Res>
    implements $ResizeHitResultCopyWith<$Res> {
  factory _$$ResizeHitResultImplCopyWith(_$ResizeHitResultImpl value,
          $Res Function(_$ResizeHitResultImpl) then) =
      __$$ResizeHitResultImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String nodeId, ResizeHandlePosition handle});
}

/// @nodoc
class __$$ResizeHitResultImplCopyWithImpl<$Res>
    extends _$ResizeHitResultCopyWithImpl<$Res, _$ResizeHitResultImpl>
    implements _$$ResizeHitResultImplCopyWith<$Res> {
  __$$ResizeHitResultImplCopyWithImpl(
      _$ResizeHitResultImpl _value, $Res Function(_$ResizeHitResultImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? nodeId = null,
    Object? handle = null,
  }) {
    return _then(_$ResizeHitResultImpl(
      nodeId: null == nodeId
          ? _value.nodeId
          : nodeId // ignore: cast_nullable_to_non_nullable
              as String,
      handle: null == handle
          ? _value.handle
          : handle // ignore: cast_nullable_to_non_nullable
              as ResizeHandlePosition,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ResizeHitResultImpl implements _ResizeHitResult {
  const _$ResizeHitResultImpl({required this.nodeId, required this.handle});

  factory _$ResizeHitResultImpl.fromJson(Map<String, dynamic> json) =>
      _$$ResizeHitResultImplFromJson(json);

  @override
  final String nodeId;
  @override
  final ResizeHandlePosition handle;

  @override
  String toString() {
    return 'ResizeHitResult(nodeId: $nodeId, handle: $handle)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ResizeHitResultImpl &&
            (identical(other.nodeId, nodeId) || other.nodeId == nodeId) &&
            (identical(other.handle, handle) || other.handle == handle));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, nodeId, handle);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ResizeHitResultImplCopyWith<_$ResizeHitResultImpl> get copyWith =>
      __$$ResizeHitResultImplCopyWithImpl<_$ResizeHitResultImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ResizeHitResultImplToJson(
      this,
    );
  }
}

abstract class _ResizeHitResult implements ResizeHitResult {
  const factory _ResizeHitResult(
      {required final String nodeId,
      required final ResizeHandlePosition handle}) = _$ResizeHitResultImpl;

  factory _ResizeHitResult.fromJson(Map<String, dynamic> json) =
      _$ResizeHitResultImpl.fromJson;

  @override
  String get nodeId;
  @override
  ResizeHandlePosition get handle;
  @override
  @JsonKey(ignore: true)
  _$$ResizeHitResultImplCopyWith<_$ResizeHitResultImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

EdgeUiHitResult _$EdgeUiHitResultFromJson(Map<String, dynamic> json) {
  return _EdgeUiHitResult.fromJson(json);
}

/// @nodoc
mixin _$EdgeUiHitResult {
  String get edgeId => throw _privateConstructorUsedError;
  String get type => throw _privateConstructorUsedError;
  @RectConverter()
  Rect get bounds => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $EdgeUiHitResultCopyWith<EdgeUiHitResult> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $EdgeUiHitResultCopyWith<$Res> {
  factory $EdgeUiHitResultCopyWith(
          EdgeUiHitResult value, $Res Function(EdgeUiHitResult) then) =
      _$EdgeUiHitResultCopyWithImpl<$Res, EdgeUiHitResult>;
  @useResult
  $Res call({String edgeId, String type, @RectConverter() Rect bounds});
}

/// @nodoc
class _$EdgeUiHitResultCopyWithImpl<$Res, $Val extends EdgeUiHitResult>
    implements $EdgeUiHitResultCopyWith<$Res> {
  _$EdgeUiHitResultCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? edgeId = null,
    Object? type = null,
    Object? bounds = null,
  }) {
    return _then(_value.copyWith(
      edgeId: null == edgeId
          ? _value.edgeId
          : edgeId // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
      bounds: null == bounds
          ? _value.bounds
          : bounds // ignore: cast_nullable_to_non_nullable
              as Rect,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$EdgeUiHitResultImplCopyWith<$Res>
    implements $EdgeUiHitResultCopyWith<$Res> {
  factory _$$EdgeUiHitResultImplCopyWith(_$EdgeUiHitResultImpl value,
          $Res Function(_$EdgeUiHitResultImpl) then) =
      __$$EdgeUiHitResultImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String edgeId, String type, @RectConverter() Rect bounds});
}

/// @nodoc
class __$$EdgeUiHitResultImplCopyWithImpl<$Res>
    extends _$EdgeUiHitResultCopyWithImpl<$Res, _$EdgeUiHitResultImpl>
    implements _$$EdgeUiHitResultImplCopyWith<$Res> {
  __$$EdgeUiHitResultImplCopyWithImpl(
      _$EdgeUiHitResultImpl _value, $Res Function(_$EdgeUiHitResultImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? edgeId = null,
    Object? type = null,
    Object? bounds = null,
  }) {
    return _then(_$EdgeUiHitResultImpl(
      edgeId: null == edgeId
          ? _value.edgeId
          : edgeId // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
      bounds: null == bounds
          ? _value.bounds
          : bounds // ignore: cast_nullable_to_non_nullable
              as Rect,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$EdgeUiHitResultImpl implements _EdgeUiHitResult {
  const _$EdgeUiHitResultImpl(
      {required this.edgeId,
      required this.type,
      @RectConverter() required this.bounds});

  factory _$EdgeUiHitResultImpl.fromJson(Map<String, dynamic> json) =>
      _$$EdgeUiHitResultImplFromJson(json);

  @override
  final String edgeId;
  @override
  final String type;
  @override
  @RectConverter()
  final Rect bounds;

  @override
  String toString() {
    return 'EdgeUiHitResult(edgeId: $edgeId, type: $type, bounds: $bounds)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$EdgeUiHitResultImpl &&
            (identical(other.edgeId, edgeId) || other.edgeId == edgeId) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.bounds, bounds) || other.bounds == bounds));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, edgeId, type, bounds);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$EdgeUiHitResultImplCopyWith<_$EdgeUiHitResultImpl> get copyWith =>
      __$$EdgeUiHitResultImplCopyWithImpl<_$EdgeUiHitResultImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$EdgeUiHitResultImplToJson(
      this,
    );
  }
}

abstract class _EdgeUiHitResult implements EdgeUiHitResult {
  const factory _EdgeUiHitResult(
      {required final String edgeId,
      required final String type,
      @RectConverter() required final Rect bounds}) = _$EdgeUiHitResultImpl;

  factory _EdgeUiHitResult.fromJson(Map<String, dynamic> json) =
      _$EdgeUiHitResultImpl.fromJson;

  @override
  String get edgeId;
  @override
  String get type;
  @override
  @RectConverter()
  Rect get bounds;
  @override
  @JsonKey(ignore: true)
  _$$EdgeUiHitResultImplCopyWith<_$EdgeUiHitResultImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

EdgeWaypointHitResult _$EdgeWaypointHitResultFromJson(
    Map<String, dynamic> json) {
  return _EdgeWaypointHitResult.fromJson(json);
}

/// @nodoc
mixin _$EdgeWaypointHitResult {
  String get edgeId => throw _privateConstructorUsedError;
  int get index => throw _privateConstructorUsedError;
  @OffsetConverter()
  Offset get center => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $EdgeWaypointHitResultCopyWith<EdgeWaypointHitResult> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $EdgeWaypointHitResultCopyWith<$Res> {
  factory $EdgeWaypointHitResultCopyWith(EdgeWaypointHitResult value,
          $Res Function(EdgeWaypointHitResult) then) =
      _$EdgeWaypointHitResultCopyWithImpl<$Res, EdgeWaypointHitResult>;
  @useResult
  $Res call({String edgeId, int index, @OffsetConverter() Offset center});
}

/// @nodoc
class _$EdgeWaypointHitResultCopyWithImpl<$Res,
        $Val extends EdgeWaypointHitResult>
    implements $EdgeWaypointHitResultCopyWith<$Res> {
  _$EdgeWaypointHitResultCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? edgeId = null,
    Object? index = null,
    Object? center = null,
  }) {
    return _then(_value.copyWith(
      edgeId: null == edgeId
          ? _value.edgeId
          : edgeId // ignore: cast_nullable_to_non_nullable
              as String,
      index: null == index
          ? _value.index
          : index // ignore: cast_nullable_to_non_nullable
              as int,
      center: null == center
          ? _value.center
          : center // ignore: cast_nullable_to_non_nullable
              as Offset,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$EdgeWaypointHitResultImplCopyWith<$Res>
    implements $EdgeWaypointHitResultCopyWith<$Res> {
  factory _$$EdgeWaypointHitResultImplCopyWith(
          _$EdgeWaypointHitResultImpl value,
          $Res Function(_$EdgeWaypointHitResultImpl) then) =
      __$$EdgeWaypointHitResultImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String edgeId, int index, @OffsetConverter() Offset center});
}

/// @nodoc
class __$$EdgeWaypointHitResultImplCopyWithImpl<$Res>
    extends _$EdgeWaypointHitResultCopyWithImpl<$Res,
        _$EdgeWaypointHitResultImpl>
    implements _$$EdgeWaypointHitResultImplCopyWith<$Res> {
  __$$EdgeWaypointHitResultImplCopyWithImpl(_$EdgeWaypointHitResultImpl _value,
      $Res Function(_$EdgeWaypointHitResultImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? edgeId = null,
    Object? index = null,
    Object? center = null,
  }) {
    return _then(_$EdgeWaypointHitResultImpl(
      edgeId: null == edgeId
          ? _value.edgeId
          : edgeId // ignore: cast_nullable_to_non_nullable
              as String,
      index: null == index
          ? _value.index
          : index // ignore: cast_nullable_to_non_nullable
              as int,
      center: null == center
          ? _value.center
          : center // ignore: cast_nullable_to_non_nullable
              as Offset,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$EdgeWaypointHitResultImpl implements _EdgeWaypointHitResult {
  const _$EdgeWaypointHitResultImpl(
      {required this.edgeId,
      required this.index,
      @OffsetConverter() required this.center});

  factory _$EdgeWaypointHitResultImpl.fromJson(Map<String, dynamic> json) =>
      _$$EdgeWaypointHitResultImplFromJson(json);

  @override
  final String edgeId;
  @override
  final int index;
  @override
  @OffsetConverter()
  final Offset center;

  @override
  String toString() {
    return 'EdgeWaypointHitResult(edgeId: $edgeId, index: $index, center: $center)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$EdgeWaypointHitResultImpl &&
            (identical(other.edgeId, edgeId) || other.edgeId == edgeId) &&
            (identical(other.index, index) || other.index == index) &&
            (identical(other.center, center) || other.center == center));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, edgeId, index, center);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$EdgeWaypointHitResultImplCopyWith<_$EdgeWaypointHitResultImpl>
      get copyWith => __$$EdgeWaypointHitResultImplCopyWithImpl<
          _$EdgeWaypointHitResultImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$EdgeWaypointHitResultImplToJson(
      this,
    );
  }
}

abstract class _EdgeWaypointHitResult implements EdgeWaypointHitResult {
  const factory _EdgeWaypointHitResult(
          {required final String edgeId,
          required final int index,
          @OffsetConverter() required final Offset center}) =
      _$EdgeWaypointHitResultImpl;

  factory _EdgeWaypointHitResult.fromJson(Map<String, dynamic> json) =
      _$EdgeWaypointHitResultImpl.fromJson;

  @override
  String get edgeId;
  @override
  int get index;
  @override
  @OffsetConverter()
  Offset get center;
  @override
  @JsonKey(ignore: true)
  _$$EdgeWaypointHitResultImplCopyWith<_$EdgeWaypointHitResultImpl>
      get copyWith => throw _privateConstructorUsedError;
}

FloatingAnchorHitResult _$FloatingAnchorHitResultFromJson(
    Map<String, dynamic> json) {
  return _FloatingAnchorHitResult.fromJson(json);
}

/// @nodoc
mixin _$FloatingAnchorHitResult {
  String get nodeId => throw _privateConstructorUsedError;
  @OffsetConverter()
  Offset get center => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $FloatingAnchorHitResultCopyWith<FloatingAnchorHitResult> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FloatingAnchorHitResultCopyWith<$Res> {
  factory $FloatingAnchorHitResultCopyWith(FloatingAnchorHitResult value,
          $Res Function(FloatingAnchorHitResult) then) =
      _$FloatingAnchorHitResultCopyWithImpl<$Res, FloatingAnchorHitResult>;
  @useResult
  $Res call({String nodeId, @OffsetConverter() Offset center});
}

/// @nodoc
class _$FloatingAnchorHitResultCopyWithImpl<$Res,
        $Val extends FloatingAnchorHitResult>
    implements $FloatingAnchorHitResultCopyWith<$Res> {
  _$FloatingAnchorHitResultCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? nodeId = null,
    Object? center = null,
  }) {
    return _then(_value.copyWith(
      nodeId: null == nodeId
          ? _value.nodeId
          : nodeId // ignore: cast_nullable_to_non_nullable
              as String,
      center: null == center
          ? _value.center
          : center // ignore: cast_nullable_to_non_nullable
              as Offset,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$FloatingAnchorHitResultImplCopyWith<$Res>
    implements $FloatingAnchorHitResultCopyWith<$Res> {
  factory _$$FloatingAnchorHitResultImplCopyWith(
          _$FloatingAnchorHitResultImpl value,
          $Res Function(_$FloatingAnchorHitResultImpl) then) =
      __$$FloatingAnchorHitResultImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String nodeId, @OffsetConverter() Offset center});
}

/// @nodoc
class __$$FloatingAnchorHitResultImplCopyWithImpl<$Res>
    extends _$FloatingAnchorHitResultCopyWithImpl<$Res,
        _$FloatingAnchorHitResultImpl>
    implements _$$FloatingAnchorHitResultImplCopyWith<$Res> {
  __$$FloatingAnchorHitResultImplCopyWithImpl(
      _$FloatingAnchorHitResultImpl _value,
      $Res Function(_$FloatingAnchorHitResultImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? nodeId = null,
    Object? center = null,
  }) {
    return _then(_$FloatingAnchorHitResultImpl(
      nodeId: null == nodeId
          ? _value.nodeId
          : nodeId // ignore: cast_nullable_to_non_nullable
              as String,
      center: null == center
          ? _value.center
          : center // ignore: cast_nullable_to_non_nullable
              as Offset,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$FloatingAnchorHitResultImpl implements _FloatingAnchorHitResult {
  const _$FloatingAnchorHitResultImpl(
      {required this.nodeId, @OffsetConverter() required this.center});

  factory _$FloatingAnchorHitResultImpl.fromJson(Map<String, dynamic> json) =>
      _$$FloatingAnchorHitResultImplFromJson(json);

  @override
  final String nodeId;
  @override
  @OffsetConverter()
  final Offset center;

  @override
  String toString() {
    return 'FloatingAnchorHitResult(nodeId: $nodeId, center: $center)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FloatingAnchorHitResultImpl &&
            (identical(other.nodeId, nodeId) || other.nodeId == nodeId) &&
            (identical(other.center, center) || other.center == center));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, nodeId, center);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$FloatingAnchorHitResultImplCopyWith<_$FloatingAnchorHitResultImpl>
      get copyWith => __$$FloatingAnchorHitResultImplCopyWithImpl<
          _$FloatingAnchorHitResultImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$FloatingAnchorHitResultImplToJson(
      this,
    );
  }
}

abstract class _FloatingAnchorHitResult implements FloatingAnchorHitResult {
  const factory _FloatingAnchorHitResult(
          {required final String nodeId,
          @OffsetConverter() required final Offset center}) =
      _$FloatingAnchorHitResultImpl;

  factory _FloatingAnchorHitResult.fromJson(Map<String, dynamic> json) =
      _$FloatingAnchorHitResultImpl.fromJson;

  @override
  String get nodeId;
  @override
  @OffsetConverter()
  Offset get center;
  @override
  @JsonKey(ignore: true)
  _$$FloatingAnchorHitResultImplCopyWith<_$FloatingAnchorHitResultImpl>
      get copyWith => throw _privateConstructorUsedError;
}

InsertTargetHitResult _$InsertTargetHitResultFromJson(
    Map<String, dynamic> json) {
  return _InsertTargetHitResult.fromJson(json);
}

/// @nodoc
mixin _$InsertTargetHitResult {
  String get targetType =>
      throw _privateConstructorUsedError; // 'node' | 'edge'
  String get targetId => throw _privateConstructorUsedError;
  @OffsetConverter()
  Offset get position => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $InsertTargetHitResultCopyWith<InsertTargetHitResult> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $InsertTargetHitResultCopyWith<$Res> {
  factory $InsertTargetHitResultCopyWith(InsertTargetHitResult value,
          $Res Function(InsertTargetHitResult) then) =
      _$InsertTargetHitResultCopyWithImpl<$Res, InsertTargetHitResult>;
  @useResult
  $Res call(
      {String targetType, String targetId, @OffsetConverter() Offset position});
}

/// @nodoc
class _$InsertTargetHitResultCopyWithImpl<$Res,
        $Val extends InsertTargetHitResult>
    implements $InsertTargetHitResultCopyWith<$Res> {
  _$InsertTargetHitResultCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? targetType = null,
    Object? targetId = null,
    Object? position = null,
  }) {
    return _then(_value.copyWith(
      targetType: null == targetType
          ? _value.targetType
          : targetType // ignore: cast_nullable_to_non_nullable
              as String,
      targetId: null == targetId
          ? _value.targetId
          : targetId // ignore: cast_nullable_to_non_nullable
              as String,
      position: null == position
          ? _value.position
          : position // ignore: cast_nullable_to_non_nullable
              as Offset,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$InsertTargetHitResultImplCopyWith<$Res>
    implements $InsertTargetHitResultCopyWith<$Res> {
  factory _$$InsertTargetHitResultImplCopyWith(
          _$InsertTargetHitResultImpl value,
          $Res Function(_$InsertTargetHitResultImpl) then) =
      __$$InsertTargetHitResultImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String targetType, String targetId, @OffsetConverter() Offset position});
}

/// @nodoc
class __$$InsertTargetHitResultImplCopyWithImpl<$Res>
    extends _$InsertTargetHitResultCopyWithImpl<$Res,
        _$InsertTargetHitResultImpl>
    implements _$$InsertTargetHitResultImplCopyWith<$Res> {
  __$$InsertTargetHitResultImplCopyWithImpl(_$InsertTargetHitResultImpl _value,
      $Res Function(_$InsertTargetHitResultImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? targetType = null,
    Object? targetId = null,
    Object? position = null,
  }) {
    return _then(_$InsertTargetHitResultImpl(
      targetType: null == targetType
          ? _value.targetType
          : targetType // ignore: cast_nullable_to_non_nullable
              as String,
      targetId: null == targetId
          ? _value.targetId
          : targetId // ignore: cast_nullable_to_non_nullable
              as String,
      position: null == position
          ? _value.position
          : position // ignore: cast_nullable_to_non_nullable
              as Offset,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$InsertTargetHitResultImpl implements _InsertTargetHitResult {
  const _$InsertTargetHitResultImpl(
      {required this.targetType,
      required this.targetId,
      @OffsetConverter() required this.position});

  factory _$InsertTargetHitResultImpl.fromJson(Map<String, dynamic> json) =>
      _$$InsertTargetHitResultImplFromJson(json);

  @override
  final String targetType;
// 'node' | 'edge'
  @override
  final String targetId;
  @override
  @OffsetConverter()
  final Offset position;

  @override
  String toString() {
    return 'InsertTargetHitResult(targetType: $targetType, targetId: $targetId, position: $position)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$InsertTargetHitResultImpl &&
            (identical(other.targetType, targetType) ||
                other.targetType == targetType) &&
            (identical(other.targetId, targetId) ||
                other.targetId == targetId) &&
            (identical(other.position, position) ||
                other.position == position));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, targetType, targetId, position);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$InsertTargetHitResultImplCopyWith<_$InsertTargetHitResultImpl>
      get copyWith => __$$InsertTargetHitResultImplCopyWithImpl<
          _$InsertTargetHitResultImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$InsertTargetHitResultImplToJson(
      this,
    );
  }
}

abstract class _InsertTargetHitResult implements InsertTargetHitResult {
  const factory _InsertTargetHitResult(
          {required final String targetType,
          required final String targetId,
          @OffsetConverter() required final Offset position}) =
      _$InsertTargetHitResultImpl;

  factory _InsertTargetHitResult.fromJson(Map<String, dynamic> json) =
      _$InsertTargetHitResultImpl.fromJson;

  @override
  String get targetType;
  @override // 'node' | 'edge'
  String get targetId;
  @override
  @OffsetConverter()
  Offset get position;
  @override
  @JsonKey(ignore: true)
  _$$InsertTargetHitResultImplCopyWith<_$InsertTargetHitResultImpl>
      get copyWith => throw _privateConstructorUsedError;
}

AnchorHitResult _$AnchorHitResultFromJson(Map<String, dynamic> json) {
  return _AnchorHitResult.fromJson(json);
}

/// @nodoc
mixin _$AnchorHitResult {
  String get nodeId => throw _privateConstructorUsedError;
  AnchorModel get anchor => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $AnchorHitResultCopyWith<AnchorHitResult> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AnchorHitResultCopyWith<$Res> {
  factory $AnchorHitResultCopyWith(
          AnchorHitResult value, $Res Function(AnchorHitResult) then) =
      _$AnchorHitResultCopyWithImpl<$Res, AnchorHitResult>;
  @useResult
  $Res call({String nodeId, AnchorModel anchor});

  $AnchorModelCopyWith<$Res> get anchor;
}

/// @nodoc
class _$AnchorHitResultCopyWithImpl<$Res, $Val extends AnchorHitResult>
    implements $AnchorHitResultCopyWith<$Res> {
  _$AnchorHitResultCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? nodeId = null,
    Object? anchor = null,
  }) {
    return _then(_value.copyWith(
      nodeId: null == nodeId
          ? _value.nodeId
          : nodeId // ignore: cast_nullable_to_non_nullable
              as String,
      anchor: null == anchor
          ? _value.anchor
          : anchor // ignore: cast_nullable_to_non_nullable
              as AnchorModel,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $AnchorModelCopyWith<$Res> get anchor {
    return $AnchorModelCopyWith<$Res>(_value.anchor, (value) {
      return _then(_value.copyWith(anchor: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$AnchorHitResultImplCopyWith<$Res>
    implements $AnchorHitResultCopyWith<$Res> {
  factory _$$AnchorHitResultImplCopyWith(_$AnchorHitResultImpl value,
          $Res Function(_$AnchorHitResultImpl) then) =
      __$$AnchorHitResultImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String nodeId, AnchorModel anchor});

  @override
  $AnchorModelCopyWith<$Res> get anchor;
}

/// @nodoc
class __$$AnchorHitResultImplCopyWithImpl<$Res>
    extends _$AnchorHitResultCopyWithImpl<$Res, _$AnchorHitResultImpl>
    implements _$$AnchorHitResultImplCopyWith<$Res> {
  __$$AnchorHitResultImplCopyWithImpl(
      _$AnchorHitResultImpl _value, $Res Function(_$AnchorHitResultImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? nodeId = null,
    Object? anchor = null,
  }) {
    return _then(_$AnchorHitResultImpl(
      nodeId: null == nodeId
          ? _value.nodeId
          : nodeId // ignore: cast_nullable_to_non_nullable
              as String,
      anchor: null == anchor
          ? _value.anchor
          : anchor // ignore: cast_nullable_to_non_nullable
              as AnchorModel,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$AnchorHitResultImpl implements _AnchorHitResult {
  const _$AnchorHitResultImpl({required this.nodeId, required this.anchor});

  factory _$AnchorHitResultImpl.fromJson(Map<String, dynamic> json) =>
      _$$AnchorHitResultImplFromJson(json);

  @override
  final String nodeId;
  @override
  final AnchorModel anchor;

  @override
  String toString() {
    return 'AnchorHitResult(nodeId: $nodeId, anchor: $anchor)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AnchorHitResultImpl &&
            (identical(other.nodeId, nodeId) || other.nodeId == nodeId) &&
            (identical(other.anchor, anchor) || other.anchor == anchor));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, nodeId, anchor);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$AnchorHitResultImplCopyWith<_$AnchorHitResultImpl> get copyWith =>
      __$$AnchorHitResultImplCopyWithImpl<_$AnchorHitResultImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AnchorHitResultImplToJson(
      this,
    );
  }
}

abstract class _AnchorHitResult implements AnchorHitResult {
  const factory _AnchorHitResult(
      {required final String nodeId,
      required final AnchorModel anchor}) = _$AnchorHitResultImpl;

  factory _AnchorHitResult.fromJson(Map<String, dynamic> json) =
      _$AnchorHitResultImpl.fromJson;

  @override
  String get nodeId;
  @override
  AnchorModel get anchor;
  @override
  @JsonKey(ignore: true)
  _$$AnchorHitResultImplCopyWith<_$AnchorHitResultImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

EdgeWaypointPathHitResult _$EdgeWaypointPathHitResultFromJson(
    Map<String, dynamic> json) {
  return _EdgeWaypointPathHitResult.fromJson(json);
}

/// @nodoc
mixin _$EdgeWaypointPathHitResult {
  String get edgeId => throw _privateConstructorUsedError;
  @OffsetConverter()
  Offset get nearestPoint => throw _privateConstructorUsedError; // 命中线段上离鼠标最近的点
  double get distance => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $EdgeWaypointPathHitResultCopyWith<EdgeWaypointPathHitResult> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $EdgeWaypointPathHitResultCopyWith<$Res> {
  factory $EdgeWaypointPathHitResultCopyWith(EdgeWaypointPathHitResult value,
          $Res Function(EdgeWaypointPathHitResult) then) =
      _$EdgeWaypointPathHitResultCopyWithImpl<$Res, EdgeWaypointPathHitResult>;
  @useResult
  $Res call(
      {String edgeId, @OffsetConverter() Offset nearestPoint, double distance});
}

/// @nodoc
class _$EdgeWaypointPathHitResultCopyWithImpl<$Res,
        $Val extends EdgeWaypointPathHitResult>
    implements $EdgeWaypointPathHitResultCopyWith<$Res> {
  _$EdgeWaypointPathHitResultCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? edgeId = null,
    Object? nearestPoint = null,
    Object? distance = null,
  }) {
    return _then(_value.copyWith(
      edgeId: null == edgeId
          ? _value.edgeId
          : edgeId // ignore: cast_nullable_to_non_nullable
              as String,
      nearestPoint: null == nearestPoint
          ? _value.nearestPoint
          : nearestPoint // ignore: cast_nullable_to_non_nullable
              as Offset,
      distance: null == distance
          ? _value.distance
          : distance // ignore: cast_nullable_to_non_nullable
              as double,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$EdgeWaypointPathHitResultImplCopyWith<$Res>
    implements $EdgeWaypointPathHitResultCopyWith<$Res> {
  factory _$$EdgeWaypointPathHitResultImplCopyWith(
          _$EdgeWaypointPathHitResultImpl value,
          $Res Function(_$EdgeWaypointPathHitResultImpl) then) =
      __$$EdgeWaypointPathHitResultImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String edgeId, @OffsetConverter() Offset nearestPoint, double distance});
}

/// @nodoc
class __$$EdgeWaypointPathHitResultImplCopyWithImpl<$Res>
    extends _$EdgeWaypointPathHitResultCopyWithImpl<$Res,
        _$EdgeWaypointPathHitResultImpl>
    implements _$$EdgeWaypointPathHitResultImplCopyWith<$Res> {
  __$$EdgeWaypointPathHitResultImplCopyWithImpl(
      _$EdgeWaypointPathHitResultImpl _value,
      $Res Function(_$EdgeWaypointPathHitResultImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? edgeId = null,
    Object? nearestPoint = null,
    Object? distance = null,
  }) {
    return _then(_$EdgeWaypointPathHitResultImpl(
      edgeId: null == edgeId
          ? _value.edgeId
          : edgeId // ignore: cast_nullable_to_non_nullable
              as String,
      nearestPoint: null == nearestPoint
          ? _value.nearestPoint
          : nearestPoint // ignore: cast_nullable_to_non_nullable
              as Offset,
      distance: null == distance
          ? _value.distance
          : distance // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$EdgeWaypointPathHitResultImpl implements _EdgeWaypointPathHitResult {
  const _$EdgeWaypointPathHitResultImpl(
      {required this.edgeId,
      @OffsetConverter() required this.nearestPoint,
      required this.distance});

  factory _$EdgeWaypointPathHitResultImpl.fromJson(Map<String, dynamic> json) =>
      _$$EdgeWaypointPathHitResultImplFromJson(json);

  @override
  final String edgeId;
  @override
  @OffsetConverter()
  final Offset nearestPoint;
// 命中线段上离鼠标最近的点
  @override
  final double distance;

  @override
  String toString() {
    return 'EdgeWaypointPathHitResult(edgeId: $edgeId, nearestPoint: $nearestPoint, distance: $distance)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$EdgeWaypointPathHitResultImpl &&
            (identical(other.edgeId, edgeId) || other.edgeId == edgeId) &&
            (identical(other.nearestPoint, nearestPoint) ||
                other.nearestPoint == nearestPoint) &&
            (identical(other.distance, distance) ||
                other.distance == distance));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, edgeId, nearestPoint, distance);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$EdgeWaypointPathHitResultImplCopyWith<_$EdgeWaypointPathHitResultImpl>
      get copyWith => __$$EdgeWaypointPathHitResultImplCopyWithImpl<
          _$EdgeWaypointPathHitResultImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$EdgeWaypointPathHitResultImplToJson(
      this,
    );
  }
}

abstract class _EdgeWaypointPathHitResult implements EdgeWaypointPathHitResult {
  const factory _EdgeWaypointPathHitResult(
      {required final String edgeId,
      @OffsetConverter() required final Offset nearestPoint,
      required final double distance}) = _$EdgeWaypointPathHitResultImpl;

  factory _EdgeWaypointPathHitResult.fromJson(Map<String, dynamic> json) =
      _$EdgeWaypointPathHitResultImpl.fromJson;

  @override
  String get edgeId;
  @override
  @OffsetConverter()
  Offset get nearestPoint;
  @override // 命中线段上离鼠标最近的点
  double get distance;
  @override
  @JsonKey(ignore: true)
  _$$EdgeWaypointPathHitResultImplCopyWith<_$EdgeWaypointPathHitResultImpl>
      get copyWith => throw _privateConstructorUsedError;
}
