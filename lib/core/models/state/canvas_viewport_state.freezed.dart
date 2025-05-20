// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'canvas_viewport_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

CanvasViewportState _$CanvasViewportStateFromJson(Map<String, dynamic> json) {
  return _CanvasViewportState.fromJson(json);
}

/// @nodoc
mixin _$CanvasViewportState {
  @OffsetConverter()
  Offset get offset => throw _privateConstructorUsedError;
  double get scale => throw _privateConstructorUsedError;
  @SizeConverter()
  Size? get viewportSize => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $CanvasViewportStateCopyWith<CanvasViewportState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CanvasViewportStateCopyWith<$Res> {
  factory $CanvasViewportStateCopyWith(
          CanvasViewportState value, $Res Function(CanvasViewportState) then) =
      _$CanvasViewportStateCopyWithImpl<$Res, CanvasViewportState>;
  @useResult
  $Res call(
      {@OffsetConverter() Offset offset,
      double scale,
      @SizeConverter() Size? viewportSize});
}

/// @nodoc
class _$CanvasViewportStateCopyWithImpl<$Res, $Val extends CanvasViewportState>
    implements $CanvasViewportStateCopyWith<$Res> {
  _$CanvasViewportStateCopyWithImpl(this._value, this._then);

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
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$CanvasViewportStateImplCopyWith<$Res>
    implements $CanvasViewportStateCopyWith<$Res> {
  factory _$$CanvasViewportStateImplCopyWith(_$CanvasViewportStateImpl value,
          $Res Function(_$CanvasViewportStateImpl) then) =
      __$$CanvasViewportStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@OffsetConverter() Offset offset,
      double scale,
      @SizeConverter() Size? viewportSize});
}

/// @nodoc
class __$$CanvasViewportStateImplCopyWithImpl<$Res>
    extends _$CanvasViewportStateCopyWithImpl<$Res, _$CanvasViewportStateImpl>
    implements _$$CanvasViewportStateImplCopyWith<$Res> {
  __$$CanvasViewportStateImplCopyWithImpl(_$CanvasViewportStateImpl _value,
      $Res Function(_$CanvasViewportStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? offset = null,
    Object? scale = null,
    Object? viewportSize = freezed,
  }) {
    return _then(_$CanvasViewportStateImpl(
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
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$CanvasViewportStateImpl extends _CanvasViewportState {
  const _$CanvasViewportStateImpl(
      {@OffsetConverter() this.offset = Offset.zero,
      this.scale = 1.0,
      @SizeConverter() this.viewportSize})
      : super._();

  factory _$CanvasViewportStateImpl.fromJson(Map<String, dynamic> json) =>
      _$$CanvasViewportStateImplFromJson(json);

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
  String toString() {
    return 'CanvasViewportState(offset: $offset, scale: $scale, viewportSize: $viewportSize)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CanvasViewportStateImpl &&
            (identical(other.offset, offset) || other.offset == offset) &&
            (identical(other.scale, scale) || other.scale == scale) &&
            (identical(other.viewportSize, viewportSize) ||
                other.viewportSize == viewportSize));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, offset, scale, viewportSize);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$CanvasViewportStateImplCopyWith<_$CanvasViewportStateImpl> get copyWith =>
      __$$CanvasViewportStateImplCopyWithImpl<_$CanvasViewportStateImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CanvasViewportStateImplToJson(
      this,
    );
  }
}

abstract class _CanvasViewportState extends CanvasViewportState {
  const factory _CanvasViewportState(
      {@OffsetConverter() final Offset offset,
      final double scale,
      @SizeConverter() final Size? viewportSize}) = _$CanvasViewportStateImpl;
  const _CanvasViewportState._() : super._();

  factory _CanvasViewportState.fromJson(Map<String, dynamic> json) =
      _$CanvasViewportStateImpl.fromJson;

  @override
  @OffsetConverter()
  Offset get offset;
  @override
  double get scale;
  @override
  @SizeConverter()
  Size? get viewportSize;
  @override
  @JsonKey(ignore: true)
  _$$CanvasViewportStateImplCopyWith<_$CanvasViewportStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
