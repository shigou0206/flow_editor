// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'edge_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

EdgeModel _$EdgeModelFromJson(Map<String, dynamic> json) {
  return _EdgeModel.fromJson(json);
}

/// @nodoc
mixin _$EdgeModel {
  String get id => throw _privateConstructorUsedError;
  @OffsetConverter()
  Offset? get sourcePosition => throw _privateConstructorUsedError;
  @OffsetConverter()
  Offset? get targetPosition =>
      throw _privateConstructorUsedError; // ===== 连接信息 =====
  String? get sourceNodeId => throw _privateConstructorUsedError;
  String? get sourceAnchorId => throw _privateConstructorUsedError;
  String? get targetNodeId => throw _privateConstructorUsedError;
  String? get targetAnchorId => throw _privateConstructorUsedError;
  bool get isConnected => throw _privateConstructorUsedError;
  bool get isDirected =>
      throw _privateConstructorUsedError; // ===== 分类与状态 =====
  String get edgeType => throw _privateConstructorUsedError;
  String? get status => throw _privateConstructorUsedError;
  bool get locked => throw _privateConstructorUsedError;
  String? get lockedByUser => throw _privateConstructorUsedError;
  int get version => throw _privateConstructorUsedError;
  int get zIndex => throw _privateConstructorUsedError; // ===== 路由点 =====
  @OffsetListConverter()
  List<Offset>? get waypoints =>
      throw _privateConstructorUsedError; // ===== 样式 & 动画 =====
  EdgeLineStyle get lineStyle => throw _privateConstructorUsedError;
  EdgeAnimationConfig get animConfig =>
      throw _privateConstructorUsedError; // ===== 标签 =====
  String? get label => throw _privateConstructorUsedError;
  Map<String, dynamic>? get labelStyle =>
      throw _privateConstructorUsedError; // ===== 扩展交互元素 =====
  List<EdgeOverlayElement> get overlays =>
      throw _privateConstructorUsedError; // ===== 附加数据 =====
  Map<String, dynamic> get data => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $EdgeModelCopyWith<EdgeModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $EdgeModelCopyWith<$Res> {
  factory $EdgeModelCopyWith(EdgeModel value, $Res Function(EdgeModel) then) =
      _$EdgeModelCopyWithImpl<$Res, EdgeModel>;
  @useResult
  $Res call(
      {String id,
      @OffsetConverter() Offset? sourcePosition,
      @OffsetConverter() Offset? targetPosition,
      String? sourceNodeId,
      String? sourceAnchorId,
      String? targetNodeId,
      String? targetAnchorId,
      bool isConnected,
      bool isDirected,
      String edgeType,
      String? status,
      bool locked,
      String? lockedByUser,
      int version,
      int zIndex,
      @OffsetListConverter() List<Offset>? waypoints,
      EdgeLineStyle lineStyle,
      EdgeAnimationConfig animConfig,
      String? label,
      Map<String, dynamic>? labelStyle,
      List<EdgeOverlayElement> overlays,
      Map<String, dynamic> data});

  $EdgeLineStyleCopyWith<$Res> get lineStyle;
  $EdgeAnimationConfigCopyWith<$Res> get animConfig;
}

/// @nodoc
class _$EdgeModelCopyWithImpl<$Res, $Val extends EdgeModel>
    implements $EdgeModelCopyWith<$Res> {
  _$EdgeModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? sourcePosition = freezed,
    Object? targetPosition = freezed,
    Object? sourceNodeId = freezed,
    Object? sourceAnchorId = freezed,
    Object? targetNodeId = freezed,
    Object? targetAnchorId = freezed,
    Object? isConnected = null,
    Object? isDirected = null,
    Object? edgeType = null,
    Object? status = freezed,
    Object? locked = null,
    Object? lockedByUser = freezed,
    Object? version = null,
    Object? zIndex = null,
    Object? waypoints = freezed,
    Object? lineStyle = null,
    Object? animConfig = null,
    Object? label = freezed,
    Object? labelStyle = freezed,
    Object? overlays = null,
    Object? data = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      sourcePosition: freezed == sourcePosition
          ? _value.sourcePosition
          : sourcePosition // ignore: cast_nullable_to_non_nullable
              as Offset?,
      targetPosition: freezed == targetPosition
          ? _value.targetPosition
          : targetPosition // ignore: cast_nullable_to_non_nullable
              as Offset?,
      sourceNodeId: freezed == sourceNodeId
          ? _value.sourceNodeId
          : sourceNodeId // ignore: cast_nullable_to_non_nullable
              as String?,
      sourceAnchorId: freezed == sourceAnchorId
          ? _value.sourceAnchorId
          : sourceAnchorId // ignore: cast_nullable_to_non_nullable
              as String?,
      targetNodeId: freezed == targetNodeId
          ? _value.targetNodeId
          : targetNodeId // ignore: cast_nullable_to_non_nullable
              as String?,
      targetAnchorId: freezed == targetAnchorId
          ? _value.targetAnchorId
          : targetAnchorId // ignore: cast_nullable_to_non_nullable
              as String?,
      isConnected: null == isConnected
          ? _value.isConnected
          : isConnected // ignore: cast_nullable_to_non_nullable
              as bool,
      isDirected: null == isDirected
          ? _value.isDirected
          : isDirected // ignore: cast_nullable_to_non_nullable
              as bool,
      edgeType: null == edgeType
          ? _value.edgeType
          : edgeType // ignore: cast_nullable_to_non_nullable
              as String,
      status: freezed == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String?,
      locked: null == locked
          ? _value.locked
          : locked // ignore: cast_nullable_to_non_nullable
              as bool,
      lockedByUser: freezed == lockedByUser
          ? _value.lockedByUser
          : lockedByUser // ignore: cast_nullable_to_non_nullable
              as String?,
      version: null == version
          ? _value.version
          : version // ignore: cast_nullable_to_non_nullable
              as int,
      zIndex: null == zIndex
          ? _value.zIndex
          : zIndex // ignore: cast_nullable_to_non_nullable
              as int,
      waypoints: freezed == waypoints
          ? _value.waypoints
          : waypoints // ignore: cast_nullable_to_non_nullable
              as List<Offset>?,
      lineStyle: null == lineStyle
          ? _value.lineStyle
          : lineStyle // ignore: cast_nullable_to_non_nullable
              as EdgeLineStyle,
      animConfig: null == animConfig
          ? _value.animConfig
          : animConfig // ignore: cast_nullable_to_non_nullable
              as EdgeAnimationConfig,
      label: freezed == label
          ? _value.label
          : label // ignore: cast_nullable_to_non_nullable
              as String?,
      labelStyle: freezed == labelStyle
          ? _value.labelStyle
          : labelStyle // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
      overlays: null == overlays
          ? _value.overlays
          : overlays // ignore: cast_nullable_to_non_nullable
              as List<EdgeOverlayElement>,
      data: null == data
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $EdgeLineStyleCopyWith<$Res> get lineStyle {
    return $EdgeLineStyleCopyWith<$Res>(_value.lineStyle, (value) {
      return _then(_value.copyWith(lineStyle: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $EdgeAnimationConfigCopyWith<$Res> get animConfig {
    return $EdgeAnimationConfigCopyWith<$Res>(_value.animConfig, (value) {
      return _then(_value.copyWith(animConfig: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$EdgeModelImplCopyWith<$Res>
    implements $EdgeModelCopyWith<$Res> {
  factory _$$EdgeModelImplCopyWith(
          _$EdgeModelImpl value, $Res Function(_$EdgeModelImpl) then) =
      __$$EdgeModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      @OffsetConverter() Offset? sourcePosition,
      @OffsetConverter() Offset? targetPosition,
      String? sourceNodeId,
      String? sourceAnchorId,
      String? targetNodeId,
      String? targetAnchorId,
      bool isConnected,
      bool isDirected,
      String edgeType,
      String? status,
      bool locked,
      String? lockedByUser,
      int version,
      int zIndex,
      @OffsetListConverter() List<Offset>? waypoints,
      EdgeLineStyle lineStyle,
      EdgeAnimationConfig animConfig,
      String? label,
      Map<String, dynamic>? labelStyle,
      List<EdgeOverlayElement> overlays,
      Map<String, dynamic> data});

  @override
  $EdgeLineStyleCopyWith<$Res> get lineStyle;
  @override
  $EdgeAnimationConfigCopyWith<$Res> get animConfig;
}

/// @nodoc
class __$$EdgeModelImplCopyWithImpl<$Res>
    extends _$EdgeModelCopyWithImpl<$Res, _$EdgeModelImpl>
    implements _$$EdgeModelImplCopyWith<$Res> {
  __$$EdgeModelImplCopyWithImpl(
      _$EdgeModelImpl _value, $Res Function(_$EdgeModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? sourcePosition = freezed,
    Object? targetPosition = freezed,
    Object? sourceNodeId = freezed,
    Object? sourceAnchorId = freezed,
    Object? targetNodeId = freezed,
    Object? targetAnchorId = freezed,
    Object? isConnected = null,
    Object? isDirected = null,
    Object? edgeType = null,
    Object? status = freezed,
    Object? locked = null,
    Object? lockedByUser = freezed,
    Object? version = null,
    Object? zIndex = null,
    Object? waypoints = freezed,
    Object? lineStyle = null,
    Object? animConfig = null,
    Object? label = freezed,
    Object? labelStyle = freezed,
    Object? overlays = null,
    Object? data = null,
  }) {
    return _then(_$EdgeModelImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      sourcePosition: freezed == sourcePosition
          ? _value.sourcePosition
          : sourcePosition // ignore: cast_nullable_to_non_nullable
              as Offset?,
      targetPosition: freezed == targetPosition
          ? _value.targetPosition
          : targetPosition // ignore: cast_nullable_to_non_nullable
              as Offset?,
      sourceNodeId: freezed == sourceNodeId
          ? _value.sourceNodeId
          : sourceNodeId // ignore: cast_nullable_to_non_nullable
              as String?,
      sourceAnchorId: freezed == sourceAnchorId
          ? _value.sourceAnchorId
          : sourceAnchorId // ignore: cast_nullable_to_non_nullable
              as String?,
      targetNodeId: freezed == targetNodeId
          ? _value.targetNodeId
          : targetNodeId // ignore: cast_nullable_to_non_nullable
              as String?,
      targetAnchorId: freezed == targetAnchorId
          ? _value.targetAnchorId
          : targetAnchorId // ignore: cast_nullable_to_non_nullable
              as String?,
      isConnected: null == isConnected
          ? _value.isConnected
          : isConnected // ignore: cast_nullable_to_non_nullable
              as bool,
      isDirected: null == isDirected
          ? _value.isDirected
          : isDirected // ignore: cast_nullable_to_non_nullable
              as bool,
      edgeType: null == edgeType
          ? _value.edgeType
          : edgeType // ignore: cast_nullable_to_non_nullable
              as String,
      status: freezed == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String?,
      locked: null == locked
          ? _value.locked
          : locked // ignore: cast_nullable_to_non_nullable
              as bool,
      lockedByUser: freezed == lockedByUser
          ? _value.lockedByUser
          : lockedByUser // ignore: cast_nullable_to_non_nullable
              as String?,
      version: null == version
          ? _value.version
          : version // ignore: cast_nullable_to_non_nullable
              as int,
      zIndex: null == zIndex
          ? _value.zIndex
          : zIndex // ignore: cast_nullable_to_non_nullable
              as int,
      waypoints: freezed == waypoints
          ? _value._waypoints
          : waypoints // ignore: cast_nullable_to_non_nullable
              as List<Offset>?,
      lineStyle: null == lineStyle
          ? _value.lineStyle
          : lineStyle // ignore: cast_nullable_to_non_nullable
              as EdgeLineStyle,
      animConfig: null == animConfig
          ? _value.animConfig
          : animConfig // ignore: cast_nullable_to_non_nullable
              as EdgeAnimationConfig,
      label: freezed == label
          ? _value.label
          : label // ignore: cast_nullable_to_non_nullable
              as String?,
      labelStyle: freezed == labelStyle
          ? _value._labelStyle
          : labelStyle // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
      overlays: null == overlays
          ? _value._overlays
          : overlays // ignore: cast_nullable_to_non_nullable
              as List<EdgeOverlayElement>,
      data: null == data
          ? _value._data
          : data // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$EdgeModelImpl extends _EdgeModel {
  const _$EdgeModelImpl(
      {required this.id,
      @OffsetConverter() this.sourcePosition,
      @OffsetConverter() this.targetPosition,
      this.sourceNodeId,
      this.sourceAnchorId,
      this.targetNodeId = "none",
      this.targetAnchorId = "none",
      this.isConnected = false,
      this.isDirected = true,
      this.edgeType = "default",
      this.status,
      this.locked = false,
      this.lockedByUser,
      this.version = 1,
      this.zIndex = 0,
      @OffsetListConverter() final List<Offset>? waypoints,
      this.lineStyle = const EdgeLineStyle(),
      this.animConfig = const EdgeAnimationConfig(),
      this.label,
      final Map<String, dynamic>? labelStyle,
      final List<EdgeOverlayElement> overlays = const [],
      final Map<String, dynamic> data = const {}})
      : _waypoints = waypoints,
        _labelStyle = labelStyle,
        _overlays = overlays,
        _data = data,
        super._();

  factory _$EdgeModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$EdgeModelImplFromJson(json);

  @override
  final String id;
  @override
  @OffsetConverter()
  final Offset? sourcePosition;
  @override
  @OffsetConverter()
  final Offset? targetPosition;
// ===== 连接信息 =====
  @override
  final String? sourceNodeId;
  @override
  final String? sourceAnchorId;
  @override
  @JsonKey()
  final String? targetNodeId;
  @override
  @JsonKey()
  final String? targetAnchorId;
  @override
  @JsonKey()
  final bool isConnected;
  @override
  @JsonKey()
  final bool isDirected;
// ===== 分类与状态 =====
  @override
  @JsonKey()
  final String edgeType;
  @override
  final String? status;
  @override
  @JsonKey()
  final bool locked;
  @override
  final String? lockedByUser;
  @override
  @JsonKey()
  final int version;
  @override
  @JsonKey()
  final int zIndex;
// ===== 路由点 =====
  final List<Offset>? _waypoints;
// ===== 路由点 =====
  @override
  @OffsetListConverter()
  List<Offset>? get waypoints {
    final value = _waypoints;
    if (value == null) return null;
    if (_waypoints is EqualUnmodifiableListView) return _waypoints;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

// ===== 样式 & 动画 =====
  @override
  @JsonKey()
  final EdgeLineStyle lineStyle;
  @override
  @JsonKey()
  final EdgeAnimationConfig animConfig;
// ===== 标签 =====
  @override
  final String? label;
  final Map<String, dynamic>? _labelStyle;
  @override
  Map<String, dynamic>? get labelStyle {
    final value = _labelStyle;
    if (value == null) return null;
    if (_labelStyle is EqualUnmodifiableMapView) return _labelStyle;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

// ===== 扩展交互元素 =====
  final List<EdgeOverlayElement> _overlays;
// ===== 扩展交互元素 =====
  @override
  @JsonKey()
  List<EdgeOverlayElement> get overlays {
    if (_overlays is EqualUnmodifiableListView) return _overlays;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_overlays);
  }

// ===== 附加数据 =====
  final Map<String, dynamic> _data;
// ===== 附加数据 =====
  @override
  @JsonKey()
  Map<String, dynamic> get data {
    if (_data is EqualUnmodifiableMapView) return _data;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_data);
  }

  @override
  String toString() {
    return 'EdgeModel(id: $id, sourcePosition: $sourcePosition, targetPosition: $targetPosition, sourceNodeId: $sourceNodeId, sourceAnchorId: $sourceAnchorId, targetNodeId: $targetNodeId, targetAnchorId: $targetAnchorId, isConnected: $isConnected, isDirected: $isDirected, edgeType: $edgeType, status: $status, locked: $locked, lockedByUser: $lockedByUser, version: $version, zIndex: $zIndex, waypoints: $waypoints, lineStyle: $lineStyle, animConfig: $animConfig, label: $label, labelStyle: $labelStyle, overlays: $overlays, data: $data)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$EdgeModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.sourcePosition, sourcePosition) ||
                other.sourcePosition == sourcePosition) &&
            (identical(other.targetPosition, targetPosition) ||
                other.targetPosition == targetPosition) &&
            (identical(other.sourceNodeId, sourceNodeId) ||
                other.sourceNodeId == sourceNodeId) &&
            (identical(other.sourceAnchorId, sourceAnchorId) ||
                other.sourceAnchorId == sourceAnchorId) &&
            (identical(other.targetNodeId, targetNodeId) ||
                other.targetNodeId == targetNodeId) &&
            (identical(other.targetAnchorId, targetAnchorId) ||
                other.targetAnchorId == targetAnchorId) &&
            (identical(other.isConnected, isConnected) ||
                other.isConnected == isConnected) &&
            (identical(other.isDirected, isDirected) ||
                other.isDirected == isDirected) &&
            (identical(other.edgeType, edgeType) ||
                other.edgeType == edgeType) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.locked, locked) || other.locked == locked) &&
            (identical(other.lockedByUser, lockedByUser) ||
                other.lockedByUser == lockedByUser) &&
            (identical(other.version, version) || other.version == version) &&
            (identical(other.zIndex, zIndex) || other.zIndex == zIndex) &&
            const DeepCollectionEquality()
                .equals(other._waypoints, _waypoints) &&
            (identical(other.lineStyle, lineStyle) ||
                other.lineStyle == lineStyle) &&
            (identical(other.animConfig, animConfig) ||
                other.animConfig == animConfig) &&
            (identical(other.label, label) || other.label == label) &&
            const DeepCollectionEquality()
                .equals(other._labelStyle, _labelStyle) &&
            const DeepCollectionEquality().equals(other._overlays, _overlays) &&
            const DeepCollectionEquality().equals(other._data, _data));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hashAll([
        runtimeType,
        id,
        sourcePosition,
        targetPosition,
        sourceNodeId,
        sourceAnchorId,
        targetNodeId,
        targetAnchorId,
        isConnected,
        isDirected,
        edgeType,
        status,
        locked,
        lockedByUser,
        version,
        zIndex,
        const DeepCollectionEquality().hash(_waypoints),
        lineStyle,
        animConfig,
        label,
        const DeepCollectionEquality().hash(_labelStyle),
        const DeepCollectionEquality().hash(_overlays),
        const DeepCollectionEquality().hash(_data)
      ]);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$EdgeModelImplCopyWith<_$EdgeModelImpl> get copyWith =>
      __$$EdgeModelImplCopyWithImpl<_$EdgeModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$EdgeModelImplToJson(
      this,
    );
  }
}

abstract class _EdgeModel extends EdgeModel {
  const factory _EdgeModel(
      {required final String id,
      @OffsetConverter() final Offset? sourcePosition,
      @OffsetConverter() final Offset? targetPosition,
      final String? sourceNodeId,
      final String? sourceAnchorId,
      final String? targetNodeId,
      final String? targetAnchorId,
      final bool isConnected,
      final bool isDirected,
      final String edgeType,
      final String? status,
      final bool locked,
      final String? lockedByUser,
      final int version,
      final int zIndex,
      @OffsetListConverter() final List<Offset>? waypoints,
      final EdgeLineStyle lineStyle,
      final EdgeAnimationConfig animConfig,
      final String? label,
      final Map<String, dynamic>? labelStyle,
      final List<EdgeOverlayElement> overlays,
      final Map<String, dynamic> data}) = _$EdgeModelImpl;
  const _EdgeModel._() : super._();

  factory _EdgeModel.fromJson(Map<String, dynamic> json) =
      _$EdgeModelImpl.fromJson;

  @override
  String get id;
  @override
  @OffsetConverter()
  Offset? get sourcePosition;
  @override
  @OffsetConverter()
  Offset? get targetPosition;
  @override // ===== 连接信息 =====
  String? get sourceNodeId;
  @override
  String? get sourceAnchorId;
  @override
  String? get targetNodeId;
  @override
  String? get targetAnchorId;
  @override
  bool get isConnected;
  @override
  bool get isDirected;
  @override // ===== 分类与状态 =====
  String get edgeType;
  @override
  String? get status;
  @override
  bool get locked;
  @override
  String? get lockedByUser;
  @override
  int get version;
  @override
  int get zIndex;
  @override // ===== 路由点 =====
  @OffsetListConverter()
  List<Offset>? get waypoints;
  @override // ===== 样式 & 动画 =====
  EdgeLineStyle get lineStyle;
  @override
  EdgeAnimationConfig get animConfig;
  @override // ===== 标签 =====
  String? get label;
  @override
  Map<String, dynamic>? get labelStyle;
  @override // ===== 扩展交互元素 =====
  List<EdgeOverlayElement> get overlays;
  @override // ===== 附加数据 =====
  Map<String, dynamic> get data;
  @override
  @JsonKey(ignore: true)
  _$$EdgeModelImplCopyWith<_$EdgeModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
