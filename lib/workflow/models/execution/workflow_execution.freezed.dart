// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'workflow_execution.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

WorkflowExecution _$WorkflowExecutionFromJson(Map<String, dynamic> json) {
  return _WorkflowExecution.fromJson(json);
}

/// @nodoc
mixin _$WorkflowExecution {
  String get runId => throw _privateConstructorUsedError;
  String get status => throw _privateConstructorUsedError;
  WorkflowDSL get workflowTemplate => throw _privateConstructorUsedError;
  Map<String, WorkflowExecutionState> get states =>
      throw _privateConstructorUsedError;
  DateTime? get startedAt => throw _privateConstructorUsedError;
  DateTime? get finishedAt => throw _privateConstructorUsedError;
  Map<String, dynamic>? get inputs => throw _privateConstructorUsedError;
  Map<String, dynamic>? get outputs => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $WorkflowExecutionCopyWith<WorkflowExecution> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $WorkflowExecutionCopyWith<$Res> {
  factory $WorkflowExecutionCopyWith(
          WorkflowExecution value, $Res Function(WorkflowExecution) then) =
      _$WorkflowExecutionCopyWithImpl<$Res, WorkflowExecution>;
  @useResult
  $Res call(
      {String runId,
      String status,
      WorkflowDSL workflowTemplate,
      Map<String, WorkflowExecutionState> states,
      DateTime? startedAt,
      DateTime? finishedAt,
      Map<String, dynamic>? inputs,
      Map<String, dynamic>? outputs});

  $WorkflowDSLCopyWith<$Res> get workflowTemplate;
}

/// @nodoc
class _$WorkflowExecutionCopyWithImpl<$Res, $Val extends WorkflowExecution>
    implements $WorkflowExecutionCopyWith<$Res> {
  _$WorkflowExecutionCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? runId = null,
    Object? status = null,
    Object? workflowTemplate = null,
    Object? states = null,
    Object? startedAt = freezed,
    Object? finishedAt = freezed,
    Object? inputs = freezed,
    Object? outputs = freezed,
  }) {
    return _then(_value.copyWith(
      runId: null == runId
          ? _value.runId
          : runId // ignore: cast_nullable_to_non_nullable
              as String,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      workflowTemplate: null == workflowTemplate
          ? _value.workflowTemplate
          : workflowTemplate // ignore: cast_nullable_to_non_nullable
              as WorkflowDSL,
      states: null == states
          ? _value.states
          : states // ignore: cast_nullable_to_non_nullable
              as Map<String, WorkflowExecutionState>,
      startedAt: freezed == startedAt
          ? _value.startedAt
          : startedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      finishedAt: freezed == finishedAt
          ? _value.finishedAt
          : finishedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      inputs: freezed == inputs
          ? _value.inputs
          : inputs // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
      outputs: freezed == outputs
          ? _value.outputs
          : outputs // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $WorkflowDSLCopyWith<$Res> get workflowTemplate {
    return $WorkflowDSLCopyWith<$Res>(_value.workflowTemplate, (value) {
      return _then(_value.copyWith(workflowTemplate: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$WorkflowExecutionImplCopyWith<$Res>
    implements $WorkflowExecutionCopyWith<$Res> {
  factory _$$WorkflowExecutionImplCopyWith(_$WorkflowExecutionImpl value,
          $Res Function(_$WorkflowExecutionImpl) then) =
      __$$WorkflowExecutionImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String runId,
      String status,
      WorkflowDSL workflowTemplate,
      Map<String, WorkflowExecutionState> states,
      DateTime? startedAt,
      DateTime? finishedAt,
      Map<String, dynamic>? inputs,
      Map<String, dynamic>? outputs});

  @override
  $WorkflowDSLCopyWith<$Res> get workflowTemplate;
}

/// @nodoc
class __$$WorkflowExecutionImplCopyWithImpl<$Res>
    extends _$WorkflowExecutionCopyWithImpl<$Res, _$WorkflowExecutionImpl>
    implements _$$WorkflowExecutionImplCopyWith<$Res> {
  __$$WorkflowExecutionImplCopyWithImpl(_$WorkflowExecutionImpl _value,
      $Res Function(_$WorkflowExecutionImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? runId = null,
    Object? status = null,
    Object? workflowTemplate = null,
    Object? states = null,
    Object? startedAt = freezed,
    Object? finishedAt = freezed,
    Object? inputs = freezed,
    Object? outputs = freezed,
  }) {
    return _then(_$WorkflowExecutionImpl(
      runId: null == runId
          ? _value.runId
          : runId // ignore: cast_nullable_to_non_nullable
              as String,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      workflowTemplate: null == workflowTemplate
          ? _value.workflowTemplate
          : workflowTemplate // ignore: cast_nullable_to_non_nullable
              as WorkflowDSL,
      states: null == states
          ? _value._states
          : states // ignore: cast_nullable_to_non_nullable
              as Map<String, WorkflowExecutionState>,
      startedAt: freezed == startedAt
          ? _value.startedAt
          : startedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      finishedAt: freezed == finishedAt
          ? _value.finishedAt
          : finishedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      inputs: freezed == inputs
          ? _value._inputs
          : inputs // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
      outputs: freezed == outputs
          ? _value._outputs
          : outputs // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$WorkflowExecutionImpl implements _WorkflowExecution {
  const _$WorkflowExecutionImpl(
      {required this.runId,
      required this.status,
      required this.workflowTemplate,
      required final Map<String, WorkflowExecutionState> states,
      this.startedAt,
      this.finishedAt,
      final Map<String, dynamic>? inputs,
      final Map<String, dynamic>? outputs})
      : _states = states,
        _inputs = inputs,
        _outputs = outputs;

  factory _$WorkflowExecutionImpl.fromJson(Map<String, dynamic> json) =>
      _$$WorkflowExecutionImplFromJson(json);

  @override
  final String runId;
  @override
  final String status;
  @override
  final WorkflowDSL workflowTemplate;
  final Map<String, WorkflowExecutionState> _states;
  @override
  Map<String, WorkflowExecutionState> get states {
    if (_states is EqualUnmodifiableMapView) return _states;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_states);
  }

  @override
  final DateTime? startedAt;
  @override
  final DateTime? finishedAt;
  final Map<String, dynamic>? _inputs;
  @override
  Map<String, dynamic>? get inputs {
    final value = _inputs;
    if (value == null) return null;
    if (_inputs is EqualUnmodifiableMapView) return _inputs;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

  final Map<String, dynamic>? _outputs;
  @override
  Map<String, dynamic>? get outputs {
    final value = _outputs;
    if (value == null) return null;
    if (_outputs is EqualUnmodifiableMapView) return _outputs;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

  @override
  String toString() {
    return 'WorkflowExecution(runId: $runId, status: $status, workflowTemplate: $workflowTemplate, states: $states, startedAt: $startedAt, finishedAt: $finishedAt, inputs: $inputs, outputs: $outputs)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$WorkflowExecutionImpl &&
            (identical(other.runId, runId) || other.runId == runId) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.workflowTemplate, workflowTemplate) ||
                other.workflowTemplate == workflowTemplate) &&
            const DeepCollectionEquality().equals(other._states, _states) &&
            (identical(other.startedAt, startedAt) ||
                other.startedAt == startedAt) &&
            (identical(other.finishedAt, finishedAt) ||
                other.finishedAt == finishedAt) &&
            const DeepCollectionEquality().equals(other._inputs, _inputs) &&
            const DeepCollectionEquality().equals(other._outputs, _outputs));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      runId,
      status,
      workflowTemplate,
      const DeepCollectionEquality().hash(_states),
      startedAt,
      finishedAt,
      const DeepCollectionEquality().hash(_inputs),
      const DeepCollectionEquality().hash(_outputs));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$WorkflowExecutionImplCopyWith<_$WorkflowExecutionImpl> get copyWith =>
      __$$WorkflowExecutionImplCopyWithImpl<_$WorkflowExecutionImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$WorkflowExecutionImplToJson(
      this,
    );
  }
}

abstract class _WorkflowExecution implements WorkflowExecution {
  const factory _WorkflowExecution(
      {required final String runId,
      required final String status,
      required final WorkflowDSL workflowTemplate,
      required final Map<String, WorkflowExecutionState> states,
      final DateTime? startedAt,
      final DateTime? finishedAt,
      final Map<String, dynamic>? inputs,
      final Map<String, dynamic>? outputs}) = _$WorkflowExecutionImpl;

  factory _WorkflowExecution.fromJson(Map<String, dynamic> json) =
      _$WorkflowExecutionImpl.fromJson;

  @override
  String get runId;
  @override
  String get status;
  @override
  WorkflowDSL get workflowTemplate;
  @override
  Map<String, WorkflowExecutionState> get states;
  @override
  DateTime? get startedAt;
  @override
  DateTime? get finishedAt;
  @override
  Map<String, dynamic>? get inputs;
  @override
  Map<String, dynamic>? get outputs;
  @override
  @JsonKey(ignore: true)
  _$$WorkflowExecutionImplCopyWith<_$WorkflowExecutionImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
