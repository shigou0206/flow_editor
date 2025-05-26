// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'workflow_dsl_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

WorkflowDslState _$WorkflowDslStateFromJson(Map<String, dynamic> json) {
  return _WorkflowDslState.fromJson(json);
}

/// @nodoc
mixin _$WorkflowDslState {
  WorkflowDSL get workflow => throw _privateConstructorUsedError;
  bool get isLoading => throw _privateConstructorUsedError;
  String? get errorMessage => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $WorkflowDslStateCopyWith<WorkflowDslState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $WorkflowDslStateCopyWith<$Res> {
  factory $WorkflowDslStateCopyWith(
          WorkflowDslState value, $Res Function(WorkflowDslState) then) =
      _$WorkflowDslStateCopyWithImpl<$Res, WorkflowDslState>;
  @useResult
  $Res call({WorkflowDSL workflow, bool isLoading, String? errorMessage});

  $WorkflowDSLCopyWith<$Res> get workflow;
}

/// @nodoc
class _$WorkflowDslStateCopyWithImpl<$Res, $Val extends WorkflowDslState>
    implements $WorkflowDslStateCopyWith<$Res> {
  _$WorkflowDslStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? workflow = null,
    Object? isLoading = null,
    Object? errorMessage = freezed,
  }) {
    return _then(_value.copyWith(
      workflow: null == workflow
          ? _value.workflow
          : workflow // ignore: cast_nullable_to_non_nullable
              as WorkflowDSL,
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      errorMessage: freezed == errorMessage
          ? _value.errorMessage
          : errorMessage // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $WorkflowDSLCopyWith<$Res> get workflow {
    return $WorkflowDSLCopyWith<$Res>(_value.workflow, (value) {
      return _then(_value.copyWith(workflow: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$WorkflowDslStateImplCopyWith<$Res>
    implements $WorkflowDslStateCopyWith<$Res> {
  factory _$$WorkflowDslStateImplCopyWith(_$WorkflowDslStateImpl value,
          $Res Function(_$WorkflowDslStateImpl) then) =
      __$$WorkflowDslStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({WorkflowDSL workflow, bool isLoading, String? errorMessage});

  @override
  $WorkflowDSLCopyWith<$Res> get workflow;
}

/// @nodoc
class __$$WorkflowDslStateImplCopyWithImpl<$Res>
    extends _$WorkflowDslStateCopyWithImpl<$Res, _$WorkflowDslStateImpl>
    implements _$$WorkflowDslStateImplCopyWith<$Res> {
  __$$WorkflowDslStateImplCopyWithImpl(_$WorkflowDslStateImpl _value,
      $Res Function(_$WorkflowDslStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? workflow = null,
    Object? isLoading = null,
    Object? errorMessage = freezed,
  }) {
    return _then(_$WorkflowDslStateImpl(
      workflow: null == workflow
          ? _value.workflow
          : workflow // ignore: cast_nullable_to_non_nullable
              as WorkflowDSL,
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      errorMessage: freezed == errorMessage
          ? _value.errorMessage
          : errorMessage // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$WorkflowDslStateImpl implements _WorkflowDslState {
  const _$WorkflowDslStateImpl(
      {required this.workflow, this.isLoading = false, this.errorMessage});

  factory _$WorkflowDslStateImpl.fromJson(Map<String, dynamic> json) =>
      _$$WorkflowDslStateImplFromJson(json);

  @override
  final WorkflowDSL workflow;
  @override
  @JsonKey()
  final bool isLoading;
  @override
  final String? errorMessage;

  @override
  String toString() {
    return 'WorkflowDslState(workflow: $workflow, isLoading: $isLoading, errorMessage: $errorMessage)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$WorkflowDslStateImpl &&
            (identical(other.workflow, workflow) ||
                other.workflow == workflow) &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading) &&
            (identical(other.errorMessage, errorMessage) ||
                other.errorMessage == errorMessage));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, workflow, isLoading, errorMessage);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$WorkflowDslStateImplCopyWith<_$WorkflowDslStateImpl> get copyWith =>
      __$$WorkflowDslStateImplCopyWithImpl<_$WorkflowDslStateImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$WorkflowDslStateImplToJson(
      this,
    );
  }
}

abstract class _WorkflowDslState implements WorkflowDslState {
  const factory _WorkflowDslState(
      {required final WorkflowDSL workflow,
      final bool isLoading,
      final String? errorMessage}) = _$WorkflowDslStateImpl;

  factory _WorkflowDslState.fromJson(Map<String, dynamic> json) =
      _$WorkflowDslStateImpl.fromJson;

  @override
  WorkflowDSL get workflow;
  @override
  bool get isLoading;
  @override
  String? get errorMessage;
  @override
  @JsonKey(ignore: true)
  _$$WorkflowDslStateImplCopyWith<_$WorkflowDslStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
