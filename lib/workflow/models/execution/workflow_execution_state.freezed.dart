// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'workflow_execution_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

WorkflowExecutionState _$WorkflowExecutionStateFromJson(
    Map<String, dynamic> json) {
  return _WorkflowExecutionState.fromJson(json);
}

/// @nodoc
mixin _$WorkflowExecutionState {
  String get stateId => throw _privateConstructorUsedError;
  String get activityType => throw _privateConstructorUsedError;
  String get status => throw _privateConstructorUsedError;
  Map<String, dynamic>? get input => throw _privateConstructorUsedError;
  Map<String, dynamic>? get result => throw _privateConstructorUsedError;
  DateTime? get scheduledAt => throw _privateConstructorUsedError;
  DateTime? get startedAt => throw _privateConstructorUsedError;
  DateTime? get completedAt => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $WorkflowExecutionStateCopyWith<WorkflowExecutionState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $WorkflowExecutionStateCopyWith<$Res> {
  factory $WorkflowExecutionStateCopyWith(WorkflowExecutionState value,
          $Res Function(WorkflowExecutionState) then) =
      _$WorkflowExecutionStateCopyWithImpl<$Res, WorkflowExecutionState>;
  @useResult
  $Res call(
      {String stateId,
      String activityType,
      String status,
      Map<String, dynamic>? input,
      Map<String, dynamic>? result,
      DateTime? scheduledAt,
      DateTime? startedAt,
      DateTime? completedAt});
}

/// @nodoc
class _$WorkflowExecutionStateCopyWithImpl<$Res,
        $Val extends WorkflowExecutionState>
    implements $WorkflowExecutionStateCopyWith<$Res> {
  _$WorkflowExecutionStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? stateId = null,
    Object? activityType = null,
    Object? status = null,
    Object? input = freezed,
    Object? result = freezed,
    Object? scheduledAt = freezed,
    Object? startedAt = freezed,
    Object? completedAt = freezed,
  }) {
    return _then(_value.copyWith(
      stateId: null == stateId
          ? _value.stateId
          : stateId // ignore: cast_nullable_to_non_nullable
              as String,
      activityType: null == activityType
          ? _value.activityType
          : activityType // ignore: cast_nullable_to_non_nullable
              as String,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      input: freezed == input
          ? _value.input
          : input // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
      result: freezed == result
          ? _value.result
          : result // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
      scheduledAt: freezed == scheduledAt
          ? _value.scheduledAt
          : scheduledAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      startedAt: freezed == startedAt
          ? _value.startedAt
          : startedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      completedAt: freezed == completedAt
          ? _value.completedAt
          : completedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$WorkflowExecutionStateImplCopyWith<$Res>
    implements $WorkflowExecutionStateCopyWith<$Res> {
  factory _$$WorkflowExecutionStateImplCopyWith(
          _$WorkflowExecutionStateImpl value,
          $Res Function(_$WorkflowExecutionStateImpl) then) =
      __$$WorkflowExecutionStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String stateId,
      String activityType,
      String status,
      Map<String, dynamic>? input,
      Map<String, dynamic>? result,
      DateTime? scheduledAt,
      DateTime? startedAt,
      DateTime? completedAt});
}

/// @nodoc
class __$$WorkflowExecutionStateImplCopyWithImpl<$Res>
    extends _$WorkflowExecutionStateCopyWithImpl<$Res,
        _$WorkflowExecutionStateImpl>
    implements _$$WorkflowExecutionStateImplCopyWith<$Res> {
  __$$WorkflowExecutionStateImplCopyWithImpl(
      _$WorkflowExecutionStateImpl _value,
      $Res Function(_$WorkflowExecutionStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? stateId = null,
    Object? activityType = null,
    Object? status = null,
    Object? input = freezed,
    Object? result = freezed,
    Object? scheduledAt = freezed,
    Object? startedAt = freezed,
    Object? completedAt = freezed,
  }) {
    return _then(_$WorkflowExecutionStateImpl(
      stateId: null == stateId
          ? _value.stateId
          : stateId // ignore: cast_nullable_to_non_nullable
              as String,
      activityType: null == activityType
          ? _value.activityType
          : activityType // ignore: cast_nullable_to_non_nullable
              as String,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      input: freezed == input
          ? _value._input
          : input // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
      result: freezed == result
          ? _value._result
          : result // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
      scheduledAt: freezed == scheduledAt
          ? _value.scheduledAt
          : scheduledAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      startedAt: freezed == startedAt
          ? _value.startedAt
          : startedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      completedAt: freezed == completedAt
          ? _value.completedAt
          : completedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$WorkflowExecutionStateImpl implements _WorkflowExecutionState {
  const _$WorkflowExecutionStateImpl(
      {required this.stateId,
      required this.activityType,
      required this.status,
      final Map<String, dynamic>? input,
      final Map<String, dynamic>? result,
      this.scheduledAt,
      this.startedAt,
      this.completedAt})
      : _input = input,
        _result = result;

  factory _$WorkflowExecutionStateImpl.fromJson(Map<String, dynamic> json) =>
      _$$WorkflowExecutionStateImplFromJson(json);

  @override
  final String stateId;
  @override
  final String activityType;
  @override
  final String status;
  final Map<String, dynamic>? _input;
  @override
  Map<String, dynamic>? get input {
    final value = _input;
    if (value == null) return null;
    if (_input is EqualUnmodifiableMapView) return _input;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

  final Map<String, dynamic>? _result;
  @override
  Map<String, dynamic>? get result {
    final value = _result;
    if (value == null) return null;
    if (_result is EqualUnmodifiableMapView) return _result;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

  @override
  final DateTime? scheduledAt;
  @override
  final DateTime? startedAt;
  @override
  final DateTime? completedAt;

  @override
  String toString() {
    return 'WorkflowExecutionState(stateId: $stateId, activityType: $activityType, status: $status, input: $input, result: $result, scheduledAt: $scheduledAt, startedAt: $startedAt, completedAt: $completedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$WorkflowExecutionStateImpl &&
            (identical(other.stateId, stateId) || other.stateId == stateId) &&
            (identical(other.activityType, activityType) ||
                other.activityType == activityType) &&
            (identical(other.status, status) || other.status == status) &&
            const DeepCollectionEquality().equals(other._input, _input) &&
            const DeepCollectionEquality().equals(other._result, _result) &&
            (identical(other.scheduledAt, scheduledAt) ||
                other.scheduledAt == scheduledAt) &&
            (identical(other.startedAt, startedAt) ||
                other.startedAt == startedAt) &&
            (identical(other.completedAt, completedAt) ||
                other.completedAt == completedAt));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      stateId,
      activityType,
      status,
      const DeepCollectionEquality().hash(_input),
      const DeepCollectionEquality().hash(_result),
      scheduledAt,
      startedAt,
      completedAt);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$WorkflowExecutionStateImplCopyWith<_$WorkflowExecutionStateImpl>
      get copyWith => __$$WorkflowExecutionStateImplCopyWithImpl<
          _$WorkflowExecutionStateImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$WorkflowExecutionStateImplToJson(
      this,
    );
  }
}

abstract class _WorkflowExecutionState implements WorkflowExecutionState {
  const factory _WorkflowExecutionState(
      {required final String stateId,
      required final String activityType,
      required final String status,
      final Map<String, dynamic>? input,
      final Map<String, dynamic>? result,
      final DateTime? scheduledAt,
      final DateTime? startedAt,
      final DateTime? completedAt}) = _$WorkflowExecutionStateImpl;

  factory _WorkflowExecutionState.fromJson(Map<String, dynamic> json) =
      _$WorkflowExecutionStateImpl.fromJson;

  @override
  String get stateId;
  @override
  String get activityType;
  @override
  String get status;
  @override
  Map<String, dynamic>? get input;
  @override
  Map<String, dynamic>? get result;
  @override
  DateTime? get scheduledAt;
  @override
  DateTime? get startedAt;
  @override
  DateTime? get completedAt;
  @override
  @JsonKey(ignore: true)
  _$$WorkflowExecutionStateImplCopyWith<_$WorkflowExecutionStateImpl>
      get copyWith => throw _privateConstructorUsedError;
}
