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
// Unique identifier for the anchor
  String get id => throw _privateConstructorUsedError; // Width of the anchor
  double get width =>
      throw _privateConstructorUsedError; // Height of the anchor
  double get height =>
      throw _privateConstructorUsedError; // Position of the anchor, defined by an enum
  Position get position =>
      throw _privateConstructorUsedError; // Ratio for positioning, default is 0.5
  double get ratio =>
      throw _privateConstructorUsedError; // Direction of the anchor, default is inout
  AnchorDirection get direction =>
      throw _privateConstructorUsedError; // Maximum number of connections allowed, optional
  int? get maxConnections =>
      throw _privateConstructorUsedError; // List of accepted edge types for connections, optional
  List<String>? get acceptedEdgeTypes =>
      throw _privateConstructorUsedError; // Shape of the anchor, default is circle
  AnchorShape get shape =>
      throw _privateConstructorUsedError; // Direction of the arrow, default is none
  ArrowDirection get arrowDirection =>
      throw _privateConstructorUsedError; // Indicates if the anchor is locked, default is false
  bool get locked =>
      throw _privateConstructorUsedError; // Version of the anchor model, default is 1
  int get version =>
      throw _privateConstructorUsedError; // User who locked the anchor, optional
  String? get lockedByUser =>
      throw _privateConstructorUsedError; // Hex color code for the plus button, optional
  String? get plusButtonColorHex =>
      throw _privateConstructorUsedError; // Size of the plus button, optional
  double? get plusButtonSize =>
      throw _privateConstructorUsedError; // Name of the icon associated with the anchor, optional
  String? get iconName =>
      throw _privateConstructorUsedError; // Additional data associated with the anchor, default is an empty map
  Map<String, dynamic> get data =>
      throw _privateConstructorUsedError; // Placement of the anchor, default is border
  AnchorPlacement get placement =>
      throw _privateConstructorUsedError; // Offset distance for the anchor, default is 0.0
  double get offsetDistance =>
      throw _privateConstructorUsedError; // Angle of the anchor, default is 0.0
  double get angle =>
      throw _privateConstructorUsedError; // Identifier of the node to which the anchor belongs
  String get nodeId => throw _privateConstructorUsedError;

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
      double width,
      double height,
      Position position,
      double ratio,
      AnchorDirection direction,
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
      AnchorPlacement placement,
      double offsetDistance,
      double angle,
      String nodeId});
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
    Object? width = null,
    Object? height = null,
    Object? position = null,
    Object? ratio = null,
    Object? direction = null,
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
    Object? placement = null,
    Object? offsetDistance = null,
    Object? angle = null,
    Object? nodeId = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      width: null == width
          ? _value.width
          : width // ignore: cast_nullable_to_non_nullable
              as double,
      height: null == height
          ? _value.height
          : height // ignore: cast_nullable_to_non_nullable
              as double,
      position: null == position
          ? _value.position
          : position // ignore: cast_nullable_to_non_nullable
              as Position,
      ratio: null == ratio
          ? _value.ratio
          : ratio // ignore: cast_nullable_to_non_nullable
              as double,
      direction: null == direction
          ? _value.direction
          : direction // ignore: cast_nullable_to_non_nullable
              as AnchorDirection,
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
      placement: null == placement
          ? _value.placement
          : placement // ignore: cast_nullable_to_non_nullable
              as AnchorPlacement,
      offsetDistance: null == offsetDistance
          ? _value.offsetDistance
          : offsetDistance // ignore: cast_nullable_to_non_nullable
              as double,
      angle: null == angle
          ? _value.angle
          : angle // ignore: cast_nullable_to_non_nullable
              as double,
      nodeId: null == nodeId
          ? _value.nodeId
          : nodeId // ignore: cast_nullable_to_non_nullable
              as String,
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
      double width,
      double height,
      Position position,
      double ratio,
      AnchorDirection direction,
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
      AnchorPlacement placement,
      double offsetDistance,
      double angle,
      String nodeId});
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
    Object? width = null,
    Object? height = null,
    Object? position = null,
    Object? ratio = null,
    Object? direction = null,
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
    Object? placement = null,
    Object? offsetDistance = null,
    Object? angle = null,
    Object? nodeId = null,
  }) {
    return _then(_$AnchorModelImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      width: null == width
          ? _value.width
          : width // ignore: cast_nullable_to_non_nullable
              as double,
      height: null == height
          ? _value.height
          : height // ignore: cast_nullable_to_non_nullable
              as double,
      position: null == position
          ? _value.position
          : position // ignore: cast_nullable_to_non_nullable
              as Position,
      ratio: null == ratio
          ? _value.ratio
          : ratio // ignore: cast_nullable_to_non_nullable
              as double,
      direction: null == direction
          ? _value.direction
          : direction // ignore: cast_nullable_to_non_nullable
              as AnchorDirection,
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
      placement: null == placement
          ? _value.placement
          : placement // ignore: cast_nullable_to_non_nullable
              as AnchorPlacement,
      offsetDistance: null == offsetDistance
          ? _value.offsetDistance
          : offsetDistance // ignore: cast_nullable_to_non_nullable
              as double,
      angle: null == angle
          ? _value.angle
          : angle // ignore: cast_nullable_to_non_nullable
              as double,
      nodeId: null == nodeId
          ? _value.nodeId
          : nodeId // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$AnchorModelImpl extends _AnchorModel {
  const _$AnchorModelImpl(
      {required this.id,
      required this.width,
      required this.height,
      required this.position,
      this.ratio = 0.5,
      this.direction = AnchorDirection.inout,
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
      this.placement = AnchorPlacement.border,
      this.offsetDistance = 0.0,
      this.angle = 0.0,
      required this.nodeId})
      : _acceptedEdgeTypes = acceptedEdgeTypes,
        _data = data,
        super._();

  factory _$AnchorModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$AnchorModelImplFromJson(json);

// Unique identifier for the anchor
  @override
  final String id;
// Width of the anchor
  @override
  final double width;
// Height of the anchor
  @override
  final double height;
// Position of the anchor, defined by an enum
  @override
  final Position position;
// Ratio for positioning, default is 0.5
  @override
  @JsonKey()
  final double ratio;
// Direction of the anchor, default is inout
  @override
  @JsonKey()
  final AnchorDirection direction;
// Maximum number of connections allowed, optional
  @override
  final int? maxConnections;
// List of accepted edge types for connections, optional
  final List<String>? _acceptedEdgeTypes;
// List of accepted edge types for connections, optional
  @override
  List<String>? get acceptedEdgeTypes {
    final value = _acceptedEdgeTypes;
    if (value == null) return null;
    if (_acceptedEdgeTypes is EqualUnmodifiableListView)
      return _acceptedEdgeTypes;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

// Shape of the anchor, default is circle
  @override
  @JsonKey()
  final AnchorShape shape;
// Direction of the arrow, default is none
  @override
  @JsonKey()
  final ArrowDirection arrowDirection;
// Indicates if the anchor is locked, default is false
  @override
  @JsonKey()
  final bool locked;
// Version of the anchor model, default is 1
  @override
  @JsonKey()
  final int version;
// User who locked the anchor, optional
  @override
  final String? lockedByUser;
// Hex color code for the plus button, optional
  @override
  final String? plusButtonColorHex;
// Size of the plus button, optional
  @override
  final double? plusButtonSize;
// Name of the icon associated with the anchor, optional
  @override
  final String? iconName;
// Additional data associated with the anchor, default is an empty map
  final Map<String, dynamic> _data;
// Additional data associated with the anchor, default is an empty map
  @override
  @JsonKey()
  Map<String, dynamic> get data {
    if (_data is EqualUnmodifiableMapView) return _data;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_data);
  }

// Placement of the anchor, default is border
  @override
  @JsonKey()
  final AnchorPlacement placement;
// Offset distance for the anchor, default is 0.0
  @override
  @JsonKey()
  final double offsetDistance;
// Angle of the anchor, default is 0.0
  @override
  @JsonKey()
  final double angle;
// Identifier of the node to which the anchor belongs
  @override
  final String nodeId;

  @override
  String toString() {
    return 'AnchorModel(id: $id, width: $width, height: $height, position: $position, ratio: $ratio, direction: $direction, maxConnections: $maxConnections, acceptedEdgeTypes: $acceptedEdgeTypes, shape: $shape, arrowDirection: $arrowDirection, locked: $locked, version: $version, lockedByUser: $lockedByUser, plusButtonColorHex: $plusButtonColorHex, plusButtonSize: $plusButtonSize, iconName: $iconName, data: $data, placement: $placement, offsetDistance: $offsetDistance, angle: $angle, nodeId: $nodeId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AnchorModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.width, width) || other.width == width) &&
            (identical(other.height, height) || other.height == height) &&
            (identical(other.position, position) ||
                other.position == position) &&
            (identical(other.ratio, ratio) || other.ratio == ratio) &&
            (identical(other.direction, direction) ||
                other.direction == direction) &&
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
            (identical(other.placement, placement) ||
                other.placement == placement) &&
            (identical(other.offsetDistance, offsetDistance) ||
                other.offsetDistance == offsetDistance) &&
            (identical(other.angle, angle) || other.angle == angle) &&
            (identical(other.nodeId, nodeId) || other.nodeId == nodeId));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hashAll([
        runtimeType,
        id,
        width,
        height,
        position,
        ratio,
        direction,
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
        placement,
        offsetDistance,
        angle,
        nodeId
      ]);

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
      required final double width,
      required final double height,
      required final Position position,
      final double ratio,
      final AnchorDirection direction,
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
      final AnchorPlacement placement,
      final double offsetDistance,
      final double angle,
      required final String nodeId}) = _$AnchorModelImpl;
  const _AnchorModel._() : super._();

  factory _AnchorModel.fromJson(Map<String, dynamic> json) =
      _$AnchorModelImpl.fromJson;

  @override // Unique identifier for the anchor
  String get id;
  @override // Width of the anchor
  double get width;
  @override // Height of the anchor
  double get height;
  @override // Position of the anchor, defined by an enum
  Position get position;
  @override // Ratio for positioning, default is 0.5
  double get ratio;
  @override // Direction of the anchor, default is inout
  AnchorDirection get direction;
  @override // Maximum number of connections allowed, optional
  int? get maxConnections;
  @override // List of accepted edge types for connections, optional
  List<String>? get acceptedEdgeTypes;
  @override // Shape of the anchor, default is circle
  AnchorShape get shape;
  @override // Direction of the arrow, default is none
  ArrowDirection get arrowDirection;
  @override // Indicates if the anchor is locked, default is false
  bool get locked;
  @override // Version of the anchor model, default is 1
  int get version;
  @override // User who locked the anchor, optional
  String? get lockedByUser;
  @override // Hex color code for the plus button, optional
  String? get plusButtonColorHex;
  @override // Size of the plus button, optional
  double? get plusButtonSize;
  @override // Name of the icon associated with the anchor, optional
  String? get iconName;
  @override // Additional data associated with the anchor, default is an empty map
  Map<String, dynamic> get data;
  @override // Placement of the anchor, default is border
  AnchorPlacement get placement;
  @override // Offset distance for the anchor, default is 0.0
  double get offsetDistance;
  @override // Angle of the anchor, default is 0.0
  double get angle;
  @override // Identifier of the node to which the anchor belongs
  String get nodeId;
  @override
  @JsonKey(ignore: true)
  _$$AnchorModelImplCopyWith<_$AnchorModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
