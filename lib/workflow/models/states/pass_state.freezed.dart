// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'pass_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

PassState _$PassStateFromJson(Map<String, dynamic> json) {
  return _PassState.fromJson(json);
}

/// @nodoc
mixin _$PassState {
  String get type => throw _privateConstructorUsedError;
  String? get comment => throw _privateConstructorUsedError;
  String? get next => throw _privateConstructorUsedError;
  bool? get end => throw _privateConstructorUsedError;
  dynamic get result => throw _privateConstructorUsedError;
  String? get resultPath => throw _privateConstructorUsedError;
  List<RetryPolicy>? get retry => throw _privateConstructorUsedError;
  List<CatchPolicy>? get catchPolicy => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $PassStateCopyWith<PassState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PassStateCopyWith<$Res> {
  factory $PassStateCopyWith(PassState value, $Res Function(PassState) then) =
      _$PassStateCopyWithImpl<$Res, PassState>;
  @useResult
  $Res call(
      {String type,
      String? comment,
      String? next,
      bool? end,
      dynamic result,
      String? resultPath,
      List<RetryPolicy>? retry,
      List<CatchPolicy>? catchPolicy});
}

/// @nodoc
class _$PassStateCopyWithImpl<$Res, $Val extends PassState>
    implements $PassStateCopyWith<$Res> {
  _$PassStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? type = null,
    Object? comment = freezed,
    Object? next = freezed,
    Object? end = freezed,
    Object? result = freezed,
    Object? resultPath = freezed,
    Object? retry = freezed,
    Object? catchPolicy = freezed,
  }) {
    return _then(_value.copyWith(
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
      comment: freezed == comment
          ? _value.comment
          : comment // ignore: cast_nullable_to_non_nullable
              as String?,
      next: freezed == next
          ? _value.next
          : next // ignore: cast_nullable_to_non_nullable
              as String?,
      end: freezed == end
          ? _value.end
          : end // ignore: cast_nullable_to_non_nullable
              as bool?,
      result: freezed == result
          ? _value.result
          : result // ignore: cast_nullable_to_non_nullable
              as dynamic,
      resultPath: freezed == resultPath
          ? _value.resultPath
          : resultPath // ignore: cast_nullable_to_non_nullable
              as String?,
      retry: freezed == retry
          ? _value.retry
          : retry // ignore: cast_nullable_to_non_nullable
              as List<RetryPolicy>?,
      catchPolicy: freezed == catchPolicy
          ? _value.catchPolicy
          : catchPolicy // ignore: cast_nullable_to_non_nullable
              as List<CatchPolicy>?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$PassStateImplCopyWith<$Res>
    implements $PassStateCopyWith<$Res> {
  factory _$$PassStateImplCopyWith(
          _$PassStateImpl value, $Res Function(_$PassStateImpl) then) =
      __$$PassStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String type,
      String? comment,
      String? next,
      bool? end,
      dynamic result,
      String? resultPath,
      List<RetryPolicy>? retry,
      List<CatchPolicy>? catchPolicy});
}

/// @nodoc
class __$$PassStateImplCopyWithImpl<$Res>
    extends _$PassStateCopyWithImpl<$Res, _$PassStateImpl>
    implements _$$PassStateImplCopyWith<$Res> {
  __$$PassStateImplCopyWithImpl(
      _$PassStateImpl _value, $Res Function(_$PassStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? type = null,
    Object? comment = freezed,
    Object? next = freezed,
    Object? end = freezed,
    Object? result = freezed,
    Object? resultPath = freezed,
    Object? retry = freezed,
    Object? catchPolicy = freezed,
  }) {
    return _then(_$PassStateImpl(
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
      comment: freezed == comment
          ? _value.comment
          : comment // ignore: cast_nullable_to_non_nullable
              as String?,
      next: freezed == next
          ? _value.next
          : next // ignore: cast_nullable_to_non_nullable
              as String?,
      end: freezed == end
          ? _value.end
          : end // ignore: cast_nullable_to_non_nullable
              as bool?,
      result: freezed == result
          ? _value.result
          : result // ignore: cast_nullable_to_non_nullable
              as dynamic,
      resultPath: freezed == resultPath
          ? _value.resultPath
          : resultPath // ignore: cast_nullable_to_non_nullable
              as String?,
      retry: freezed == retry
          ? _value._retry
          : retry // ignore: cast_nullable_to_non_nullable
              as List<RetryPolicy>?,
      catchPolicy: freezed == catchPolicy
          ? _value._catchPolicy
          : catchPolicy // ignore: cast_nullable_to_non_nullable
              as List<CatchPolicy>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$PassStateImpl extends _PassState {
  const _$PassStateImpl(
      {this.type = 'Pass',
      this.comment,
      this.next,
      this.end,
      this.result,
      this.resultPath,
      final List<RetryPolicy>? retry,
      final List<CatchPolicy>? catchPolicy})
      : _retry = retry,
        _catchPolicy = catchPolicy,
        super._();

  factory _$PassStateImpl.fromJson(Map<String, dynamic> json) =>
      _$$PassStateImplFromJson(json);

  @override
  @JsonKey()
  final String type;
  @override
  final String? comment;
  @override
  final String? next;
  @override
  final bool? end;
  @override
  final dynamic result;
  @override
  final String? resultPath;
  final List<RetryPolicy>? _retry;
  @override
  List<RetryPolicy>? get retry {
    final value = _retry;
    if (value == null) return null;
    if (_retry is EqualUnmodifiableListView) return _retry;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  final List<CatchPolicy>? _catchPolicy;
  @override
  List<CatchPolicy>? get catchPolicy {
    final value = _catchPolicy;
    if (value == null) return null;
    if (_catchPolicy is EqualUnmodifiableListView) return _catchPolicy;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  String toString() {
    return 'PassState(type: $type, comment: $comment, next: $next, end: $end, result: $result, resultPath: $resultPath, retry: $retry, catchPolicy: $catchPolicy)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PassStateImpl &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.comment, comment) || other.comment == comment) &&
            (identical(other.next, next) || other.next == next) &&
            (identical(other.end, end) || other.end == end) &&
            const DeepCollectionEquality().equals(other.result, result) &&
            (identical(other.resultPath, resultPath) ||
                other.resultPath == resultPath) &&
            const DeepCollectionEquality().equals(other._retry, _retry) &&
            const DeepCollectionEquality()
                .equals(other._catchPolicy, _catchPolicy));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      type,
      comment,
      next,
      end,
      const DeepCollectionEquality().hash(result),
      resultPath,
      const DeepCollectionEquality().hash(_retry),
      const DeepCollectionEquality().hash(_catchPolicy));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$PassStateImplCopyWith<_$PassStateImpl> get copyWith =>
      __$$PassStateImplCopyWithImpl<_$PassStateImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PassStateImplToJson(
      this,
    );
  }
}

abstract class _PassState extends PassState {
  const factory _PassState(
      {final String type,
      final String? comment,
      final String? next,
      final bool? end,
      final dynamic result,
      final String? resultPath,
      final List<RetryPolicy>? retry,
      final List<CatchPolicy>? catchPolicy}) = _$PassStateImpl;
  const _PassState._() : super._();

  factory _PassState.fromJson(Map<String, dynamic> json) =
      _$PassStateImpl.fromJson;

  @override
  String get type;
  @override
  String? get comment;
  @override
  String? get next;
  @override
  bool? get end;
  @override
  dynamic get result;
  @override
  String? get resultPath;
  @override
  List<RetryPolicy>? get retry;
  @override
  List<CatchPolicy>? get catchPolicy;
  @override
  @JsonKey(ignore: true)
  _$$PassStateImplCopyWith<_$PassStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
