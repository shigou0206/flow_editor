// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'task_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

TaskState _$TaskStateFromJson(Map<String, dynamic> json) {
  return _TaskState.fromJson(json);
}

/// @nodoc
mixin _$TaskState {
  String get resource => throw _privateConstructorUsedError;
  Map<String, dynamic>? get parameters => throw _privateConstructorUsedError;
  Map<String, dynamic>? get executionConfig =>
      throw _privateConstructorUsedError;
  int? get heartbeatSeconds => throw _privateConstructorUsedError;
  String? get heartbeatExpr => throw _privateConstructorUsedError;
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
  $TaskStateCopyWith<TaskState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TaskStateCopyWith<$Res> {
  factory $TaskStateCopyWith(TaskState value, $Res Function(TaskState) then) =
      _$TaskStateCopyWithImpl<$Res, TaskState>;
  @useResult
  $Res call(
      {String resource,
      Map<String, dynamic>? parameters,
      Map<String, dynamic>? executionConfig,
      int? heartbeatSeconds,
      String? heartbeatExpr,
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
class _$TaskStateCopyWithImpl<$Res, $Val extends TaskState>
    implements $TaskStateCopyWith<$Res> {
  _$TaskStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? resource = null,
    Object? parameters = freezed,
    Object? executionConfig = freezed,
    Object? heartbeatSeconds = freezed,
    Object? heartbeatExpr = freezed,
    Object? comment = freezed,
    Object? inputMapping = freezed,
    Object? outputMapping = freezed,
    Object? retry = freezed,
    Object? catchPolicy = freezed,
    Object? next = freezed,
    Object? end = freezed,
  }) {
    return _then(_value.copyWith(
      resource: null == resource
          ? _value.resource
          : resource // ignore: cast_nullable_to_non_nullable
              as String,
      parameters: freezed == parameters
          ? _value.parameters
          : parameters // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
      executionConfig: freezed == executionConfig
          ? _value.executionConfig
          : executionConfig // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
      heartbeatSeconds: freezed == heartbeatSeconds
          ? _value.heartbeatSeconds
          : heartbeatSeconds // ignore: cast_nullable_to_non_nullable
              as int?,
      heartbeatExpr: freezed == heartbeatExpr
          ? _value.heartbeatExpr
          : heartbeatExpr // ignore: cast_nullable_to_non_nullable
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
abstract class _$$TaskStateImplCopyWith<$Res>
    implements $TaskStateCopyWith<$Res> {
  factory _$$TaskStateImplCopyWith(
          _$TaskStateImpl value, $Res Function(_$TaskStateImpl) then) =
      __$$TaskStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String resource,
      Map<String, dynamic>? parameters,
      Map<String, dynamic>? executionConfig,
      int? heartbeatSeconds,
      String? heartbeatExpr,
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
class __$$TaskStateImplCopyWithImpl<$Res>
    extends _$TaskStateCopyWithImpl<$Res, _$TaskStateImpl>
    implements _$$TaskStateImplCopyWith<$Res> {
  __$$TaskStateImplCopyWithImpl(
      _$TaskStateImpl _value, $Res Function(_$TaskStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? resource = null,
    Object? parameters = freezed,
    Object? executionConfig = freezed,
    Object? heartbeatSeconds = freezed,
    Object? heartbeatExpr = freezed,
    Object? comment = freezed,
    Object? inputMapping = freezed,
    Object? outputMapping = freezed,
    Object? retry = freezed,
    Object? catchPolicy = freezed,
    Object? next = freezed,
    Object? end = freezed,
  }) {
    return _then(_$TaskStateImpl(
      resource: null == resource
          ? _value.resource
          : resource // ignore: cast_nullable_to_non_nullable
              as String,
      parameters: freezed == parameters
          ? _value._parameters
          : parameters // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
      executionConfig: freezed == executionConfig
          ? _value._executionConfig
          : executionConfig // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
      heartbeatSeconds: freezed == heartbeatSeconds
          ? _value.heartbeatSeconds
          : heartbeatSeconds // ignore: cast_nullable_to_non_nullable
              as int?,
      heartbeatExpr: freezed == heartbeatExpr
          ? _value.heartbeatExpr
          : heartbeatExpr // ignore: cast_nullable_to_non_nullable
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
class _$TaskStateImpl implements _TaskState {
  const _$TaskStateImpl(
      {required this.resource,
      final Map<String, dynamic>? parameters,
      final Map<String, dynamic>? executionConfig,
      this.heartbeatSeconds,
      this.heartbeatExpr,
      this.comment = null,
      @JsonKey(defaultValue: null) this.inputMapping,
      @JsonKey(defaultValue: null) this.outputMapping,
      @JsonKey(defaultValue: null) final List<RetryPolicy>? retry,
      @JsonKey(name: 'catch', defaultValue: null)
      final List<CatchPolicy>? catchPolicy,
      this.next = null,
      this.end = null})
      : _parameters = parameters,
        _executionConfig = executionConfig,
        _retry = retry,
        _catchPolicy = catchPolicy;

  factory _$TaskStateImpl.fromJson(Map<String, dynamic> json) =>
      _$$TaskStateImplFromJson(json);

  @override
  final String resource;
  final Map<String, dynamic>? _parameters;
  @override
  Map<String, dynamic>? get parameters {
    final value = _parameters;
    if (value == null) return null;
    if (_parameters is EqualUnmodifiableMapView) return _parameters;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

  final Map<String, dynamic>? _executionConfig;
  @override
  Map<String, dynamic>? get executionConfig {
    final value = _executionConfig;
    if (value == null) return null;
    if (_executionConfig is EqualUnmodifiableMapView) return _executionConfig;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

  @override
  final int? heartbeatSeconds;
  @override
  final String? heartbeatExpr;
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
    return 'TaskState(resource: $resource, parameters: $parameters, executionConfig: $executionConfig, heartbeatSeconds: $heartbeatSeconds, heartbeatExpr: $heartbeatExpr, comment: $comment, inputMapping: $inputMapping, outputMapping: $outputMapping, retry: $retry, catchPolicy: $catchPolicy, next: $next, end: $end)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TaskStateImpl &&
            (identical(other.resource, resource) ||
                other.resource == resource) &&
            const DeepCollectionEquality()
                .equals(other._parameters, _parameters) &&
            const DeepCollectionEquality()
                .equals(other._executionConfig, _executionConfig) &&
            (identical(other.heartbeatSeconds, heartbeatSeconds) ||
                other.heartbeatSeconds == heartbeatSeconds) &&
            (identical(other.heartbeatExpr, heartbeatExpr) ||
                other.heartbeatExpr == heartbeatExpr) &&
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
      resource,
      const DeepCollectionEquality().hash(_parameters),
      const DeepCollectionEquality().hash(_executionConfig),
      heartbeatSeconds,
      heartbeatExpr,
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
  _$$TaskStateImplCopyWith<_$TaskStateImpl> get copyWith =>
      __$$TaskStateImplCopyWithImpl<_$TaskStateImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TaskStateImplToJson(
      this,
    );
  }
}

abstract class _TaskState implements TaskState {
  const factory _TaskState(
      {required final String resource,
      final Map<String, dynamic>? parameters,
      final Map<String, dynamic>? executionConfig,
      final int? heartbeatSeconds,
      final String? heartbeatExpr,
      final String? comment,
      @JsonKey(defaultValue: null) final MappingDSL? inputMapping,
      @JsonKey(defaultValue: null) final MappingDSL? outputMapping,
      @JsonKey(defaultValue: null) final List<RetryPolicy>? retry,
      @JsonKey(name: 'catch', defaultValue: null)
      final List<CatchPolicy>? catchPolicy,
      final String? next,
      final bool? end}) = _$TaskStateImpl;

  factory _TaskState.fromJson(Map<String, dynamic> json) =
      _$TaskStateImpl.fromJson;

  @override
  String get resource;
  @override
  Map<String, dynamic>? get parameters;
  @override
  Map<String, dynamic>? get executionConfig;
  @override
  int? get heartbeatSeconds;
  @override
  String? get heartbeatExpr;
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
  _$$TaskStateImplCopyWith<_$TaskStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
