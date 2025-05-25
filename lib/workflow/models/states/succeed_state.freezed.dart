// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'succeed_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

SucceedState _$SucceedStateFromJson(Map<String, dynamic> json) {
  return _SucceedState.fromJson(json);
}

/// @nodoc
mixin _$SucceedState {
  String get type => throw _privateConstructorUsedError;
  String? get comment => throw _privateConstructorUsedError;
  String? get next => throw _privateConstructorUsedError; // 明确声明为null
  bool? get end => throw _privateConstructorUsedError; // 明确声明为true
  List<RetryPolicy>? get retry =>
      throw _privateConstructorUsedError; // 明确声明为null
  List<CatchPolicy>? get catchPolicy => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $SucceedStateCopyWith<SucceedState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SucceedStateCopyWith<$Res> {
  factory $SucceedStateCopyWith(
          SucceedState value, $Res Function(SucceedState) then) =
      _$SucceedStateCopyWithImpl<$Res, SucceedState>;
  @useResult
  $Res call(
      {String type,
      String? comment,
      String? next,
      bool? end,
      List<RetryPolicy>? retry,
      List<CatchPolicy>? catchPolicy});
}

/// @nodoc
class _$SucceedStateCopyWithImpl<$Res, $Val extends SucceedState>
    implements $SucceedStateCopyWith<$Res> {
  _$SucceedStateCopyWithImpl(this._value, this._then);

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
abstract class _$$SucceedStateImplCopyWith<$Res>
    implements $SucceedStateCopyWith<$Res> {
  factory _$$SucceedStateImplCopyWith(
          _$SucceedStateImpl value, $Res Function(_$SucceedStateImpl) then) =
      __$$SucceedStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String type,
      String? comment,
      String? next,
      bool? end,
      List<RetryPolicy>? retry,
      List<CatchPolicy>? catchPolicy});
}

/// @nodoc
class __$$SucceedStateImplCopyWithImpl<$Res>
    extends _$SucceedStateCopyWithImpl<$Res, _$SucceedStateImpl>
    implements _$$SucceedStateImplCopyWith<$Res> {
  __$$SucceedStateImplCopyWithImpl(
      _$SucceedStateImpl _value, $Res Function(_$SucceedStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? type = null,
    Object? comment = freezed,
    Object? next = freezed,
    Object? end = freezed,
    Object? retry = freezed,
    Object? catchPolicy = freezed,
  }) {
    return _then(_$SucceedStateImpl(
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
class _$SucceedStateImpl extends _SucceedState {
  const _$SucceedStateImpl(
      {this.type = 'Succeed',
      this.comment,
      this.next = null,
      this.end = true,
      final List<RetryPolicy>? retry = null,
      final List<CatchPolicy>? catchPolicy = null})
      : _retry = retry,
        _catchPolicy = catchPolicy,
        super._();

  factory _$SucceedStateImpl.fromJson(Map<String, dynamic> json) =>
      _$$SucceedStateImplFromJson(json);

  @override
  @JsonKey()
  final String type;
  @override
  final String? comment;
  @override
  @JsonKey()
  final String? next;
// 明确声明为null
  @override
  @JsonKey()
  final bool? end;
// 明确声明为true
  final List<RetryPolicy>? _retry;
// 明确声明为true
  @override
  @JsonKey()
  List<RetryPolicy>? get retry {
    final value = _retry;
    if (value == null) return null;
    if (_retry is EqualUnmodifiableListView) return _retry;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

// 明确声明为null
  final List<CatchPolicy>? _catchPolicy;
// 明确声明为null
  @override
  @JsonKey()
  List<CatchPolicy>? get catchPolicy {
    final value = _catchPolicy;
    if (value == null) return null;
    if (_catchPolicy is EqualUnmodifiableListView) return _catchPolicy;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  String toString() {
    return 'SucceedState(type: $type, comment: $comment, next: $next, end: $end, retry: $retry, catchPolicy: $catchPolicy)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SucceedStateImpl &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.comment, comment) || other.comment == comment) &&
            (identical(other.next, next) || other.next == next) &&
            (identical(other.end, end) || other.end == end) &&
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
      const DeepCollectionEquality().hash(_retry),
      const DeepCollectionEquality().hash(_catchPolicy));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$SucceedStateImplCopyWith<_$SucceedStateImpl> get copyWith =>
      __$$SucceedStateImplCopyWithImpl<_$SucceedStateImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SucceedStateImplToJson(
      this,
    );
  }
}

abstract class _SucceedState extends SucceedState {
  const factory _SucceedState(
      {final String type,
      final String? comment,
      final String? next,
      final bool? end,
      final List<RetryPolicy>? retry,
      final List<CatchPolicy>? catchPolicy}) = _$SucceedStateImpl;
  const _SucceedState._() : super._();

  factory _SucceedState.fromJson(Map<String, dynamic> json) =
      _$SucceedStateImpl.fromJson;

  @override
  String get type;
  @override
  String? get comment;
  @override
  String? get next;
  @override // 明确声明为null
  bool? get end;
  @override // 明确声明为true
  List<RetryPolicy>? get retry;
  @override // 明确声明为null
  List<CatchPolicy>? get catchPolicy;
  @override
  @JsonKey(ignore: true)
  _$$SucceedStateImplCopyWith<_$SucceedStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
