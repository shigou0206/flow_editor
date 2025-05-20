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
  DragMode get dragMode => throw _privateConstructorUsedError;
  String get type => throw _privateConstructorUsedError;
  NodeRole get role => throw _privateConstructorUsedError;
  String? get title => throw _privateConstructorUsedError;
  List<AnchorModel> get anchors => throw _privateConstructorUsedError;
  bool get isGroup => throw _privateConstructorUsedError;
  bool get isGroupRoot => throw _privateConstructorUsedError;
  List<NodeModel> get children => throw _privateConstructorUsedError;
  List<String> get outgoingEdgeIds => throw _privateConstructorUsedError;
  List<String> get incomingEdgeIds => throw _privateConstructorUsedError;
  NodeStatus get status => throw _privateConstructorUsedError;
  String? get parentId => throw _privateConstructorUsedError;
  int get zIndex => throw _privateConstructorUsedError;
  bool get enabled => throw _privateConstructorUsedError;
  bool get locked => throw _privateConstructorUsedError;
  String? get description => throw _privateConstructorUsedError;
  NodeStyle? get style => throw _privateConstructorUsedError;
  int get version => throw _privateConstructorUsedError;
  DateTime? get createdAt => throw _privateConstructorUsedError;
  DateTime? get updatedAt => throw _privateConstructorUsedError;
  Map<String, dynamic> get inputs => throw _privateConstructorUsedError;
  Map<String, dynamic> get outputs => throw _privateConstructorUsedError;
  Map<String, dynamic> get config => throw _privateConstructorUsedError;
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
      DragMode dragMode,
      String type,
      NodeRole role,
      String? title,
      List<AnchorModel> anchors,
      bool isGroup,
      bool isGroupRoot,
      List<NodeModel> children,
      List<String> outgoingEdgeIds,
      List<String> incomingEdgeIds,
      NodeStatus status,
      String? parentId,
      int zIndex,
      bool enabled,
      bool locked,
      String? description,
      NodeStyle? style,
      int version,
      DateTime? createdAt,
      DateTime? updatedAt,
      Map<String, dynamic> inputs,
      Map<String, dynamic> outputs,
      Map<String, dynamic> config,
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
    Object? dragMode = null,
    Object? type = null,
    Object? role = null,
    Object? title = freezed,
    Object? anchors = null,
    Object? isGroup = null,
    Object? isGroupRoot = null,
    Object? children = null,
    Object? outgoingEdgeIds = null,
    Object? incomingEdgeIds = null,
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
    Object? inputs = null,
    Object? outputs = null,
    Object? config = null,
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
      dragMode: null == dragMode
          ? _value.dragMode
          : dragMode // ignore: cast_nullable_to_non_nullable
              as DragMode,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
      role: null == role
          ? _value.role
          : role // ignore: cast_nullable_to_non_nullable
              as NodeRole,
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
      children: null == children
          ? _value.children
          : children // ignore: cast_nullable_to_non_nullable
              as List<NodeModel>,
      outgoingEdgeIds: null == outgoingEdgeIds
          ? _value.outgoingEdgeIds
          : outgoingEdgeIds // ignore: cast_nullable_to_non_nullable
              as List<String>,
      incomingEdgeIds: null == incomingEdgeIds
          ? _value.incomingEdgeIds
          : incomingEdgeIds // ignore: cast_nullable_to_non_nullable
              as List<String>,
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
      inputs: null == inputs
          ? _value.inputs
          : inputs // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
      outputs: null == outputs
          ? _value.outputs
          : outputs // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
      config: null == config
          ? _value.config
          : config // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
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
      DragMode dragMode,
      String type,
      NodeRole role,
      String? title,
      List<AnchorModel> anchors,
      bool isGroup,
      bool isGroupRoot,
      List<NodeModel> children,
      List<String> outgoingEdgeIds,
      List<String> incomingEdgeIds,
      NodeStatus status,
      String? parentId,
      int zIndex,
      bool enabled,
      bool locked,
      String? description,
      NodeStyle? style,
      int version,
      DateTime? createdAt,
      DateTime? updatedAt,
      Map<String, dynamic> inputs,
      Map<String, dynamic> outputs,
      Map<String, dynamic> config,
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
    Object? dragMode = null,
    Object? type = null,
    Object? role = null,
    Object? title = freezed,
    Object? anchors = null,
    Object? isGroup = null,
    Object? isGroupRoot = null,
    Object? children = null,
    Object? outgoingEdgeIds = null,
    Object? incomingEdgeIds = null,
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
    Object? inputs = null,
    Object? outputs = null,
    Object? config = null,
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
      dragMode: null == dragMode
          ? _value.dragMode
          : dragMode // ignore: cast_nullable_to_non_nullable
              as DragMode,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
      role: null == role
          ? _value.role
          : role // ignore: cast_nullable_to_non_nullable
              as NodeRole,
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
      children: null == children
          ? _value._children
          : children // ignore: cast_nullable_to_non_nullable
              as List<NodeModel>,
      outgoingEdgeIds: null == outgoingEdgeIds
          ? _value._outgoingEdgeIds
          : outgoingEdgeIds // ignore: cast_nullable_to_non_nullable
              as List<String>,
      incomingEdgeIds: null == incomingEdgeIds
          ? _value._incomingEdgeIds
          : incomingEdgeIds // ignore: cast_nullable_to_non_nullable
              as List<String>,
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
      inputs: null == inputs
          ? _value._inputs
          : inputs // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
      outputs: null == outputs
          ? _value._outputs
          : outputs // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
      config: null == config
          ? _value._config
          : config // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
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
      this.dragMode = DragMode.full,
      this.type = '',
      this.role = NodeRole.middle,
      this.title,
      final List<AnchorModel> anchors = const [],
      this.isGroup = false,
      this.isGroupRoot = false,
      final List<NodeModel> children = const [],
      final List<String> outgoingEdgeIds = const [],
      final List<String> incomingEdgeIds = const [],
      this.status = NodeStatus.none,
      this.parentId,
      this.zIndex = 0,
      this.enabled = true,
      this.locked = false,
      this.description,
      this.style,
      this.version = 1,
      this.createdAt,
      this.updatedAt,
      final Map<String, dynamic> inputs = const {},
      final Map<String, dynamic> outputs = const {},
      final Map<String, dynamic> config = const {},
      final Map<String, dynamic> data = const {}})
      : _anchors = anchors,
        _children = children,
        _outgoingEdgeIds = outgoingEdgeIds,
        _incomingEdgeIds = incomingEdgeIds,
        _inputs = inputs,
        _outputs = outputs,
        _config = config,
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
  final DragMode dragMode;
  @override
  @JsonKey()
  final String type;
  @override
  @JsonKey()
  final NodeRole role;
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
  final List<NodeModel> _children;
  @override
  @JsonKey()
  List<NodeModel> get children {
    if (_children is EqualUnmodifiableListView) return _children;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_children);
  }

  final List<String> _outgoingEdgeIds;
  @override
  @JsonKey()
  List<String> get outgoingEdgeIds {
    if (_outgoingEdgeIds is EqualUnmodifiableListView) return _outgoingEdgeIds;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_outgoingEdgeIds);
  }

  final List<String> _incomingEdgeIds;
  @override
  @JsonKey()
  List<String> get incomingEdgeIds {
    if (_incomingEdgeIds is EqualUnmodifiableListView) return _incomingEdgeIds;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_incomingEdgeIds);
  }

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
  final DateTime? createdAt;
  @override
  final DateTime? updatedAt;
  final Map<String, dynamic> _inputs;
  @override
  @JsonKey()
  Map<String, dynamic> get inputs {
    if (_inputs is EqualUnmodifiableMapView) return _inputs;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_inputs);
  }

  final Map<String, dynamic> _outputs;
  @override
  @JsonKey()
  Map<String, dynamic> get outputs {
    if (_outputs is EqualUnmodifiableMapView) return _outputs;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_outputs);
  }

  final Map<String, dynamic> _config;
  @override
  @JsonKey()
  Map<String, dynamic> get config {
    if (_config is EqualUnmodifiableMapView) return _config;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_config);
  }

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
    return 'NodeModel(id: $id, position: $position, size: $size, dragMode: $dragMode, type: $type, role: $role, title: $title, anchors: $anchors, isGroup: $isGroup, isGroupRoot: $isGroupRoot, children: $children, outgoingEdgeIds: $outgoingEdgeIds, incomingEdgeIds: $incomingEdgeIds, status: $status, parentId: $parentId, zIndex: $zIndex, enabled: $enabled, locked: $locked, description: $description, style: $style, version: $version, createdAt: $createdAt, updatedAt: $updatedAt, inputs: $inputs, outputs: $outputs, config: $config, data: $data)';
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
            (identical(other.dragMode, dragMode) ||
                other.dragMode == dragMode) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.role, role) || other.role == role) &&
            (identical(other.title, title) || other.title == title) &&
            const DeepCollectionEquality().equals(other._anchors, _anchors) &&
            (identical(other.isGroup, isGroup) || other.isGroup == isGroup) &&
            (identical(other.isGroupRoot, isGroupRoot) ||
                other.isGroupRoot == isGroupRoot) &&
            const DeepCollectionEquality().equals(other._children, _children) &&
            const DeepCollectionEquality()
                .equals(other._outgoingEdgeIds, _outgoingEdgeIds) &&
            const DeepCollectionEquality()
                .equals(other._incomingEdgeIds, _incomingEdgeIds) &&
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
            const DeepCollectionEquality().equals(other._inputs, _inputs) &&
            const DeepCollectionEquality().equals(other._outputs, _outputs) &&
            const DeepCollectionEquality().equals(other._config, _config) &&
            const DeepCollectionEquality().equals(other._data, _data));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hashAll([
        runtimeType,
        id,
        position,
        size,
        dragMode,
        type,
        role,
        title,
        const DeepCollectionEquality().hash(_anchors),
        isGroup,
        isGroupRoot,
        const DeepCollectionEquality().hash(_children),
        const DeepCollectionEquality().hash(_outgoingEdgeIds),
        const DeepCollectionEquality().hash(_incomingEdgeIds),
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
        const DeepCollectionEquality().hash(_inputs),
        const DeepCollectionEquality().hash(_outputs),
        const DeepCollectionEquality().hash(_config),
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
      final DragMode dragMode,
      final String type,
      final NodeRole role,
      final String? title,
      final List<AnchorModel> anchors,
      final bool isGroup,
      final bool isGroupRoot,
      final List<NodeModel> children,
      final List<String> outgoingEdgeIds,
      final List<String> incomingEdgeIds,
      final NodeStatus status,
      final String? parentId,
      final int zIndex,
      final bool enabled,
      final bool locked,
      final String? description,
      final NodeStyle? style,
      final int version,
      final DateTime? createdAt,
      final DateTime? updatedAt,
      final Map<String, dynamic> inputs,
      final Map<String, dynamic> outputs,
      final Map<String, dynamic> config,
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
  DragMode get dragMode;
  @override
  String get type;
  @override
  NodeRole get role;
  @override
  String? get title;
  @override
  List<AnchorModel> get anchors;
  @override
  bool get isGroup;
  @override
  bool get isGroupRoot;
  @override
  List<NodeModel> get children;
  @override
  List<String> get outgoingEdgeIds;
  @override
  List<String> get incomingEdgeIds;
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
  DateTime? get createdAt;
  @override
  DateTime? get updatedAt;
  @override
  Map<String, dynamic> get inputs;
  @override
  Map<String, dynamic> get outputs;
  @override
  Map<String, dynamic> get config;
  @override
  Map<String, dynamic> get data;
  @override
  @JsonKey(ignore: true)
  _$$NodeModelImplCopyWith<_$NodeModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
