// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'canvas_visual_config.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

CanvasVisualConfig _$CanvasVisualConfigFromJson(Map<String, dynamic> json) {
  return _CanvasVisualConfig.fromJson(json);
}

/// @nodoc
mixin _$CanvasVisualConfig {
  @ColorConverter()
  Color get backgroundColor => throw _privateConstructorUsedError;
  bool get showGrid => throw _privateConstructorUsedError;
  @ColorConverter()
  Color get gridColor => throw _privateConstructorUsedError;
  double get gridSpacing => throw _privateConstructorUsedError;
  double get width => throw _privateConstructorUsedError;
  double get height => throw _privateConstructorUsedError;
  BackgroundStyle get backgroundStyle => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $CanvasVisualConfigCopyWith<CanvasVisualConfig> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CanvasVisualConfigCopyWith<$Res> {
  factory $CanvasVisualConfigCopyWith(
          CanvasVisualConfig value, $Res Function(CanvasVisualConfig) then) =
      _$CanvasVisualConfigCopyWithImpl<$Res, CanvasVisualConfig>;
  @useResult
  $Res call(
      {@ColorConverter() Color backgroundColor,
      bool showGrid,
      @ColorConverter() Color gridColor,
      double gridSpacing,
      double width,
      double height,
      BackgroundStyle backgroundStyle});
}

/// @nodoc
class _$CanvasVisualConfigCopyWithImpl<$Res, $Val extends CanvasVisualConfig>
    implements $CanvasVisualConfigCopyWith<$Res> {
  _$CanvasVisualConfigCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? backgroundColor = null,
    Object? showGrid = null,
    Object? gridColor = null,
    Object? gridSpacing = null,
    Object? width = null,
    Object? height = null,
    Object? backgroundStyle = null,
  }) {
    return _then(_value.copyWith(
      backgroundColor: null == backgroundColor
          ? _value.backgroundColor
          : backgroundColor // ignore: cast_nullable_to_non_nullable
              as Color,
      showGrid: null == showGrid
          ? _value.showGrid
          : showGrid // ignore: cast_nullable_to_non_nullable
              as bool,
      gridColor: null == gridColor
          ? _value.gridColor
          : gridColor // ignore: cast_nullable_to_non_nullable
              as Color,
      gridSpacing: null == gridSpacing
          ? _value.gridSpacing
          : gridSpacing // ignore: cast_nullable_to_non_nullable
              as double,
      width: null == width
          ? _value.width
          : width // ignore: cast_nullable_to_non_nullable
              as double,
      height: null == height
          ? _value.height
          : height // ignore: cast_nullable_to_non_nullable
              as double,
      backgroundStyle: null == backgroundStyle
          ? _value.backgroundStyle
          : backgroundStyle // ignore: cast_nullable_to_non_nullable
              as BackgroundStyle,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$CanvasVisualConfigImplCopyWith<$Res>
    implements $CanvasVisualConfigCopyWith<$Res> {
  factory _$$CanvasVisualConfigImplCopyWith(_$CanvasVisualConfigImpl value,
          $Res Function(_$CanvasVisualConfigImpl) then) =
      __$$CanvasVisualConfigImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@ColorConverter() Color backgroundColor,
      bool showGrid,
      @ColorConverter() Color gridColor,
      double gridSpacing,
      double width,
      double height,
      BackgroundStyle backgroundStyle});
}

/// @nodoc
class __$$CanvasVisualConfigImplCopyWithImpl<$Res>
    extends _$CanvasVisualConfigCopyWithImpl<$Res, _$CanvasVisualConfigImpl>
    implements _$$CanvasVisualConfigImplCopyWith<$Res> {
  __$$CanvasVisualConfigImplCopyWithImpl(_$CanvasVisualConfigImpl _value,
      $Res Function(_$CanvasVisualConfigImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? backgroundColor = null,
    Object? showGrid = null,
    Object? gridColor = null,
    Object? gridSpacing = null,
    Object? width = null,
    Object? height = null,
    Object? backgroundStyle = null,
  }) {
    return _then(_$CanvasVisualConfigImpl(
      backgroundColor: null == backgroundColor
          ? _value.backgroundColor
          : backgroundColor // ignore: cast_nullable_to_non_nullable
              as Color,
      showGrid: null == showGrid
          ? _value.showGrid
          : showGrid // ignore: cast_nullable_to_non_nullable
              as bool,
      gridColor: null == gridColor
          ? _value.gridColor
          : gridColor // ignore: cast_nullable_to_non_nullable
              as Color,
      gridSpacing: null == gridSpacing
          ? _value.gridSpacing
          : gridSpacing // ignore: cast_nullable_to_non_nullable
              as double,
      width: null == width
          ? _value.width
          : width // ignore: cast_nullable_to_non_nullable
              as double,
      height: null == height
          ? _value.height
          : height // ignore: cast_nullable_to_non_nullable
              as double,
      backgroundStyle: null == backgroundStyle
          ? _value.backgroundStyle
          : backgroundStyle // ignore: cast_nullable_to_non_nullable
              as BackgroundStyle,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$CanvasVisualConfigImpl implements _CanvasVisualConfig {
  const _$CanvasVisualConfigImpl(
      {@ColorConverter() this.backgroundColor = Colors.white,
      this.showGrid = false,
      @ColorConverter() this.gridColor = const Color(0xffe0e0e0),
      this.gridSpacing = 20.0,
      this.width = 1000000.0,
      this.height = 1000000.0,
      this.backgroundStyle = BackgroundStyle.dots});

  factory _$CanvasVisualConfigImpl.fromJson(Map<String, dynamic> json) =>
      _$$CanvasVisualConfigImplFromJson(json);

  @override
  @JsonKey()
  @ColorConverter()
  final Color backgroundColor;
  @override
  @JsonKey()
  final bool showGrid;
  @override
  @JsonKey()
  @ColorConverter()
  final Color gridColor;
  @override
  @JsonKey()
  final double gridSpacing;
  @override
  @JsonKey()
  final double width;
  @override
  @JsonKey()
  final double height;
  @override
  @JsonKey()
  final BackgroundStyle backgroundStyle;

  @override
  String toString() {
    return 'CanvasVisualConfig(backgroundColor: $backgroundColor, showGrid: $showGrid, gridColor: $gridColor, gridSpacing: $gridSpacing, width: $width, height: $height, backgroundStyle: $backgroundStyle)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CanvasVisualConfigImpl &&
            (identical(other.backgroundColor, backgroundColor) ||
                other.backgroundColor == backgroundColor) &&
            (identical(other.showGrid, showGrid) ||
                other.showGrid == showGrid) &&
            (identical(other.gridColor, gridColor) ||
                other.gridColor == gridColor) &&
            (identical(other.gridSpacing, gridSpacing) ||
                other.gridSpacing == gridSpacing) &&
            (identical(other.width, width) || other.width == width) &&
            (identical(other.height, height) || other.height == height) &&
            (identical(other.backgroundStyle, backgroundStyle) ||
                other.backgroundStyle == backgroundStyle));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, backgroundColor, showGrid,
      gridColor, gridSpacing, width, height, backgroundStyle);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$CanvasVisualConfigImplCopyWith<_$CanvasVisualConfigImpl> get copyWith =>
      __$$CanvasVisualConfigImplCopyWithImpl<_$CanvasVisualConfigImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CanvasVisualConfigImplToJson(
      this,
    );
  }
}

abstract class _CanvasVisualConfig implements CanvasVisualConfig {
  const factory _CanvasVisualConfig(
      {@ColorConverter() final Color backgroundColor,
      final bool showGrid,
      @ColorConverter() final Color gridColor,
      final double gridSpacing,
      final double width,
      final double height,
      final BackgroundStyle backgroundStyle}) = _$CanvasVisualConfigImpl;

  factory _CanvasVisualConfig.fromJson(Map<String, dynamic> json) =
      _$CanvasVisualConfigImpl.fromJson;

  @override
  @ColorConverter()
  Color get backgroundColor;
  @override
  bool get showGrid;
  @override
  @ColorConverter()
  Color get gridColor;
  @override
  double get gridSpacing;
  @override
  double get width;
  @override
  double get height;
  @override
  BackgroundStyle get backgroundStyle;
  @override
  @JsonKey(ignore: true)
  _$$CanvasVisualConfigImplCopyWith<_$CanvasVisualConfigImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
