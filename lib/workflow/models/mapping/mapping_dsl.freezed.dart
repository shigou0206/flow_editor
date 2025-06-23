// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'mapping_dsl.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

MappingDSL _$MappingDSLFromJson(Map<String, dynamic> json) {
  return _MappingDSL.fromJson(json);
}

/// @nodoc
mixin _$MappingDSL {
  String? get namespace => throw _privateConstructorUsedError;
  String? get version => throw _privateConstructorUsedError;
  String? get description => throw _privateConstructorUsedError;
  PreserveFields get preserve => throw _privateConstructorUsedError;
  bool get debug => throw _privateConstructorUsedError;
  List<MappingRule> get mappings => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $MappingDSLCopyWith<MappingDSL> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MappingDSLCopyWith<$Res> {
  factory $MappingDSLCopyWith(
          MappingDSL value, $Res Function(MappingDSL) then) =
      _$MappingDSLCopyWithImpl<$Res, MappingDSL>;
  @useResult
  $Res call(
      {String? namespace,
      String? version,
      String? description,
      PreserveFields preserve,
      bool debug,
      List<MappingRule> mappings});

  $PreserveFieldsCopyWith<$Res> get preserve;
}

/// @nodoc
class _$MappingDSLCopyWithImpl<$Res, $Val extends MappingDSL>
    implements $MappingDSLCopyWith<$Res> {
  _$MappingDSLCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? namespace = freezed,
    Object? version = freezed,
    Object? description = freezed,
    Object? preserve = null,
    Object? debug = null,
    Object? mappings = null,
  }) {
    return _then(_value.copyWith(
      namespace: freezed == namespace
          ? _value.namespace
          : namespace // ignore: cast_nullable_to_non_nullable
              as String?,
      version: freezed == version
          ? _value.version
          : version // ignore: cast_nullable_to_non_nullable
              as String?,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      preserve: null == preserve
          ? _value.preserve
          : preserve // ignore: cast_nullable_to_non_nullable
              as PreserveFields,
      debug: null == debug
          ? _value.debug
          : debug // ignore: cast_nullable_to_non_nullable
              as bool,
      mappings: null == mappings
          ? _value.mappings
          : mappings // ignore: cast_nullable_to_non_nullable
              as List<MappingRule>,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $PreserveFieldsCopyWith<$Res> get preserve {
    return $PreserveFieldsCopyWith<$Res>(_value.preserve, (value) {
      return _then(_value.copyWith(preserve: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$MappingDSLImplCopyWith<$Res>
    implements $MappingDSLCopyWith<$Res> {
  factory _$$MappingDSLImplCopyWith(
          _$MappingDSLImpl value, $Res Function(_$MappingDSLImpl) then) =
      __$$MappingDSLImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? namespace,
      String? version,
      String? description,
      PreserveFields preserve,
      bool debug,
      List<MappingRule> mappings});

  @override
  $PreserveFieldsCopyWith<$Res> get preserve;
}

/// @nodoc
class __$$MappingDSLImplCopyWithImpl<$Res>
    extends _$MappingDSLCopyWithImpl<$Res, _$MappingDSLImpl>
    implements _$$MappingDSLImplCopyWith<$Res> {
  __$$MappingDSLImplCopyWithImpl(
      _$MappingDSLImpl _value, $Res Function(_$MappingDSLImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? namespace = freezed,
    Object? version = freezed,
    Object? description = freezed,
    Object? preserve = null,
    Object? debug = null,
    Object? mappings = null,
  }) {
    return _then(_$MappingDSLImpl(
      namespace: freezed == namespace
          ? _value.namespace
          : namespace // ignore: cast_nullable_to_non_nullable
              as String?,
      version: freezed == version
          ? _value.version
          : version // ignore: cast_nullable_to_non_nullable
              as String?,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      preserve: null == preserve
          ? _value.preserve
          : preserve // ignore: cast_nullable_to_non_nullable
              as PreserveFields,
      debug: null == debug
          ? _value.debug
          : debug // ignore: cast_nullable_to_non_nullable
              as bool,
      mappings: null == mappings
          ? _value._mappings
          : mappings // ignore: cast_nullable_to_non_nullable
              as List<MappingRule>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$MappingDSLImpl implements _MappingDSL {
  const _$MappingDSLImpl(
      {this.namespace,
      this.version,
      this.description,
      this.preserve = const PreserveFields.none(),
      this.debug = false,
      required final List<MappingRule> mappings})
      : _mappings = mappings;

  factory _$MappingDSLImpl.fromJson(Map<String, dynamic> json) =>
      _$$MappingDSLImplFromJson(json);

  @override
  final String? namespace;
  @override
  final String? version;
  @override
  final String? description;
  @override
  @JsonKey()
  final PreserveFields preserve;
  @override
  @JsonKey()
  final bool debug;
  final List<MappingRule> _mappings;
  @override
  List<MappingRule> get mappings {
    if (_mappings is EqualUnmodifiableListView) return _mappings;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_mappings);
  }

  @override
  String toString() {
    return 'MappingDSL(namespace: $namespace, version: $version, description: $description, preserve: $preserve, debug: $debug, mappings: $mappings)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MappingDSLImpl &&
            (identical(other.namespace, namespace) ||
                other.namespace == namespace) &&
            (identical(other.version, version) || other.version == version) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.preserve, preserve) ||
                other.preserve == preserve) &&
            (identical(other.debug, debug) || other.debug == debug) &&
            const DeepCollectionEquality().equals(other._mappings, _mappings));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, namespace, version, description,
      preserve, debug, const DeepCollectionEquality().hash(_mappings));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$MappingDSLImplCopyWith<_$MappingDSLImpl> get copyWith =>
      __$$MappingDSLImplCopyWithImpl<_$MappingDSLImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$MappingDSLImplToJson(
      this,
    );
  }
}

abstract class _MappingDSL implements MappingDSL {
  const factory _MappingDSL(
      {final String? namespace,
      final String? version,
      final String? description,
      final PreserveFields preserve,
      final bool debug,
      required final List<MappingRule> mappings}) = _$MappingDSLImpl;

  factory _MappingDSL.fromJson(Map<String, dynamic> json) =
      _$MappingDSLImpl.fromJson;

  @override
  String? get namespace;
  @override
  String? get version;
  @override
  String? get description;
  @override
  PreserveFields get preserve;
  @override
  bool get debug;
  @override
  List<MappingRule> get mappings;
  @override
  @JsonKey(ignore: true)
  _$$MappingDSLImplCopyWith<_$MappingDSLImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
