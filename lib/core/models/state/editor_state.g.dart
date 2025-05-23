// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'editor_state.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$EditorStateImpl _$$EditorStateImplFromJson(Map<String, dynamic> json) =>
    _$EditorStateImpl(
      canvasState:
          CanvasState.fromJson(json['canvasState'] as Map<String, dynamic>),
      nodeState: NodeState.fromJson(json['nodeState'] as Map<String, dynamic>),
      edgeState: EdgeState.fromJson(json['edgeState'] as Map<String, dynamic>),
      selection: json['selection'] == null
          ? const SelectionState()
          : SelectionState.fromJson(json['selection'] as Map<String, dynamic>),
      interaction: json['interaction'] == null
          ? const InteractionState.idle()
          : InteractionState.fromJson(
              json['interaction'] as Map<String, dynamic>),
      inputConfig: json['inputConfig'] == null
          ? const InputConfig()
          : InputConfig.fromJson(json['inputConfig'] as Map<String, dynamic>),
      clipboard: json['clipboard'] == null
          ? const ClipboardState()
          : ClipboardState.fromJson(json['clipboard'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$EditorStateImplToJson(_$EditorStateImpl instance) =>
    <String, dynamic>{
      'canvasState': instance.canvasState,
      'nodeState': instance.nodeState,
      'edgeState': instance.edgeState,
      'selection': instance.selection,
      'interaction': instance.interaction,
      'inputConfig': instance.inputConfig,
      'clipboard': instance.clipboard,
    };
