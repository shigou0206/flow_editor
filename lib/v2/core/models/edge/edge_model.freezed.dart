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
  String? get id => throw _privateConstructorUsedError;
  @OffsetConverter()
  Offset get start => throw _privateConstructorUsedError;
  @OffsetConverter()
  Offset get end => throw _privateConstructorUsedError;
  String? get sourceNodeId => throw _privateConstructorUsedError;
  String? get sourceAnchorId => throw _privateConstructorUsedError;
  String? get targetNodeId => throw _privateConstructorUsedError;
  String? get targetAnchorId => throw _privateConstructorUsedError;
  List<Point> get waypoints => throw _privateConstructorUsedError;
  bool get isDirected => throw _privateConstructorUsedError;
  bool get isConnected => throw _privateConstructorUsedError;
  int get version => throw _privateConstructorUsedError;
  int get zIndex => throw _privateConstructorUsedError;
  String get edgeType => throw _privateConstructorUsedError;
  String? get status => throw _privateConstructorUsedError;
  bool get locked => throw _privateConstructorUsedError;
  String? get lockedByUser => throw _privateConstructorUsedError;
  EdgeLineStyle get lineStyle => throw _privateConstructorUsedError;
  EdgeAnimationConfig get animConfig => throw _privateConstructorUsedError;
  String? get label => throw _privateConstructorUsedError;
  Map<String, dynamic>? get labelStyle => throw _privateConstructorUsedError;
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
      {String? id,
      @OffsetConverter() Offset start,
      @OffsetConverter() Offset end,
      String? sourceNodeId,
      String? sourceAnchorId,
      String? targetNodeId,
      String? targetAnchorId,
      List<Point> waypoints,
      bool isDirected,
      bool isConnected,
      int version,
      int zIndex,
      String edgeType,
      String? status,
      bool locked,
      String? lockedByUser,
      EdgeLineStyle lineStyle,
      EdgeAnimationConfig animConfig,
      String? label,
      Map<String, dynamic>? labelStyle,
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
    Object? id = freezed,
    Object? start = null,
    Object? end = null,
    Object? sourceNodeId = freezed,
    Object? sourceAnchorId = freezed,
    Object? targetNodeId = freezed,
    Object? targetAnchorId = freezed,
    Object? waypoints = null,
    Object? isDirected = null,
    Object? isConnected = null,
    Object? version = null,
    Object? zIndex = null,
    Object? edgeType = null,
    Object? status = freezed,
    Object? locked = null,
    Object? lockedByUser = freezed,
    Object? lineStyle = null,
    Object? animConfig = null,
    Object? label = freezed,
    Object? labelStyle = freezed,
    Object? data = null,
  }) {
    return _then(_value.copyWith(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      start: null == start
          ? _value.start
          : start // ignore: cast_nullable_to_non_nullable
              as Offset,
      end: null == end
          ? _value.end
          : end // ignore: cast_nullable_to_non_nullable
              as Offset,
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
      waypoints: null == waypoints
          ? _value.waypoints
          : waypoints // ignore: cast_nullable_to_non_nullable
              as List<Point>,
      isDirected: null == isDirected
          ? _value.isDirected
          : isDirected // ignore: cast_nullable_to_non_nullable
              as bool,
      isConnected: null == isConnected
          ? _value.isConnected
          : isConnected // ignore: cast_nullable_to_non_nullable
              as bool,
      version: null == version
          ? _value.version
          : version // ignore: cast_nullable_to_non_nullable
              as int,
      zIndex: null == zIndex
          ? _value.zIndex
          : zIndex // ignore: cast_nullable_to_non_nullable
              as int,
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
      {String? id,
      @OffsetConverter() Offset start,
      @OffsetConverter() Offset end,
      String? sourceNodeId,
      String? sourceAnchorId,
      String? targetNodeId,
      String? targetAnchorId,
      List<Point> waypoints,
      bool isDirected,
      bool isConnected,
      int version,
      int zIndex,
      String edgeType,
      String? status,
      bool locked,
      String? lockedByUser,
      EdgeLineStyle lineStyle,
      EdgeAnimationConfig animConfig,
      String? label,
      Map<String, dynamic>? labelStyle,
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
    Object? id = freezed,
    Object? start = null,
    Object? end = null,
    Object? sourceNodeId = freezed,
    Object? sourceAnchorId = freezed,
    Object? targetNodeId = freezed,
    Object? targetAnchorId = freezed,
    Object? waypoints = null,
    Object? isDirected = null,
    Object? isConnected = null,
    Object? version = null,
    Object? zIndex = null,
    Object? edgeType = null,
    Object? status = freezed,
    Object? locked = null,
    Object? lockedByUser = freezed,
    Object? lineStyle = null,
    Object? animConfig = null,
    Object? label = freezed,
    Object? labelStyle = freezed,
    Object? data = null,
  }) {
    return _then(_$EdgeModelImpl(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      start: null == start
          ? _value.start
          : start // ignore: cast_nullable_to_non_nullable
              as Offset,
      end: null == end
          ? _value.end
          : end // ignore: cast_nullable_to_non_nullable
              as Offset,
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
      waypoints: null == waypoints
          ? _value._waypoints
          : waypoints // ignore: cast_nullable_to_non_nullable
              as List<Point>,
      isDirected: null == isDirected
          ? _value.isDirected
          : isDirected // ignore: cast_nullable_to_non_nullable
              as bool,
      isConnected: null == isConnected
          ? _value.isConnected
          : isConnected // ignore: cast_nullable_to_non_nullable
              as bool,
      version: null == version
          ? _value.version
          : version // ignore: cast_nullable_to_non_nullable
              as int,
      zIndex: null == zIndex
          ? _value.zIndex
          : zIndex // ignore: cast_nullable_to_non_nullable
              as int,
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
      {this.id,
      @OffsetConverter() required this.start,
      @OffsetConverter() required this.end,
      this.sourceNodeId,
      this.sourceAnchorId,
      this.targetNodeId,
      this.targetAnchorId,
      final List<Point> waypoints = const [],
      this.isDirected = true,
      this.isConnected = false,
      this.version = 1,
      this.zIndex = 0,
      this.edgeType = "default",
      this.status,
      this.locked = false,
      this.lockedByUser,
      this.lineStyle = const EdgeLineStyle(),
      this.animConfig = const EdgeAnimationConfig(),
      this.label,
      final Map<String, dynamic>? labelStyle,
      final Map<String, dynamic> data = const {}})
      : _waypoints = waypoints,
        _labelStyle = labelStyle,
        _data = data,
        super._();

  factory _$EdgeModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$EdgeModelImplFromJson(json);

  @override
  final String? id;
  @override
  @OffsetConverter()
  final Offset start;
  @override
  @OffsetConverter()
  final Offset end;
  @override
  final String? sourceNodeId;
  @override
  final String? sourceAnchorId;
  @override
  final String? targetNodeId;
  @override
  final String? targetAnchorId;
  final List<Point> _waypoints;
  @override
  @JsonKey()
  List<Point> get waypoints {
    if (_waypoints is EqualUnmodifiableListView) return _waypoints;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_waypoints);
  }

  @override
  @JsonKey()
  final bool isDirected;
  @override
  @JsonKey()
  final bool isConnected;
  @override
  @JsonKey()
  final int version;
  @override
  @JsonKey()
  final int zIndex;
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
  final EdgeLineStyle lineStyle;
  @override
  @JsonKey()
  final EdgeAnimationConfig animConfig;
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
    return 'EdgeModel(id: $id, start: $start, end: $end, sourceNodeId: $sourceNodeId, sourceAnchorId: $sourceAnchorId, targetNodeId: $targetNodeId, targetAnchorId: $targetAnchorId, waypoints: $waypoints, isDirected: $isDirected, isConnected: $isConnected, version: $version, zIndex: $zIndex, edgeType: $edgeType, status: $status, locked: $locked, lockedByUser: $lockedByUser, lineStyle: $lineStyle, animConfig: $animConfig, label: $label, labelStyle: $labelStyle, data: $data)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$EdgeModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.start, start) || other.start == start) &&
            (identical(other.end, end) || other.end == end) &&
            (identical(other.sourceNodeId, sourceNodeId) ||
                other.sourceNodeId == sourceNodeId) &&
            (identical(other.sourceAnchorId, sourceAnchorId) ||
                other.sourceAnchorId == sourceAnchorId) &&
            (identical(other.targetNodeId, targetNodeId) ||
                other.targetNodeId == targetNodeId) &&
            (identical(other.targetAnchorId, targetAnchorId) ||
                other.targetAnchorId == targetAnchorId) &&
            const DeepCollectionEquality()
                .equals(other._waypoints, _waypoints) &&
            (identical(other.isDirected, isDirected) ||
                other.isDirected == isDirected) &&
            (identical(other.isConnected, isConnected) ||
                other.isConnected == isConnected) &&
            (identical(other.version, version) || other.version == version) &&
            (identical(other.zIndex, zIndex) || other.zIndex == zIndex) &&
            (identical(other.edgeType, edgeType) ||
                other.edgeType == edgeType) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.locked, locked) || other.locked == locked) &&
            (identical(other.lockedByUser, lockedByUser) ||
                other.lockedByUser == lockedByUser) &&
            (identical(other.lineStyle, lineStyle) ||
                other.lineStyle == lineStyle) &&
            (identical(other.animConfig, animConfig) ||
                other.animConfig == animConfig) &&
            (identical(other.label, label) || other.label == label) &&
            const DeepCollectionEquality()
                .equals(other._labelStyle, _labelStyle) &&
            const DeepCollectionEquality().equals(other._data, _data));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hashAll([
        runtimeType,
        id,
        start,
        end,
        sourceNodeId,
        sourceAnchorId,
        targetNodeId,
        targetAnchorId,
        const DeepCollectionEquality().hash(_waypoints),
        isDirected,
        isConnected,
        version,
        zIndex,
        edgeType,
        status,
        locked,
        lockedByUser,
        lineStyle,
        animConfig,
        label,
        const DeepCollectionEquality().hash(_labelStyle),
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
      {final String? id,
      @OffsetConverter() required final Offset start,
      @OffsetConverter() required final Offset end,
      final String? sourceNodeId,
      final String? sourceAnchorId,
      final String? targetNodeId,
      final String? targetAnchorId,
      final List<Point> waypoints,
      final bool isDirected,
      final bool isConnected,
      final int version,
      final int zIndex,
      final String edgeType,
      final String? status,
      final bool locked,
      final String? lockedByUser,
      final EdgeLineStyle lineStyle,
      final EdgeAnimationConfig animConfig,
      final String? label,
      final Map<String, dynamic>? labelStyle,
      final Map<String, dynamic> data}) = _$EdgeModelImpl;
  const _EdgeModel._() : super._();

  factory _EdgeModel.fromJson(Map<String, dynamic> json) =
      _$EdgeModelImpl.fromJson;

  @override
  String? get id;
  @override
  @OffsetConverter()
  Offset get start;
  @override
  @OffsetConverter()
  Offset get end;
  @override
  String? get sourceNodeId;
  @override
  String? get sourceAnchorId;
  @override
  String? get targetNodeId;
  @override
  String? get targetAnchorId;
  @override
  List<Point> get waypoints;
  @override
  bool get isDirected;
  @override
  bool get isConnected;
  @override
  int get version;
  @override
  int get zIndex;
  @override
  String get edgeType;
  @override
  String? get status;
  @override
  bool get locked;
  @override
  String? get lockedByUser;
  @override
  EdgeLineStyle get lineStyle;
  @override
  EdgeAnimationConfig get animConfig;
  @override
  String? get label;
  @override
  Map<String, dynamic>? get labelStyle;
  @override
  Map<String, dynamic> get data;
  @override
  @JsonKey(ignore: true)
  _$$EdgeModelImplCopyWith<_$EdgeModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
