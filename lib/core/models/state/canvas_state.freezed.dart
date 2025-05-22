// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'canvas_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

CanvasState _$CanvasStateFromJson(Map<String, dynamic> json) {
  return _CanvasState.fromJson(json);
}

/// @nodoc
mixin _$CanvasState {
  @OffsetConverter()
  Offset get offset => throw _privateConstructorUsedError;
  double get scale => throw _privateConstructorUsedError;
  @SizeConverter()
  Size? get viewportSize => throw _privateConstructorUsedError;
  CanvasInteractionMode get interactionMode =>
      throw _privateConstructorUsedError;
  CanvasVisualConfig get visualConfig => throw _privateConstructorUsedError;
  CanvasInteractionConfig get interactionConfig =>
      throw _privateConstructorUsedError;
  int get version => throw _privateConstructorUsedError;
  String? get focusItemId => throw _privateConstructorUsedError;
  WorkflowStatus get workflowStatus => throw _privateConstructorUsedError;
  Map<String, dynamic>? get data => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $CanvasStateCopyWith<CanvasState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CanvasStateCopyWith<$Res> {
  factory $CanvasStateCopyWith(
          CanvasState value, $Res Function(CanvasState) then) =
      _$CanvasStateCopyWithImpl<$Res, CanvasState>;
  @useResult
  $Res call(
      {@OffsetConverter() Offset offset,
      double scale,
      @SizeConverter() Size? viewportSize,
      CanvasInteractionMode interactionMode,
      CanvasVisualConfig visualConfig,
      CanvasInteractionConfig interactionConfig,
      int version,
      String? focusItemId,
      WorkflowStatus workflowStatus,
      Map<String, dynamic>? data});

  $CanvasVisualConfigCopyWith<$Res> get visualConfig;
  $CanvasInteractionConfigCopyWith<$Res> get interactionConfig;
}

/// @nodoc
class _$CanvasStateCopyWithImpl<$Res, $Val extends CanvasState>
    implements $CanvasStateCopyWith<$Res> {
  _$CanvasStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? offset = null,
    Object? scale = null,
    Object? viewportSize = freezed,
    Object? interactionMode = null,
    Object? visualConfig = null,
    Object? interactionConfig = null,
    Object? version = null,
    Object? focusItemId = freezed,
    Object? workflowStatus = null,
    Object? data = freezed,
  }) {
    return _then(_value.copyWith(
      offset: null == offset
          ? _value.offset
          : offset // ignore: cast_nullable_to_non_nullable
              as Offset,
      scale: null == scale
          ? _value.scale
          : scale // ignore: cast_nullable_to_non_nullable
              as double,
      viewportSize: freezed == viewportSize
          ? _value.viewportSize
          : viewportSize // ignore: cast_nullable_to_non_nullable
              as Size?,
      interactionMode: null == interactionMode
          ? _value.interactionMode
          : interactionMode // ignore: cast_nullable_to_non_nullable
              as CanvasInteractionMode,
      visualConfig: null == visualConfig
          ? _value.visualConfig
          : visualConfig // ignore: cast_nullable_to_non_nullable
              as CanvasVisualConfig,
      interactionConfig: null == interactionConfig
          ? _value.interactionConfig
          : interactionConfig // ignore: cast_nullable_to_non_nullable
              as CanvasInteractionConfig,
      version: null == version
          ? _value.version
          : version // ignore: cast_nullable_to_non_nullable
              as int,
      focusItemId: freezed == focusItemId
          ? _value.focusItemId
          : focusItemId // ignore: cast_nullable_to_non_nullable
              as String?,
      workflowStatus: null == workflowStatus
          ? _value.workflowStatus
          : workflowStatus // ignore: cast_nullable_to_non_nullable
              as WorkflowStatus,
      data: freezed == data
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $CanvasVisualConfigCopyWith<$Res> get visualConfig {
    return $CanvasVisualConfigCopyWith<$Res>(_value.visualConfig, (value) {
      return _then(_value.copyWith(visualConfig: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $CanvasInteractionConfigCopyWith<$Res> get interactionConfig {
    return $CanvasInteractionConfigCopyWith<$Res>(_value.interactionConfig,
        (value) {
      return _then(_value.copyWith(interactionConfig: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$CanvasStateImplCopyWith<$Res>
    implements $CanvasStateCopyWith<$Res> {
  factory _$$CanvasStateImplCopyWith(
          _$CanvasStateImpl value, $Res Function(_$CanvasStateImpl) then) =
      __$$CanvasStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@OffsetConverter() Offset offset,
      double scale,
      @SizeConverter() Size? viewportSize,
      CanvasInteractionMode interactionMode,
      CanvasVisualConfig visualConfig,
      CanvasInteractionConfig interactionConfig,
      int version,
      String? focusItemId,
      WorkflowStatus workflowStatus,
      Map<String, dynamic>? data});

  @override
  $CanvasVisualConfigCopyWith<$Res> get visualConfig;
  @override
  $CanvasInteractionConfigCopyWith<$Res> get interactionConfig;
}

/// @nodoc
class __$$CanvasStateImplCopyWithImpl<$Res>
    extends _$CanvasStateCopyWithImpl<$Res, _$CanvasStateImpl>
    implements _$$CanvasStateImplCopyWith<$Res> {
  __$$CanvasStateImplCopyWithImpl(
      _$CanvasStateImpl _value, $Res Function(_$CanvasStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? offset = null,
    Object? scale = null,
    Object? viewportSize = freezed,
    Object? interactionMode = null,
    Object? visualConfig = null,
    Object? interactionConfig = null,
    Object? version = null,
    Object? focusItemId = freezed,
    Object? workflowStatus = null,
    Object? data = freezed,
  }) {
    return _then(_$CanvasStateImpl(
      offset: null == offset
          ? _value.offset
          : offset // ignore: cast_nullable_to_non_nullable
              as Offset,
      scale: null == scale
          ? _value.scale
          : scale // ignore: cast_nullable_to_non_nullable
              as double,
      viewportSize: freezed == viewportSize
          ? _value.viewportSize
          : viewportSize // ignore: cast_nullable_to_non_nullable
              as Size?,
      interactionMode: null == interactionMode
          ? _value.interactionMode
          : interactionMode // ignore: cast_nullable_to_non_nullable
              as CanvasInteractionMode,
      visualConfig: null == visualConfig
          ? _value.visualConfig
          : visualConfig // ignore: cast_nullable_to_non_nullable
              as CanvasVisualConfig,
      interactionConfig: null == interactionConfig
          ? _value.interactionConfig
          : interactionConfig // ignore: cast_nullable_to_non_nullable
              as CanvasInteractionConfig,
      version: null == version
          ? _value.version
          : version // ignore: cast_nullable_to_non_nullable
              as int,
      focusItemId: freezed == focusItemId
          ? _value.focusItemId
          : focusItemId // ignore: cast_nullable_to_non_nullable
              as String?,
      workflowStatus: null == workflowStatus
          ? _value.workflowStatus
          : workflowStatus // ignore: cast_nullable_to_non_nullable
              as WorkflowStatus,
      data: freezed == data
          ? _value._data
          : data // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$CanvasStateImpl extends _CanvasState {
  const _$CanvasStateImpl(
      {@OffsetConverter() this.offset = Offset.zero,
      this.scale = 1.0,
      @SizeConverter() this.viewportSize,
      this.interactionMode = CanvasInteractionMode.panCanvas,
      this.visualConfig = const CanvasVisualConfig(),
      this.interactionConfig = const CanvasInteractionConfig(),
      this.version = 1,
      this.focusItemId,
      this.workflowStatus = WorkflowStatus.pending,
      final Map<String, dynamic>? data})
      : _data = data,
        super._();

  factory _$CanvasStateImpl.fromJson(Map<String, dynamic> json) =>
      _$$CanvasStateImplFromJson(json);

  @override
  @JsonKey()
  @OffsetConverter()
  final Offset offset;
  @override
  @JsonKey()
  final double scale;
  @override
  @SizeConverter()
  final Size? viewportSize;
  @override
  @JsonKey()
  final CanvasInteractionMode interactionMode;
  @override
  @JsonKey()
  final CanvasVisualConfig visualConfig;
  @override
  @JsonKey()
  final CanvasInteractionConfig interactionConfig;
  @override
  @JsonKey()
  final int version;
  @override
  final String? focusItemId;
  @override
  @JsonKey()
  final WorkflowStatus workflowStatus;
  final Map<String, dynamic>? _data;
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
    return 'CanvasState(offset: $offset, scale: $scale, viewportSize: $viewportSize, interactionMode: $interactionMode, visualConfig: $visualConfig, interactionConfig: $interactionConfig, version: $version, focusItemId: $focusItemId, workflowStatus: $workflowStatus, data: $data)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CanvasStateImpl &&
            (identical(other.offset, offset) || other.offset == offset) &&
            (identical(other.scale, scale) || other.scale == scale) &&
            (identical(other.viewportSize, viewportSize) ||
                other.viewportSize == viewportSize) &&
            (identical(other.interactionMode, interactionMode) ||
                other.interactionMode == interactionMode) &&
            (identical(other.visualConfig, visualConfig) ||
                other.visualConfig == visualConfig) &&
            (identical(other.interactionConfig, interactionConfig) ||
                other.interactionConfig == interactionConfig) &&
            (identical(other.version, version) || other.version == version) &&
            (identical(other.focusItemId, focusItemId) ||
                other.focusItemId == focusItemId) &&
            (identical(other.workflowStatus, workflowStatus) ||
                other.workflowStatus == workflowStatus) &&
            const DeepCollectionEquality().equals(other._data, _data));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      offset,
      scale,
      viewportSize,
      interactionMode,
      visualConfig,
      interactionConfig,
      version,
      focusItemId,
      workflowStatus,
      const DeepCollectionEquality().hash(_data));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$CanvasStateImplCopyWith<_$CanvasStateImpl> get copyWith =>
      __$$CanvasStateImplCopyWithImpl<_$CanvasStateImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CanvasStateImplToJson(
      this,
    );
  }
}

abstract class _CanvasState extends CanvasState {
  const factory _CanvasState(
      {@OffsetConverter() final Offset offset,
      final double scale,
      @SizeConverter() final Size? viewportSize,
      final CanvasInteractionMode interactionMode,
      final CanvasVisualConfig visualConfig,
      final CanvasInteractionConfig interactionConfig,
      final int version,
      final String? focusItemId,
      final WorkflowStatus workflowStatus,
      final Map<String, dynamic>? data}) = _$CanvasStateImpl;
  const _CanvasState._() : super._();

  factory _CanvasState.fromJson(Map<String, dynamic> json) =
      _$CanvasStateImpl.fromJson;

  @override
  @OffsetConverter()
  Offset get offset;
  @override
  double get scale;
  @override
  @SizeConverter()
  Size? get viewportSize;
  @override
  CanvasInteractionMode get interactionMode;
  @override
  CanvasVisualConfig get visualConfig;
  @override
  CanvasInteractionConfig get interactionConfig;
  @override
  int get version;
  @override
  String? get focusItemId;
  @override
  WorkflowStatus get workflowStatus;
  @override
  Map<String, dynamic>? get data;
  @override
  @JsonKey(ignore: true)
  _$$CanvasStateImplCopyWith<_$CanvasStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
