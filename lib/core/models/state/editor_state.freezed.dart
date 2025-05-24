// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'editor_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

EditorState _$EditorStateFromJson(Map<String, dynamic> json) {
  return _EditorState.fromJson(json);
}

/// @nodoc
mixin _$EditorState {
  CanvasState get canvasState => throw _privateConstructorUsedError;
  NodeState get nodeState => throw _privateConstructorUsedError;
  EdgeState get edgeState => throw _privateConstructorUsedError;
  SelectionState get selection => throw _privateConstructorUsedError;
  InteractionState get interaction => throw _privateConstructorUsedError;
  InputConfig get inputConfig => throw _privateConstructorUsedError;
  BehaviorPriority get behaviorPriority => throw _privateConstructorUsedError;
  ClipboardState get clipboard => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $EditorStateCopyWith<EditorState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $EditorStateCopyWith<$Res> {
  factory $EditorStateCopyWith(
          EditorState value, $Res Function(EditorState) then) =
      _$EditorStateCopyWithImpl<$Res, EditorState>;
  @useResult
  $Res call(
      {CanvasState canvasState,
      NodeState nodeState,
      EdgeState edgeState,
      SelectionState selection,
      InteractionState interaction,
      InputConfig inputConfig,
      BehaviorPriority behaviorPriority,
      ClipboardState clipboard});

  $CanvasStateCopyWith<$Res> get canvasState;
  $NodeStateCopyWith<$Res> get nodeState;
  $EdgeStateCopyWith<$Res> get edgeState;
  $InteractionStateCopyWith<$Res> get interaction;
  $InputConfigCopyWith<$Res> get inputConfig;
  $BehaviorPriorityCopyWith<$Res> get behaviorPriority;
  $ClipboardStateCopyWith<$Res> get clipboard;
}

/// @nodoc
class _$EditorStateCopyWithImpl<$Res, $Val extends EditorState>
    implements $EditorStateCopyWith<$Res> {
  _$EditorStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? canvasState = null,
    Object? nodeState = null,
    Object? edgeState = null,
    Object? selection = null,
    Object? interaction = null,
    Object? inputConfig = null,
    Object? behaviorPriority = null,
    Object? clipboard = null,
  }) {
    return _then(_value.copyWith(
      canvasState: null == canvasState
          ? _value.canvasState
          : canvasState // ignore: cast_nullable_to_non_nullable
              as CanvasState,
      nodeState: null == nodeState
          ? _value.nodeState
          : nodeState // ignore: cast_nullable_to_non_nullable
              as NodeState,
      edgeState: null == edgeState
          ? _value.edgeState
          : edgeState // ignore: cast_nullable_to_non_nullable
              as EdgeState,
      selection: null == selection
          ? _value.selection
          : selection // ignore: cast_nullable_to_non_nullable
              as SelectionState,
      interaction: null == interaction
          ? _value.interaction
          : interaction // ignore: cast_nullable_to_non_nullable
              as InteractionState,
      inputConfig: null == inputConfig
          ? _value.inputConfig
          : inputConfig // ignore: cast_nullable_to_non_nullable
              as InputConfig,
      behaviorPriority: null == behaviorPriority
          ? _value.behaviorPriority
          : behaviorPriority // ignore: cast_nullable_to_non_nullable
              as BehaviorPriority,
      clipboard: null == clipboard
          ? _value.clipboard
          : clipboard // ignore: cast_nullable_to_non_nullable
              as ClipboardState,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $CanvasStateCopyWith<$Res> get canvasState {
    return $CanvasStateCopyWith<$Res>(_value.canvasState, (value) {
      return _then(_value.copyWith(canvasState: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $NodeStateCopyWith<$Res> get nodeState {
    return $NodeStateCopyWith<$Res>(_value.nodeState, (value) {
      return _then(_value.copyWith(nodeState: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $EdgeStateCopyWith<$Res> get edgeState {
    return $EdgeStateCopyWith<$Res>(_value.edgeState, (value) {
      return _then(_value.copyWith(edgeState: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $InteractionStateCopyWith<$Res> get interaction {
    return $InteractionStateCopyWith<$Res>(_value.interaction, (value) {
      return _then(_value.copyWith(interaction: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $InputConfigCopyWith<$Res> get inputConfig {
    return $InputConfigCopyWith<$Res>(_value.inputConfig, (value) {
      return _then(_value.copyWith(inputConfig: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $BehaviorPriorityCopyWith<$Res> get behaviorPriority {
    return $BehaviorPriorityCopyWith<$Res>(_value.behaviorPriority, (value) {
      return _then(_value.copyWith(behaviorPriority: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $ClipboardStateCopyWith<$Res> get clipboard {
    return $ClipboardStateCopyWith<$Res>(_value.clipboard, (value) {
      return _then(_value.copyWith(clipboard: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$EditorStateImplCopyWith<$Res>
    implements $EditorStateCopyWith<$Res> {
  factory _$$EditorStateImplCopyWith(
          _$EditorStateImpl value, $Res Function(_$EditorStateImpl) then) =
      __$$EditorStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {CanvasState canvasState,
      NodeState nodeState,
      EdgeState edgeState,
      SelectionState selection,
      InteractionState interaction,
      InputConfig inputConfig,
      BehaviorPriority behaviorPriority,
      ClipboardState clipboard});

  @override
  $CanvasStateCopyWith<$Res> get canvasState;
  @override
  $NodeStateCopyWith<$Res> get nodeState;
  @override
  $EdgeStateCopyWith<$Res> get edgeState;
  @override
  $InteractionStateCopyWith<$Res> get interaction;
  @override
  $InputConfigCopyWith<$Res> get inputConfig;
  @override
  $BehaviorPriorityCopyWith<$Res> get behaviorPriority;
  @override
  $ClipboardStateCopyWith<$Res> get clipboard;
}

/// @nodoc
class __$$EditorStateImplCopyWithImpl<$Res>
    extends _$EditorStateCopyWithImpl<$Res, _$EditorStateImpl>
    implements _$$EditorStateImplCopyWith<$Res> {
  __$$EditorStateImplCopyWithImpl(
      _$EditorStateImpl _value, $Res Function(_$EditorStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? canvasState = null,
    Object? nodeState = null,
    Object? edgeState = null,
    Object? selection = null,
    Object? interaction = null,
    Object? inputConfig = null,
    Object? behaviorPriority = null,
    Object? clipboard = null,
  }) {
    return _then(_$EditorStateImpl(
      canvasState: null == canvasState
          ? _value.canvasState
          : canvasState // ignore: cast_nullable_to_non_nullable
              as CanvasState,
      nodeState: null == nodeState
          ? _value.nodeState
          : nodeState // ignore: cast_nullable_to_non_nullable
              as NodeState,
      edgeState: null == edgeState
          ? _value.edgeState
          : edgeState // ignore: cast_nullable_to_non_nullable
              as EdgeState,
      selection: null == selection
          ? _value.selection
          : selection // ignore: cast_nullable_to_non_nullable
              as SelectionState,
      interaction: null == interaction
          ? _value.interaction
          : interaction // ignore: cast_nullable_to_non_nullable
              as InteractionState,
      inputConfig: null == inputConfig
          ? _value.inputConfig
          : inputConfig // ignore: cast_nullable_to_non_nullable
              as InputConfig,
      behaviorPriority: null == behaviorPriority
          ? _value.behaviorPriority
          : behaviorPriority // ignore: cast_nullable_to_non_nullable
              as BehaviorPriority,
      clipboard: null == clipboard
          ? _value.clipboard
          : clipboard // ignore: cast_nullable_to_non_nullable
              as ClipboardState,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$EditorStateImpl extends _EditorState {
  const _$EditorStateImpl(
      {required this.canvasState,
      required this.nodeState,
      required this.edgeState,
      this.selection = const SelectionState(),
      this.interaction = const InteractionState.idle(),
      this.inputConfig = const InputConfig(),
      this.behaviorPriority = const BehaviorPriority(),
      this.clipboard = const ClipboardState()})
      : super._();

  factory _$EditorStateImpl.fromJson(Map<String, dynamic> json) =>
      _$$EditorStateImplFromJson(json);

  @override
  final CanvasState canvasState;
  @override
  final NodeState nodeState;
  @override
  final EdgeState edgeState;
  @override
  @JsonKey()
  final SelectionState selection;
  @override
  @JsonKey()
  final InteractionState interaction;
  @override
  @JsonKey()
  final InputConfig inputConfig;
  @override
  @JsonKey()
  final BehaviorPriority behaviorPriority;
  @override
  @JsonKey()
  final ClipboardState clipboard;

  @override
  String toString() {
    return 'EditorState(canvasState: $canvasState, nodeState: $nodeState, edgeState: $edgeState, selection: $selection, interaction: $interaction, inputConfig: $inputConfig, behaviorPriority: $behaviorPriority, clipboard: $clipboard)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$EditorStateImpl &&
            (identical(other.canvasState, canvasState) ||
                other.canvasState == canvasState) &&
            (identical(other.nodeState, nodeState) ||
                other.nodeState == nodeState) &&
            (identical(other.edgeState, edgeState) ||
                other.edgeState == edgeState) &&
            (identical(other.selection, selection) ||
                other.selection == selection) &&
            (identical(other.interaction, interaction) ||
                other.interaction == interaction) &&
            (identical(other.inputConfig, inputConfig) ||
                other.inputConfig == inputConfig) &&
            (identical(other.behaviorPriority, behaviorPriority) ||
                other.behaviorPriority == behaviorPriority) &&
            (identical(other.clipboard, clipboard) ||
                other.clipboard == clipboard));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      canvasState,
      nodeState,
      edgeState,
      selection,
      interaction,
      inputConfig,
      behaviorPriority,
      clipboard);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$EditorStateImplCopyWith<_$EditorStateImpl> get copyWith =>
      __$$EditorStateImplCopyWithImpl<_$EditorStateImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$EditorStateImplToJson(
      this,
    );
  }
}

abstract class _EditorState extends EditorState {
  const factory _EditorState(
      {required final CanvasState canvasState,
      required final NodeState nodeState,
      required final EdgeState edgeState,
      final SelectionState selection,
      final InteractionState interaction,
      final InputConfig inputConfig,
      final BehaviorPriority behaviorPriority,
      final ClipboardState clipboard}) = _$EditorStateImpl;
  const _EditorState._() : super._();

  factory _EditorState.fromJson(Map<String, dynamic> json) =
      _$EditorStateImpl.fromJson;

  @override
  CanvasState get canvasState;
  @override
  NodeState get nodeState;
  @override
  EdgeState get edgeState;
  @override
  SelectionState get selection;
  @override
  InteractionState get interaction;
  @override
  InputConfig get inputConfig;
  @override
  BehaviorPriority get behaviorPriority;
  @override
  ClipboardState get clipboard;
  @override
  @JsonKey(ignore: true)
  _$$EditorStateImplCopyWith<_$EditorStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
