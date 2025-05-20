// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'editor_state.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$EditorStateImpl _$$EditorStateImplFromJson(Map<String, dynamic> json) =>
    _$EditorStateImpl(
      canvases: (json['canvases'] as Map<String, dynamic>).map(
        (k, e) => MapEntry(k, CanvasState.fromJson(e as Map<String, dynamic>)),
      ),
      activeWorkflowId: json['activeWorkflowId'] as String,
      nodes: NodeState.fromJson(json['nodes'] as Map<String, dynamic>),
      edges: EdgeState.fromJson(json['edges'] as Map<String, dynamic>),
      viewport: json['viewport'] == null
          ? const CanvasViewportState()
          : CanvasViewportState.fromJson(
              json['viewport'] as Map<String, dynamic>),
      selection: json['selection'] == null
          ? const SelectionState()
          : SelectionState.fromJson(json['selection'] as Map<String, dynamic>),
      interaction: json['interaction'] == null
          ? const InteractionState.idle()
          : InteractionState.fromJson(
              json['interaction'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$EditorStateImplToJson(_$EditorStateImpl instance) =>
    <String, dynamic>{
      'canvases': instance.canvases,
      'activeWorkflowId': instance.activeWorkflowId,
      'nodes': instance.nodes,
      'edges': instance.edges,
      'viewport': instance.viewport,
      'selection': instance.selection,
      'interaction': instance.interaction,
    };
