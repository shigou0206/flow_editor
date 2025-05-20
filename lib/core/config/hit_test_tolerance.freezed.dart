// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'hit_test_tolerance.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

HitTestTolerance _$HitTestToleranceFromJson(Map<String, dynamic> json) {
  return _HitTestTolerance.fromJson(json);
}

/// @nodoc
mixin _$HitTestTolerance {
  /// 命中 Anchor 的半径阈值（默认 20 像素）
  double get anchor => throw _privateConstructorUsedError;

  /// 命中 Edge 的路径距离容差（默认 6 像素）
  double get edge => throw _privateConstructorUsedError;

  /// 命中 Waypoint（边拐点）的容差（默认 8 像素）
  double get waypoint => throw _privateConstructorUsedError;

  /// 命中 Resize Handle 的容差（默认 10 像素）
  double get resizeHandle => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $HitTestToleranceCopyWith<HitTestTolerance> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $HitTestToleranceCopyWith<$Res> {
  factory $HitTestToleranceCopyWith(
          HitTestTolerance value, $Res Function(HitTestTolerance) then) =
      _$HitTestToleranceCopyWithImpl<$Res, HitTestTolerance>;
  @useResult
  $Res call({double anchor, double edge, double waypoint, double resizeHandle});
}

/// @nodoc
class _$HitTestToleranceCopyWithImpl<$Res, $Val extends HitTestTolerance>
    implements $HitTestToleranceCopyWith<$Res> {
  _$HitTestToleranceCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? anchor = null,
    Object? edge = null,
    Object? waypoint = null,
    Object? resizeHandle = null,
  }) {
    return _then(_value.copyWith(
      anchor: null == anchor
          ? _value.anchor
          : anchor // ignore: cast_nullable_to_non_nullable
              as double,
      edge: null == edge
          ? _value.edge
          : edge // ignore: cast_nullable_to_non_nullable
              as double,
      waypoint: null == waypoint
          ? _value.waypoint
          : waypoint // ignore: cast_nullable_to_non_nullable
              as double,
      resizeHandle: null == resizeHandle
          ? _value.resizeHandle
          : resizeHandle // ignore: cast_nullable_to_non_nullable
              as double,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$HitTestToleranceImplCopyWith<$Res>
    implements $HitTestToleranceCopyWith<$Res> {
  factory _$$HitTestToleranceImplCopyWith(_$HitTestToleranceImpl value,
          $Res Function(_$HitTestToleranceImpl) then) =
      __$$HitTestToleranceImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({double anchor, double edge, double waypoint, double resizeHandle});
}

/// @nodoc
class __$$HitTestToleranceImplCopyWithImpl<$Res>
    extends _$HitTestToleranceCopyWithImpl<$Res, _$HitTestToleranceImpl>
    implements _$$HitTestToleranceImplCopyWith<$Res> {
  __$$HitTestToleranceImplCopyWithImpl(_$HitTestToleranceImpl _value,
      $Res Function(_$HitTestToleranceImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? anchor = null,
    Object? edge = null,
    Object? waypoint = null,
    Object? resizeHandle = null,
  }) {
    return _then(_$HitTestToleranceImpl(
      anchor: null == anchor
          ? _value.anchor
          : anchor // ignore: cast_nullable_to_non_nullable
              as double,
      edge: null == edge
          ? _value.edge
          : edge // ignore: cast_nullable_to_non_nullable
              as double,
      waypoint: null == waypoint
          ? _value.waypoint
          : waypoint // ignore: cast_nullable_to_non_nullable
              as double,
      resizeHandle: null == resizeHandle
          ? _value.resizeHandle
          : resizeHandle // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$HitTestToleranceImpl implements _HitTestTolerance {
  const _$HitTestToleranceImpl(
      {this.anchor = 20.0,
      this.edge = 6.0,
      this.waypoint = 8.0,
      this.resizeHandle = 10.0});

  factory _$HitTestToleranceImpl.fromJson(Map<String, dynamic> json) =>
      _$$HitTestToleranceImplFromJson(json);

  /// 命中 Anchor 的半径阈值（默认 20 像素）
  @override
  @JsonKey()
  final double anchor;

  /// 命中 Edge 的路径距离容差（默认 6 像素）
  @override
  @JsonKey()
  final double edge;

  /// 命中 Waypoint（边拐点）的容差（默认 8 像素）
  @override
  @JsonKey()
  final double waypoint;

  /// 命中 Resize Handle 的容差（默认 10 像素）
  @override
  @JsonKey()
  final double resizeHandle;

  @override
  String toString() {
    return 'HitTestTolerance(anchor: $anchor, edge: $edge, waypoint: $waypoint, resizeHandle: $resizeHandle)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$HitTestToleranceImpl &&
            (identical(other.anchor, anchor) || other.anchor == anchor) &&
            (identical(other.edge, edge) || other.edge == edge) &&
            (identical(other.waypoint, waypoint) ||
                other.waypoint == waypoint) &&
            (identical(other.resizeHandle, resizeHandle) ||
                other.resizeHandle == resizeHandle));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, anchor, edge, waypoint, resizeHandle);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$HitTestToleranceImplCopyWith<_$HitTestToleranceImpl> get copyWith =>
      __$$HitTestToleranceImplCopyWithImpl<_$HitTestToleranceImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$HitTestToleranceImplToJson(
      this,
    );
  }
}

abstract class _HitTestTolerance implements HitTestTolerance {
  const factory _HitTestTolerance(
      {final double anchor,
      final double edge,
      final double waypoint,
      final double resizeHandle}) = _$HitTestToleranceImpl;

  factory _HitTestTolerance.fromJson(Map<String, dynamic> json) =
      _$HitTestToleranceImpl.fromJson;

  @override

  /// 命中 Anchor 的半径阈值（默认 20 像素）
  double get anchor;
  @override

  /// 命中 Edge 的路径距离容差（默认 6 像素）
  double get edge;
  @override

  /// 命中 Waypoint（边拐点）的容差（默认 8 像素）
  double get waypoint;
  @override

  /// 命中 Resize Handle 的容差（默认 10 像素）
  double get resizeHandle;
  @override
  @JsonKey(ignore: true)
  _$$HitTestToleranceImplCopyWith<_$HitTestToleranceImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
