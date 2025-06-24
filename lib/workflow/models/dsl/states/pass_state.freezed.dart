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
  String? get resultPath => throw _privateConstructorUsedError;
  String? get comment =>
      throw _privateConstructorUsedError; // ignore: invalid_annotation_target
  @JsonKey(defaultValue: null)
  MappingDSL? get inputMapping =>
      throw _privateConstructorUsedError; // ignore: invalid_annotation_target
  @JsonKey(defaultValue: null)
  MappingDSL? get outputMapping =>
      throw _privateConstructorUsedError; // ignore: invalid_annotation_target
  @JsonKey(defaultValue: null)
  List<RetryPolicy>? get retry =>
      throw _privateConstructorUsedError; // ignore: invalid_annotation_target
  @JsonKey(name: 'catch', defaultValue: null)
  List<CatchPolicy>? get catchPolicy => throw _privateConstructorUsedError;
  String? get next => throw _privateConstructorUsedError;
  bool? get end => throw _privateConstructorUsedError;

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
      {String? resultPath,
      String? comment,
      @JsonKey(defaultValue: null) MappingDSL? inputMapping,
      @JsonKey(defaultValue: null) MappingDSL? outputMapping,
      @JsonKey(defaultValue: null) List<RetryPolicy>? retry,
      @JsonKey(name: 'catch', defaultValue: null)
      List<CatchPolicy>? catchPolicy,
      String? next,
      bool? end});

  $MappingDSLCopyWith<$Res>? get inputMapping;
  $MappingDSLCopyWith<$Res>? get outputMapping;
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
    Object? resultPath = freezed,
    Object? comment = freezed,
    Object? inputMapping = freezed,
    Object? outputMapping = freezed,
    Object? retry = freezed,
    Object? catchPolicy = freezed,
    Object? next = freezed,
    Object? end = freezed,
  }) {
    return _then(_value.copyWith(
      resultPath: freezed == resultPath
          ? _value.resultPath
          : resultPath // ignore: cast_nullable_to_non_nullable
              as String?,
      comment: freezed == comment
          ? _value.comment
          : comment // ignore: cast_nullable_to_non_nullable
              as String?,
      inputMapping: freezed == inputMapping
          ? _value.inputMapping
          : inputMapping // ignore: cast_nullable_to_non_nullable
              as MappingDSL?,
      outputMapping: freezed == outputMapping
          ? _value.outputMapping
          : outputMapping // ignore: cast_nullable_to_non_nullable
              as MappingDSL?,
      retry: freezed == retry
          ? _value.retry
          : retry // ignore: cast_nullable_to_non_nullable
              as List<RetryPolicy>?,
      catchPolicy: freezed == catchPolicy
          ? _value.catchPolicy
          : catchPolicy // ignore: cast_nullable_to_non_nullable
              as List<CatchPolicy>?,
      next: freezed == next
          ? _value.next
          : next // ignore: cast_nullable_to_non_nullable
              as String?,
      end: freezed == end
          ? _value.end
          : end // ignore: cast_nullable_to_non_nullable
              as bool?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $MappingDSLCopyWith<$Res>? get inputMapping {
    if (_value.inputMapping == null) {
      return null;
    }

    return $MappingDSLCopyWith<$Res>(_value.inputMapping!, (value) {
      return _then(_value.copyWith(inputMapping: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $MappingDSLCopyWith<$Res>? get outputMapping {
    if (_value.outputMapping == null) {
      return null;
    }

    return $MappingDSLCopyWith<$Res>(_value.outputMapping!, (value) {
      return _then(_value.copyWith(outputMapping: value) as $Val);
    });
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
      {String? resultPath,
      String? comment,
      @JsonKey(defaultValue: null) MappingDSL? inputMapping,
      @JsonKey(defaultValue: null) MappingDSL? outputMapping,
      @JsonKey(defaultValue: null) List<RetryPolicy>? retry,
      @JsonKey(name: 'catch', defaultValue: null)
      List<CatchPolicy>? catchPolicy,
      String? next,
      bool? end});

  @override
  $MappingDSLCopyWith<$Res>? get inputMapping;
  @override
  $MappingDSLCopyWith<$Res>? get outputMapping;
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
    Object? resultPath = freezed,
    Object? comment = freezed,
    Object? inputMapping = freezed,
    Object? outputMapping = freezed,
    Object? retry = freezed,
    Object? catchPolicy = freezed,
    Object? next = freezed,
    Object? end = freezed,
  }) {
    return _then(_$PassStateImpl(
      resultPath: freezed == resultPath
          ? _value.resultPath
          : resultPath // ignore: cast_nullable_to_non_nullable
              as String?,
      comment: freezed == comment
          ? _value.comment
          : comment // ignore: cast_nullable_to_non_nullable
              as String?,
      inputMapping: freezed == inputMapping
          ? _value.inputMapping
          : inputMapping // ignore: cast_nullable_to_non_nullable
              as MappingDSL?,
      outputMapping: freezed == outputMapping
          ? _value.outputMapping
          : outputMapping // ignore: cast_nullable_to_non_nullable
              as MappingDSL?,
      retry: freezed == retry
          ? _value._retry
          : retry // ignore: cast_nullable_to_non_nullable
              as List<RetryPolicy>?,
      catchPolicy: freezed == catchPolicy
          ? _value._catchPolicy
          : catchPolicy // ignore: cast_nullable_to_non_nullable
              as List<CatchPolicy>?,
      next: freezed == next
          ? _value.next
          : next // ignore: cast_nullable_to_non_nullable
              as String?,
      end: freezed == end
          ? _value.end
          : end // ignore: cast_nullable_to_non_nullable
              as bool?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$PassStateImpl extends _PassState {
  const _$PassStateImpl(
      {this.resultPath,
      this.comment = null,
      @JsonKey(defaultValue: null) this.inputMapping,
      @JsonKey(defaultValue: null) this.outputMapping,
      @JsonKey(defaultValue: null) final List<RetryPolicy>? retry,
      @JsonKey(name: 'catch', defaultValue: null)
      final List<CatchPolicy>? catchPolicy,
      this.next = null,
      this.end = null})
      : _retry = retry,
        _catchPolicy = catchPolicy,
        super._();

  factory _$PassStateImpl.fromJson(Map<String, dynamic> json) =>
      _$$PassStateImplFromJson(json);

  @override
  final String? resultPath;
  @override
  @JsonKey()
  final String? comment;
// ignore: invalid_annotation_target
  @override
  @JsonKey(defaultValue: null)
  final MappingDSL? inputMapping;
// ignore: invalid_annotation_target
  @override
  @JsonKey(defaultValue: null)
  final MappingDSL? outputMapping;
// ignore: invalid_annotation_target
  final List<RetryPolicy>? _retry;
// ignore: invalid_annotation_target
  @override
  @JsonKey(defaultValue: null)
  List<RetryPolicy>? get retry {
    final value = _retry;
    if (value == null) return null;
    if (_retry is EqualUnmodifiableListView) return _retry;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

// ignore: invalid_annotation_target
  final List<CatchPolicy>? _catchPolicy;
// ignore: invalid_annotation_target
  @override
  @JsonKey(name: 'catch', defaultValue: null)
  List<CatchPolicy>? get catchPolicy {
    final value = _catchPolicy;
    if (value == null) return null;
    if (_catchPolicy is EqualUnmodifiableListView) return _catchPolicy;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  @JsonKey()
  final String? next;
  @override
  @JsonKey()
  final bool? end;

  @override
  String toString() {
    return 'PassState(resultPath: $resultPath, comment: $comment, inputMapping: $inputMapping, outputMapping: $outputMapping, retry: $retry, catchPolicy: $catchPolicy, next: $next, end: $end)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PassStateImpl &&
            (identical(other.resultPath, resultPath) ||
                other.resultPath == resultPath) &&
            (identical(other.comment, comment) || other.comment == comment) &&
            (identical(other.inputMapping, inputMapping) ||
                other.inputMapping == inputMapping) &&
            (identical(other.outputMapping, outputMapping) ||
                other.outputMapping == outputMapping) &&
            const DeepCollectionEquality().equals(other._retry, _retry) &&
            const DeepCollectionEquality()
                .equals(other._catchPolicy, _catchPolicy) &&
            (identical(other.next, next) || other.next == next) &&
            (identical(other.end, end) || other.end == end));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      resultPath,
      comment,
      inputMapping,
      outputMapping,
      const DeepCollectionEquality().hash(_retry),
      const DeepCollectionEquality().hash(_catchPolicy),
      next,
      end);

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
      {final String? resultPath,
      final String? comment,
      @JsonKey(defaultValue: null) final MappingDSL? inputMapping,
      @JsonKey(defaultValue: null) final MappingDSL? outputMapping,
      @JsonKey(defaultValue: null) final List<RetryPolicy>? retry,
      @JsonKey(name: 'catch', defaultValue: null)
      final List<CatchPolicy>? catchPolicy,
      final String? next,
      final bool? end}) = _$PassStateImpl;
  const _PassState._() : super._();

  factory _PassState.fromJson(Map<String, dynamic> json) =
      _$PassStateImpl.fromJson;

  @override
  String? get resultPath;
  @override
  String? get comment;
  @override // ignore: invalid_annotation_target
  @JsonKey(defaultValue: null)
  MappingDSL? get inputMapping;
  @override // ignore: invalid_annotation_target
  @JsonKey(defaultValue: null)
  MappingDSL? get outputMapping;
  @override // ignore: invalid_annotation_target
  @JsonKey(defaultValue: null)
  List<RetryPolicy>? get retry;
  @override // ignore: invalid_annotation_target
  @JsonKey(name: 'catch', defaultValue: null)
  List<CatchPolicy>? get catchPolicy;
  @override
  String? get next;
  @override
  bool? get end;
  @override
  @JsonKey(ignore: true)
  _$$PassStateImplCopyWith<_$PassStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
