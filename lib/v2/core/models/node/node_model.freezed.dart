// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'node_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

NodeModel _$NodeModelFromJson(Map<String, dynamic> json) {
  return _NodeModel.fromJson(json);
}

/// @nodoc
mixin _$NodeModel {
  String get id => throw _privateConstructorUsedError;
  @OffsetConverter()
  Offset get position => throw _privateConstructorUsedError;
  @SizeConverter()
  Size get size => throw _privateConstructorUsedError;
  String get type => throw _privateConstructorUsedError;
  String? get title => throw _privateConstructorUsedError;
  List<AnchorModel> get anchors => throw _privateConstructorUsedError;
  bool get isGroup => throw _privateConstructorUsedError;
  bool get isGroupRoot => throw _privateConstructorUsedError;
  NodeStatus get status => throw _privateConstructorUsedError;
  String? get parentId => throw _privateConstructorUsedError;
  int get zIndex => throw _privateConstructorUsedError;
  bool get enabled => throw _privateConstructorUsedError;
  bool get locked => throw _privateConstructorUsedError;
  String? get description => throw _privateConstructorUsedError;
  NodeStyle? get style => throw _privateConstructorUsedError;
  int get version => throw _privateConstructorUsedError;
  @DateTimeEpochConverter()
  DateTime? get createdAt => throw _privateConstructorUsedError;
  @DateTimeEpochConverter()
  DateTime? get updatedAt => throw _privateConstructorUsedError;
  Map<String, dynamic> get data => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $NodeModelCopyWith<NodeModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $NodeModelCopyWith<$Res> {
  factory $NodeModelCopyWith(NodeModel value, $Res Function(NodeModel) then) =
      _$NodeModelCopyWithImpl<$Res, NodeModel>;
  @useResult
  $Res call(
      {String id,
      @OffsetConverter() Offset position,
      @SizeConverter() Size size,
      String type,
      String? title,
      List<AnchorModel> anchors,
      bool isGroup,
      bool isGroupRoot,
      NodeStatus status,
      String? parentId,
      int zIndex,
      bool enabled,
      bool locked,
      String? description,
      NodeStyle? style,
      int version,
      @DateTimeEpochConverter() DateTime? createdAt,
      @DateTimeEpochConverter() DateTime? updatedAt,
      Map<String, dynamic> data});

  $NodeStyleCopyWith<$Res>? get style;
}

/// @nodoc
class _$NodeModelCopyWithImpl<$Res, $Val extends NodeModel>
    implements $NodeModelCopyWith<$Res> {
  _$NodeModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? position = null,
    Object? size = null,
    Object? type = null,
    Object? title = freezed,
    Object? anchors = null,
    Object? isGroup = null,
    Object? isGroupRoot = null,
    Object? status = null,
    Object? parentId = freezed,
    Object? zIndex = null,
    Object? enabled = null,
    Object? locked = null,
    Object? description = freezed,
    Object? style = freezed,
    Object? version = null,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
    Object? data = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      position: null == position
          ? _value.position
          : position // ignore: cast_nullable_to_non_nullable
              as Offset,
      size: null == size
          ? _value.size
          : size // ignore: cast_nullable_to_non_nullable
              as Size,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
      title: freezed == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String?,
      anchors: null == anchors
          ? _value.anchors
          : anchors // ignore: cast_nullable_to_non_nullable
              as List<AnchorModel>,
      isGroup: null == isGroup
          ? _value.isGroup
          : isGroup // ignore: cast_nullable_to_non_nullable
              as bool,
      isGroupRoot: null == isGroupRoot
          ? _value.isGroupRoot
          : isGroupRoot // ignore: cast_nullable_to_non_nullable
              as bool,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as NodeStatus,
      parentId: freezed == parentId
          ? _value.parentId
          : parentId // ignore: cast_nullable_to_non_nullable
              as String?,
      zIndex: null == zIndex
          ? _value.zIndex
          : zIndex // ignore: cast_nullable_to_non_nullable
              as int,
      enabled: null == enabled
          ? _value.enabled
          : enabled // ignore: cast_nullable_to_non_nullable
              as bool,
      locked: null == locked
          ? _value.locked
          : locked // ignore: cast_nullable_to_non_nullable
              as bool,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      style: freezed == style
          ? _value.style
          : style // ignore: cast_nullable_to_non_nullable
              as NodeStyle?,
      version: null == version
          ? _value.version
          : version // ignore: cast_nullable_to_non_nullable
              as int,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      updatedAt: freezed == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      data: null == data
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $NodeStyleCopyWith<$Res>? get style {
    if (_value.style == null) {
      return null;
    }

    return $NodeStyleCopyWith<$Res>(_value.style!, (value) {
      return _then(_value.copyWith(style: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$NodeModelImplCopyWith<$Res>
    implements $NodeModelCopyWith<$Res> {
  factory _$$NodeModelImplCopyWith(
          _$NodeModelImpl value, $Res Function(_$NodeModelImpl) then) =
      __$$NodeModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      @OffsetConverter() Offset position,
      @SizeConverter() Size size,
      String type,
      String? title,
      List<AnchorModel> anchors,
      bool isGroup,
      bool isGroupRoot,
      NodeStatus status,
      String? parentId,
      int zIndex,
      bool enabled,
      bool locked,
      String? description,
      NodeStyle? style,
      int version,
      @DateTimeEpochConverter() DateTime? createdAt,
      @DateTimeEpochConverter() DateTime? updatedAt,
      Map<String, dynamic> data});

  @override
  $NodeStyleCopyWith<$Res>? get style;
}

/// @nodoc
class __$$NodeModelImplCopyWithImpl<$Res>
    extends _$NodeModelCopyWithImpl<$Res, _$NodeModelImpl>
    implements _$$NodeModelImplCopyWith<$Res> {
  __$$NodeModelImplCopyWithImpl(
      _$NodeModelImpl _value, $Res Function(_$NodeModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? position = null,
    Object? size = null,
    Object? type = null,
    Object? title = freezed,
    Object? anchors = null,
    Object? isGroup = null,
    Object? isGroupRoot = null,
    Object? status = null,
    Object? parentId = freezed,
    Object? zIndex = null,
    Object? enabled = null,
    Object? locked = null,
    Object? description = freezed,
    Object? style = freezed,
    Object? version = null,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
    Object? data = null,
  }) {
    return _then(_$NodeModelImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      position: null == position
          ? _value.position
          : position // ignore: cast_nullable_to_non_nullable
              as Offset,
      size: null == size
          ? _value.size
          : size // ignore: cast_nullable_to_non_nullable
              as Size,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
      title: freezed == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String?,
      anchors: null == anchors
          ? _value._anchors
          : anchors // ignore: cast_nullable_to_non_nullable
              as List<AnchorModel>,
      isGroup: null == isGroup
          ? _value.isGroup
          : isGroup // ignore: cast_nullable_to_non_nullable
              as bool,
      isGroupRoot: null == isGroupRoot
          ? _value.isGroupRoot
          : isGroupRoot // ignore: cast_nullable_to_non_nullable
              as bool,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as NodeStatus,
      parentId: freezed == parentId
          ? _value.parentId
          : parentId // ignore: cast_nullable_to_non_nullable
              as String?,
      zIndex: null == zIndex
          ? _value.zIndex
          : zIndex // ignore: cast_nullable_to_non_nullable
              as int,
      enabled: null == enabled
          ? _value.enabled
          : enabled // ignore: cast_nullable_to_non_nullable
              as bool,
      locked: null == locked
          ? _value.locked
          : locked // ignore: cast_nullable_to_non_nullable
              as bool,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      style: freezed == style
          ? _value.style
          : style // ignore: cast_nullable_to_non_nullable
              as NodeStyle?,
      version: null == version
          ? _value.version
          : version // ignore: cast_nullable_to_non_nullable
              as int,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      updatedAt: freezed == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      data: null == data
          ? _value._data
          : data // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$NodeModelImpl extends _NodeModel {
  const _$NodeModelImpl(
      {required this.id,
      @OffsetConverter() required this.position,
      @SizeConverter() required this.size,
      this.type = '',
      this.title,
      final List<AnchorModel> anchors = const [],
      this.isGroup = false,
      this.isGroupRoot = false,
      this.status = NodeStatus.none,
      this.parentId,
      this.zIndex = 0,
      this.enabled = true,
      this.locked = false,
      this.description,
      this.style,
      this.version = 1,
      @DateTimeEpochConverter() this.createdAt,
      @DateTimeEpochConverter() this.updatedAt,
      final Map<String, dynamic> data = const <String, dynamic>{}})
      : _anchors = anchors,
        _data = data,
        super._();

  factory _$NodeModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$NodeModelImplFromJson(json);

  @override
  final String id;
  @override
  @OffsetConverter()
  final Offset position;
  @override
  @SizeConverter()
  final Size size;
  @override
  @JsonKey()
  final String type;
  @override
  final String? title;
  final List<AnchorModel> _anchors;
  @override
  @JsonKey()
  List<AnchorModel> get anchors {
    if (_anchors is EqualUnmodifiableListView) return _anchors;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_anchors);
  }

  @override
  @JsonKey()
  final bool isGroup;
  @override
  @JsonKey()
  final bool isGroupRoot;
  @override
  @JsonKey()
  final NodeStatus status;
  @override
  final String? parentId;
  @override
  @JsonKey()
  final int zIndex;
  @override
  @JsonKey()
  final bool enabled;
  @override
  @JsonKey()
  final bool locked;
  @override
  final String? description;
  @override
  final NodeStyle? style;
  @override
  @JsonKey()
  final int version;
  @override
  @DateTimeEpochConverter()
  final DateTime? createdAt;
  @override
  @DateTimeEpochConverter()
  final DateTime? updatedAt;
  final Map<String, dynamic> _data;
  @override
  @JsonKey()
  Map<String, dynamic> get data {
    if (_data is EqualUnmodifiableMapView) return _data;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_data);
  }

  @override
  String toString() {
    return 'NodeModel(id: $id, position: $position, size: $size, type: $type, title: $title, anchors: $anchors, isGroup: $isGroup, isGroupRoot: $isGroupRoot, status: $status, parentId: $parentId, zIndex: $zIndex, enabled: $enabled, locked: $locked, description: $description, style: $style, version: $version, createdAt: $createdAt, updatedAt: $updatedAt, data: $data)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$NodeModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.position, position) ||
                other.position == position) &&
            (identical(other.size, size) || other.size == size) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.title, title) || other.title == title) &&
            const DeepCollectionEquality().equals(other._anchors, _anchors) &&
            (identical(other.isGroup, isGroup) || other.isGroup == isGroup) &&
            (identical(other.isGroupRoot, isGroupRoot) ||
                other.isGroupRoot == isGroupRoot) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.parentId, parentId) ||
                other.parentId == parentId) &&
            (identical(other.zIndex, zIndex) || other.zIndex == zIndex) &&
            (identical(other.enabled, enabled) || other.enabled == enabled) &&
            (identical(other.locked, locked) || other.locked == locked) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.style, style) || other.style == style) &&
            (identical(other.version, version) || other.version == version) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt) &&
            const DeepCollectionEquality().equals(other._data, _data));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hashAll([
        runtimeType,
        id,
        position,
        size,
        type,
        title,
        const DeepCollectionEquality().hash(_anchors),
        isGroup,
        isGroupRoot,
        status,
        parentId,
        zIndex,
        enabled,
        locked,
        description,
        style,
        version,
        createdAt,
        updatedAt,
        const DeepCollectionEquality().hash(_data)
      ]);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$NodeModelImplCopyWith<_$NodeModelImpl> get copyWith =>
      __$$NodeModelImplCopyWithImpl<_$NodeModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$NodeModelImplToJson(
      this,
    );
  }
}

abstract class _NodeModel extends NodeModel {
  const factory _NodeModel(
      {required final String id,
      @OffsetConverter() required final Offset position,
      @SizeConverter() required final Size size,
      final String type,
      final String? title,
      final List<AnchorModel> anchors,
      final bool isGroup,
      final bool isGroupRoot,
      final NodeStatus status,
      final String? parentId,
      final int zIndex,
      final bool enabled,
      final bool locked,
      final String? description,
      final NodeStyle? style,
      final int version,
      @DateTimeEpochConverter() final DateTime? createdAt,
      @DateTimeEpochConverter() final DateTime? updatedAt,
      final Map<String, dynamic> data}) = _$NodeModelImpl;
  const _NodeModel._() : super._();

  factory _NodeModel.fromJson(Map<String, dynamic> json) =
      _$NodeModelImpl.fromJson;

  @override
  String get id;
  @override
  @OffsetConverter()
  Offset get position;
  @override
  @SizeConverter()
  Size get size;
  @override
  String get type;
  @override
  String? get title;
  @override
  List<AnchorModel> get anchors;
  @override
  bool get isGroup;
  @override
  bool get isGroupRoot;
  @override
  NodeStatus get status;
  @override
  String? get parentId;
  @override
  int get zIndex;
  @override
  bool get enabled;
  @override
  bool get locked;
  @override
  String? get description;
  @override
  NodeStyle? get style;
  @override
  int get version;
  @override
  @DateTimeEpochConverter()
  DateTime? get createdAt;
  @override
  @DateTimeEpochConverter()
  DateTime? get updatedAt;
  @override
  Map<String, dynamic> get data;
  @override
  @JsonKey(ignore: true)
  _$$NodeModelImplCopyWith<_$NodeModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
