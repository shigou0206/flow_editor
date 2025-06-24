// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'retry_policy.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

RetryPolicy _$RetryPolicyFromJson(Map<String, dynamic> json) {
  return _RetryPolicy.fromJson(json);
}

/// @nodoc
mixin _$RetryPolicy {
  List<String> get errorEquals =>
      throw _privateConstructorUsedError; // ignore: invalid_annotation_target
  @JsonKey(defaultValue: null)
  int? get intervalSeconds =>
      throw _privateConstructorUsedError; // ignore: invalid_annotation_target
  @JsonKey(defaultValue: null)
  double? get backoffRate =>
      throw _privateConstructorUsedError; // ignore: invalid_annotation_target
  @JsonKey(defaultValue: null)
  int? get maxAttempts => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $RetryPolicyCopyWith<RetryPolicy> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RetryPolicyCopyWith<$Res> {
  factory $RetryPolicyCopyWith(
          RetryPolicy value, $Res Function(RetryPolicy) then) =
      _$RetryPolicyCopyWithImpl<$Res, RetryPolicy>;
  @useResult
  $Res call(
      {List<String> errorEquals,
      @JsonKey(defaultValue: null) int? intervalSeconds,
      @JsonKey(defaultValue: null) double? backoffRate,
      @JsonKey(defaultValue: null) int? maxAttempts});
}

/// @nodoc
class _$RetryPolicyCopyWithImpl<$Res, $Val extends RetryPolicy>
    implements $RetryPolicyCopyWith<$Res> {
  _$RetryPolicyCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? errorEquals = null,
    Object? intervalSeconds = freezed,
    Object? backoffRate = freezed,
    Object? maxAttempts = freezed,
  }) {
    return _then(_value.copyWith(
      errorEquals: null == errorEquals
          ? _value.errorEquals
          : errorEquals // ignore: cast_nullable_to_non_nullable
              as List<String>,
      intervalSeconds: freezed == intervalSeconds
          ? _value.intervalSeconds
          : intervalSeconds // ignore: cast_nullable_to_non_nullable
              as int?,
      backoffRate: freezed == backoffRate
          ? _value.backoffRate
          : backoffRate // ignore: cast_nullable_to_non_nullable
              as double?,
      maxAttempts: freezed == maxAttempts
          ? _value.maxAttempts
          : maxAttempts // ignore: cast_nullable_to_non_nullable
              as int?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$RetryPolicyImplCopyWith<$Res>
    implements $RetryPolicyCopyWith<$Res> {
  factory _$$RetryPolicyImplCopyWith(
          _$RetryPolicyImpl value, $Res Function(_$RetryPolicyImpl) then) =
      __$$RetryPolicyImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {List<String> errorEquals,
      @JsonKey(defaultValue: null) int? intervalSeconds,
      @JsonKey(defaultValue: null) double? backoffRate,
      @JsonKey(defaultValue: null) int? maxAttempts});
}

/// @nodoc
class __$$RetryPolicyImplCopyWithImpl<$Res>
    extends _$RetryPolicyCopyWithImpl<$Res, _$RetryPolicyImpl>
    implements _$$RetryPolicyImplCopyWith<$Res> {
  __$$RetryPolicyImplCopyWithImpl(
      _$RetryPolicyImpl _value, $Res Function(_$RetryPolicyImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? errorEquals = null,
    Object? intervalSeconds = freezed,
    Object? backoffRate = freezed,
    Object? maxAttempts = freezed,
  }) {
    return _then(_$RetryPolicyImpl(
      errorEquals: null == errorEquals
          ? _value._errorEquals
          : errorEquals // ignore: cast_nullable_to_non_nullable
              as List<String>,
      intervalSeconds: freezed == intervalSeconds
          ? _value.intervalSeconds
          : intervalSeconds // ignore: cast_nullable_to_non_nullable
              as int?,
      backoffRate: freezed == backoffRate
          ? _value.backoffRate
          : backoffRate // ignore: cast_nullable_to_non_nullable
              as double?,
      maxAttempts: freezed == maxAttempts
          ? _value.maxAttempts
          : maxAttempts // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$RetryPolicyImpl implements _RetryPolicy {
  const _$RetryPolicyImpl(
      {required final List<String> errorEquals,
      @JsonKey(defaultValue: null) this.intervalSeconds,
      @JsonKey(defaultValue: null) this.backoffRate,
      @JsonKey(defaultValue: null) this.maxAttempts})
      : _errorEquals = errorEquals;

  factory _$RetryPolicyImpl.fromJson(Map<String, dynamic> json) =>
      _$$RetryPolicyImplFromJson(json);

  final List<String> _errorEquals;
  @override
  List<String> get errorEquals {
    if (_errorEquals is EqualUnmodifiableListView) return _errorEquals;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_errorEquals);
  }

// ignore: invalid_annotation_target
  @override
  @JsonKey(defaultValue: null)
  final int? intervalSeconds;
// ignore: invalid_annotation_target
  @override
  @JsonKey(defaultValue: null)
  final double? backoffRate;
// ignore: invalid_annotation_target
  @override
  @JsonKey(defaultValue: null)
  final int? maxAttempts;

  @override
  String toString() {
    return 'RetryPolicy(errorEquals: $errorEquals, intervalSeconds: $intervalSeconds, backoffRate: $backoffRate, maxAttempts: $maxAttempts)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RetryPolicyImpl &&
            const DeepCollectionEquality()
                .equals(other._errorEquals, _errorEquals) &&
            (identical(other.intervalSeconds, intervalSeconds) ||
                other.intervalSeconds == intervalSeconds) &&
            (identical(other.backoffRate, backoffRate) ||
                other.backoffRate == backoffRate) &&
            (identical(other.maxAttempts, maxAttempts) ||
                other.maxAttempts == maxAttempts));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_errorEquals),
      intervalSeconds,
      backoffRate,
      maxAttempts);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$RetryPolicyImplCopyWith<_$RetryPolicyImpl> get copyWith =>
      __$$RetryPolicyImplCopyWithImpl<_$RetryPolicyImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$RetryPolicyImplToJson(
      this,
    );
  }
}

abstract class _RetryPolicy implements RetryPolicy {
  const factory _RetryPolicy(
      {required final List<String> errorEquals,
      @JsonKey(defaultValue: null) final int? intervalSeconds,
      @JsonKey(defaultValue: null) final double? backoffRate,
      @JsonKey(defaultValue: null) final int? maxAttempts}) = _$RetryPolicyImpl;

  factory _RetryPolicy.fromJson(Map<String, dynamic> json) =
      _$RetryPolicyImpl.fromJson;

  @override
  List<String> get errorEquals;
  @override // ignore: invalid_annotation_target
  @JsonKey(defaultValue: null)
  int? get intervalSeconds;
  @override // ignore: invalid_annotation_target
  @JsonKey(defaultValue: null)
  double? get backoffRate;
  @override // ignore: invalid_annotation_target
  @JsonKey(defaultValue: null)
  int? get maxAttempts;
  @override
  @JsonKey(ignore: true)
  _$$RetryPolicyImplCopyWith<_$RetryPolicyImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
