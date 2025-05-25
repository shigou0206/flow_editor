// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'wait_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

WaitState _$WaitStateFromJson(Map<String, dynamic> json) {
  return _WaitState.fromJson(json);
}

/// @nodoc
mixin _$WaitState {
  String get type => throw _privateConstructorUsedError;
  String? get comment => throw _privateConstructorUsedError;
  String? get next => throw _privateConstructorUsedError;
  bool? get end => throw _privateConstructorUsedError;
  int? get seconds => throw _privateConstructorUsedError;
  String? get timestamp => throw _privateConstructorUsedError;
  List<RetryPolicy>? get retry =>
      throw _privateConstructorUsedError; // ✅ 新添加，满足BaseState接口
  List<CatchPolicy>? get catchPolicy => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $WaitStateCopyWith<WaitState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $WaitStateCopyWith<$Res> {
  factory $WaitStateCopyWith(WaitState value, $Res Function(WaitState) then) =
      _$WaitStateCopyWithImpl<$Res, WaitState>;
  @useResult
  $Res call(
      {String type,
      String? comment,
      String? next,
      bool? end,
      int? seconds,
      String? timestamp,
      List<RetryPolicy>? retry,
      List<CatchPolicy>? catchPolicy});
}

/// @nodoc
class _$WaitStateCopyWithImpl<$Res, $Val extends WaitState>
    implements $WaitStateCopyWith<$Res> {
  _$WaitStateCopyWithImpl(this._value, this._then);

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
    Object? seconds = freezed,
    Object? timestamp = freezed,
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
      seconds: freezed == seconds
          ? _value.seconds
          : seconds // ignore: cast_nullable_to_non_nullable
              as int?,
      timestamp: freezed == timestamp
          ? _value.timestamp
          : timestamp // ignore: cast_nullable_to_non_nullable
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
abstract class _$$WaitStateImplCopyWith<$Res>
    implements $WaitStateCopyWith<$Res> {
  factory _$$WaitStateImplCopyWith(
          _$WaitStateImpl value, $Res Function(_$WaitStateImpl) then) =
      __$$WaitStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String type,
      String? comment,
      String? next,
      bool? end,
      int? seconds,
      String? timestamp,
      List<RetryPolicy>? retry,
      List<CatchPolicy>? catchPolicy});
}

/// @nodoc
class __$$WaitStateImplCopyWithImpl<$Res>
    extends _$WaitStateCopyWithImpl<$Res, _$WaitStateImpl>
    implements _$$WaitStateImplCopyWith<$Res> {
  __$$WaitStateImplCopyWithImpl(
      _$WaitStateImpl _value, $Res Function(_$WaitStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? type = null,
    Object? comment = freezed,
    Object? next = freezed,
    Object? end = freezed,
    Object? seconds = freezed,
    Object? timestamp = freezed,
    Object? retry = freezed,
    Object? catchPolicy = freezed,
  }) {
    return _then(_$WaitStateImpl(
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
      seconds: freezed == seconds
          ? _value.seconds
          : seconds // ignore: cast_nullable_to_non_nullable
              as int?,
      timestamp: freezed == timestamp
          ? _value.timestamp
          : timestamp // ignore: cast_nullable_to_non_nullable
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
class _$WaitStateImpl extends _WaitState {
  const _$WaitStateImpl(
      {this.type = 'Wait',
      this.comment,
      this.next,
      this.end,
      this.seconds,
      this.timestamp,
      final List<RetryPolicy>? retry,
      final List<CatchPolicy>? catchPolicy})
      : _retry = retry,
        _catchPolicy = catchPolicy,
        super._();

  factory _$WaitStateImpl.fromJson(Map<String, dynamic> json) =>
      _$$WaitStateImplFromJson(json);

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
  final int? seconds;
  @override
  final String? timestamp;
  final List<RetryPolicy>? _retry;
  @override
  List<RetryPolicy>? get retry {
    final value = _retry;
    if (value == null) return null;
    if (_retry is EqualUnmodifiableListView) return _retry;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

// ✅ 新添加，满足BaseState接口
  final List<CatchPolicy>? _catchPolicy;
// ✅ 新添加，满足BaseState接口
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
    return 'WaitState(type: $type, comment: $comment, next: $next, end: $end, seconds: $seconds, timestamp: $timestamp, retry: $retry, catchPolicy: $catchPolicy)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$WaitStateImpl &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.comment, comment) || other.comment == comment) &&
            (identical(other.next, next) || other.next == next) &&
            (identical(other.end, end) || other.end == end) &&
            (identical(other.seconds, seconds) || other.seconds == seconds) &&
            (identical(other.timestamp, timestamp) ||
                other.timestamp == timestamp) &&
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
      seconds,
      timestamp,
      const DeepCollectionEquality().hash(_retry),
      const DeepCollectionEquality().hash(_catchPolicy));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$WaitStateImplCopyWith<_$WaitStateImpl> get copyWith =>
      __$$WaitStateImplCopyWithImpl<_$WaitStateImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$WaitStateImplToJson(
      this,
    );
  }
}

abstract class _WaitState extends WaitState {
  const factory _WaitState(
      {final String type,
      final String? comment,
      final String? next,
      final bool? end,
      final int? seconds,
      final String? timestamp,
      final List<RetryPolicy>? retry,
      final List<CatchPolicy>? catchPolicy}) = _$WaitStateImpl;
  const _WaitState._() : super._();

  factory _WaitState.fromJson(Map<String, dynamic> json) =
      _$WaitStateImpl.fromJson;

  @override
  String get type;
  @override
  String? get comment;
  @override
  String? get next;
  @override
  bool? get end;
  @override
  int? get seconds;
  @override
  String? get timestamp;
  @override
  List<RetryPolicy>? get retry;
  @override // ✅ 新添加，满足BaseState接口
  List<CatchPolicy>? get catchPolicy;
  @override
  @JsonKey(ignore: true)
  _$$WaitStateImplCopyWith<_$WaitStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
