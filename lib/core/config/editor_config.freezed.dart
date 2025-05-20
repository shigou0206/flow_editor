// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'editor_config.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

EditorConfig _$EditorConfigFromJson(Map<String, dynamic> json) {
  return _EditorConfig.fromJson(json);
}

/// @nodoc
mixin _$EditorConfig {
  HitTestTolerance get hitTestTolerance => throw _privateConstructorUsedError;
  bool get enableMultiSelect => throw _privateConstructorUsedError;
  bool get enableGroupNode => throw _privateConstructorUsedError;
  bool get enableUndoRedo => throw _privateConstructorUsedError;
  bool get enableClipboard => throw _privateConstructorUsedError;
  bool get enableKeyboardShortcuts => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $EditorConfigCopyWith<EditorConfig> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $EditorConfigCopyWith<$Res> {
  factory $EditorConfigCopyWith(
          EditorConfig value, $Res Function(EditorConfig) then) =
      _$EditorConfigCopyWithImpl<$Res, EditorConfig>;
  @useResult
  $Res call(
      {HitTestTolerance hitTestTolerance,
      bool enableMultiSelect,
      bool enableGroupNode,
      bool enableUndoRedo,
      bool enableClipboard,
      bool enableKeyboardShortcuts});

  $HitTestToleranceCopyWith<$Res> get hitTestTolerance;
}

/// @nodoc
class _$EditorConfigCopyWithImpl<$Res, $Val extends EditorConfig>
    implements $EditorConfigCopyWith<$Res> {
  _$EditorConfigCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? hitTestTolerance = null,
    Object? enableMultiSelect = null,
    Object? enableGroupNode = null,
    Object? enableUndoRedo = null,
    Object? enableClipboard = null,
    Object? enableKeyboardShortcuts = null,
  }) {
    return _then(_value.copyWith(
      hitTestTolerance: null == hitTestTolerance
          ? _value.hitTestTolerance
          : hitTestTolerance // ignore: cast_nullable_to_non_nullable
              as HitTestTolerance,
      enableMultiSelect: null == enableMultiSelect
          ? _value.enableMultiSelect
          : enableMultiSelect // ignore: cast_nullable_to_non_nullable
              as bool,
      enableGroupNode: null == enableGroupNode
          ? _value.enableGroupNode
          : enableGroupNode // ignore: cast_nullable_to_non_nullable
              as bool,
      enableUndoRedo: null == enableUndoRedo
          ? _value.enableUndoRedo
          : enableUndoRedo // ignore: cast_nullable_to_non_nullable
              as bool,
      enableClipboard: null == enableClipboard
          ? _value.enableClipboard
          : enableClipboard // ignore: cast_nullable_to_non_nullable
              as bool,
      enableKeyboardShortcuts: null == enableKeyboardShortcuts
          ? _value.enableKeyboardShortcuts
          : enableKeyboardShortcuts // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $HitTestToleranceCopyWith<$Res> get hitTestTolerance {
    return $HitTestToleranceCopyWith<$Res>(_value.hitTestTolerance, (value) {
      return _then(_value.copyWith(hitTestTolerance: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$EditorConfigImplCopyWith<$Res>
    implements $EditorConfigCopyWith<$Res> {
  factory _$$EditorConfigImplCopyWith(
          _$EditorConfigImpl value, $Res Function(_$EditorConfigImpl) then) =
      __$$EditorConfigImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {HitTestTolerance hitTestTolerance,
      bool enableMultiSelect,
      bool enableGroupNode,
      bool enableUndoRedo,
      bool enableClipboard,
      bool enableKeyboardShortcuts});

  @override
  $HitTestToleranceCopyWith<$Res> get hitTestTolerance;
}

/// @nodoc
class __$$EditorConfigImplCopyWithImpl<$Res>
    extends _$EditorConfigCopyWithImpl<$Res, _$EditorConfigImpl>
    implements _$$EditorConfigImplCopyWith<$Res> {
  __$$EditorConfigImplCopyWithImpl(
      _$EditorConfigImpl _value, $Res Function(_$EditorConfigImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? hitTestTolerance = null,
    Object? enableMultiSelect = null,
    Object? enableGroupNode = null,
    Object? enableUndoRedo = null,
    Object? enableClipboard = null,
    Object? enableKeyboardShortcuts = null,
  }) {
    return _then(_$EditorConfigImpl(
      hitTestTolerance: null == hitTestTolerance
          ? _value.hitTestTolerance
          : hitTestTolerance // ignore: cast_nullable_to_non_nullable
              as HitTestTolerance,
      enableMultiSelect: null == enableMultiSelect
          ? _value.enableMultiSelect
          : enableMultiSelect // ignore: cast_nullable_to_non_nullable
              as bool,
      enableGroupNode: null == enableGroupNode
          ? _value.enableGroupNode
          : enableGroupNode // ignore: cast_nullable_to_non_nullable
              as bool,
      enableUndoRedo: null == enableUndoRedo
          ? _value.enableUndoRedo
          : enableUndoRedo // ignore: cast_nullable_to_non_nullable
              as bool,
      enableClipboard: null == enableClipboard
          ? _value.enableClipboard
          : enableClipboard // ignore: cast_nullable_to_non_nullable
              as bool,
      enableKeyboardShortcuts: null == enableKeyboardShortcuts
          ? _value.enableKeyboardShortcuts
          : enableKeyboardShortcuts // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$EditorConfigImpl implements _EditorConfig {
  const _$EditorConfigImpl(
      {this.hitTestTolerance = const HitTestTolerance(),
      this.enableMultiSelect = true,
      this.enableGroupNode = true,
      this.enableUndoRedo = true,
      this.enableClipboard = true,
      this.enableKeyboardShortcuts = true});

  factory _$EditorConfigImpl.fromJson(Map<String, dynamic> json) =>
      _$$EditorConfigImplFromJson(json);

  @override
  @JsonKey()
  final HitTestTolerance hitTestTolerance;
  @override
  @JsonKey()
  final bool enableMultiSelect;
  @override
  @JsonKey()
  final bool enableGroupNode;
  @override
  @JsonKey()
  final bool enableUndoRedo;
  @override
  @JsonKey()
  final bool enableClipboard;
  @override
  @JsonKey()
  final bool enableKeyboardShortcuts;

  @override
  String toString() {
    return 'EditorConfig(hitTestTolerance: $hitTestTolerance, enableMultiSelect: $enableMultiSelect, enableGroupNode: $enableGroupNode, enableUndoRedo: $enableUndoRedo, enableClipboard: $enableClipboard, enableKeyboardShortcuts: $enableKeyboardShortcuts)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$EditorConfigImpl &&
            (identical(other.hitTestTolerance, hitTestTolerance) ||
                other.hitTestTolerance == hitTestTolerance) &&
            (identical(other.enableMultiSelect, enableMultiSelect) ||
                other.enableMultiSelect == enableMultiSelect) &&
            (identical(other.enableGroupNode, enableGroupNode) ||
                other.enableGroupNode == enableGroupNode) &&
            (identical(other.enableUndoRedo, enableUndoRedo) ||
                other.enableUndoRedo == enableUndoRedo) &&
            (identical(other.enableClipboard, enableClipboard) ||
                other.enableClipboard == enableClipboard) &&
            (identical(
                    other.enableKeyboardShortcuts, enableKeyboardShortcuts) ||
                other.enableKeyboardShortcuts == enableKeyboardShortcuts));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      hitTestTolerance,
      enableMultiSelect,
      enableGroupNode,
      enableUndoRedo,
      enableClipboard,
      enableKeyboardShortcuts);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$EditorConfigImplCopyWith<_$EditorConfigImpl> get copyWith =>
      __$$EditorConfigImplCopyWithImpl<_$EditorConfigImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$EditorConfigImplToJson(
      this,
    );
  }
}

abstract class _EditorConfig implements EditorConfig {
  const factory _EditorConfig(
      {final HitTestTolerance hitTestTolerance,
      final bool enableMultiSelect,
      final bool enableGroupNode,
      final bool enableUndoRedo,
      final bool enableClipboard,
      final bool enableKeyboardShortcuts}) = _$EditorConfigImpl;

  factory _EditorConfig.fromJson(Map<String, dynamic> json) =
      _$EditorConfigImpl.fromJson;

  @override
  HitTestTolerance get hitTestTolerance;
  @override
  bool get enableMultiSelect;
  @override
  bool get enableGroupNode;
  @override
  bool get enableUndoRedo;
  @override
  bool get enableClipboard;
  @override
  bool get enableKeyboardShortcuts;
  @override
  @JsonKey(ignore: true)
  _$$EditorConfigImplCopyWith<_$EditorConfigImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
