// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'choice_logic.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

ChoiceLogic _$ChoiceLogicFromJson(Map<String, dynamic> json) {
  return _ChoiceLogic.fromJson(json);
}

/// @nodoc
mixin _$ChoiceLogic {
// ignore: invalid_annotation_target
  @JsonKey(
      name: 'And',
      toJson: _choiceLogicListToJson,
      fromJson: _choiceLogicListFromJson)
  List<ChoiceLogic>? get and =>
      throw _privateConstructorUsedError; // ignore: invalid_annotation_target
  @JsonKey(
      name: 'Or',
      toJson: _choiceLogicListToJson,
      fromJson: _choiceLogicListFromJson)
  List<ChoiceLogic>? get or =>
      throw _privateConstructorUsedError; // ignore: invalid_annotation_target
  @JsonKey(
      name: 'Not', toJson: _choiceLogicToJson, fromJson: _choiceLogicFromJson)
  ChoiceLogic? get not => throw _privateConstructorUsedError;
  String? get variable => throw _privateConstructorUsedError;
  String? get operator => throw _privateConstructorUsedError;
  dynamic get value => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ChoiceLogicCopyWith<ChoiceLogic> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ChoiceLogicCopyWith<$Res> {
  factory $ChoiceLogicCopyWith(
          ChoiceLogic value, $Res Function(ChoiceLogic) then) =
      _$ChoiceLogicCopyWithImpl<$Res, ChoiceLogic>;
  @useResult
  $Res call(
      {@JsonKey(
          name: 'And',
          toJson: _choiceLogicListToJson,
          fromJson: _choiceLogicListFromJson)
      List<ChoiceLogic>? and,
      @JsonKey(
          name: 'Or',
          toJson: _choiceLogicListToJson,
          fromJson: _choiceLogicListFromJson)
      List<ChoiceLogic>? or,
      @JsonKey(
          name: 'Not',
          toJson: _choiceLogicToJson,
          fromJson: _choiceLogicFromJson)
      ChoiceLogic? not,
      String? variable,
      String? operator,
      dynamic value});

  $ChoiceLogicCopyWith<$Res>? get not;
}

/// @nodoc
class _$ChoiceLogicCopyWithImpl<$Res, $Val extends ChoiceLogic>
    implements $ChoiceLogicCopyWith<$Res> {
  _$ChoiceLogicCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? and = freezed,
    Object? or = freezed,
    Object? not = freezed,
    Object? variable = freezed,
    Object? operator = freezed,
    Object? value = freezed,
  }) {
    return _then(_value.copyWith(
      and: freezed == and
          ? _value.and
          : and // ignore: cast_nullable_to_non_nullable
              as List<ChoiceLogic>?,
      or: freezed == or
          ? _value.or
          : or // ignore: cast_nullable_to_non_nullable
              as List<ChoiceLogic>?,
      not: freezed == not
          ? _value.not
          : not // ignore: cast_nullable_to_non_nullable
              as ChoiceLogic?,
      variable: freezed == variable
          ? _value.variable
          : variable // ignore: cast_nullable_to_non_nullable
              as String?,
      operator: freezed == operator
          ? _value.operator
          : operator // ignore: cast_nullable_to_non_nullable
              as String?,
      value: freezed == value
          ? _value.value
          : value // ignore: cast_nullable_to_non_nullable
              as dynamic,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $ChoiceLogicCopyWith<$Res>? get not {
    if (_value.not == null) {
      return null;
    }

    return $ChoiceLogicCopyWith<$Res>(_value.not!, (value) {
      return _then(_value.copyWith(not: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$ChoiceLogicImplCopyWith<$Res>
    implements $ChoiceLogicCopyWith<$Res> {
  factory _$$ChoiceLogicImplCopyWith(
          _$ChoiceLogicImpl value, $Res Function(_$ChoiceLogicImpl) then) =
      __$$ChoiceLogicImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(
          name: 'And',
          toJson: _choiceLogicListToJson,
          fromJson: _choiceLogicListFromJson)
      List<ChoiceLogic>? and,
      @JsonKey(
          name: 'Or',
          toJson: _choiceLogicListToJson,
          fromJson: _choiceLogicListFromJson)
      List<ChoiceLogic>? or,
      @JsonKey(
          name: 'Not',
          toJson: _choiceLogicToJson,
          fromJson: _choiceLogicFromJson)
      ChoiceLogic? not,
      String? variable,
      String? operator,
      dynamic value});

  @override
  $ChoiceLogicCopyWith<$Res>? get not;
}

/// @nodoc
class __$$ChoiceLogicImplCopyWithImpl<$Res>
    extends _$ChoiceLogicCopyWithImpl<$Res, _$ChoiceLogicImpl>
    implements _$$ChoiceLogicImplCopyWith<$Res> {
  __$$ChoiceLogicImplCopyWithImpl(
      _$ChoiceLogicImpl _value, $Res Function(_$ChoiceLogicImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? and = freezed,
    Object? or = freezed,
    Object? not = freezed,
    Object? variable = freezed,
    Object? operator = freezed,
    Object? value = freezed,
  }) {
    return _then(_$ChoiceLogicImpl(
      and: freezed == and
          ? _value._and
          : and // ignore: cast_nullable_to_non_nullable
              as List<ChoiceLogic>?,
      or: freezed == or
          ? _value._or
          : or // ignore: cast_nullable_to_non_nullable
              as List<ChoiceLogic>?,
      not: freezed == not
          ? _value.not
          : not // ignore: cast_nullable_to_non_nullable
              as ChoiceLogic?,
      variable: freezed == variable
          ? _value.variable
          : variable // ignore: cast_nullable_to_non_nullable
              as String?,
      operator: freezed == operator
          ? _value.operator
          : operator // ignore: cast_nullable_to_non_nullable
              as String?,
      value: freezed == value
          ? _value.value
          : value // ignore: cast_nullable_to_non_nullable
              as dynamic,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ChoiceLogicImpl extends _ChoiceLogic {
  const _$ChoiceLogicImpl(
      {@JsonKey(
          name: 'And',
          toJson: _choiceLogicListToJson,
          fromJson: _choiceLogicListFromJson)
      final List<ChoiceLogic>? and,
      @JsonKey(
          name: 'Or',
          toJson: _choiceLogicListToJson,
          fromJson: _choiceLogicListFromJson)
      final List<ChoiceLogic>? or,
      @JsonKey(
          name: 'Not',
          toJson: _choiceLogicToJson,
          fromJson: _choiceLogicFromJson)
      this.not,
      this.variable,
      this.operator,
      this.value})
      : _and = and,
        _or = or,
        super._();

  factory _$ChoiceLogicImpl.fromJson(Map<String, dynamic> json) =>
      _$$ChoiceLogicImplFromJson(json);

// ignore: invalid_annotation_target
  final List<ChoiceLogic>? _and;
// ignore: invalid_annotation_target
  @override
  @JsonKey(
      name: 'And',
      toJson: _choiceLogicListToJson,
      fromJson: _choiceLogicListFromJson)
  List<ChoiceLogic>? get and {
    final value = _and;
    if (value == null) return null;
    if (_and is EqualUnmodifiableListView) return _and;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

// ignore: invalid_annotation_target
  final List<ChoiceLogic>? _or;
// ignore: invalid_annotation_target
  @override
  @JsonKey(
      name: 'Or',
      toJson: _choiceLogicListToJson,
      fromJson: _choiceLogicListFromJson)
  List<ChoiceLogic>? get or {
    final value = _or;
    if (value == null) return null;
    if (_or is EqualUnmodifiableListView) return _or;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

// ignore: invalid_annotation_target
  @override
  @JsonKey(
      name: 'Not', toJson: _choiceLogicToJson, fromJson: _choiceLogicFromJson)
  final ChoiceLogic? not;
  @override
  final String? variable;
  @override
  final String? operator;
  @override
  final dynamic value;

  @override
  String toString() {
    return 'ChoiceLogic(and: $and, or: $or, not: $not, variable: $variable, operator: $operator, value: $value)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ChoiceLogicImpl &&
            const DeepCollectionEquality().equals(other._and, _and) &&
            const DeepCollectionEquality().equals(other._or, _or) &&
            (identical(other.not, not) || other.not == not) &&
            (identical(other.variable, variable) ||
                other.variable == variable) &&
            (identical(other.operator, operator) ||
                other.operator == operator) &&
            const DeepCollectionEquality().equals(other.value, value));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_and),
      const DeepCollectionEquality().hash(_or),
      not,
      variable,
      operator,
      const DeepCollectionEquality().hash(value));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ChoiceLogicImplCopyWith<_$ChoiceLogicImpl> get copyWith =>
      __$$ChoiceLogicImplCopyWithImpl<_$ChoiceLogicImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ChoiceLogicImplToJson(
      this,
    );
  }
}

abstract class _ChoiceLogic extends ChoiceLogic {
  const factory _ChoiceLogic(
      {@JsonKey(
          name: 'And',
          toJson: _choiceLogicListToJson,
          fromJson: _choiceLogicListFromJson)
      final List<ChoiceLogic>? and,
      @JsonKey(
          name: 'Or',
          toJson: _choiceLogicListToJson,
          fromJson: _choiceLogicListFromJson)
      final List<ChoiceLogic>? or,
      @JsonKey(
          name: 'Not',
          toJson: _choiceLogicToJson,
          fromJson: _choiceLogicFromJson)
      final ChoiceLogic? not,
      final String? variable,
      final String? operator,
      final dynamic value}) = _$ChoiceLogicImpl;
  const _ChoiceLogic._() : super._();

  factory _ChoiceLogic.fromJson(Map<String, dynamic> json) =
      _$ChoiceLogicImpl.fromJson;

  @override // ignore: invalid_annotation_target
  @JsonKey(
      name: 'And',
      toJson: _choiceLogicListToJson,
      fromJson: _choiceLogicListFromJson)
  List<ChoiceLogic>? get and;
  @override // ignore: invalid_annotation_target
  @JsonKey(
      name: 'Or',
      toJson: _choiceLogicListToJson,
      fromJson: _choiceLogicListFromJson)
  List<ChoiceLogic>? get or;
  @override // ignore: invalid_annotation_target
  @JsonKey(
      name: 'Not', toJson: _choiceLogicToJson, fromJson: _choiceLogicFromJson)
  ChoiceLogic? get not;
  @override
  String? get variable;
  @override
  String? get operator;
  @override
  dynamic get value;
  @override
  @JsonKey(ignore: true)
  _$$ChoiceLogicImplCopyWith<_$ChoiceLogicImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
