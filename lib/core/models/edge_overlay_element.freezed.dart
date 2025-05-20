// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'edge_overlay_element.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

EdgeOverlayElement _$EdgeOverlayElementFromJson(Map<String, dynamic> json) {
  return _EdgeOverlayElement.fromJson(json);
}

/// @nodoc
mixin _$EdgeOverlayElement {
  String get id => throw _privateConstructorUsedError; // 唯一标识（可用于编辑或点击）
  String get type =>
      throw _privateConstructorUsedError; // 'label', 'button:add', 'icon:warn'...
  /// 路径上的相对位置（0.0 ~ 1.0）
  double get positionRatio => throw _privateConstructorUsedError;

  /// 相对于路径切线方向的偏移方向（上/下/左/右）
  OverlayDirection get direction => throw _privateConstructorUsedError;

  /// 偏移量（单位：像素）
  @OffsetConverter()
  Offset get offset => throw _privateConstructorUsedError;

  /// 元素的尺寸（用于布局和 hitTest）
  @SizeConverter()
  Size? get size => throw _privateConstructorUsedError;

  /// 附加数据
  Map<String, dynamic>? get data => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $EdgeOverlayElementCopyWith<EdgeOverlayElement> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $EdgeOverlayElementCopyWith<$Res> {
  factory $EdgeOverlayElementCopyWith(
          EdgeOverlayElement value, $Res Function(EdgeOverlayElement) then) =
      _$EdgeOverlayElementCopyWithImpl<$Res, EdgeOverlayElement>;
  @useResult
  $Res call(
      {String id,
      String type,
      double positionRatio,
      OverlayDirection direction,
      @OffsetConverter() Offset offset,
      @SizeConverter() Size? size,
      Map<String, dynamic>? data});
}

/// @nodoc
class _$EdgeOverlayElementCopyWithImpl<$Res, $Val extends EdgeOverlayElement>
    implements $EdgeOverlayElementCopyWith<$Res> {
  _$EdgeOverlayElementCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? type = null,
    Object? positionRatio = null,
    Object? direction = null,
    Object? offset = null,
    Object? size = freezed,
    Object? data = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
      positionRatio: null == positionRatio
          ? _value.positionRatio
          : positionRatio // ignore: cast_nullable_to_non_nullable
              as double,
      direction: null == direction
          ? _value.direction
          : direction // ignore: cast_nullable_to_non_nullable
              as OverlayDirection,
      offset: null == offset
          ? _value.offset
          : offset // ignore: cast_nullable_to_non_nullable
              as Offset,
      size: freezed == size
          ? _value.size
          : size // ignore: cast_nullable_to_non_nullable
              as Size?,
      data: freezed == data
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$EdgeOverlayElementImplCopyWith<$Res>
    implements $EdgeOverlayElementCopyWith<$Res> {
  factory _$$EdgeOverlayElementImplCopyWith(_$EdgeOverlayElementImpl value,
          $Res Function(_$EdgeOverlayElementImpl) then) =
      __$$EdgeOverlayElementImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String type,
      double positionRatio,
      OverlayDirection direction,
      @OffsetConverter() Offset offset,
      @SizeConverter() Size? size,
      Map<String, dynamic>? data});
}

/// @nodoc
class __$$EdgeOverlayElementImplCopyWithImpl<$Res>
    extends _$EdgeOverlayElementCopyWithImpl<$Res, _$EdgeOverlayElementImpl>
    implements _$$EdgeOverlayElementImplCopyWith<$Res> {
  __$$EdgeOverlayElementImplCopyWithImpl(_$EdgeOverlayElementImpl _value,
      $Res Function(_$EdgeOverlayElementImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? type = null,
    Object? positionRatio = null,
    Object? direction = null,
    Object? offset = null,
    Object? size = freezed,
    Object? data = freezed,
  }) {
    return _then(_$EdgeOverlayElementImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
      positionRatio: null == positionRatio
          ? _value.positionRatio
          : positionRatio // ignore: cast_nullable_to_non_nullable
              as double,
      direction: null == direction
          ? _value.direction
          : direction // ignore: cast_nullable_to_non_nullable
              as OverlayDirection,
      offset: null == offset
          ? _value.offset
          : offset // ignore: cast_nullable_to_non_nullable
              as Offset,
      size: freezed == size
          ? _value.size
          : size // ignore: cast_nullable_to_non_nullable
              as Size?,
      data: freezed == data
          ? _value._data
          : data // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$EdgeOverlayElementImpl implements _EdgeOverlayElement {
  const _$EdgeOverlayElementImpl(
      {required this.id,
      required this.type,
      this.positionRatio = 0.5,
      this.direction = OverlayDirection.above,
      @OffsetConverter() this.offset = Offset.zero,
      @SizeConverter() this.size,
      final Map<String, dynamic>? data})
      : _data = data;

  factory _$EdgeOverlayElementImpl.fromJson(Map<String, dynamic> json) =>
      _$$EdgeOverlayElementImplFromJson(json);

  @override
  final String id;
// 唯一标识（可用于编辑或点击）
  @override
  final String type;
// 'label', 'button:add', 'icon:warn'...
  /// 路径上的相对位置（0.0 ~ 1.0）
  @override
  @JsonKey()
  final double positionRatio;

  /// 相对于路径切线方向的偏移方向（上/下/左/右）
  @override
  @JsonKey()
  final OverlayDirection direction;

  /// 偏移量（单位：像素）
  @override
  @JsonKey()
  @OffsetConverter()
  final Offset offset;

  /// 元素的尺寸（用于布局和 hitTest）
  @override
  @SizeConverter()
  final Size? size;

  /// 附加数据
  final Map<String, dynamic>? _data;

  /// 附加数据
  @override
  Map<String, dynamic>? get data {
    final value = _data;
    if (value == null) return null;
    if (_data is EqualUnmodifiableMapView) return _data;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

  @override
  String toString() {
    return 'EdgeOverlayElement(id: $id, type: $type, positionRatio: $positionRatio, direction: $direction, offset: $offset, size: $size, data: $data)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$EdgeOverlayElementImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.positionRatio, positionRatio) ||
                other.positionRatio == positionRatio) &&
            (identical(other.direction, direction) ||
                other.direction == direction) &&
            (identical(other.offset, offset) || other.offset == offset) &&
            (identical(other.size, size) || other.size == size) &&
            const DeepCollectionEquality().equals(other._data, _data));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, type, positionRatio,
      direction, offset, size, const DeepCollectionEquality().hash(_data));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$EdgeOverlayElementImplCopyWith<_$EdgeOverlayElementImpl> get copyWith =>
      __$$EdgeOverlayElementImplCopyWithImpl<_$EdgeOverlayElementImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$EdgeOverlayElementImplToJson(
      this,
    );
  }
}

abstract class _EdgeOverlayElement implements EdgeOverlayElement {
  const factory _EdgeOverlayElement(
      {required final String id,
      required final String type,
      final double positionRatio,
      final OverlayDirection direction,
      @OffsetConverter() final Offset offset,
      @SizeConverter() final Size? size,
      final Map<String, dynamic>? data}) = _$EdgeOverlayElementImpl;

  factory _EdgeOverlayElement.fromJson(Map<String, dynamic> json) =
      _$EdgeOverlayElementImpl.fromJson;

  @override
  String get id;
  @override // 唯一标识（可用于编辑或点击）
  String get type;
  @override // 'label', 'button:add', 'icon:warn'...
  /// 路径上的相对位置（0.0 ~ 1.0）
  double get positionRatio;
  @override

  /// 相对于路径切线方向的偏移方向（上/下/左/右）
  OverlayDirection get direction;
  @override

  /// 偏移量（单位：像素）
  @OffsetConverter()
  Offset get offset;
  @override

  /// 元素的尺寸（用于布局和 hitTest）
  @SizeConverter()
  Size? get size;
  @override

  /// 附加数据
  Map<String, dynamic>? get data;
  @override
  @JsonKey(ignore: true)
  _$$EdgeOverlayElementImplCopyWith<_$EdgeOverlayElementImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
