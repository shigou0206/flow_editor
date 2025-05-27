// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'workflow_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$WorkflowState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(TaskState task) task,
    required TResult Function(PassState pass) pass,
    required TResult Function(ChoiceState choice) choice,
    required TResult Function(SucceedState succeed) succeed,
    required TResult Function(FailState fail) fail,
    required TResult Function(WaitState wait) wait,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(TaskState task)? task,
    TResult? Function(PassState pass)? pass,
    TResult? Function(ChoiceState choice)? choice,
    TResult? Function(SucceedState succeed)? succeed,
    TResult? Function(FailState fail)? fail,
    TResult? Function(WaitState wait)? wait,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(TaskState task)? task,
    TResult Function(PassState pass)? pass,
    TResult Function(ChoiceState choice)? choice,
    TResult Function(SucceedState succeed)? succeed,
    TResult Function(FailState fail)? fail,
    TResult Function(WaitState wait)? wait,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(TaskWorkflowState value) task,
    required TResult Function(PassWorkflowState value) pass,
    required TResult Function(ChoiceWorkflowState value) choice,
    required TResult Function(SucceedWorkflowState value) succeed,
    required TResult Function(FailWorkflowState value) fail,
    required TResult Function(WaitWorkflowState value) wait,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(TaskWorkflowState value)? task,
    TResult? Function(PassWorkflowState value)? pass,
    TResult? Function(ChoiceWorkflowState value)? choice,
    TResult? Function(SucceedWorkflowState value)? succeed,
    TResult? Function(FailWorkflowState value)? fail,
    TResult? Function(WaitWorkflowState value)? wait,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(TaskWorkflowState value)? task,
    TResult Function(PassWorkflowState value)? pass,
    TResult Function(ChoiceWorkflowState value)? choice,
    TResult Function(SucceedWorkflowState value)? succeed,
    TResult Function(FailWorkflowState value)? fail,
    TResult Function(WaitWorkflowState value)? wait,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $WorkflowStateCopyWith<$Res> {
  factory $WorkflowStateCopyWith(
          WorkflowState value, $Res Function(WorkflowState) then) =
      _$WorkflowStateCopyWithImpl<$Res, WorkflowState>;
}

/// @nodoc
class _$WorkflowStateCopyWithImpl<$Res, $Val extends WorkflowState>
    implements $WorkflowStateCopyWith<$Res> {
  _$WorkflowStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;
}

/// @nodoc
abstract class _$$TaskWorkflowStateImplCopyWith<$Res> {
  factory _$$TaskWorkflowStateImplCopyWith(_$TaskWorkflowStateImpl value,
          $Res Function(_$TaskWorkflowStateImpl) then) =
      __$$TaskWorkflowStateImplCopyWithImpl<$Res>;
  @useResult
  $Res call({TaskState task});

  $TaskStateCopyWith<$Res> get task;
}

/// @nodoc
class __$$TaskWorkflowStateImplCopyWithImpl<$Res>
    extends _$WorkflowStateCopyWithImpl<$Res, _$TaskWorkflowStateImpl>
    implements _$$TaskWorkflowStateImplCopyWith<$Res> {
  __$$TaskWorkflowStateImplCopyWithImpl(_$TaskWorkflowStateImpl _value,
      $Res Function(_$TaskWorkflowStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? task = null,
  }) {
    return _then(_$TaskWorkflowStateImpl(
      null == task
          ? _value.task
          : task // ignore: cast_nullable_to_non_nullable
              as TaskState,
    ));
  }

  @override
  @pragma('vm:prefer-inline')
  $TaskStateCopyWith<$Res> get task {
    return $TaskStateCopyWith<$Res>(_value.task, (value) {
      return _then(_value.copyWith(task: value));
    });
  }
}

/// @nodoc

class _$TaskWorkflowStateImpl extends TaskWorkflowState {
  const _$TaskWorkflowStateImpl(this.task) : super._();

  @override
  final TaskState task;

  @override
  String toString() {
    return 'WorkflowState.task(task: $task)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TaskWorkflowStateImpl &&
            (identical(other.task, task) || other.task == task));
  }

  @override
  int get hashCode => Object.hash(runtimeType, task);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$TaskWorkflowStateImplCopyWith<_$TaskWorkflowStateImpl> get copyWith =>
      __$$TaskWorkflowStateImplCopyWithImpl<_$TaskWorkflowStateImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(TaskState task) task,
    required TResult Function(PassState pass) pass,
    required TResult Function(ChoiceState choice) choice,
    required TResult Function(SucceedState succeed) succeed,
    required TResult Function(FailState fail) fail,
    required TResult Function(WaitState wait) wait,
  }) {
    return task(this.task);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(TaskState task)? task,
    TResult? Function(PassState pass)? pass,
    TResult? Function(ChoiceState choice)? choice,
    TResult? Function(SucceedState succeed)? succeed,
    TResult? Function(FailState fail)? fail,
    TResult? Function(WaitState wait)? wait,
  }) {
    return task?.call(this.task);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(TaskState task)? task,
    TResult Function(PassState pass)? pass,
    TResult Function(ChoiceState choice)? choice,
    TResult Function(SucceedState succeed)? succeed,
    TResult Function(FailState fail)? fail,
    TResult Function(WaitState wait)? wait,
    required TResult orElse(),
  }) {
    if (task != null) {
      return task(this.task);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(TaskWorkflowState value) task,
    required TResult Function(PassWorkflowState value) pass,
    required TResult Function(ChoiceWorkflowState value) choice,
    required TResult Function(SucceedWorkflowState value) succeed,
    required TResult Function(FailWorkflowState value) fail,
    required TResult Function(WaitWorkflowState value) wait,
  }) {
    return task(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(TaskWorkflowState value)? task,
    TResult? Function(PassWorkflowState value)? pass,
    TResult? Function(ChoiceWorkflowState value)? choice,
    TResult? Function(SucceedWorkflowState value)? succeed,
    TResult? Function(FailWorkflowState value)? fail,
    TResult? Function(WaitWorkflowState value)? wait,
  }) {
    return task?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(TaskWorkflowState value)? task,
    TResult Function(PassWorkflowState value)? pass,
    TResult Function(ChoiceWorkflowState value)? choice,
    TResult Function(SucceedWorkflowState value)? succeed,
    TResult Function(FailWorkflowState value)? fail,
    TResult Function(WaitWorkflowState value)? wait,
    required TResult orElse(),
  }) {
    if (task != null) {
      return task(this);
    }
    return orElse();
  }
}

abstract class TaskWorkflowState extends WorkflowState {
  const factory TaskWorkflowState(final TaskState task) =
      _$TaskWorkflowStateImpl;
  const TaskWorkflowState._() : super._();

  TaskState get task;
  @JsonKey(ignore: true)
  _$$TaskWorkflowStateImplCopyWith<_$TaskWorkflowStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$PassWorkflowStateImplCopyWith<$Res> {
  factory _$$PassWorkflowStateImplCopyWith(_$PassWorkflowStateImpl value,
          $Res Function(_$PassWorkflowStateImpl) then) =
      __$$PassWorkflowStateImplCopyWithImpl<$Res>;
  @useResult
  $Res call({PassState pass});

  $PassStateCopyWith<$Res> get pass;
}

/// @nodoc
class __$$PassWorkflowStateImplCopyWithImpl<$Res>
    extends _$WorkflowStateCopyWithImpl<$Res, _$PassWorkflowStateImpl>
    implements _$$PassWorkflowStateImplCopyWith<$Res> {
  __$$PassWorkflowStateImplCopyWithImpl(_$PassWorkflowStateImpl _value,
      $Res Function(_$PassWorkflowStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? pass = null,
  }) {
    return _then(_$PassWorkflowStateImpl(
      null == pass
          ? _value.pass
          : pass // ignore: cast_nullable_to_non_nullable
              as PassState,
    ));
  }

  @override
  @pragma('vm:prefer-inline')
  $PassStateCopyWith<$Res> get pass {
    return $PassStateCopyWith<$Res>(_value.pass, (value) {
      return _then(_value.copyWith(pass: value));
    });
  }
}

/// @nodoc

class _$PassWorkflowStateImpl extends PassWorkflowState {
  const _$PassWorkflowStateImpl(this.pass) : super._();

  @override
  final PassState pass;

  @override
  String toString() {
    return 'WorkflowState.pass(pass: $pass)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PassWorkflowStateImpl &&
            (identical(other.pass, pass) || other.pass == pass));
  }

  @override
  int get hashCode => Object.hash(runtimeType, pass);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$PassWorkflowStateImplCopyWith<_$PassWorkflowStateImpl> get copyWith =>
      __$$PassWorkflowStateImplCopyWithImpl<_$PassWorkflowStateImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(TaskState task) task,
    required TResult Function(PassState pass) pass,
    required TResult Function(ChoiceState choice) choice,
    required TResult Function(SucceedState succeed) succeed,
    required TResult Function(FailState fail) fail,
    required TResult Function(WaitState wait) wait,
  }) {
    return pass(this.pass);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(TaskState task)? task,
    TResult? Function(PassState pass)? pass,
    TResult? Function(ChoiceState choice)? choice,
    TResult? Function(SucceedState succeed)? succeed,
    TResult? Function(FailState fail)? fail,
    TResult? Function(WaitState wait)? wait,
  }) {
    return pass?.call(this.pass);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(TaskState task)? task,
    TResult Function(PassState pass)? pass,
    TResult Function(ChoiceState choice)? choice,
    TResult Function(SucceedState succeed)? succeed,
    TResult Function(FailState fail)? fail,
    TResult Function(WaitState wait)? wait,
    required TResult orElse(),
  }) {
    if (pass != null) {
      return pass(this.pass);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(TaskWorkflowState value) task,
    required TResult Function(PassWorkflowState value) pass,
    required TResult Function(ChoiceWorkflowState value) choice,
    required TResult Function(SucceedWorkflowState value) succeed,
    required TResult Function(FailWorkflowState value) fail,
    required TResult Function(WaitWorkflowState value) wait,
  }) {
    return pass(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(TaskWorkflowState value)? task,
    TResult? Function(PassWorkflowState value)? pass,
    TResult? Function(ChoiceWorkflowState value)? choice,
    TResult? Function(SucceedWorkflowState value)? succeed,
    TResult? Function(FailWorkflowState value)? fail,
    TResult? Function(WaitWorkflowState value)? wait,
  }) {
    return pass?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(TaskWorkflowState value)? task,
    TResult Function(PassWorkflowState value)? pass,
    TResult Function(ChoiceWorkflowState value)? choice,
    TResult Function(SucceedWorkflowState value)? succeed,
    TResult Function(FailWorkflowState value)? fail,
    TResult Function(WaitWorkflowState value)? wait,
    required TResult orElse(),
  }) {
    if (pass != null) {
      return pass(this);
    }
    return orElse();
  }
}

abstract class PassWorkflowState extends WorkflowState {
  const factory PassWorkflowState(final PassState pass) =
      _$PassWorkflowStateImpl;
  const PassWorkflowState._() : super._();

  PassState get pass;
  @JsonKey(ignore: true)
  _$$PassWorkflowStateImplCopyWith<_$PassWorkflowStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ChoiceWorkflowStateImplCopyWith<$Res> {
  factory _$$ChoiceWorkflowStateImplCopyWith(_$ChoiceWorkflowStateImpl value,
          $Res Function(_$ChoiceWorkflowStateImpl) then) =
      __$$ChoiceWorkflowStateImplCopyWithImpl<$Res>;
  @useResult
  $Res call({ChoiceState choice});

  $ChoiceStateCopyWith<$Res> get choice;
}

/// @nodoc
class __$$ChoiceWorkflowStateImplCopyWithImpl<$Res>
    extends _$WorkflowStateCopyWithImpl<$Res, _$ChoiceWorkflowStateImpl>
    implements _$$ChoiceWorkflowStateImplCopyWith<$Res> {
  __$$ChoiceWorkflowStateImplCopyWithImpl(_$ChoiceWorkflowStateImpl _value,
      $Res Function(_$ChoiceWorkflowStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? choice = null,
  }) {
    return _then(_$ChoiceWorkflowStateImpl(
      null == choice
          ? _value.choice
          : choice // ignore: cast_nullable_to_non_nullable
              as ChoiceState,
    ));
  }

  @override
  @pragma('vm:prefer-inline')
  $ChoiceStateCopyWith<$Res> get choice {
    return $ChoiceStateCopyWith<$Res>(_value.choice, (value) {
      return _then(_value.copyWith(choice: value));
    });
  }
}

/// @nodoc

class _$ChoiceWorkflowStateImpl extends ChoiceWorkflowState {
  const _$ChoiceWorkflowStateImpl(this.choice) : super._();

  @override
  final ChoiceState choice;

  @override
  String toString() {
    return 'WorkflowState.choice(choice: $choice)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ChoiceWorkflowStateImpl &&
            (identical(other.choice, choice) || other.choice == choice));
  }

  @override
  int get hashCode => Object.hash(runtimeType, choice);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ChoiceWorkflowStateImplCopyWith<_$ChoiceWorkflowStateImpl> get copyWith =>
      __$$ChoiceWorkflowStateImplCopyWithImpl<_$ChoiceWorkflowStateImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(TaskState task) task,
    required TResult Function(PassState pass) pass,
    required TResult Function(ChoiceState choice) choice,
    required TResult Function(SucceedState succeed) succeed,
    required TResult Function(FailState fail) fail,
    required TResult Function(WaitState wait) wait,
  }) {
    return choice(this.choice);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(TaskState task)? task,
    TResult? Function(PassState pass)? pass,
    TResult? Function(ChoiceState choice)? choice,
    TResult? Function(SucceedState succeed)? succeed,
    TResult? Function(FailState fail)? fail,
    TResult? Function(WaitState wait)? wait,
  }) {
    return choice?.call(this.choice);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(TaskState task)? task,
    TResult Function(PassState pass)? pass,
    TResult Function(ChoiceState choice)? choice,
    TResult Function(SucceedState succeed)? succeed,
    TResult Function(FailState fail)? fail,
    TResult Function(WaitState wait)? wait,
    required TResult orElse(),
  }) {
    if (choice != null) {
      return choice(this.choice);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(TaskWorkflowState value) task,
    required TResult Function(PassWorkflowState value) pass,
    required TResult Function(ChoiceWorkflowState value) choice,
    required TResult Function(SucceedWorkflowState value) succeed,
    required TResult Function(FailWorkflowState value) fail,
    required TResult Function(WaitWorkflowState value) wait,
  }) {
    return choice(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(TaskWorkflowState value)? task,
    TResult? Function(PassWorkflowState value)? pass,
    TResult? Function(ChoiceWorkflowState value)? choice,
    TResult? Function(SucceedWorkflowState value)? succeed,
    TResult? Function(FailWorkflowState value)? fail,
    TResult? Function(WaitWorkflowState value)? wait,
  }) {
    return choice?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(TaskWorkflowState value)? task,
    TResult Function(PassWorkflowState value)? pass,
    TResult Function(ChoiceWorkflowState value)? choice,
    TResult Function(SucceedWorkflowState value)? succeed,
    TResult Function(FailWorkflowState value)? fail,
    TResult Function(WaitWorkflowState value)? wait,
    required TResult orElse(),
  }) {
    if (choice != null) {
      return choice(this);
    }
    return orElse();
  }
}

abstract class ChoiceWorkflowState extends WorkflowState {
  const factory ChoiceWorkflowState(final ChoiceState choice) =
      _$ChoiceWorkflowStateImpl;
  const ChoiceWorkflowState._() : super._();

  ChoiceState get choice;
  @JsonKey(ignore: true)
  _$$ChoiceWorkflowStateImplCopyWith<_$ChoiceWorkflowStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$SucceedWorkflowStateImplCopyWith<$Res> {
  factory _$$SucceedWorkflowStateImplCopyWith(_$SucceedWorkflowStateImpl value,
          $Res Function(_$SucceedWorkflowStateImpl) then) =
      __$$SucceedWorkflowStateImplCopyWithImpl<$Res>;
  @useResult
  $Res call({SucceedState succeed});

  $SucceedStateCopyWith<$Res> get succeed;
}

/// @nodoc
class __$$SucceedWorkflowStateImplCopyWithImpl<$Res>
    extends _$WorkflowStateCopyWithImpl<$Res, _$SucceedWorkflowStateImpl>
    implements _$$SucceedWorkflowStateImplCopyWith<$Res> {
  __$$SucceedWorkflowStateImplCopyWithImpl(_$SucceedWorkflowStateImpl _value,
      $Res Function(_$SucceedWorkflowStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? succeed = null,
  }) {
    return _then(_$SucceedWorkflowStateImpl(
      null == succeed
          ? _value.succeed
          : succeed // ignore: cast_nullable_to_non_nullable
              as SucceedState,
    ));
  }

  @override
  @pragma('vm:prefer-inline')
  $SucceedStateCopyWith<$Res> get succeed {
    return $SucceedStateCopyWith<$Res>(_value.succeed, (value) {
      return _then(_value.copyWith(succeed: value));
    });
  }
}

/// @nodoc

class _$SucceedWorkflowStateImpl extends SucceedWorkflowState {
  const _$SucceedWorkflowStateImpl(this.succeed) : super._();

  @override
  final SucceedState succeed;

  @override
  String toString() {
    return 'WorkflowState.succeed(succeed: $succeed)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SucceedWorkflowStateImpl &&
            (identical(other.succeed, succeed) || other.succeed == succeed));
  }

  @override
  int get hashCode => Object.hash(runtimeType, succeed);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$SucceedWorkflowStateImplCopyWith<_$SucceedWorkflowStateImpl>
      get copyWith =>
          __$$SucceedWorkflowStateImplCopyWithImpl<_$SucceedWorkflowStateImpl>(
              this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(TaskState task) task,
    required TResult Function(PassState pass) pass,
    required TResult Function(ChoiceState choice) choice,
    required TResult Function(SucceedState succeed) succeed,
    required TResult Function(FailState fail) fail,
    required TResult Function(WaitState wait) wait,
  }) {
    return succeed(this.succeed);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(TaskState task)? task,
    TResult? Function(PassState pass)? pass,
    TResult? Function(ChoiceState choice)? choice,
    TResult? Function(SucceedState succeed)? succeed,
    TResult? Function(FailState fail)? fail,
    TResult? Function(WaitState wait)? wait,
  }) {
    return succeed?.call(this.succeed);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(TaskState task)? task,
    TResult Function(PassState pass)? pass,
    TResult Function(ChoiceState choice)? choice,
    TResult Function(SucceedState succeed)? succeed,
    TResult Function(FailState fail)? fail,
    TResult Function(WaitState wait)? wait,
    required TResult orElse(),
  }) {
    if (succeed != null) {
      return succeed(this.succeed);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(TaskWorkflowState value) task,
    required TResult Function(PassWorkflowState value) pass,
    required TResult Function(ChoiceWorkflowState value) choice,
    required TResult Function(SucceedWorkflowState value) succeed,
    required TResult Function(FailWorkflowState value) fail,
    required TResult Function(WaitWorkflowState value) wait,
  }) {
    return succeed(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(TaskWorkflowState value)? task,
    TResult? Function(PassWorkflowState value)? pass,
    TResult? Function(ChoiceWorkflowState value)? choice,
    TResult? Function(SucceedWorkflowState value)? succeed,
    TResult? Function(FailWorkflowState value)? fail,
    TResult? Function(WaitWorkflowState value)? wait,
  }) {
    return succeed?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(TaskWorkflowState value)? task,
    TResult Function(PassWorkflowState value)? pass,
    TResult Function(ChoiceWorkflowState value)? choice,
    TResult Function(SucceedWorkflowState value)? succeed,
    TResult Function(FailWorkflowState value)? fail,
    TResult Function(WaitWorkflowState value)? wait,
    required TResult orElse(),
  }) {
    if (succeed != null) {
      return succeed(this);
    }
    return orElse();
  }
}

abstract class SucceedWorkflowState extends WorkflowState {
  const factory SucceedWorkflowState(final SucceedState succeed) =
      _$SucceedWorkflowStateImpl;
  const SucceedWorkflowState._() : super._();

  SucceedState get succeed;
  @JsonKey(ignore: true)
  _$$SucceedWorkflowStateImplCopyWith<_$SucceedWorkflowStateImpl>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$FailWorkflowStateImplCopyWith<$Res> {
  factory _$$FailWorkflowStateImplCopyWith(_$FailWorkflowStateImpl value,
          $Res Function(_$FailWorkflowStateImpl) then) =
      __$$FailWorkflowStateImplCopyWithImpl<$Res>;
  @useResult
  $Res call({FailState fail});

  $FailStateCopyWith<$Res> get fail;
}

/// @nodoc
class __$$FailWorkflowStateImplCopyWithImpl<$Res>
    extends _$WorkflowStateCopyWithImpl<$Res, _$FailWorkflowStateImpl>
    implements _$$FailWorkflowStateImplCopyWith<$Res> {
  __$$FailWorkflowStateImplCopyWithImpl(_$FailWorkflowStateImpl _value,
      $Res Function(_$FailWorkflowStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? fail = null,
  }) {
    return _then(_$FailWorkflowStateImpl(
      null == fail
          ? _value.fail
          : fail // ignore: cast_nullable_to_non_nullable
              as FailState,
    ));
  }

  @override
  @pragma('vm:prefer-inline')
  $FailStateCopyWith<$Res> get fail {
    return $FailStateCopyWith<$Res>(_value.fail, (value) {
      return _then(_value.copyWith(fail: value));
    });
  }
}

/// @nodoc

class _$FailWorkflowStateImpl extends FailWorkflowState {
  const _$FailWorkflowStateImpl(this.fail) : super._();

  @override
  final FailState fail;

  @override
  String toString() {
    return 'WorkflowState.fail(fail: $fail)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FailWorkflowStateImpl &&
            (identical(other.fail, fail) || other.fail == fail));
  }

  @override
  int get hashCode => Object.hash(runtimeType, fail);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$FailWorkflowStateImplCopyWith<_$FailWorkflowStateImpl> get copyWith =>
      __$$FailWorkflowStateImplCopyWithImpl<_$FailWorkflowStateImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(TaskState task) task,
    required TResult Function(PassState pass) pass,
    required TResult Function(ChoiceState choice) choice,
    required TResult Function(SucceedState succeed) succeed,
    required TResult Function(FailState fail) fail,
    required TResult Function(WaitState wait) wait,
  }) {
    return fail(this.fail);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(TaskState task)? task,
    TResult? Function(PassState pass)? pass,
    TResult? Function(ChoiceState choice)? choice,
    TResult? Function(SucceedState succeed)? succeed,
    TResult? Function(FailState fail)? fail,
    TResult? Function(WaitState wait)? wait,
  }) {
    return fail?.call(this.fail);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(TaskState task)? task,
    TResult Function(PassState pass)? pass,
    TResult Function(ChoiceState choice)? choice,
    TResult Function(SucceedState succeed)? succeed,
    TResult Function(FailState fail)? fail,
    TResult Function(WaitState wait)? wait,
    required TResult orElse(),
  }) {
    if (fail != null) {
      return fail(this.fail);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(TaskWorkflowState value) task,
    required TResult Function(PassWorkflowState value) pass,
    required TResult Function(ChoiceWorkflowState value) choice,
    required TResult Function(SucceedWorkflowState value) succeed,
    required TResult Function(FailWorkflowState value) fail,
    required TResult Function(WaitWorkflowState value) wait,
  }) {
    return fail(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(TaskWorkflowState value)? task,
    TResult? Function(PassWorkflowState value)? pass,
    TResult? Function(ChoiceWorkflowState value)? choice,
    TResult? Function(SucceedWorkflowState value)? succeed,
    TResult? Function(FailWorkflowState value)? fail,
    TResult? Function(WaitWorkflowState value)? wait,
  }) {
    return fail?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(TaskWorkflowState value)? task,
    TResult Function(PassWorkflowState value)? pass,
    TResult Function(ChoiceWorkflowState value)? choice,
    TResult Function(SucceedWorkflowState value)? succeed,
    TResult Function(FailWorkflowState value)? fail,
    TResult Function(WaitWorkflowState value)? wait,
    required TResult orElse(),
  }) {
    if (fail != null) {
      return fail(this);
    }
    return orElse();
  }
}

abstract class FailWorkflowState extends WorkflowState {
  const factory FailWorkflowState(final FailState fail) =
      _$FailWorkflowStateImpl;
  const FailWorkflowState._() : super._();

  FailState get fail;
  @JsonKey(ignore: true)
  _$$FailWorkflowStateImplCopyWith<_$FailWorkflowStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$WaitWorkflowStateImplCopyWith<$Res> {
  factory _$$WaitWorkflowStateImplCopyWith(_$WaitWorkflowStateImpl value,
          $Res Function(_$WaitWorkflowStateImpl) then) =
      __$$WaitWorkflowStateImplCopyWithImpl<$Res>;
  @useResult
  $Res call({WaitState wait});

  $WaitStateCopyWith<$Res> get wait;
}

/// @nodoc
class __$$WaitWorkflowStateImplCopyWithImpl<$Res>
    extends _$WorkflowStateCopyWithImpl<$Res, _$WaitWorkflowStateImpl>
    implements _$$WaitWorkflowStateImplCopyWith<$Res> {
  __$$WaitWorkflowStateImplCopyWithImpl(_$WaitWorkflowStateImpl _value,
      $Res Function(_$WaitWorkflowStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? wait = null,
  }) {
    return _then(_$WaitWorkflowStateImpl(
      null == wait
          ? _value.wait
          : wait // ignore: cast_nullable_to_non_nullable
              as WaitState,
    ));
  }

  @override
  @pragma('vm:prefer-inline')
  $WaitStateCopyWith<$Res> get wait {
    return $WaitStateCopyWith<$Res>(_value.wait, (value) {
      return _then(_value.copyWith(wait: value));
    });
  }
}

/// @nodoc

class _$WaitWorkflowStateImpl extends WaitWorkflowState {
  const _$WaitWorkflowStateImpl(this.wait) : super._();

  @override
  final WaitState wait;

  @override
  String toString() {
    return 'WorkflowState.wait(wait: $wait)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$WaitWorkflowStateImpl &&
            (identical(other.wait, wait) || other.wait == wait));
  }

  @override
  int get hashCode => Object.hash(runtimeType, wait);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$WaitWorkflowStateImplCopyWith<_$WaitWorkflowStateImpl> get copyWith =>
      __$$WaitWorkflowStateImplCopyWithImpl<_$WaitWorkflowStateImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(TaskState task) task,
    required TResult Function(PassState pass) pass,
    required TResult Function(ChoiceState choice) choice,
    required TResult Function(SucceedState succeed) succeed,
    required TResult Function(FailState fail) fail,
    required TResult Function(WaitState wait) wait,
  }) {
    return wait(this.wait);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(TaskState task)? task,
    TResult? Function(PassState pass)? pass,
    TResult? Function(ChoiceState choice)? choice,
    TResult? Function(SucceedState succeed)? succeed,
    TResult? Function(FailState fail)? fail,
    TResult? Function(WaitState wait)? wait,
  }) {
    return wait?.call(this.wait);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(TaskState task)? task,
    TResult Function(PassState pass)? pass,
    TResult Function(ChoiceState choice)? choice,
    TResult Function(SucceedState succeed)? succeed,
    TResult Function(FailState fail)? fail,
    TResult Function(WaitState wait)? wait,
    required TResult orElse(),
  }) {
    if (wait != null) {
      return wait(this.wait);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(TaskWorkflowState value) task,
    required TResult Function(PassWorkflowState value) pass,
    required TResult Function(ChoiceWorkflowState value) choice,
    required TResult Function(SucceedWorkflowState value) succeed,
    required TResult Function(FailWorkflowState value) fail,
    required TResult Function(WaitWorkflowState value) wait,
  }) {
    return wait(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(TaskWorkflowState value)? task,
    TResult? Function(PassWorkflowState value)? pass,
    TResult? Function(ChoiceWorkflowState value)? choice,
    TResult? Function(SucceedWorkflowState value)? succeed,
    TResult? Function(FailWorkflowState value)? fail,
    TResult? Function(WaitWorkflowState value)? wait,
  }) {
    return wait?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(TaskWorkflowState value)? task,
    TResult Function(PassWorkflowState value)? pass,
    TResult Function(ChoiceWorkflowState value)? choice,
    TResult Function(SucceedWorkflowState value)? succeed,
    TResult Function(FailWorkflowState value)? fail,
    TResult Function(WaitWorkflowState value)? wait,
    required TResult orElse(),
  }) {
    if (wait != null) {
      return wait(this);
    }
    return orElse();
  }
}

abstract class WaitWorkflowState extends WorkflowState {
  const factory WaitWorkflowState(final WaitState wait) =
      _$WaitWorkflowStateImpl;
  const WaitWorkflowState._() : super._();

  WaitState get wait;
  @JsonKey(ignore: true)
  _$$WaitWorkflowStateImplCopyWith<_$WaitWorkflowStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
