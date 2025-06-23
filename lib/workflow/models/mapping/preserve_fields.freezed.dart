// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'preserve_fields.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

PreserveFields _$PreserveFieldsFromJson(Map<String, dynamic> json) {
  switch (json['runtimeType']) {
    case 'all':
      return AllPreserveFields.fromJson(json);
    case 'none':
      return NonePreserveFields.fromJson(json);
    case 'some':
      return SomePreserveFields.fromJson(json);

    default:
      throw CheckedFromJsonException(json, 'runtimeType', 'PreserveFields',
          'Invalid union type "${json['runtimeType']}"!');
  }
}

/// @nodoc
mixin _$PreserveFields {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() all,
    required TResult Function() none,
    required TResult Function(List<String> fields) some,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? all,
    TResult? Function()? none,
    TResult? Function(List<String> fields)? some,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? all,
    TResult Function()? none,
    TResult Function(List<String> fields)? some,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(AllPreserveFields value) all,
    required TResult Function(NonePreserveFields value) none,
    required TResult Function(SomePreserveFields value) some,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(AllPreserveFields value)? all,
    TResult? Function(NonePreserveFields value)? none,
    TResult? Function(SomePreserveFields value)? some,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(AllPreserveFields value)? all,
    TResult Function(NonePreserveFields value)? none,
    TResult Function(SomePreserveFields value)? some,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PreserveFieldsCopyWith<$Res> {
  factory $PreserveFieldsCopyWith(
          PreserveFields value, $Res Function(PreserveFields) then) =
      _$PreserveFieldsCopyWithImpl<$Res, PreserveFields>;
}

/// @nodoc
class _$PreserveFieldsCopyWithImpl<$Res, $Val extends PreserveFields>
    implements $PreserveFieldsCopyWith<$Res> {
  _$PreserveFieldsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;
}

/// @nodoc
abstract class _$$AllPreserveFieldsImplCopyWith<$Res> {
  factory _$$AllPreserveFieldsImplCopyWith(_$AllPreserveFieldsImpl value,
          $Res Function(_$AllPreserveFieldsImpl) then) =
      __$$AllPreserveFieldsImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$AllPreserveFieldsImplCopyWithImpl<$Res>
    extends _$PreserveFieldsCopyWithImpl<$Res, _$AllPreserveFieldsImpl>
    implements _$$AllPreserveFieldsImplCopyWith<$Res> {
  __$$AllPreserveFieldsImplCopyWithImpl(_$AllPreserveFieldsImpl _value,
      $Res Function(_$AllPreserveFieldsImpl) _then)
      : super(_value, _then);
}

/// @nodoc
@JsonSerializable()
class _$AllPreserveFieldsImpl implements AllPreserveFields {
  const _$AllPreserveFieldsImpl({final String? $type}) : $type = $type ?? 'all';

  factory _$AllPreserveFieldsImpl.fromJson(Map<String, dynamic> json) =>
      _$$AllPreserveFieldsImplFromJson(json);

  @JsonKey(name: 'runtimeType')
  final String $type;

  @override
  String toString() {
    return 'PreserveFields.all()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$AllPreserveFieldsImpl);
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() all,
    required TResult Function() none,
    required TResult Function(List<String> fields) some,
  }) {
    return all();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? all,
    TResult? Function()? none,
    TResult? Function(List<String> fields)? some,
  }) {
    return all?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? all,
    TResult Function()? none,
    TResult Function(List<String> fields)? some,
    required TResult orElse(),
  }) {
    if (all != null) {
      return all();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(AllPreserveFields value) all,
    required TResult Function(NonePreserveFields value) none,
    required TResult Function(SomePreserveFields value) some,
  }) {
    return all(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(AllPreserveFields value)? all,
    TResult? Function(NonePreserveFields value)? none,
    TResult? Function(SomePreserveFields value)? some,
  }) {
    return all?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(AllPreserveFields value)? all,
    TResult Function(NonePreserveFields value)? none,
    TResult Function(SomePreserveFields value)? some,
    required TResult orElse(),
  }) {
    if (all != null) {
      return all(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$AllPreserveFieldsImplToJson(
      this,
    );
  }
}

abstract class AllPreserveFields implements PreserveFields {
  const factory AllPreserveFields() = _$AllPreserveFieldsImpl;

  factory AllPreserveFields.fromJson(Map<String, dynamic> json) =
      _$AllPreserveFieldsImpl.fromJson;
}

/// @nodoc
abstract class _$$NonePreserveFieldsImplCopyWith<$Res> {
  factory _$$NonePreserveFieldsImplCopyWith(_$NonePreserveFieldsImpl value,
          $Res Function(_$NonePreserveFieldsImpl) then) =
      __$$NonePreserveFieldsImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$NonePreserveFieldsImplCopyWithImpl<$Res>
    extends _$PreserveFieldsCopyWithImpl<$Res, _$NonePreserveFieldsImpl>
    implements _$$NonePreserveFieldsImplCopyWith<$Res> {
  __$$NonePreserveFieldsImplCopyWithImpl(_$NonePreserveFieldsImpl _value,
      $Res Function(_$NonePreserveFieldsImpl) _then)
      : super(_value, _then);
}

/// @nodoc
@JsonSerializable()
class _$NonePreserveFieldsImpl implements NonePreserveFields {
  const _$NonePreserveFieldsImpl({final String? $type})
      : $type = $type ?? 'none';

  factory _$NonePreserveFieldsImpl.fromJson(Map<String, dynamic> json) =>
      _$$NonePreserveFieldsImplFromJson(json);

  @JsonKey(name: 'runtimeType')
  final String $type;

  @override
  String toString() {
    return 'PreserveFields.none()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$NonePreserveFieldsImpl);
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() all,
    required TResult Function() none,
    required TResult Function(List<String> fields) some,
  }) {
    return none();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? all,
    TResult? Function()? none,
    TResult? Function(List<String> fields)? some,
  }) {
    return none?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? all,
    TResult Function()? none,
    TResult Function(List<String> fields)? some,
    required TResult orElse(),
  }) {
    if (none != null) {
      return none();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(AllPreserveFields value) all,
    required TResult Function(NonePreserveFields value) none,
    required TResult Function(SomePreserveFields value) some,
  }) {
    return none(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(AllPreserveFields value)? all,
    TResult? Function(NonePreserveFields value)? none,
    TResult? Function(SomePreserveFields value)? some,
  }) {
    return none?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(AllPreserveFields value)? all,
    TResult Function(NonePreserveFields value)? none,
    TResult Function(SomePreserveFields value)? some,
    required TResult orElse(),
  }) {
    if (none != null) {
      return none(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$NonePreserveFieldsImplToJson(
      this,
    );
  }
}

abstract class NonePreserveFields implements PreserveFields {
  const factory NonePreserveFields() = _$NonePreserveFieldsImpl;

  factory NonePreserveFields.fromJson(Map<String, dynamic> json) =
      _$NonePreserveFieldsImpl.fromJson;
}

/// @nodoc
abstract class _$$SomePreserveFieldsImplCopyWith<$Res> {
  factory _$$SomePreserveFieldsImplCopyWith(_$SomePreserveFieldsImpl value,
          $Res Function(_$SomePreserveFieldsImpl) then) =
      __$$SomePreserveFieldsImplCopyWithImpl<$Res>;
  @useResult
  $Res call({List<String> fields});
}

/// @nodoc
class __$$SomePreserveFieldsImplCopyWithImpl<$Res>
    extends _$PreserveFieldsCopyWithImpl<$Res, _$SomePreserveFieldsImpl>
    implements _$$SomePreserveFieldsImplCopyWith<$Res> {
  __$$SomePreserveFieldsImplCopyWithImpl(_$SomePreserveFieldsImpl _value,
      $Res Function(_$SomePreserveFieldsImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? fields = null,
  }) {
    return _then(_$SomePreserveFieldsImpl(
      null == fields
          ? _value._fields
          : fields // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$SomePreserveFieldsImpl implements SomePreserveFields {
  const _$SomePreserveFieldsImpl(final List<String> fields,
      {final String? $type})
      : _fields = fields,
        $type = $type ?? 'some';

  factory _$SomePreserveFieldsImpl.fromJson(Map<String, dynamic> json) =>
      _$$SomePreserveFieldsImplFromJson(json);

  final List<String> _fields;
  @override
  List<String> get fields {
    if (_fields is EqualUnmodifiableListView) return _fields;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_fields);
  }

  @JsonKey(name: 'runtimeType')
  final String $type;

  @override
  String toString() {
    return 'PreserveFields.some(fields: $fields)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SomePreserveFieldsImpl &&
            const DeepCollectionEquality().equals(other._fields, _fields));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_fields));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$SomePreserveFieldsImplCopyWith<_$SomePreserveFieldsImpl> get copyWith =>
      __$$SomePreserveFieldsImplCopyWithImpl<_$SomePreserveFieldsImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() all,
    required TResult Function() none,
    required TResult Function(List<String> fields) some,
  }) {
    return some(fields);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? all,
    TResult? Function()? none,
    TResult? Function(List<String> fields)? some,
  }) {
    return some?.call(fields);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? all,
    TResult Function()? none,
    TResult Function(List<String> fields)? some,
    required TResult orElse(),
  }) {
    if (some != null) {
      return some(fields);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(AllPreserveFields value) all,
    required TResult Function(NonePreserveFields value) none,
    required TResult Function(SomePreserveFields value) some,
  }) {
    return some(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(AllPreserveFields value)? all,
    TResult? Function(NonePreserveFields value)? none,
    TResult? Function(SomePreserveFields value)? some,
  }) {
    return some?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(AllPreserveFields value)? all,
    TResult Function(NonePreserveFields value)? none,
    TResult Function(SomePreserveFields value)? some,
    required TResult orElse(),
  }) {
    if (some != null) {
      return some(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$SomePreserveFieldsImplToJson(
      this,
    );
  }
}

abstract class SomePreserveFields implements PreserveFields {
  const factory SomePreserveFields(final List<String> fields) =
      _$SomePreserveFieldsImpl;

  factory SomePreserveFields.fromJson(Map<String, dynamic> json) =
      _$SomePreserveFieldsImpl.fromJson;

  List<String> get fields;
  @JsonKey(ignore: true)
  _$$SomePreserveFieldsImplCopyWith<_$SomePreserveFieldsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
