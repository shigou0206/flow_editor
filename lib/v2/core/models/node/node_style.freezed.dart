// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'node_style.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

NodeStyle _$NodeStyleFromJson(Map<String, dynamic> json) {
  return _NodeStyle.fromJson(json);
}

/// @nodoc
mixin _$NodeStyle {
  @ColorHexConverter()
  Color? get fillColor => throw _privateConstructorUsedError;
  @ColorHexConverter()
  Color? get borderColor => throw _privateConstructorUsedError;
  double get borderWidth => throw _privateConstructorUsedError;
  double get borderRadius => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $NodeStyleCopyWith<NodeStyle> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $NodeStyleCopyWith<$Res> {
  factory $NodeStyleCopyWith(NodeStyle value, $Res Function(NodeStyle) then) =
      _$NodeStyleCopyWithImpl<$Res, NodeStyle>;
  @useResult
  $Res call(
      {@ColorHexConverter() Color? fillColor,
      @ColorHexConverter() Color? borderColor,
      double borderWidth,
      double borderRadius});
}

/// @nodoc
class _$NodeStyleCopyWithImpl<$Res, $Val extends NodeStyle>
    implements $NodeStyleCopyWith<$Res> {
  _$NodeStyleCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? fillColor = freezed,
    Object? borderColor = freezed,
    Object? borderWidth = null,
    Object? borderRadius = null,
  }) {
    return _then(_value.copyWith(
      fillColor: freezed == fillColor
          ? _value.fillColor
          : fillColor // ignore: cast_nullable_to_non_nullable
              as Color?,
      borderColor: freezed == borderColor
          ? _value.borderColor
          : borderColor // ignore: cast_nullable_to_non_nullable
              as Color?,
      borderWidth: null == borderWidth
          ? _value.borderWidth
          : borderWidth // ignore: cast_nullable_to_non_nullable
              as double,
      borderRadius: null == borderRadius
          ? _value.borderRadius
          : borderRadius // ignore: cast_nullable_to_non_nullable
              as double,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$NodeStyleImplCopyWith<$Res>
    implements $NodeStyleCopyWith<$Res> {
  factory _$$NodeStyleImplCopyWith(
          _$NodeStyleImpl value, $Res Function(_$NodeStyleImpl) then) =
      __$$NodeStyleImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@ColorHexConverter() Color? fillColor,
      @ColorHexConverter() Color? borderColor,
      double borderWidth,
      double borderRadius});
}

/// @nodoc
class __$$NodeStyleImplCopyWithImpl<$Res>
    extends _$NodeStyleCopyWithImpl<$Res, _$NodeStyleImpl>
    implements _$$NodeStyleImplCopyWith<$Res> {
  __$$NodeStyleImplCopyWithImpl(
      _$NodeStyleImpl _value, $Res Function(_$NodeStyleImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? fillColor = freezed,
    Object? borderColor = freezed,
    Object? borderWidth = null,
    Object? borderRadius = null,
  }) {
    return _then(_$NodeStyleImpl(
      fillColor: freezed == fillColor
          ? _value.fillColor
          : fillColor // ignore: cast_nullable_to_non_nullable
              as Color?,
      borderColor: freezed == borderColor
          ? _value.borderColor
          : borderColor // ignore: cast_nullable_to_non_nullable
              as Color?,
      borderWidth: null == borderWidth
          ? _value.borderWidth
          : borderWidth // ignore: cast_nullable_to_non_nullable
              as double,
      borderRadius: null == borderRadius
          ? _value.borderRadius
          : borderRadius // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$NodeStyleImpl extends _NodeStyle {
  const _$NodeStyleImpl(
      {@ColorHexConverter() this.fillColor,
      @ColorHexConverter() this.borderColor,
      this.borderWidth = 1.0,
      this.borderRadius = 4.0})
      : super._();

  factory _$NodeStyleImpl.fromJson(Map<String, dynamic> json) =>
      _$$NodeStyleImplFromJson(json);

  @override
  @ColorHexConverter()
  final Color? fillColor;
  @override
  @ColorHexConverter()
  final Color? borderColor;
  @override
  @JsonKey()
  final double borderWidth;
  @override
  @JsonKey()
  final double borderRadius;

  @override
  String toString() {
    return 'NodeStyle(fillColor: $fillColor, borderColor: $borderColor, borderWidth: $borderWidth, borderRadius: $borderRadius)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$NodeStyleImpl &&
            (identical(other.fillColor, fillColor) ||
                other.fillColor == fillColor) &&
            (identical(other.borderColor, borderColor) ||
                other.borderColor == borderColor) &&
            (identical(other.borderWidth, borderWidth) ||
                other.borderWidth == borderWidth) &&
            (identical(other.borderRadius, borderRadius) ||
                other.borderRadius == borderRadius));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType, fillColor, borderColor, borderWidth, borderRadius);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$NodeStyleImplCopyWith<_$NodeStyleImpl> get copyWith =>
      __$$NodeStyleImplCopyWithImpl<_$NodeStyleImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$NodeStyleImplToJson(
      this,
    );
  }
}

abstract class _NodeStyle extends NodeStyle {
  const factory _NodeStyle(
      {@ColorHexConverter() final Color? fillColor,
      @ColorHexConverter() final Color? borderColor,
      final double borderWidth,
      final double borderRadius}) = _$NodeStyleImpl;
  const _NodeStyle._() : super._();

  factory _NodeStyle.fromJson(Map<String, dynamic> json) =
      _$NodeStyleImpl.fromJson;

  @override
  @ColorHexConverter()
  Color? get fillColor;
  @override
  @ColorHexConverter()
  Color? get borderColor;
  @override
  double get borderWidth;
  @override
  double get borderRadius;
  @override
  @JsonKey(ignore: true)
  _$$NodeStyleImplCopyWith<_$NodeStyleImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
