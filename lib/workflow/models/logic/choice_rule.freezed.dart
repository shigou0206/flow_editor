// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'choice_rule.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

ChoiceRule _$ChoiceRuleFromJson(Map<String, dynamic> json) {
  return _ChoiceRule.fromJson(json);
}

/// @nodoc
mixin _$ChoiceRule {
  ChoiceLogic get condition => throw _privateConstructorUsedError;
  String get next => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ChoiceRuleCopyWith<ChoiceRule> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ChoiceRuleCopyWith<$Res> {
  factory $ChoiceRuleCopyWith(
          ChoiceRule value, $Res Function(ChoiceRule) then) =
      _$ChoiceRuleCopyWithImpl<$Res, ChoiceRule>;
  @useResult
  $Res call({ChoiceLogic condition, String next});

  $ChoiceLogicCopyWith<$Res> get condition;
}

/// @nodoc
class _$ChoiceRuleCopyWithImpl<$Res, $Val extends ChoiceRule>
    implements $ChoiceRuleCopyWith<$Res> {
  _$ChoiceRuleCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? condition = null,
    Object? next = null,
  }) {
    return _then(_value.copyWith(
      condition: null == condition
          ? _value.condition
          : condition // ignore: cast_nullable_to_non_nullable
              as ChoiceLogic,
      next: null == next
          ? _value.next
          : next // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $ChoiceLogicCopyWith<$Res> get condition {
    return $ChoiceLogicCopyWith<$Res>(_value.condition, (value) {
      return _then(_value.copyWith(condition: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$ChoiceRuleImplCopyWith<$Res>
    implements $ChoiceRuleCopyWith<$Res> {
  factory _$$ChoiceRuleImplCopyWith(
          _$ChoiceRuleImpl value, $Res Function(_$ChoiceRuleImpl) then) =
      __$$ChoiceRuleImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({ChoiceLogic condition, String next});

  @override
  $ChoiceLogicCopyWith<$Res> get condition;
}

/// @nodoc
class __$$ChoiceRuleImplCopyWithImpl<$Res>
    extends _$ChoiceRuleCopyWithImpl<$Res, _$ChoiceRuleImpl>
    implements _$$ChoiceRuleImplCopyWith<$Res> {
  __$$ChoiceRuleImplCopyWithImpl(
      _$ChoiceRuleImpl _value, $Res Function(_$ChoiceRuleImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? condition = null,
    Object? next = null,
  }) {
    return _then(_$ChoiceRuleImpl(
      condition: null == condition
          ? _value.condition
          : condition // ignore: cast_nullable_to_non_nullable
              as ChoiceLogic,
      next: null == next
          ? _value.next
          : next // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ChoiceRuleImpl implements _ChoiceRule {
  const _$ChoiceRuleImpl({required this.condition, required this.next});

  factory _$ChoiceRuleImpl.fromJson(Map<String, dynamic> json) =>
      _$$ChoiceRuleImplFromJson(json);

  @override
  final ChoiceLogic condition;
  @override
  final String next;

  @override
  String toString() {
    return 'ChoiceRule(condition: $condition, next: $next)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ChoiceRuleImpl &&
            (identical(other.condition, condition) ||
                other.condition == condition) &&
            (identical(other.next, next) || other.next == next));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, condition, next);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ChoiceRuleImplCopyWith<_$ChoiceRuleImpl> get copyWith =>
      __$$ChoiceRuleImplCopyWithImpl<_$ChoiceRuleImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ChoiceRuleImplToJson(
      this,
    );
  }
}

abstract class _ChoiceRule implements ChoiceRule {
  const factory _ChoiceRule(
      {required final ChoiceLogic condition,
      required final String next}) = _$ChoiceRuleImpl;

  factory _ChoiceRule.fromJson(Map<String, dynamic> json) =
      _$ChoiceRuleImpl.fromJson;

  @override
  ChoiceLogic get condition;
  @override
  String get next;
  @override
  @JsonKey(ignore: true)
  _$$ChoiceRuleImplCopyWith<_$ChoiceRuleImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
