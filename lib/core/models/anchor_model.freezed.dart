// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'anchor_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

AnchorModel _$AnchorModelFromJson(Map<String, dynamic> json) {
  return _AnchorModel.fromJson(json);
}

/// @nodoc
mixin _$AnchorModel {
  String get id => throw _privateConstructorUsedError;
  @SizeConverter()
  Size get size => throw _privateConstructorUsedError;
  Position get position =>
      throw _privateConstructorUsedError; // 0.0 <= ratio <= 1.0
  double get ratio => throw _privateConstructorUsedError;
  int? get maxConnections => throw _privateConstructorUsedError;
  List<String>? get acceptedEdgeTypes => throw _privateConstructorUsedError;
  AnchorShape get shape => throw _privateConstructorUsedError;
  ArrowDirection get arrowDirection => throw _privateConstructorUsedError;
  bool get locked => throw _privateConstructorUsedError;
  int get version => throw _privateConstructorUsedError;
  String? get lockedByUser => throw _privateConstructorUsedError;
  String? get plusButtonColorHex => throw _privateConstructorUsedError;
  double? get plusButtonSize => throw _privateConstructorUsedError;
  String? get iconName => throw _privateConstructorUsedError;
  Map<String, dynamic> get data => throw _privateConstructorUsedError;
  @OffsetConverter()
  Offset get offset => throw _privateConstructorUsedError;
  @OffsetConverter()
  Offset get edgeOffset => throw _privateConstructorUsedError;
  double get angle => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $AnchorModelCopyWith<AnchorModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AnchorModelCopyWith<$Res> {
  factory $AnchorModelCopyWith(
          AnchorModel value, $Res Function(AnchorModel) then) =
      _$AnchorModelCopyWithImpl<$Res, AnchorModel>;
  @useResult
  $Res call(
      {String id,
      @SizeConverter() Size size,
      Position position,
      double ratio,
      int? maxConnections,
      List<String>? acceptedEdgeTypes,
      AnchorShape shape,
      ArrowDirection arrowDirection,
      bool locked,
      int version,
      String? lockedByUser,
      String? plusButtonColorHex,
      double? plusButtonSize,
      String? iconName,
      Map<String, dynamic> data,
      @OffsetConverter() Offset offset,
      @OffsetConverter() Offset edgeOffset,
      double angle});
}

/// @nodoc
class _$AnchorModelCopyWithImpl<$Res, $Val extends AnchorModel>
    implements $AnchorModelCopyWith<$Res> {
  _$AnchorModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? size = null,
    Object? position = null,
    Object? ratio = null,
    Object? maxConnections = freezed,
    Object? acceptedEdgeTypes = freezed,
    Object? shape = null,
    Object? arrowDirection = null,
    Object? locked = null,
    Object? version = null,
    Object? lockedByUser = freezed,
    Object? plusButtonColorHex = freezed,
    Object? plusButtonSize = freezed,
    Object? iconName = freezed,
    Object? data = null,
    Object? offset = null,
    Object? edgeOffset = null,
    Object? angle = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      size: null == size
          ? _value.size
          : size // ignore: cast_nullable_to_non_nullable
              as Size,
      position: null == position
          ? _value.position
          : position // ignore: cast_nullable_to_non_nullable
              as Position,
      ratio: null == ratio
          ? _value.ratio
          : ratio // ignore: cast_nullable_to_non_nullable
              as double,
      maxConnections: freezed == maxConnections
          ? _value.maxConnections
          : maxConnections // ignore: cast_nullable_to_non_nullable
              as int?,
      acceptedEdgeTypes: freezed == acceptedEdgeTypes
          ? _value.acceptedEdgeTypes
          : acceptedEdgeTypes // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      shape: null == shape
          ? _value.shape
          : shape // ignore: cast_nullable_to_non_nullable
              as AnchorShape,
      arrowDirection: null == arrowDirection
          ? _value.arrowDirection
          : arrowDirection // ignore: cast_nullable_to_non_nullable
              as ArrowDirection,
      locked: null == locked
          ? _value.locked
          : locked // ignore: cast_nullable_to_non_nullable
              as bool,
      version: null == version
          ? _value.version
          : version // ignore: cast_nullable_to_non_nullable
              as int,
      lockedByUser: freezed == lockedByUser
          ? _value.lockedByUser
          : lockedByUser // ignore: cast_nullable_to_non_nullable
              as String?,
      plusButtonColorHex: freezed == plusButtonColorHex
          ? _value.plusButtonColorHex
          : plusButtonColorHex // ignore: cast_nullable_to_non_nullable
              as String?,
      plusButtonSize: freezed == plusButtonSize
          ? _value.plusButtonSize
          : plusButtonSize // ignore: cast_nullable_to_non_nullable
              as double?,
      iconName: freezed == iconName
          ? _value.iconName
          : iconName // ignore: cast_nullable_to_non_nullable
              as String?,
      data: null == data
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
      offset: null == offset
          ? _value.offset
          : offset // ignore: cast_nullable_to_non_nullable
              as Offset,
      edgeOffset: null == edgeOffset
          ? _value.edgeOffset
          : edgeOffset // ignore: cast_nullable_to_non_nullable
              as Offset,
      angle: null == angle
          ? _value.angle
          : angle // ignore: cast_nullable_to_non_nullable
              as double,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$AnchorModelImplCopyWith<$Res>
    implements $AnchorModelCopyWith<$Res> {
  factory _$$AnchorModelImplCopyWith(
          _$AnchorModelImpl value, $Res Function(_$AnchorModelImpl) then) =
      __$$AnchorModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      @SizeConverter() Size size,
      Position position,
      double ratio,
      int? maxConnections,
      List<String>? acceptedEdgeTypes,
      AnchorShape shape,
      ArrowDirection arrowDirection,
      bool locked,
      int version,
      String? lockedByUser,
      String? plusButtonColorHex,
      double? plusButtonSize,
      String? iconName,
      Map<String, dynamic> data,
      @OffsetConverter() Offset offset,
      @OffsetConverter() Offset edgeOffset,
      double angle});
}

/// @nodoc
class __$$AnchorModelImplCopyWithImpl<$Res>
    extends _$AnchorModelCopyWithImpl<$Res, _$AnchorModelImpl>
    implements _$$AnchorModelImplCopyWith<$Res> {
  __$$AnchorModelImplCopyWithImpl(
      _$AnchorModelImpl _value, $Res Function(_$AnchorModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? size = null,
    Object? position = null,
    Object? ratio = null,
    Object? maxConnections = freezed,
    Object? acceptedEdgeTypes = freezed,
    Object? shape = null,
    Object? arrowDirection = null,
    Object? locked = null,
    Object? version = null,
    Object? lockedByUser = freezed,
    Object? plusButtonColorHex = freezed,
    Object? plusButtonSize = freezed,
    Object? iconName = freezed,
    Object? data = null,
    Object? offset = null,
    Object? edgeOffset = null,
    Object? angle = null,
  }) {
    return _then(_$AnchorModelImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      size: null == size
          ? _value.size
          : size // ignore: cast_nullable_to_non_nullable
              as Size,
      position: null == position
          ? _value.position
          : position // ignore: cast_nullable_to_non_nullable
              as Position,
      ratio: null == ratio
          ? _value.ratio
          : ratio // ignore: cast_nullable_to_non_nullable
              as double,
      maxConnections: freezed == maxConnections
          ? _value.maxConnections
          : maxConnections // ignore: cast_nullable_to_non_nullable
              as int?,
      acceptedEdgeTypes: freezed == acceptedEdgeTypes
          ? _value._acceptedEdgeTypes
          : acceptedEdgeTypes // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      shape: null == shape
          ? _value.shape
          : shape // ignore: cast_nullable_to_non_nullable
              as AnchorShape,
      arrowDirection: null == arrowDirection
          ? _value.arrowDirection
          : arrowDirection // ignore: cast_nullable_to_non_nullable
              as ArrowDirection,
      locked: null == locked
          ? _value.locked
          : locked // ignore: cast_nullable_to_non_nullable
              as bool,
      version: null == version
          ? _value.version
          : version // ignore: cast_nullable_to_non_nullable
              as int,
      lockedByUser: freezed == lockedByUser
          ? _value.lockedByUser
          : lockedByUser // ignore: cast_nullable_to_non_nullable
              as String?,
      plusButtonColorHex: freezed == plusButtonColorHex
          ? _value.plusButtonColorHex
          : plusButtonColorHex // ignore: cast_nullable_to_non_nullable
              as String?,
      plusButtonSize: freezed == plusButtonSize
          ? _value.plusButtonSize
          : plusButtonSize // ignore: cast_nullable_to_non_nullable
              as double?,
      iconName: freezed == iconName
          ? _value.iconName
          : iconName // ignore: cast_nullable_to_non_nullable
              as String?,
      data: null == data
          ? _value._data
          : data // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
      offset: null == offset
          ? _value.offset
          : offset // ignore: cast_nullable_to_non_nullable
              as Offset,
      edgeOffset: null == edgeOffset
          ? _value.edgeOffset
          : edgeOffset // ignore: cast_nullable_to_non_nullable
              as Offset,
      angle: null == angle
          ? _value.angle
          : angle // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$AnchorModelImpl extends _AnchorModel {
  const _$AnchorModelImpl(
      {required this.id,
      @SizeConverter() this.size = const Size(24, 24),
      this.position = Position.left,
      this.ratio = 0.5,
      this.maxConnections,
      final List<String>? acceptedEdgeTypes,
      this.shape = AnchorShape.circle,
      this.arrowDirection = ArrowDirection.none,
      this.locked = false,
      this.version = 1,
      this.lockedByUser,
      this.plusButtonColorHex,
      this.plusButtonSize,
      this.iconName,
      final Map<String, dynamic> data = const {},
      @OffsetConverter() this.offset = Offset.zero,
      @OffsetConverter() this.edgeOffset = Offset.zero,
      this.angle = 0.0})
      : _acceptedEdgeTypes = acceptedEdgeTypes,
        _data = data,
        super._();

  factory _$AnchorModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$AnchorModelImplFromJson(json);

  @override
  final String id;
  @override
  @JsonKey()
  @SizeConverter()
  final Size size;
  @override
  @JsonKey()
  final Position position;
// 0.0 <= ratio <= 1.0
  @override
  @JsonKey()
  final double ratio;
  @override
  final int? maxConnections;
  final List<String>? _acceptedEdgeTypes;
  @override
  List<String>? get acceptedEdgeTypes {
    final value = _acceptedEdgeTypes;
    if (value == null) return null;
    if (_acceptedEdgeTypes is EqualUnmodifiableListView)
      return _acceptedEdgeTypes;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  @JsonKey()
  final AnchorShape shape;
  @override
  @JsonKey()
  final ArrowDirection arrowDirection;
  @override
  @JsonKey()
  final bool locked;
  @override
  @JsonKey()
  final int version;
  @override
  final String? lockedByUser;
  @override
  final String? plusButtonColorHex;
  @override
  final double? plusButtonSize;
  @override
  final String? iconName;
  final Map<String, dynamic> _data;
  @override
  @JsonKey()
  Map<String, dynamic> get data {
    if (_data is EqualUnmodifiableMapView) return _data;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_data);
  }

  @override
  @JsonKey()
  @OffsetConverter()
  final Offset offset;
  @override
  @JsonKey()
  @OffsetConverter()
  final Offset edgeOffset;
  @override
  @JsonKey()
  final double angle;

  @override
  String toString() {
    return 'AnchorModel(id: $id, size: $size, position: $position, ratio: $ratio, maxConnections: $maxConnections, acceptedEdgeTypes: $acceptedEdgeTypes, shape: $shape, arrowDirection: $arrowDirection, locked: $locked, version: $version, lockedByUser: $lockedByUser, plusButtonColorHex: $plusButtonColorHex, plusButtonSize: $plusButtonSize, iconName: $iconName, data: $data, offset: $offset, edgeOffset: $edgeOffset, angle: $angle)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AnchorModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.size, size) || other.size == size) &&
            (identical(other.position, position) ||
                other.position == position) &&
            (identical(other.ratio, ratio) || other.ratio == ratio) &&
            (identical(other.maxConnections, maxConnections) ||
                other.maxConnections == maxConnections) &&
            const DeepCollectionEquality()
                .equals(other._acceptedEdgeTypes, _acceptedEdgeTypes) &&
            (identical(other.shape, shape) || other.shape == shape) &&
            (identical(other.arrowDirection, arrowDirection) ||
                other.arrowDirection == arrowDirection) &&
            (identical(other.locked, locked) || other.locked == locked) &&
            (identical(other.version, version) || other.version == version) &&
            (identical(other.lockedByUser, lockedByUser) ||
                other.lockedByUser == lockedByUser) &&
            (identical(other.plusButtonColorHex, plusButtonColorHex) ||
                other.plusButtonColorHex == plusButtonColorHex) &&
            (identical(other.plusButtonSize, plusButtonSize) ||
                other.plusButtonSize == plusButtonSize) &&
            (identical(other.iconName, iconName) ||
                other.iconName == iconName) &&
            const DeepCollectionEquality().equals(other._data, _data) &&
            (identical(other.offset, offset) || other.offset == offset) &&
            (identical(other.edgeOffset, edgeOffset) ||
                other.edgeOffset == edgeOffset) &&
            (identical(other.angle, angle) || other.angle == angle));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      size,
      position,
      ratio,
      maxConnections,
      const DeepCollectionEquality().hash(_acceptedEdgeTypes),
      shape,
      arrowDirection,
      locked,
      version,
      lockedByUser,
      plusButtonColorHex,
      plusButtonSize,
      iconName,
      const DeepCollectionEquality().hash(_data),
      offset,
      edgeOffset,
      angle);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$AnchorModelImplCopyWith<_$AnchorModelImpl> get copyWith =>
      __$$AnchorModelImplCopyWithImpl<_$AnchorModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AnchorModelImplToJson(
      this,
    );
  }
}

abstract class _AnchorModel extends AnchorModel {
  const factory _AnchorModel(
      {required final String id,
      @SizeConverter() final Size size,
      final Position position,
      final double ratio,
      final int? maxConnections,
      final List<String>? acceptedEdgeTypes,
      final AnchorShape shape,
      final ArrowDirection arrowDirection,
      final bool locked,
      final int version,
      final String? lockedByUser,
      final String? plusButtonColorHex,
      final double? plusButtonSize,
      final String? iconName,
      final Map<String, dynamic> data,
      @OffsetConverter() final Offset offset,
      @OffsetConverter() final Offset edgeOffset,
      final double angle}) = _$AnchorModelImpl;
  const _AnchorModel._() : super._();

  factory _AnchorModel.fromJson(Map<String, dynamic> json) =
      _$AnchorModelImpl.fromJson;

  @override
  String get id;
  @override
  @SizeConverter()
  Size get size;
  @override
  Position get position;
  @override // 0.0 <= ratio <= 1.0
  double get ratio;
  @override
  int? get maxConnections;
  @override
  List<String>? get acceptedEdgeTypes;
  @override
  AnchorShape get shape;
  @override
  ArrowDirection get arrowDirection;
  @override
  bool get locked;
  @override
  int get version;
  @override
  String? get lockedByUser;
  @override
  String? get plusButtonColorHex;
  @override
  double? get plusButtonSize;
  @override
  String? get iconName;
  @override
  Map<String, dynamic> get data;
  @override
  @OffsetConverter()
  Offset get offset;
  @override
  @OffsetConverter()
  Offset get edgeOffset;
  @override
  double get angle;
  @override
  @JsonKey(ignore: true)
  _$$AnchorModelImplCopyWith<_$AnchorModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
