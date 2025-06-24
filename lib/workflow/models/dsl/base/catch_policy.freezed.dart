// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'catch_policy.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

CatchPolicy _$CatchPolicyFromJson(Map<String, dynamic> json) {
  return _CatchPolicy.fromJson(json);
}

/// @nodoc
mixin _$CatchPolicy {
  List<String> get errorEquals => throw _privateConstructorUsedError;
  String get next =>
      throw _privateConstructorUsedError; // ignore: invalid_annotation_target
  @JsonKey(defaultValue: null)
  String? get resultPath => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $CatchPolicyCopyWith<CatchPolicy> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CatchPolicyCopyWith<$Res> {
  factory $CatchPolicyCopyWith(
          CatchPolicy value, $Res Function(CatchPolicy) then) =
      _$CatchPolicyCopyWithImpl<$Res, CatchPolicy>;
  @useResult
  $Res call(
      {List<String> errorEquals,
      String next,
      @JsonKey(defaultValue: null) String? resultPath});
}

/// @nodoc
class _$CatchPolicyCopyWithImpl<$Res, $Val extends CatchPolicy>
    implements $CatchPolicyCopyWith<$Res> {
  _$CatchPolicyCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? errorEquals = null,
    Object? next = null,
    Object? resultPath = freezed,
  }) {
    return _then(_value.copyWith(
      errorEquals: null == errorEquals
          ? _value.errorEquals
          : errorEquals // ignore: cast_nullable_to_non_nullable
              as List<String>,
      next: null == next
          ? _value.next
          : next // ignore: cast_nullable_to_non_nullable
              as String,
      resultPath: freezed == resultPath
          ? _value.resultPath
          : resultPath // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$CatchPolicyImplCopyWith<$Res>
    implements $CatchPolicyCopyWith<$Res> {
  factory _$$CatchPolicyImplCopyWith(
          _$CatchPolicyImpl value, $Res Function(_$CatchPolicyImpl) then) =
      __$$CatchPolicyImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {List<String> errorEquals,
      String next,
      @JsonKey(defaultValue: null) String? resultPath});
}

/// @nodoc
class __$$CatchPolicyImplCopyWithImpl<$Res>
    extends _$CatchPolicyCopyWithImpl<$Res, _$CatchPolicyImpl>
    implements _$$CatchPolicyImplCopyWith<$Res> {
  __$$CatchPolicyImplCopyWithImpl(
      _$CatchPolicyImpl _value, $Res Function(_$CatchPolicyImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? errorEquals = null,
    Object? next = null,
    Object? resultPath = freezed,
  }) {
    return _then(_$CatchPolicyImpl(
      errorEquals: null == errorEquals
          ? _value._errorEquals
          : errorEquals // ignore: cast_nullable_to_non_nullable
              as List<String>,
      next: null == next
          ? _value.next
          : next // ignore: cast_nullable_to_non_nullable
              as String,
      resultPath: freezed == resultPath
          ? _value.resultPath
          : resultPath // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$CatchPolicyImpl implements _CatchPolicy {
  const _$CatchPolicyImpl(
      {required final List<String> errorEquals,
      required this.next,
      @JsonKey(defaultValue: null) this.resultPath})
      : _errorEquals = errorEquals;

  factory _$CatchPolicyImpl.fromJson(Map<String, dynamic> json) =>
      _$$CatchPolicyImplFromJson(json);

  final List<String> _errorEquals;
  @override
  List<String> get errorEquals {
    if (_errorEquals is EqualUnmodifiableListView) return _errorEquals;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_errorEquals);
  }

  @override
  final String next;
// ignore: invalid_annotation_target
  @override
  @JsonKey(defaultValue: null)
  final String? resultPath;

  @override
  String toString() {
    return 'CatchPolicy(errorEquals: $errorEquals, next: $next, resultPath: $resultPath)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CatchPolicyImpl &&
            const DeepCollectionEquality()
                .equals(other._errorEquals, _errorEquals) &&
            (identical(other.next, next) || other.next == next) &&
            (identical(other.resultPath, resultPath) ||
                other.resultPath == resultPath));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType,
      const DeepCollectionEquality().hash(_errorEquals), next, resultPath);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$CatchPolicyImplCopyWith<_$CatchPolicyImpl> get copyWith =>
      __$$CatchPolicyImplCopyWithImpl<_$CatchPolicyImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CatchPolicyImplToJson(
      this,
    );
  }
}

abstract class _CatchPolicy implements CatchPolicy {
  const factory _CatchPolicy(
          {required final List<String> errorEquals,
          required final String next,
          @JsonKey(defaultValue: null) final String? resultPath}) =
      _$CatchPolicyImpl;

  factory _CatchPolicy.fromJson(Map<String, dynamic> json) =
      _$CatchPolicyImpl.fromJson;

  @override
  List<String> get errorEquals;
  @override
  String get next;
  @override // ignore: invalid_annotation_target
  @JsonKey(defaultValue: null)
  String? get resultPath;
  @override
  @JsonKey(ignore: true)
  _$$CatchPolicyImplCopyWith<_$CatchPolicyImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
